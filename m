From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: [PATCH] Fix git-update-index to work with relative pathnames
Date: Wed, 31 Jan 2007 14:48:57 +0100
Message-ID: <81b0412b0701310548i2925045cr598765b9e7d67b36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3224_31379432.1170251337105"
Cc: "Junio C Hamano" <junkio@cox.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 14:49:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCFpg-00082a-8c
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 14:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933141AbXAaNs7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 08:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933274AbXAaNs7
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 08:48:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:8177 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933141AbXAaNs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 08:48:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so173823uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 05:48:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=b+XCuQTkhMbMxPINiKgoWCga4R/+YJwZ9qKWIHchq7CXa06VOa5BNvUO93c6U1pz42BPMMyH1Du5fUzJwABC4yttdwmq+lBaaHgNJwftAgO0akY0tlOF/xFQbatJGQ59z4wCEjc6QDTWZ4UOAxOKH5b1B7WWGnW6RBrJO2Eee2A=
Received: by 10.78.166.7 with SMTP id o7mr164259hue.1170251337184;
        Wed, 31 Jan 2007 05:48:57 -0800 (PST)
Received: by 10.78.139.7 with HTTP; Wed, 31 Jan 2007 05:48:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38250>

------=_Part_3224_31379432.1170251337105
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In particular, it fixes the following (typical for cygwin) problem:

    $ git-update-index --chmod=-x ../wrapper/Jamfile
    fatal: git-update-index: cannot chmod -x '../wrapper/Jamfile'

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 builtin-update-index.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

------=_Part_3224_31379432.1170251337105
Content-Type: text/plain; name="0001-Fix-git-update-index-to-work-with-relative-pathnames.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="0001-Fix-git-update-index-to-work-with-relative-pathnames.txt"
X-Attachment-Id: f_exltg5cf

RnJvbSBlNDNhY2QxN2NjZGQwYjA0NWE5MmZlMTQzOTU1NGIzMTBlMzU3OWM0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDMxIEphbiAyMDA3IDE0OjM0OjE3ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGdp
dC11cGRhdGUtaW5kZXggdG8gd29yayB3aXRoIHJlbGF0aXZlIHBhdGhuYW1lcy4KCkluIHBhcnRp
Y3VsYXIsIGl0IGZpeGVzIHRoZSBmb2xsb3dpbmcgKHR5cGljYWwgZm9yIGN5Z3dpbikgcHJvYmxl
bToKCiAgICAkIGdpdC11cGRhdGUtaW5kZXggLS1jaG1vZD0teCAuLi93cmFwcGVyL0phbWZpbGUK
ICAgIGZhdGFsOiBnaXQtdXBkYXRlLWluZGV4OiBjYW5ub3QgY2htb2QgLXggJy4uL3dyYXBwZXIv
SmFtZmlsZScKClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+
Ci0tLQogYnVpbHRpbi11cGRhdGUtaW5kZXguYyB8ICAgIDggKysrKysrLS0KIDEgZmlsZXMgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2J1aWx0
aW4tdXBkYXRlLWluZGV4LmMgYi9idWlsdGluLXVwZGF0ZS1pbmRleC5jCmluZGV4IDE4MjMzMWQu
LjgyMzY0YzEgMTAwNjQ0Ci0tLSBhL2J1aWx0aW4tdXBkYXRlLWluZGV4LmMKKysrIGIvYnVpbHRp
bi11cGRhdGUtaW5kZXguYwpAQCAtNTAxLDYgKzUwMSw3IEBAIGludCBjbWRfdXBkYXRlX2luZGV4
KGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgY29uc3QgY2hhciAqcHJlZml4KQogCiAJZm9y
IChpID0gMSA7IGkgPCBhcmdjOyBpKyspIHsKIAkJY29uc3QgY2hhciAqcGF0aCA9IGFyZ3ZbaV07
CisJCWNoYXIgKnA7CiAKIAkJaWYgKGFsbG93X29wdGlvbnMgJiYgKnBhdGggPT0gJy0nKSB7CiAJ
CQlpZiAoIXN0cmNtcChwYXRoLCAiLS0iKSkgewpAQCAtNjE2LDkgKzYxNywxMiBAQCBpbnQgY21k
X3VwZGF0ZV9pbmRleChpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YsIGNvbnN0IGNoYXIgKnBy
ZWZpeCkKIAkJCQl1c2FnZSh1cGRhdGVfaW5kZXhfdXNhZ2UpOwogCQkJZGllKCJ1bmtub3duIG9w
dGlvbiAlcyIsIHBhdGgpOwogCQl9Ci0JCXVwZGF0ZV9vbmUocGF0aCwgcHJlZml4LCBwcmVmaXhf
bGVuZ3RoKTsKKwkJcCA9IHByZWZpeF9wYXRoKHByZWZpeCwgcHJlZml4X2xlbmd0aCwgcGF0aCk7
CisJCXVwZGF0ZV9vbmUocCwgTlVMTCwgMCk7CiAJCWlmIChzZXRfZXhlY3V0YWJsZV9iaXQpCi0J
CQljaG1vZF9wYXRoKHNldF9leGVjdXRhYmxlX2JpdCwgcGF0aCk7CisJCQljaG1vZF9wYXRoKHNl
dF9leGVjdXRhYmxlX2JpdCwgcCk7CisJCWlmIChwIDwgcGF0aCB8fCBwID4gcGF0aCArIHN0cmxl
bihwYXRoKSkKKwkJCWZyZWUocCk7CiAJfQogCWlmIChyZWFkX2Zyb21fc3RkaW4pIHsKIAkJc3Ry
dWN0IHN0cmJ1ZiBidWY7Ci0tIAoxLjUuMC5yYzIuMTUwLmdkMTc0ZQoK
------=_Part_3224_31379432.1170251337105--
