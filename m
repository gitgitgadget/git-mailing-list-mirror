From: Lin Mac <mkl0301@gmail.com>
Subject: How do I ignore the changes made by CVS keyword substitution 
	efficiently?
Date: Fri, 4 Jun 2010 03:13:29 +0800
Message-ID: <AANLkTilhvjn1ypRoKs2CxJdA1zDkaT5i64vh0ZtfjwMk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=00504502ad2c72506604882500f2
To: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jun 03 21:13:43 2010
connect(): No such file or directory
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OKFrK-0007NP-Bc
	for glk-linux-kernel-3@lo.gmane.org; Thu, 03 Jun 2010 21:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753046Ab0FCTNc (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 3 Jun 2010 15:13:32 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38132 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab0FCTNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2010 15:13:31 -0400
Received: by pvg16 with SMTP id 16so214126pvg.19
        for <multiple recipients>; Thu, 03 Jun 2010 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=oMkFURibDEfIQK6wEiFZwAp8EJLuVh660muWY+nVHS4=;
        b=OnIb3gmpykRAG3Fl7Dny6CCiY2INh/HixcicM2+L/D04208fsUsIkkvWq3ru9ZLVoP
         gQBBSBP0SMjJZ8clb28ZeW6tBmVNG0rH/J3m/K2wR/O8B5O9gsVSnbq84N5JoxFeXUVc
         1DNDkjtsBfWOe97h5mH1WfyjzFer517YgEfzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=OJoO6yJ01E6A93ztCijoruO6MMlS3ctwkVJFhIkxk2oROkX1IuFdesMEmLAbCn541F
         1+gBGurn4412ltl5v9KLT3LiPGdIkw8xVNfzAS/7RlcX8cVTJSET+oueLV/PTziIUBoN
         PQGTpxn/ALGrBcEgWl5mceFfajihRsIS7tQP4=
Received: by 10.142.3.19 with SMTP id 19mr7082585wfc.200.1275592409501; Thu, 
	03 Jun 2010 12:13:29 -0700 (PDT)
Received: by 10.140.134.6 with HTTP; Thu, 3 Jun 2010 12:13:29 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148354>

--00504502ad2c72506604882500f2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I'm merging kernel from others, and they used CVS to manage their
code, and so do some part of linux kernel. Unfortunatly CVS would
substitude the keywords in the source, result in unecessary changes in
the code, like the one in the following diff. In fact, there are
around 1174 of CVS keywords in the kernel source. I don't want those
useless changes to get into my tree.

Currently I use the attached scripts to as a basic filter, which could
filter out 1-line changes by CVS keyword in a patch. But I still have
to handle other cases (multi-line changes, $Log, which would result in
log of latest commit) myself.

Do you have better idea to get this task done?

diff --git a/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
b/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
index d9b0868..c7bb74b 100644
--- a/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
+++ b/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
@@ -1,6 +1,6 @@
 Linux 2.4 on the CRIS architecture
 ==================================
-$Id: README,v 1.7 2001/04/19 12:38:32 bjornw Exp $
+$Id: README,v 1.1 2010-05-14 09:47:54 XXXXXXXX Exp $

 This is a port of Linux 2.4 to Axis Communications ETRAX 100LX embedded
 network CPU. For more information about CRIS and ETRAX please see further
@@ -103,7 +103,7 @@ block: queued sectors max/low 9109kB/3036kB, 64
slots per queue
 ETRAX 100LX 10/100MBit ethernet v2.0 (c) 2000 Axis Communications AB
 eth0 initialized
 eth0: changed MAC to 00:40:8C:CD:00:00
-ETRAX 100LX serial-driver $Revision: 1.7 $, (c) 2000 Axis Communications AB
+ETRAX 100LX serial-driver $Revision: 1.1 $, (c) 2000 Axis Communications AB
 ttyS0 at 0xb0000060 is a builtin UART with DMA
 ttyS1 at 0xb0000068 is a builtin UART with DMA
 ttyS2 at 0xb0000070 is a builtin UART with DMA
@@ -133,7 +133,7 @@ Default gateway is 10.13.9.1
 Hostname is bbox1
 Telnetd starting, using port 23.
   using /bin/sash as shell.
-sftpd[15]: sftpd $Revision: 1.7 $ starting up
+sftpd[15]: sftpd $Revision: 1.1 $ starting up

--00504502ad2c72506604882500f2
Content-Type: application/octet-stream; 
	name="undo-cvs-tag-one-line-chage.pl"
Content-Disposition: attachment; filename="undo-cvs-tag-one-line-chage.pl"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9zxt4500

IyEvdXNyL2Jpbi9wZXJsCiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCnN1YiByZXBsYWNlCiAgIHsKICAgICAgJGkgPSAwOwogICAgICBwcmludCAkXzsKICAgICAg
d2hpbGUoMSkKICAgICAgICAgewogICAgICAgICAgICAkbGluZSA9IDxGTj47CiAgICAgICAgICAg
IHByaW50ICRsaW5lOwogICAgICAgICAgICBpZigkbGluZSA9fiAnXi0uKlwkKFJldmlzaW9ufExv
Z3xJZHxEYXRlfEhlYWRlcnxBdXRob3J8TG9ja2VyfE5hbWV8UkNTZmlsZXxTb3VyY2V8U3RhdGUp
LipcJCcgKQogICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICRsaW5lMiA9IDxGTj47
CiAgICAgICAgICAgICAgICAgIGlmKCAkbGluZTIgPX4gJ15cKy4qXCQoUmV2aXNpb258TG9nfElk
fERhdGV8SGVhZGVyfEF1dGhvcnxMb2NrZXJ8TmFtZXxSQ1NmaWxlfFNvdXJjZXxTdGF0ZSk6Lipc
JCcpewogICAgICAgICAgICAgICAgICAgICAgJGxpbmUyID0gJGxpbmU7CiAgICAgICAgICAgICAg
ICAgICAgICAkbGluZTIgPX4gcy8tLysvOwogICAgICAgICAgICAgICAgICB9CiAgICAgICAgICAg
ICAgICAgIHByaW50ICRsaW5lMjsKICAgICAgICAgICAgICAgICAgcmV0dXJuOwogICAgICAgICAg
ICAgICB9CiAgICAgICAgICAgICRpKys7CiAgICAgICAgICAgIGlmKCRpPj01KXtyZXR1cm47fQog
ICAgICAgICB9CiAgIH0KIyAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KJGZuID0gQEFSR1ZbMF07CiMgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCmlmKCFkZWZpbmVkKCRmbikpCiAgIHsKICAgICAgcHJpbnQgIlxuTm8gRmlsZW5hbWUg
IVxuXG4iOwogICAgICBwcmludCAidXNhZ2U6ICQwIFwkZmlsZW5hbWVcblxuIjsKICAgICAgZXhp
dDsKICAgfQojIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpvcGVu
KEZOLCRmbik7CndoaWxlKDxGTj4pCiAgIHsKICAgICAgaWYoJF89fiAiXF5AQCIpeyZyZXBsYWNl
KCk7fQogICAgICBlbHNle3ByaW50ICRfO30KICAgfQpjbG9zZShGTik7CiMgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCg==
--00504502ad2c72506604882500f2
Content-Type: application/x-sh; name="refine.sh"
Content-Disposition: attachment; filename="refine.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g9zxtac41

IyEvYmluL3NoCgppZiBbICJ4eCQxIiA9ICJ4eCIgXSA7IHRoZW4gZWNobyBuZWVkIHRhcmdldCBw
YXRjaC4uLjsgZXhpdCAxOyBmaTsKaWYgWyAieHgkMiIgPSAieHgiIF0gOyB0aGVuIGVjaG8gbmVl
ZCBvdXRwdXQgcGF0Y2guLi47IGV4aXQgMTsgZmk7CgpUT19ESVI9YGRpcm5hbWUgJDBgOwoKcm0g
dG1wMCB0bXAxIHRtcDIKY3AgJDEgdG1wMCAKdG91Y2ggdG1wMQpjb3VudD0xOwoKZ2l0IHJlc2V0
IC0taGFyZCAxPi9kZXYvbnVsbCAgfHwgZXhpdCAxCndoaWxlICEgY21wIHRtcDAgdG1wMSAxPi9k
ZXYvbnVsbCA7IGRvIAplY2hvICRjb3VudCAuLi4KY3AgdG1wMCB0bXAxIDsKJHtUT19ESVJ9L3Vu
ZG8tY3ZzLXRhZy1vbmUtbGluZS1jaGFnZS5wbCB0bXAxID4gdG1wMiA7CmdpdCByZXNldCAtLWhh
cmQgMT4vZGV2L251bGwgIHx8IGV4aXQgMQppZiAhIHBhdGNoIC1pIHRtcDIgLXAgMyAtZiAxPi9k
ZXYvbnVsbDsgdGhlbiAgZWNobyBwYXRjaCBmYWlsZWQuLi47ZXhpdCAxIDsgZmkKZ2l0IGRpZmYg
LiA+IHRtcDA7CmNvdW50PSQoKCRjb3VudCsxKSkKZG9uZTsKCmVjaG8gZG9uZS4uLi4KZ2l0IHJl
c2V0IC0taGFyZCAxPi9kZXYvbnVsbCB8fCBleGl0IDEKY3AgdG1wMCAkMiAtdgo=
--00504502ad2c72506604882500f2--
