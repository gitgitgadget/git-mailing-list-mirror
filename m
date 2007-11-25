From: "=?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: [Resend PATCH] Avoid recalculating filename string pointer.
Date: Sun, 25 Nov 2007 19:43:58 -0200
Message-ID: <b8bf37780711251343s7f10804fmd2558d38dc434eb4@mail.gmail.com>
References: <b8bf37780711211659i65a99493te3e3d5cee008ae7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33525_8133450.1196027038970"
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 22:44:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwPH7-0003UT-0P
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 22:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755202AbXKYVoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 16:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755215AbXKYVoD
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 16:44:03 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:18674 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755202AbXKYVoB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 16:44:01 -0500
Received: by ug-out-1314.google.com with SMTP id z38so809143ugc
        for <git@vger.kernel.org>; Sun, 25 Nov 2007 13:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=DLL38XkD/gquS9FTG0x+IBZ2i92svl178PJaLUWst+Y=;
        b=FmixtI1BzaJbPvUTJ0ehn7gQNk4G+ze2Ddv3EG35MGl+THDnVu5bJdmaPAbte89dqbQQJuxQcaLhOxxLpjU+DWx7/a84aY4pWFQVbLutgoCsex02n5Sjc9ebgBy+RWML9w6aJaqv2TbJT1gMoJgbUIFnSXxs9WYOXAXJq5s2k4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=xGXtsPJzq135FxSxC8w+HyuDt87ft8Sskby+ZB3p23MSOoeCbHmMGFdmyAX8tXcFvEkEx9yK0N9lOJnbj0ZqOMC85TgD688lb7G0/mRYxQwTXniZmlLrds+pH4qIIecn23P4hI6/9xvO10nKoXoZakvTcTqPQp9/DC3/QZ5rYUw=
Received: by 10.78.157.19 with SMTP id f19mr2129726hue.1196027039243;
        Sun, 25 Nov 2007 13:43:59 -0800 (PST)
Received: by 10.78.120.18 with HTTP; Sun, 25 Nov 2007 13:43:58 -0800 (PST)
In-Reply-To: <b8bf37780711211659i65a99493te3e3d5cee008ae7d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66012>

------=_Part_33525_8133450.1196027038970
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Disposition: inline

SGksIGFsbCEKCiAgIEF2b2lkIGNhbGN1bGF0aW5nIHN0cmluZyBwb3NpdGlvbiBpbiAyIGRpZmZl
cmVudCBwbGFjZXMuCgpGcm9tIGI2YjA1ZDlmOGQ4ZTA1M2RmNGU5NzFjZDIyOWUwM2I3NzhjNGQx
NjMgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEFuZHJlIEdvZGRhcmQgUm9zYSA8YW5k
cmUuZ29kZGFyZEBnbWFpbC5jb20+CkRhdGU6IFR1ZSwgMjcgTm92IDIwMDcgMTA6MTc6NTQgLTAy
MDAKU3ViamVjdDogW1BBVENIXSBBdm9pZCByZWNhbGN1bGF0aW5nIGZpbGVuYW1lIHN0cmluZyBw
b2ludGVyLgoKU2lnbmVkLW9mZi1ieTogQW5kcmUgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJk
QGdtYWlsLmNvbT4KLS0tCiBmYXN0LWltcG9ydC5jIHwgICAgNiArKysrLS0KIDEgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Zhc3Qt
aW1wb3J0LmMgYi9mYXN0LWltcG9ydC5jCmluZGV4IDk4YzJiZDUuLjJkMjYyZWIgMTAwNjQ0Ci0t
LSBhL2Zhc3QtaW1wb3J0LmMKKysrIGIvZmFzdC1pbXBvcnQuYwpAQCAtMjMwNCwxMSArMjMwNCwx
MyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFyZ3YpCiAgICAgICAgICAgICAg
ICBlbHNlIGlmICghcHJlZml4Y21wKGEsICItLWV4cG9ydC1tYXJrcz0iKSkKICAgICAgICAgICAg
ICAgICAgICAgICAgbWFya19maWxlID0gYSArIDE1OwogICAgICAgICAgICAgICAgZWxzZSBpZiAo
IXByZWZpeGNtcChhLCAiLS1leHBvcnQtcGFjay1lZGdlcz0iKSkgeworICAgICAgICAgICAgICAg
ICAgICAgICBjaGFyICpmaWxlbmFtZSA9IGEgKyAyMDsKKwogICAgICAgICAgICAgICAgICAgICAg
ICBpZiAocGFja19lZGdlcykKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmY2xvc2Uo
cGFja19lZGdlcyk7Ci0gICAgICAgICAgICAgICAgICAgICAgIHBhY2tfZWRnZXMgPSBmb3Blbihh
ICsgMjAsICJhIik7CisgICAgICAgICAgICAgICAgICAgICAgIHBhY2tfZWRnZXMgPSBmb3Blbihm
aWxlbmFtZSwgImEiKTsKICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFwYWNrX2VkZ2VzKQot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGRpZSgiQ2Fubm90IG9wZW4gJXM6ICVzIiwg
YSArIDIwLApzdHJlcnJvcihlcnJubykpOworICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGRpZSgiQ2Fubm90IG9wZW4gJXM6ICVzIiwgZmlsZW5hbWUsCnN0cmVycm9yKGVycm5vKSk7CiAg
ICAgICAgICAgICAgICB9IGVsc2UgaWYgKCFzdHJjbXAoYSwgIi0tZm9yY2UiKSkKICAgICAgICAg
ICAgICAgICAgICAgICAgZm9yY2VfdXBkYXRlID0gMTsKICAgICAgICAgICAgICAgIGVsc2UgaWYg
KCFzdHJjbXAoYSwgIi0tcXVpZXQiKSkKLS0KMS41LjMuNi44NjEuZ2Q3OTQtZGlydHkKCgoKLS0g
CltdcywKQW5kcsOpIEdvZGRhcmQK
------=_Part_33525_8133450.1196027038970
Content-Type: text/x-patch;
 name=0003-Avoid-recalculating-filename-string-pointer.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f9akp7470
Content-Disposition: attachment;
 filename=0003-Avoid-recalculating-filename-string-pointer.patch

RnJvbSBiNmIwNWQ5ZjhkOGUwNTNkZjRlOTcxY2QyMjllMDNiNzc4YzRkMTYzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRyZSBHb2RkYXJkIFJvc2EgPGFuZHJlLmdvZGRhcmRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDI3IE5vdiAyMDA3IDEwOjE3OjU0IC0wMjAwClN1YmplY3Q6IFtQ
QVRDSF0gQXZvaWQgcmVjYWxjdWxhdGluZyBmaWxlbmFtZSBzdHJpbmcgcG9pbnRlci4KClNpZ25l
ZC1vZmYtYnk6IEFuZHJlIEdvZGRhcmQgUm9zYSA8YW5kcmUuZ29kZGFyZEBnbWFpbC5jb20+Ci0t
LQogZmFzdC1pbXBvcnQuYyB8ICAgIDYgKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mYXN0LWltcG9ydC5jIGIvZmFz
dC1pbXBvcnQuYwppbmRleCA5OGMyYmQ1Li4yZDI2MmViIDEwMDY0NAotLS0gYS9mYXN0LWltcG9y
dC5jCisrKyBiL2Zhc3QtaW1wb3J0LmMKQEAgLTIzMDQsMTEgKzIzMDQsMTMgQEAgaW50IG1haW4o
aW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQogCQllbHNlIGlmICghcHJlZml4Y21wKGEsICIt
LWV4cG9ydC1tYXJrcz0iKSkKIAkJCW1hcmtfZmlsZSA9IGEgKyAxNTsKIAkJZWxzZSBpZiAoIXBy
ZWZpeGNtcChhLCAiLS1leHBvcnQtcGFjay1lZGdlcz0iKSkgeworCQkJY2hhciAqZmlsZW5hbWUg
PSBhICsgMjA7CisKIAkJCWlmIChwYWNrX2VkZ2VzKQogCQkJCWZjbG9zZShwYWNrX2VkZ2VzKTsK
LQkJCXBhY2tfZWRnZXMgPSBmb3BlbihhICsgMjAsICJhIik7CisJCQlwYWNrX2VkZ2VzID0gZm9w
ZW4oZmlsZW5hbWUsICJhIik7CiAJCQlpZiAoIXBhY2tfZWRnZXMpCi0JCQkJZGllKCJDYW5ub3Qg
b3BlbiAlczogJXMiLCBhICsgMjAsIHN0cmVycm9yKGVycm5vKSk7CisJCQkJZGllKCJDYW5ub3Qg
b3BlbiAlczogJXMiLCBmaWxlbmFtZSwgc3RyZXJyb3IoZXJybm8pKTsKIAkJfSBlbHNlIGlmICgh
c3RyY21wKGEsICItLWZvcmNlIikpCiAJCQlmb3JjZV91cGRhdGUgPSAxOwogCQllbHNlIGlmICgh
c3RyY21wKGEsICItLXF1aWV0IikpCi0tIAoxLjUuMy42Ljg2MS5nZDc5NC1kaXJ0eQoK
------=_Part_33525_8133450.1196027038970--
