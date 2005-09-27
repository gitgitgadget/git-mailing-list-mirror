From: "H. Peter Anvin" <hpa@zytor.com>
Subject: git-daemon: path validation, export all option
Date: Mon, 26 Sep 2005 19:13:32 -0700
Message-ID: <4338AACC.1050305@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030705040406040805050106"
X-From: git-owner@vger.kernel.org Tue Sep 27 04:14:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK4yS-0005CS-Ll
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 04:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVI0CNh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 22:13:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbVI0CNh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 22:13:37 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:28879 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S964797AbVI0CNg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 22:13:36 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8R2DWJv014082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 26 Sep 2005 19:13:33 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9362>

This is a multi-part message in MIME format.
--------------030705040406040805050106
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

A first attempt to make git-daemon a bit more suitable for kernel.org 
use: it allows the user to specify a whitelist of directories, rejects 
paths which have . or .. in them (to avoid bypassing the whitelist), and 
allows for an --export-all option.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------030705040406040805050106
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch"

U3VwcG9ydCBhIG1vZGljdW0gb2YgcGF0aCB2YWxpZGF0aW9uLCBhbmQgYWxsb3cgYW4gZXhw
b3J0IGFsbCB0cmVlcyBvcHRpb24uCgotLS0KY29tbWl0IDRhZTk1NjgyNjk0YTFjZDA1ZWUy
MDI5ZmUyNDFhZDkwZDQzYzhjMGUKdHJlZSA0MTg4YzI2NTAxYzg1MmJhOWMxYjFhM2YzOTI3
NmQzYWM3ZGMzZjhhCnBhcmVudCAxNTJkYTNkZmNmMmMxNmQ3YzI0MGEwZGJkY2I4YTNhZTFk
MzMyZDgxCmF1dGhvciBILiBQZXRlciBBbnZpbiA8aHBhQHNteXJuby5ob3MuYW52aW4ub3Jn
PiBNb24sIDI2IFNlcCAyMDA1IDE5OjEwOjU1IC0wNzAwCmNvbW1pdHRlciBILiBQZXRlciBB
bnZpbiA8aHBhQHNteXJuby5ob3MuYW52aW4ub3JnPiBNb24sIDI2IFNlcCAyMDA1IDE5OjEw
OjU1IC0wNzAwCgogZGFlbW9uLmMgfCAgIDcyICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tCiAxIGZpbGVzIGNoYW5nZWQs
IDY3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZGFlbW9u
LmMgYi9kYWVtb24uYwotLS0gYS9kYWVtb24uYworKysgYi9kYWVtb24uYwpAQCAtMTIsNyAr
MTIsMTMgQEAKIHN0YXRpYyBpbnQgbG9nX3N5c2xvZzsKIHN0YXRpYyBpbnQgdmVyYm9zZTsK
IAotc3RhdGljIGNvbnN0IGNoYXIgZGFlbW9uX3VzYWdlW10gPSAiZ2l0LWRhZW1vbiBbLS12
ZXJib3NlXSBbLS1zeXNsb2ddIFstLWluZXRkIHwgLS1wb3J0PW5dIjsKK3N0YXRpYyBjb25z
dCBjaGFyIGRhZW1vbl91c2FnZVtdID0gImdpdC1kYWVtb24gWy0tdmVyYm9zZV0gWy0tc3lz
bG9nXSBbLS1pbmV0ZCB8IC0tcG9ydD1uXSBbLS1leHBvcnQtYWxsXSBbZGlyZWN0b3J5Li4u
XSI7CisKKy8qIExpc3Qgb2YgYWNjZXB0YWJsZSBwYXRobmFtZSBwcmVmaXhlcyAqLworc3Rh
dGljIGNoYXIgKipva19wYXRocyA9IE5VTEw7CisKKy8qIElmIHRoaXMgaXMgc2V0LCBnaXQt
ZGFlbW9uLWV4cG9ydC1vayBpcyBub3QgcmVxdWlyZWQgKi8KK3N0YXRpYyBpbnQgZXhwb3J0
X2FsbF90cmVlcyA9IDA7CiAKIAogc3RhdGljIHZvaWQgbG9ncmVwb3J0KGludCBwcmlvcml0
eSwgY29uc3QgY2hhciAqZXJyLCB2YV9saXN0IHBhcmFtcykKQEAgLTY5LDE1ICs3NSw2MSBA
QCB2b2lkIGxvZ2luZm8oY29uc3QgY2hhciAqZXJyLCAuLi4pCiAJdmFfZW5kKHBhcmFtcyk7
CiB9CiAKK3N0YXRpYyBpbnQgcGF0aF9vayhjb25zdCBjaGFyICpkaXIpCit7CisJY29uc3Qg
Y2hhciAqcCA9IGRpcjsKKwljaGFyICoqcHA7CisJaW50IHNsID0gMSwgbmRvdCA9IDA7CisK
Kwlmb3IgKDs7KSB7CisJCWlmICggKnAgPT0gJy4nICkgeworCQkJbmRvdCsrOworCQl9IGVs
c2UgaWYgKCAqcCA9PSAnLycgfHwgKnAgPT0gJ1wwJyApIHsKKwkJCWlmICggc2wgJiYgbmRv
dCA+IDAgJiYgbmRvdCA8IDMgKQorCQkJCXJldHVybiAwOyAvKiAuIG9yIC4uIGluIHBhdGgg
Ki8KKwkJCXNsID0gMTsKKwkJCWlmICggKnAgPT0gJ1wwJyApCisJCQkJYnJlYWs7IC8qIEVu
ZCBvZiBzdHJpbmcgYW5kIGFsbCBpcyBnb29kICovCisJCX0gZWxzZSB7CisJCQlzbCA9IG5k
b3QgPSAwOworCQl9CisJCXArKzsKKwl9CisKKwlpZiAoIG9rX3BhdGhzICYmICpva19wYXRo
cyApIHsKKwkJaW50IG9rID0gMDsKKwkJaW50IGRpcmxlbiA9IHN0cmxlbihkaXIpOyAvKiBy
ZWFkX3BhY2tldF9saW5lIGNhbiByZXR1cm4gZW1iZWRkZWQgXDAgKi8KKworCQlmb3IgKCBw
cCA9IG9rX3BhdGhzIDsgKnBwIDsgcHArKyApIHsKKwkJCWludCBsZW4gPSBzdHJsZW4oKnBw
KTsKKwkJCWlmICggbGVuIDw9IGRpcmxlbiAmJgorCQkJICAgICAhc3RybmNtcCgqcHAsIGRp
ciwgbGVuKSAmJgorCQkJICAgICAoZGlyW2xlbl0gPT0gJy8nIHx8IGRpcltsZW5dID09ICdc
MCcpICkgeworCQkJCW9rID0gMTsKKwkJCQlicmVhazsKKwkJCX0KKwkJfQorCisJCWlmICgg
IW9rICkKKwkJCXJldHVybiAwOyAvKiBQYXRoIG5vdCBpbiB3aGl0ZWxpc3QgKi8KKwl9CisK
KwlyZXR1cm4gMTsJCS8qIFBhdGggYWNjZXB0YWJsZSAqLworfQogCiBzdGF0aWMgaW50IHVw
bG9hZChjaGFyICpkaXIsIGludCBkaXJsZW4pCiB7CiAJbG9naW5mbygiUmVxdWVzdCBmb3Ig
JyVzJyIsIGRpcik7CisKKwlpZiAoIXBhdGhfb2soZGlyKSkgeworCQlsb2dlcnJvcigiRm9y
YmlkZGVuIGRpcmVjdG9yeTogJXNcbiIsIGRpcik7CisJCXJldHVybiAtMTsKKwl9CisKIAlp
ZiAoY2hkaXIoZGlyKSA8IDApIHsKIAkJbG9nZXJyb3IoIkNhbm5vdCBjaGRpcignJXMnKTog
JXMiLCBkaXIsIHN0cmVycm9yKGVycm5vKSk7CiAJCXJldHVybiAtMTsKIAl9Ci0JY2hkaXIo
Ii5naXQiKTsKIAogCS8qCiAJICogU2VjdXJpdHkgb24gdGhlIGNoZWFwLgpAQCAtODYsMTAg
KzEzOCwxMCBAQCBzdGF0aWMgaW50IHVwbG9hZChjaGFyICpkaXIsIGludCBkaXJsZW4pCiAJ
ICogYSAiZ2l0LWRhZW1vbi1leHBvcnQtb2siIGZsYWcgdGhhdCBzYXlzIHRoYXQgdGhlIG90
aGVyIHNpZGUKIAkgKiBpcyBvayB3aXRoIHVzIGRvaW5nIHRoaXMuCiAJICovCi0JaWYgKGFj
Y2VzcygiZ2l0LWRhZW1vbi1leHBvcnQtb2siLCBGX09LKSB8fAorCWlmICgoIWV4cG9ydF9h
bGxfdHJlZXMgJiYgYWNjZXNzKCJnaXQtZGFlbW9uLWV4cG9ydC1vayIsIEZfT0spKSB8fAog
CSAgICBhY2Nlc3MoIm9iamVjdHMvMDAiLCBYX09LKSB8fAogCSAgICBhY2Nlc3MoIkhFQUQi
LCBSX09LKSkgewotCQlsb2dlcnJvcigiTm90IGEgdmFsaWQgZ2l0ZC1lbmFibGVkIHJlcG9z
aXRvcnk6ICclcyciLCBkaXIpOworCQlsb2dlcnJvcigiTm90IGEgdmFsaWQgZ2l0LWRhZW1v
bi1lbmFibGVkIHJlcG9zaXRvcnk6ICclcyciLCBkaXIpOwogCQlyZXR1cm4gLTE7CiAJfQog
CkBAIC00NDEsNyArNDkzLDYgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKiphcmd2KQog
CQkJCWNvbnRpbnVlOwogCQkJfQogCQl9Ci0KIAkJaWYgKCFzdHJjbXAoYXJnLCAiLS1pbmV0
ZCIpKSB7CiAJCQlpbmV0ZF9tb2RlID0gMTsKIAkJCWNvbnRpbnVlOwpAQCAtNDU1LDYgKzUw
NiwxNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCQlvcGVubG9nKCJn
aXQtZGFlbW9uIiwgMCwgTE9HX0RBRU1PTik7CiAJCQljb250aW51ZTsKIAkJfQorCQlpZiAo
IXN0cmNtcChhcmcsICItLWV4cG9ydC1hbGwiKSkgeworCQkJZXhwb3J0X2FsbF90cmVlcyA9
IDE7CisJCQljb250aW51ZTsKKwkJfQorCQlpZiAoIXN0cmNtcChhcmcsICItLSIpKSB7CisJ
CQlva19wYXRocyA9ICZhcmd2W2krMV07CisJCQlicmVhazsKKwkJfSBlbHNlIGlmIChhcmdb
MF0gIT0gJy0nKSB7CisJCQlva19wYXRocyA9ICZhcmd2W2ldOworCQkJYnJlYWs7CisJCX0K
IAogCQl1c2FnZShkYWVtb25fdXNhZ2UpOwogCX0K
--------------030705040406040805050106--
