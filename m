From: Tuomo Tanskanen <tuomo@tanskanen.org>
Subject: BUG: git_work_tree issue with git alias and scripting
Date: Fri, 18 Sep 2015 10:33:44 +0300
Message-ID: <CAE_UwRp7LB0E636u9cOEisMgJi3xApAVPPH_T2Hpkm43DS5F0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f46d043c06e08e6a720520008f84
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 18 09:34:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcqBi-0004Il-0z
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 09:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046AbbIRHeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 03:34:25 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:36280 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbbIRHeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 03:34:25 -0400
Received: by wicgb1 with SMTP id gb1so20205792wic.1
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 00:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=u1KaDvNwjR2jMI3g7GBkwEJ7jGB5dfUI4RzJP+WpWas=;
        b=XEJif95cvlIUCJwyPBvz1PkBnWcCuIx/d0t4mz1kWEoQ8BiTxE1Ync4BaY9FsMcMwT
         z1hLCrKfy8osw/dEJ+mXtLAVFQjlzhwbMpJY7xMNGN22ZKTU5vwwmtcWPbWfOTUH3Fny
         yI+/2F9hJPA3lOj6EPBDAA/GupYCYBc1MBDBQHzcc7C4BtgJ5eD77ftiXzGMMhRh5Uvj
         NLQP+azgIOQLx9twU+fsHCQL1GxOBZId1Wc05wz1DH3TDUEjVxD+ulBilcGQfcl2oHcj
         R5zJ4vZGGiHKNGCsA3rZPPXmGWrtI48WUkHHj9zCelkTe59rkIzWFROayUuYO0xA5l8/
         98Hg==
X-Received: by 10.180.84.163 with SMTP id a3mr36956352wiz.34.1442561664108;
 Fri, 18 Sep 2015 00:34:24 -0700 (PDT)
Received: by 10.28.127.131 with HTTP; Fri, 18 Sep 2015 00:33:44 -0700 (PDT)
X-Google-Sender-Auth: BcPEphbC2xYG5-6O3gp7vNNYFAo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278182>

--f46d043c06e08e6a720520008f84
Content-Type: text/plain; charset=UTF-8

Hello,

Attached is a simple script exposing a possible bug when git alias is
combined with git commands in script. It should be pretty self-explanatory.
Check what it does and execute it. On my Linux and OSX, both with git 2.5.1
behave the same, ie. git add fails even the file "test" is in $PWD.

Summary: $GIT_WORK_TREE persists in env, and then some git commands operate
on repo in $PWD (like git log), while some others (like git add) operate on
repo in $GIT_WORK_TREE, making it inconsistent and results in very
unexpected results.

Cheers, Tuomo

--f46d043c06e08e6a720520008f84
Content-Type: application/x-sh; name="gitbug.sh"
Content-Disposition: attachment; filename="gitbug.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iepbxrkn0

IyEvYmluL3NoCgojIHNldHVwIHNlY29uZGFyeSBnaXQKbWtkaXIgYmFyCmNkIGJhcgpnaXQgaW5p
dAplY2hvICJ0ZXN0IiA+IGJhcgpnaXQgYWRkIGJhcgpnaXQgY29tbWl0IC1tICJ0ZXN0IGNvbW1p
dCBpbiBiYXIiCmVjaG8gImFkZGluZyB0aGlzIHdpbGwgZmFpbCBsYXRlciBvbiIgPiB0ZXN0CmNk
IC4uCgojIHNldHVwIHByaW1hcnkgZ2l0IHdpdGggYWxpYXMgYW5kIHNjcmlwdCB0aGF0IGFsaWFz
IHdpbGwgZXhlY3V0ZQpta2RpciBmb28KY2QgZm9vCmdpdCBpbml0CgpjYXQgPmZvby5zaCA8PEVP
RgojIS9iaW4vc2ggLXgKY2QgJFBXRC8uLi9iYXIKZW52IHwgZWdyZXAgIl4oR0lUX1dPUktfVFJF
RXxQV0QpIgplY2hvICJHaXQgbG9nIHdvcmtzIChiYXIgbG9nIHNob3dzIHVwKToiCmdpdCBsb2cg
LS1vbmVsaW5lIHwgaGVhZCAtMQplY2hvICJHaXQgYWRkIGRvZXMgbm90ICh0cmllcyB0byBhZGQg
ZmlsZXMgaW4gZm9vLCB3aGlsZSBQV0QgaXMgaW4gYmFyKToiCmdpdCBhZGQgdGVzdApFT0YKY2ht
b2QgNzU1IGZvby5zaAoKY2F0ID4+LmdpdC9jb25maWcgPDxFT0YKW2FsaWFzXQogIGZvbyA9ICEk
UFdEL2Zvby5zaApFT0YKCmdpdCBhZGQgZm9vLnNoCmdpdCBjb21taXQgLW0gImNvbW1pdHRpbmcg
Zm9vLnNoIgoKIyB0ZXN0IGNhc2U6IHVzaW5nIGFsaWFzLCBjZCBpbnRvIGFub3RoZXIgZ2l0IHRy
ZWUsIGFuZCB0cnkgdG8gZG8gZ2l0IG9wZXJhdGlvbiBvbiBUSEFUIGRpcgojIEdJVF9XT1JLX1RS
RUUgZ2V0cyBzZXQgdXAgaW50byAiZm9vIiwgYW5kIHdoaWxlIFBXRCBpcyBpbiAiYmFyIiwgc29t
ZSBnaXQgb3BzIGRvIHdvcmsgb24gV1JPTkcgVFJFRSEKZ2l0IGZvbwoK
--f46d043c06e08e6a720520008f84--
