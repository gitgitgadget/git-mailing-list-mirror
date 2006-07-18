From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: print errors from git-update-ref
Date: Tue, 18 Jul 2006 15:13:48 +0200
Message-ID: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_31922_13738718.1153228428594"
Cc: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jul 18 15:14:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2pOc-0000Tu-B5
	for gcvg-git@gmane.org; Tue, 18 Jul 2006 15:13:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWGRNNv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Jul 2006 09:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWGRNNu
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Jul 2006 09:13:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:48254 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932191AbWGRNNu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jul 2006 09:13:50 -0400
Received: by ug-out-1314.google.com with SMTP id m3so2225389ugc
        for <git@vger.kernel.org>; Tue, 18 Jul 2006 06:13:48 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=O7scoO90jCcGcvR4tFnABJ+cD3u7bXBjb7wDsu03tgRgRZ44UKKbIeZyN7ihFMSZPEU/mDgP9U+grzYktYb7OoRbJZW2uTTyK9tdUjP8/EW5KkGqEQ51curnBB/wjHYmnWUZsXR7+oFuL8u1xWwgwT8N0TXiuy+VEX8JsEx/3RQ=
Received: by 10.78.156.6 with SMTP id d6mr1482059hue;
        Tue, 18 Jul 2006 06:13:48 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Tue, 18 Jul 2006 06:13:48 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23994>

------=_Part_31922_13738718.1153228428594
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

...otherwise it not clear what happened when update-ref fails.

E.g., git checkout -b a/b/c HEAD would print nothing if refs/heads/a
exists and is a directory (it does return 1, so scripts checking for
return code should be ok).

I'm attaching two patches, because I'm not quite sure where it should
be done: git-checkout is the least intrusive, but only builtin-update-ref.c
has enough info to help user to resolve the problem (errno is ENOTDIR,
which is selfexplanatory). And I happen to use git-update-ref directly
sometimes.

------=_Part_31922_13738718.1153228428594
Content-Type: text/plain; 
	name=0001-update-ref-print-errors-otherwise-it-not-clear-what-happened.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_eps9xzcs
Content-Disposition: attachment; filename="0001-update-ref-print-errors-otherwise-it-not-clear-what-happened.txt"

RnJvbSA1Mzk4ZjBlZTZiYWIwMzk3MDE5MTJmZGFmNzg0NzkyZjRjZjc2YWZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDE4IEp1bCAyMDA2IDE0OjUyOjE1ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gdXBkYXRl
LXJlZjogcHJpbnQgZXJyb3JzCgpvdGhlcndpc2UgaXQgbm90IGNsZWFyIHdoYXQgaGFwcGVuZWQK
ClNpZ25lZC1vZmYtYnk6IEFsZXggUmllc2VuIDxyYWEubGttbEBnbWFpbC5jb20+Ci0tLQogYnVp
bHRpbi11cGRhdGUtcmVmLmMgfCAgICA4ICsrKysrKy0tCiAxIGZpbGVzIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9idWlsdGluLXVwZGF0ZS1y
ZWYuYyBiL2J1aWx0aW4tdXBkYXRlLXJlZi5jCmluZGV4IDgzMDk0YWIuLmFkNGE0NGQgMTAwNjQ0
Ci0tLSBhL2J1aWx0aW4tdXBkYXRlLXJlZi5jCisrKyBiL2J1aWx0aW4tdXBkYXRlLXJlZi5jCkBA
IC01MCwxMCArNTAsMTQgQEAgaW50IGNtZF91cGRhdGVfcmVmKGludCBhcmdjLCBjb25zdCBjaGFy
IAogCQlkaWUoIiVzOiBub3QgYSB2YWxpZCBvbGQgU0hBMSIsIG9sZHZhbCk7CiAKIAlsb2NrID0g
bG9ja19hbnlfcmVmX2Zvcl91cGRhdGUocmVmbmFtZSwgb2xkdmFsID8gb2xkc2hhMSA6IE5VTEws
IDApOwotCWlmICghbG9jaykKKwlpZiAoIWxvY2spIHsKKwkJZXJyb3IoIiVzOiAlcyIsIHJlZm5h
bWUsIHN0cmVycm9yKGVycm5vKSk7CiAJCXJldHVybiAxOwotCWlmICh3cml0ZV9yZWZfc2hhMShs
b2NrLCBzaGExLCBtc2cpIDwgMCkKKyAgICAgICAgfQorCWlmICh3cml0ZV9yZWZfc2hhMShsb2Nr
LCBzaGExLCBtc2cpIDwgMCkgeworCQllcnJvcigiJXM6ICVzIiwgcmVmbmFtZSwgc3RyZXJyb3Io
ZXJybm8pKTsKIAkJcmV0dXJuIDE7CisJfQogCiAJLyogd3JpdGVfcmVmX3NoYTEgYWx3YXlzIHVu
bG9ja3MgdGhlIHJlZiwgbm8gbmVlZCB0byBkbyBpdCBleHBsaWNpdGx5ICovCiAJcmV0dXJuIDA7
Ci0tIAoxLjQuMi5yYzEuZzIyNzM0Cgo=
------=_Part_31922_13738718.1153228428594
Content-Type: text/plain; 
	name=0001-git-checkout.sh-print-errors-otherwise-it-is-not-clear-what-happened.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_epsad5l3
Content-Disposition: attachment; filename="0001-git-checkout.sh-print-errors-otherwise-it-is-not-clear-what-happened.txt"

RnJvbSA3ZWEzMTc3YWVjOTA5ZTMzM2JhY2NjZDAwNjkzZjIyMzk5N2UyNjEzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbGV4IFJpZXNlbiA8cmFhLmxrbWxAZ21haWwuY29tPgpEYXRl
OiBUdWUsIDE4IEp1bCAyMDA2IDE1OjEwOjU0ICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZ2l0LWNo
ZWNrb3V0LnNoOiBwcmludCBlcnJvcnMsIG90aGVyd2lzZSBpdCBpcyBub3QgY2xlYXIgd2hhdCBo
YXBwZW5lZAoKU2lnbmVkLW9mZi1ieTogQWxleCBSaWVzZW4gPHJhYS5sa21sQGdtYWlsLmNvbT4K
LS0tCiBnaXQtY2hlY2tvdXQuc2ggfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9naXQtY2hlY2tvdXQuc2ggYi9n
aXQtY2hlY2tvdXQuc2gKaW5kZXggNTYxM2JmYy4uN2IzMzVlNSAxMDA3NTUKLS0tIGEvZ2l0LWNo
ZWNrb3V0LnNoCisrKyBiL2dpdC1jaGVja291dC5zaApAQCAtMTk4LDcgKzE5OCw3IEBAIGlmIFsg
IiQ/IiAtZXEgMCBdOyB0aGVuCiAJCQlta2RpciAtcCAkKGRpcm5hbWUgIiRHSVRfRElSL2xvZ3Mv
cmVmcy9oZWFkcy8kbmV3YnJhbmNoIikKIAkJCXRvdWNoICIkR0lUX0RJUi9sb2dzL3JlZnMvaGVh
ZHMvJG5ld2JyYW5jaCIKIAkJZmkKLQkJZ2l0LXVwZGF0ZS1yZWYgLW0gImNoZWNrb3V0OiBDcmVh
dGVkIGZyb20gJG5ld19uYW1lIiAicmVmcy9oZWFkcy8kbmV3YnJhbmNoIiAkbmV3IHx8IGV4aXQK
KwkJZ2l0LXVwZGF0ZS1yZWYgLW0gImNoZWNrb3V0OiBDcmVhdGVkIGZyb20gJG5ld19uYW1lIiAi
cmVmcy9oZWFkcy8kbmV3YnJhbmNoIiAkbmV3IHx8IGRpZSAiZmFpbGVkIHRvIGNyZWF0ZSBicmFu
Y2ggJG5ld2JyYW5jaCIKIAkJYnJhbmNoPSIkbmV3YnJhbmNoIgogCWZpCiAJWyAiJGJyYW5jaCIg
XSAmJgotLSAKMS40LjIucmMxLmcyMjczNAoK
------=_Part_31922_13738718.1153228428594--
