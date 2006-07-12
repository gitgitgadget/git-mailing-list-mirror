From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: remove perl from git-commit.sh
Date: Wed, 12 Jul 2006 13:15:03 +0200
Message-ID: <81b0412b0607120415g243f2160tf42c40e52b8bc9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_65181_9782251.1152702903385"
Cc: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jul 12 13:15:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0cgQ-0007q4-4a
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 13:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWGLLPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 07:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWGLLPF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 07:15:05 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:17744 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750760AbWGLLPE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 07:15:04 -0400
Received: by wr-out-0506.google.com with SMTP id 58so91869wri
        for <git@vger.kernel.org>; Wed, 12 Jul 2006 04:15:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=rz9eZWvj01PqJLgIywV3dlEydysp73AjEHvdckexBJoCNrL80/YLcDuTn7Sz37gGRkmPvO1tee5kpUvKkAaKjQA1xTk8qmkc8PFVbPTjkwn4lX321qst4Dx8eMr4o+r7VvNuy0QiEB2NifhPat15wPWR4MRZtrUkcTcIhRChdqg=
Received: by 10.82.103.11 with SMTP id a11mr55451buc;
        Wed, 12 Jul 2006 04:15:03 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Wed, 12 Jul 2006 04:15:03 -0700 (PDT)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23773>

------=_Part_65181_9782251.1152702903385
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

It is really annoying when the essentials do not work.
I think we could improve at  least them, by minimizing
their dependencies to external tools.

---

git-commit.sh has only ohne place where perl is used
and it can actually quite trivially be done in sh.
git-ls-files without "-z" produces quoted output, even if
is different from that produced by perl code it could be
enough. Otherwise I'd better suggest to add another
quoting style (replacing only \t, \n and backslash) than
having to constantly patch git-commit.sh for binmode
or perl path (Windows has no stable tool set, and perl
for instance often resides "somewhere").

------=_Part_65181_9782251.1152702903385
Content-Type: text/plain; name=0001-remove-perl-from-git-commit.sh.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_epjlg5nq
Content-Disposition: attachment; filename="0001-remove-perl-from-git-commit.sh.txt"

RnJvbSA2OWJmNDFkZjRlZjY5ZDBmMWU0YWI1Mjk0MmM1OWJiM2ZkNTY4Y2I4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBXZWQsIDEyIEp1bCAyMDA2IDEzOjAyOjIzICswMjAwClN1YmplY3Q6IHJlbW92ZSBwZXJsIGZy
b20gZ2l0LWNvbW1pdC5zaAotLS0KIGdpdC1jb21taXQuc2ggfCAgIDMyICsrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE5
IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdC1jb21taXQuc2ggYi9naXQtY29tbWl0LnNo
CmluZGV4IDgwMmRkNzIuLjRjZjNmYWIgMTAwNzU1Ci0tLSBhL2dpdC1jb21taXQuc2gKKysrIGIv
Z2l0LWNvbW1pdC5zaApAQCAtMTM4LDMyICsxMzgsMjYgQEAgIycKICAgICAgICAgaWYgdGVzdCAt
eiAiJHVudHJhY2tlZF9maWxlcyI7IHRoZW4KICAgICAgICAgICAgIG9wdGlvbj0iLS1kaXJlY3Rv
cnkgLS1uby1lbXB0eS1kaXJlY3RvcnkiCiAgICAgICAgIGZpCisJaGRyX3Nob3duPQogCWlmIHRl
c3QgLWYgIiRHSVRfRElSL2luZm8vZXhjbHVkZSIKIAl0aGVuCi0JICAgIGdpdC1scy1maWxlcyAt
eiAtLW90aGVycyAkb3B0aW9uIFwKKwkgICAgZ2l0LWxzLWZpbGVzIC0tb3RoZXJzICRvcHRpb24g
XAogCQktLWV4Y2x1ZGUtZnJvbT0iJEdJVF9ESVIvaW5mby9leGNsdWRlIiBcCiAJCS0tZXhjbHVk
ZS1wZXItZGlyZWN0b3J5PS5naXRpZ25vcmUKIAllbHNlCi0JICAgIGdpdC1scy1maWxlcyAteiAt
LW90aGVycyAkb3B0aW9uIFwKKwkgICAgZ2l0LWxzLWZpbGVzIC0tb3RoZXJzICRvcHRpb24gXAog
CQktLWV4Y2x1ZGUtcGVyLWRpcmVjdG9yeT0uZ2l0aWdub3JlCiAJZmkgfAotCUBAUEVSTEBAIC1l
ICckLyA9ICJcMCI7Ci0JICAgIG15ICRzaG93biA9IDA7Ci0JICAgIHdoaWxlICg8PikgewotCQlj
aG9tcDsKLQkJc3xcXHxcXFxcfGc7Ci0JCXN8XHR8XFx0fGc7Ci0JCXN8XG58XFxufGc7Ci0JCXMv
Xi8jCS87Ci0JCWlmICghJHNob3duKSB7Ci0JCSAgICBwcmludCAiI1xuIyBVbnRyYWNrZWQgZmls
ZXM6XG4iOwotCQkgICAgcHJpbnQgIiMgICAodXNlIFwiZ2l0IGFkZFwiIHRvIGFkZCB0byBjb21t
aXQpXG4iOwotCQkgICAgcHJpbnQgIiNcbiI7Ci0JCSAgICAkc2hvd24gPSAxOwotCQl9Ci0JCXBy
aW50ICIkX1xuIjsKLQkgICAgfQotCScKKwl3aGlsZSByZWFkIGxpbmU7IGRvCisJICAgIGlmIFsg
LXogIiRoZHJfc2hvd24iIF07IHRoZW4KKwkJZWNobyAnIycKKwkJZWNobyAnIyBVbnRyYWNrZWQg
ZmlsZXM6JworCQllY2hvICcjICAgKHVzZSAiZ2l0IGFkZCIgdG8gYWRkIHRvIGNvbW1pdCknCisJ
CWVjaG8gJyMnCisJCWhkcl9zaG93bj0xCisJICAgIGZpCisJICAgIGVjaG8gIiMJJGxpbmUiCisJ
ZG9uZQogCiAJaWYgdGVzdCAtbiAiJHZlcmJvc2UiIC1hIC16ICIkSVNfSU5JVElBTCIKIAl0aGVu
Ci0tIAoxLjQuMS5nYjRhZGYKCg==
------=_Part_65181_9782251.1152702903385--
