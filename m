From: Jiri Sevcik <jsevcik14@gmail.com>
Subject: git-remote-fd problem
Date: Wed, 10 Sep 2014 15:29:00 +0200
Message-ID: <CAOP4-939uAP2Tgofz01F40_Eb0F8GxBsU49HxNvAiyBCW6H08w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c2bb1ee78ce10502b6085f
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 10 15:29:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRhxL-00017t-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbaIJN3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 09:29:03 -0400
Received: from mail-vc0-f196.google.com ([209.85.220.196]:34645 "EHLO
	mail-vc0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaIJN3B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:29:01 -0400
Received: by mail-vc0-f196.google.com with SMTP id id10so6057990vcb.7
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 06:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Zc47hx8UM9l9cJnittcr1w3QwcHR5GqWm515vRMuwCs=;
        b=bpdLhLdwPJRBIbVPc8PWvcCH/1VIu1rOSzDXPw+gjzHt2V12w+baimIml9LRw4+hei
         dBZLJjO+BbayBczdgyi8akqm4YEfIAf3Z5RWELkrPUmVm1riE1YWM2JGx9V4L1lBf9/6
         OoAlEYeDPcmXE5RVzj7YGrZ4IjmZRbvKW81ZFAZFvU08hvJH2G+2oCj2WUDNhdoG8Uas
         5hLh50Pzu94AxQ6X1bYofOqsKH1sLtwBLcAPFEiZXQHCVLuboXqc8/Atn2ibM5QBYv+7
         lmubODQIZ0xg+Yaj07WVHcJ8u6UZuaFfUIKLVyemyAte+0Ezq9jpmBEgTxfNBtOxqBr9
         Sx4Q==
X-Received: by 10.220.168.74 with SMTP id t10mr16953039vcy.35.1410355740239;
 Wed, 10 Sep 2014 06:29:00 -0700 (PDT)
Received: by 10.220.240.207 with HTTP; Wed, 10 Sep 2014 06:29:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256737>

--001a11c2bb1ee78ce10502b6085f
Content-Type: text/plain; charset=UTF-8

Hi!
I have problem with using git-remote-fd function. I create two local
pipes for communication for locally running process git pull. Then I
start git-upload-pack on remote side (this process is started in
different part of my code  and it works correctly). Communication runs
successfully and when remote side finish, I want to close local pipes
to finish local process. I call close function to all of these pipes,
but unfortunatelly local process doesnt finish (in this moment
transfered data aresaved in /.git/object/pack folder in .pack files)
and hanging on. But if I kill child of this local process, downloaded
files are unpacked and files are created sucessfully. I think this way
is not so correct. Can someone help me and tell me what am I doing
wrong? Thank You. Code is in an attachement (its part of big system).

--001a11c2bb1ee78ce10502b6085f
Content-Type: text/x-python; charset=US-ASCII; name="git_remote.py"
Content-Disposition: attachment; filename="git_remote.py"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzwpdzn70

ICAgICNjcmVhdGUgbG9jYWwgcGlwZXMgZm9yIGNpbW11bmljYXRpb24KICAgIGxvY2FsX3IsIGxv
Y2FsX3cgPSBvcy5waXBlKCkKICAgIHJlbW90ZV9yLCByZW1vdGVfdyA9IG9zLnBpcGUoKQoKICAg
ICNzdGFydCBsb2NhbCBnaXQgcHJvY2VzcwogICAgY2xpZW50X3Byb2Nlc3MgPSBzdWJwcm9jZXNz
LlBvcGVuKCIvdXNyL2Jpbi9naXQgcHVsbCBmZDo6ezB9LHsxfSIuZm9ybWF0KHJlbW90ZV9yLCBs
b2NhbF93LCksIHNoZWxsPVRydWUpCiAgICAKICAgICNzdGFydCBnaXQgcHJvY2VzcyBvbiByZW1v
dGUgc2lkZSAKICAgIHJlbW90ZUdpdCA9IHByb2MucnVuRGFlbW9uKCJzdWRvIGdpdC11cGxvYWQt
cGFjayAvdG1wL3Rlc3RHaXQiKQoKICAgICNzZXQKICAgIGVwb2xsID0gc2VsZWN0LmVwb2xsKCkK
CiAgICBlcG9sbC5yZWdpc3Rlcihsb2NhbF9yLCBzZWxlY3QuRVBPTExJTikKICAgICNyZWdpc3Rl
ciBmcm9tIHJlbW90ZSBzaWRlCiAgICBlcG9sbC5yZWdpc3Rlcihwcm9jLmZkLCBzZWxlY3QuRVBP
TExJTikKCiAgICB3aGlsZSBUcnVlOgogICAgICAgIGV2ZW50cyA9IGVwb2xsLnBvbGwoMSkKCiAg
ICAgICAgZm9yIGZkLCBldmVudCBpbiBldmVudHM6CiAgICAgICAgICAgIGlmIGZkID09IGxvY2Fs
X3I6CiAgICAgICAgICAgICAgICAjZXZlbnQgb24gbG9jYWwgcHJvY2VzcwogICAgICAgICAgICAg
ICAgaWYgZXZlbnQgJiBzZWxlY3QuRVBPTExJTjoKICAgICAgICAgICAgICAgICAgICByZCA9IG9z
LnJlYWQobG9jYWxfciwgNTAwMCkKCiAgICAgICAgICAgICAgICAgICAgaWYgcmQ6CiAgICAgICAg
ICAgICAgICAgICAgICAgICN3cml0ZSBkYXRhIHRvIHJlbW90ZSBzaWRlCiAgICAgICAgICAgICAg
ICAgICAgICAgIHJlbW90ZUdpdC53cml0ZVRvQ2hhbm5lbChyZCkKICAgICAgICAgICAgICAgICAg
ICBlbHNlOgogICAgICAgICAgICAgICAgICAgICAgICBwcm9jLndyaXRlRXJyb3IoIkxvY2FsIHNv
Y2tldCB3cml0ZSBlcnJvciIpCiAgICAgICAgICAgICAgICAgICAgICAgIGNsaWVudF9wcm9jZXNz
LmtpbGwoKQogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMQogICAgICAgICAgICAgICAg
ZWxzZToKICAgICAgICAgICAgICAgICAgICBwcm9jLndyaXRlRXJyb3IoIkxvY2FsIHNvY2tldCBl
cnJvciIpCiAgICAgICAgICAgICAgICAgICAgY2xpZW50X3Byb2Nlc3Mua2lsbCgpCiAgICAgICAg
ICAgICAgICAgICAgcmV0dXJuIDEKCiAgICAgICAgICAgIGVsc2U6CiAgICAgICAgICAgICAgICBp
ZiBldmVudCAmIHNlbGVjdC5FUE9MTElOOgogICAgICAgICAgICAgICAgICAgICNnZXQgYWxsIGRh
dGEgZnJvbSByZW1vdGUgc2lkZQogICAgICAgICAgICAgICAgICAgIGRhdGEgPSByZW1vdGVHaXQu
Z2V0QWxsKCkKICAgICAgICAgICAgICAgICAgICByZW1vdGVHaXQuc3RkZXJyV3JpdGUoKQoKICAg
ICAgICAgICAgICAgICAgICBpZiBub3QgZGF0YToKICAgICAgICAgICAgICAgICAgICAgICAgI3Jl
bW90ZSBzaWRlIGZpbmlzaGVkIC0gY2xvc2UgbG9jYWwgcGlwZXMgLSBsb2NhbCBwcm9jZXNzIHdv
dWxkbnQgZmluaXNoIAogICAgICAgICAgICAgICAgICAgICAgICBvcy5jbG9zZShsb2NhbF9yKSAK
ICAgICAgICAgICAgICAgICAgICAgICAgb3MuY2xvc2UobG9jYWxfdykKICAgICAgICAgICAgICAg
ICAgICAgICAgb3MuY2xvc2UocmVtb3RlX3IpCiAgICAgICAgICAgICAgICAgICAgICAgIG9zLmNs
b3NlKHJlbW90ZV93KQoKICAgICAgICAgICAgICAgICAgICAgICAgI2dldCBsb2NhbCBwcm9jZXNz
IHBpZCBhbmQga2lsbCBoaXMgY2hpbGQgdG8gZmluaXNoIGdpdC1yZW1vdGUtZmQKICAgICAgICAg
ICAgICAgICAgICAgICAgZ2l0UGlkID0gcHN1dGlsLlByb2Nlc3MoY2xpZW50X3Byb2Nlc3MucGlk
KS5jaGlsZHJlbigpWzBdLnBpZAogICAgICAgICAgICAgICAgICAgICAgICBvcy5raWxsKGdpdFBp
ZCwgc2lnbmFsLlNJR1RFUk0pCgogICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gMAoKCiAg
ICAgICAgICAgICAgICAgICAgd2FudCA9IGxlbihkYXRhKQogICAgICAgICAgICAgICAgICAgIHdy
aXRlZCA9IDAKICAgICAgICAgICAgICAgICAgICBvZmZzZXQgPSAwCgogICAgICAgICAgICAgICAg
ICAgIHdoaWxlKHdyaXRlZCAhPSB3YW50KToKICAgICAgICAgICAgICAgICAgICAgICAgI3dyaXRl
IGRhdGEgZnJvbSByZW1vdGUgc2lkZSB0byBsb2NhbCBwcm9jZXNzCiAgICAgICAgICAgICAgICAg
ICAgICAgIHdyID0gb3Mud3JpdGUocmVtb3RlX3csIGRhdGFbb2Zmc2V0Ol0pCgogICAgICAgICAg
ICAgICAgICAgICAgICBpZih3ciA8IDApOgogICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJv
Yy53cml0ZUVycm9yKCJMb2NhbCBzb2NrZXQgd3JpdGUgZXJyb3IiKQoKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAxCgogICAgICAgICAgICAgICAgICAgICAgICB3cml0ZWQgKz0g
d3IKICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0ICs9IHdyCgogICAgICAgICAgICAgICAg
ZWxzZToKICAgICAgICAgICAgICAgICAgICBwcm9jLndyaXRlRXJyb3IoIlJlbW90ZSBzb2NrZXQg
ZXJyb3IiKQogICAgICAgICAgICAgICAgICAgIGNsaWVudF9wcm9jZXNzLmtpbGwoKQogICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtMQ==
--001a11c2bb1ee78ce10502b6085f--
