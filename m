From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Cleanup uninitialized value in chomp
Date: Mon, 22 Jan 2007 15:59:27 +0100
Message-ID: <81b0412b0701220659n3699a65cl2c5c34023717c52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_155173_33404381.1169477967691"
Cc: "Junio C Hamano" <junkio@cox.net>, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 22 15:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H90dy-0007Hg-08
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 15:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbXAVO7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 09:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbXAVO7a
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 09:59:30 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:59000 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbXAVO73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 09:59:29 -0500
Received: by wr-out-0506.google.com with SMTP id i22so676950wra
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 06:59:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=SAGBKviPi+EB/hQwqhG8Ba759tOA4KW4ihr+F8HlpiwO1+ZZemT0GJ6MVeB7CVQcW6+vkydmaD42J6bRiIbE3jbXU8DagoObAJbkIAOn7gQOH0lwJ0wuXI+0jApqrobC0lUQxPfH5TyYBOKqb3AsY4vlG/LTfMD2hd+nV0wCGCA=
Received: by 10.90.49.19 with SMTP id w19mr6267349agw.1169477967784;
        Mon, 22 Jan 2007 06:59:27 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 22 Jan 2007 06:59:27 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37414>

------=_Part_155173_33404381.1169477967691
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

which happens if you use ActiveState Perl and a
pipe workaround specially for it.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

This probably can happen anywhere.

 perl/Git.pm |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_155173_33404381.1169477967691
Content-Type: application/xxxxx; 
	name=0003-Cleanup-uninitialized-value-in-chomp.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ex90z98s
Content-Disposition: attachment; filename="0003-Cleanup-uninitialized-value-in-chomp.patch"

RnJvbSA4OGZjYWVlYTg4ZmU4YzFlYmI4NDU2ZjhmNDA1ODU2MDM1OGM1YTc2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBNb24sIDIyIEphbiAyMDA3IDE1OjU4OjAzICswMTAwClN1YmplY3Q6IFtQQVRDSF0gQ2xlYW51
cCB1bmluaXRpYWxpemVkIHZhbHVlIGluIGNob21wCgp3aGljaCBoYXBwZW5zIGlmIHlvdSB1c2Ug
QWN0aXZlU3RhdGUgUGVybCBhbmQgYQpwaXBlIHdvcmthcm91bmQgc3BlY2lhbGx5IGZvciBpdC4K
LS0tCiBwZXJsL0dpdC5wbSB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3BlcmwvR2l0LnBtIGIvcGVybC9HaXQu
cG0KaW5kZXggM2IzMmEyOC4uYTdkOGNkMSAxMDA2NDQKLS0tIGEvcGVybC9HaXQucG0KKysrIGIv
cGVybC9HaXQucG0KQEAgLTI3NSw3ICsyNzUsNyBAQCBzdWIgY29tbWFuZCB7CiAKIAl9IGVsc2Ug
ewogCQlteSBAbGluZXMgPSA8JGZoPjsKLQkJY2hvbXAgQGxpbmVzOworCQlkZWZpbmVkIGFuZCBj
aG9tcCBmb3IgQGxpbmVzOwogCQl0cnkgewogCQkJX2NtZF9jbG9zZSgkZmgsICRjdHgpOwogCQl9
IGNhdGNoIEdpdDo6RXJyb3I6OkNvbW1hbmQgd2l0aCB7Ci0tIAoxLjUuMC5yYzIuZzNmMWEKCg==

------=_Part_155173_33404381.1169477967691--
