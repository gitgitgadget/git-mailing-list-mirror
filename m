From: Anders Ro <anders.ronnbrant@gmail.com>
Subject: [PATCH/RFC] Pinning of submodules
Date: Thu, 3 Sep 2015 01:34:24 +0200
Message-ID: <55E78780.2040801@gmail.com>
References: <55E78522.1030107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030706030006060707020801"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 01:34:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXHY6-0007T7-GB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 01:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbbIBXeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 19:34:31 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36353 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755690AbbIBXe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 19:34:27 -0400
Received: by lbcao8 with SMTP id ao8so15068946lbc.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type;
        bh=8MH5wcskVr/a5mrm+s/upV/Bng9+jLSP0DqwB9C8TLo=;
        b=Zn8nSUjc0CsKKGz3aba5jg0K3vF2/yz6xCFKJnXtcy8y5RBO2swIcuQlGCmylUDUII
         k0o7//byDDNW5K3lxA9EUneZE27mDRvolQseP5OnAcbrSjaZfIE0Vu6ifIKlVm/ILJ+V
         xRGpKniQGuGRc8EAAUfgXne0JgVTpwWRiWthwcKH893T/EwAdaD8gf93vkyE+8Vx0bFp
         5N61nicD1+eFQWjnbDG2pgMSZf9YFeGFYYvUFCTkNb4N1KoAyZVME5iP35Zusv/C2adK
         17hOep+wKyj2BXGIxXmx7KdB8Z9X+mkbViMxaqCIA9Ln+xHJb9G4KOxyZlnbLqGulAnf
         2Vyg==
X-Received: by 10.152.27.10 with SMTP id p10mr18651469lag.89.1441236865801;
        Wed, 02 Sep 2015 16:34:25 -0700 (PDT)
Received: from [192.168.1.20] (h-176-10-249-254.na.cust.bahnhof.se. [176.10.249.254])
        by smtp.gmail.com with ESMTPSA id o1sm2962743lag.22.2015.09.02.16.34.24
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2015 16:34:25 -0700 (PDT)
X-Forwarded-Message-Id: <55E78522.1030107@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <55E78522.1030107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277136>

This is a multi-part message in MIME format.
--------------030706030006060707020801
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Patch to make it possible to pin submodules so that they are not
affected by the --remote option in "git submodule".

Anders Ro (2):
  git-submodule.sh: pin submodule when branch name is '@'
  t7412: add test case for pinned submodules

 Documentation/git-submodule.txt |  3 +-
 git-submodule.sh                |  9 ++++-
 t/t7412-submodule-pinning.sh    | 73
+++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)
 create mode 100755 t/t7412-submodule-pinning.sh


--------------030706030006060707020801
Content-Type: text/plain; charset=UTF-8;
 name="0001-git-submodule.sh-pin-submodule-when-branch-name-is.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-git-submodule.sh-pin-submodule-when-branch-name-is.txt"

RnJvbSAzMmIyNWFkZWQwYzRlMzBjNjhhYzNhYjc1ZjRjYmI2MzMwMmNhMTQ3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRlcnMgUm8gPGFuZGVycy5yb25uYnJhbnRAZ21h
aWwuY29tPgpEYXRlOiBGcmksIDI4IE5vdiAyMDE0IDAxOjM5OjM3ICswMTAwClN1YmplY3Q6
IFtQQVRDSCAxLzJdIGdpdC1zdWJtb2R1bGUuc2g6IHBpbiBzdWJtb2R1bGUgd2hlbiBicmFu
Y2ggbmFtZSBpcyAnQCcKClNldHRpbmcgYnJhbmNoIG5hbWUgdG8gJ0AnIGZvciBhIHN1Ym1v
ZHVsZSB3aWxsIGRpc2FibGUgJ2dpdCBzdWJtb2R1bGUKdXBkYXRlIC0tcmVtb3RlJyBjYWxs
cyBmb3IgdGhhdCBzcGVjaWZpYyBzdWJtb2R1bGUuIEkuZS4gaW5zdGVhZCBvZgpmb2xsb3cg
dGhlIHVuc3BlY2lmaWVkIGRlZmF1bHQgY2hvaWNlIG9mIG1hc3Rlciwgbm90aGluZyBpcyBi
ZWluZwp1cGRhdGVkLiBUaGlzIGlzIHVzZWZ1bCB3aGVuIG11bHRpcGxlIHN1Ym1vZHVsZXMg
ZXhpc3QgYnV0IG5vdCBhbGwKc2hvdWxkIGZvbGxvdyB0aGUgcmVtb3RlIGJyYW5jaCBoZWFk
LgoKU2lnbmVkLW9mZi1ieTogQW5kZXJzIFJvIDxhbmRlcnMucm9ubmJyYW50QGdtYWlsLmNv
bT4KLS0tCiBEb2N1bWVudGF0aW9uL2dpdC1zdWJtb2R1bGUudHh0IHwgMyArKy0KIGdpdC1z
dWJtb2R1bGUuc2ggICAgICAgICAgICAgICAgfCA5ICsrKysrKysrLQogMiBmaWxlcyBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL0Rv
Y3VtZW50YXRpb24vZ2l0LXN1Ym1vZHVsZS50eHQgYi9Eb2N1bWVudGF0aW9uL2dpdC1zdWJt
b2R1bGUudHh0CmluZGV4IGYxNzY4N2UuLmJkMGNjZWQgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50
YXRpb24vZ2l0LXN1Ym1vZHVsZS50eHQKKysrIGIvRG9jdW1lbnRhdGlvbi9naXQtc3VibW9k
dWxlLnR4dApAQCAtMjg5LDcgKzI4OSw4IEBAIE9QVElPTlMKIAlUaGUgcmVtb3RlIGJyYW5j
aCB1c2VkIGRlZmF1bHRzIHRvIGBtYXN0ZXJgLCBidXQgdGhlIGJyYW5jaCBuYW1lIG1heQog
CWJlIG92ZXJyaWRkZW4gYnkgc2V0dGluZyB0aGUgYHN1Ym1vZHVsZS48bmFtZT4uYnJhbmNo
YCBvcHRpb24gaW4KIAllaXRoZXIgYC5naXRtb2R1bGVzYCBvciBgLmdpdC9jb25maWdgICh3
aXRoIGAuZ2l0L2NvbmZpZ2AgdGFraW5nCi0JcHJlY2VkZW5jZSkuCisJcHJlY2VkZW5jZSku
IFNldHRpbmcgdGhlIGJyYW5jaCBuYW1lIHRvIHRoZSBpbnZhbGlkIGJyYW5jaCBuYW1lICdA
JworCWRpc2FibGVzIHRoaXMgb3B0aW9uLCBpLmUuIHBpbnMgdGhlIHN1Ym1vZHVsZSBhdCB0
aGUgcmVjb3JkZWQgU0hBLTEuCiArCiBUaGlzIHdvcmtzIGZvciBhbnkgb2YgdGhlIHN1cHBv
cnRlZCB1cGRhdGUgcHJvY2VkdXJlcyAoYC0tY2hlY2tvdXRgLAogYC0tcmViYXNlYCwgZXRj
LikuICBUaGUgb25seSBjaGFuZ2UgaXMgdGhlIHNvdXJjZSBvZiB0aGUgdGFyZ2V0IFNIQS0x
LgpkaWZmIC0tZ2l0IGEvZ2l0LXN1Ym1vZHVsZS5zaCBiL2dpdC1zdWJtb2R1bGUuc2gKaW5k
ZXggMjViMWRkZi4uMWJiMmJiMSAxMDA3NTUKLS0tIGEvZ2l0LXN1Ym1vZHVsZS5zaAorKysg
Yi9naXQtc3VibW9kdWxlLnNoCkBAIC04NDMsNyArODQzLDggQEAgTWF5YmUgeW91IHdhbnQg
dG8gdXNlICd1cGRhdGUgLS1pbml0Jz8iKSIKIAkJCWRpZSAiJChldmFsX2dldHRleHQgIlVu
YWJsZSB0byBmaW5kIGN1cnJlbnQgcmV2aXNpb24gaW4gc3VibW9kdWxlIHBhdGggJ1wkZGlz
cGxheXBhdGgnIikiCiAJCWZpCiAKLQkJaWYgdGVzdCAtbiAiJHJlbW90ZSIKKwkJIyBGZXRj
aCBsYXRlc3QgaW4gcmVtb3RlIHVubGVzcyBicmFuY2ggbmFtZSBpbiBjb25maWcgaXMgJ0An
CisJCWlmIHRlc3QgLW4gIiRyZW1vdGUiIC1hICIkYnJhbmNoIiAhPSAiQCIKIAkJdGhlbgog
CQkJaWYgdGVzdCAteiAiJG5vZmV0Y2giCiAJCQl0aGVuCkBAIC04NTcsNiArODU4LDEyIEBA
IE1heWJlIHlvdSB3YW50IHRvIHVzZSAndXBkYXRlIC0taW5pdCc/IikiCiAJCQlkaWUgIiQo
ZXZhbF9nZXR0ZXh0ICJVbmFibGUgdG8gZmluZCBjdXJyZW50ICR7cmVtb3RlX25hbWV9LyR7
YnJhbmNofSByZXZpc2lvbiBpbiBzdWJtb2R1bGUgcGF0aCAnXCRzbV9wYXRoJyIpIgogCQlm
aQogCisJCSMgSW5mb3JtIHRoYXQgdGhlIGN1cnJlbnQgc20gaXMgcGlubmVkIGFuZCB1c2Ug
b2YgJy0tcmVtb3RlJyBpZ25vcmVkCisJCWlmIHRlc3QgLW4gIiRyZW1vdGUiIC1hICIkYnJh
bmNoIiA9ICJAIgorCQl0aGVuCisJCQlzYXkgIiQoZXZhbF9nZXR0ZXh0ICJTdWJtb2R1bGUg
cGF0aCAnXCRkaXNwbGF5cGF0aCcgcGlubmVkLCByZW1vdGUgdXBkYXRlIGlnbm9yZWQiKSIK
KwkJZmkKKwogCQlpZiB0ZXN0ICIkc3Vic2hhMSIgIT0gIiRzaGExIiB8fCB0ZXN0IC1uICIk
Zm9yY2UiCiAJCXRoZW4KIAkJCXN1YmZvcmNlPSRmb3JjZQotLSAKMi4xLjQKCg==
--------------030706030006060707020801
Content-Type: text/plain; charset=UTF-8;
 name="0002-t7412-add-test-case-for-pinned-submodules.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-t7412-add-test-case-for-pinned-submodules.txt"

RnJvbSA5OGU2Njc3MzI1YmFkYTYyMzAxZWJhMThiODFmNDg4NDc5M2Q3YzAyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBBbmRlcnMgUm8gPGFuZGVycy5yb25uYnJhbnRAZ21h
aWwuY29tPgpEYXRlOiBUaHUsIDMgU2VwIDIwMTUgMDA6MDM6MTUgKzAyMDAKU3ViamVjdDog
W1BBVENIIDIvMl0gdDc0MTI6IGFkZCB0ZXN0IGNhc2UgZm9yIHBpbm5lZCBzdWJtb2R1bGVz
CgpTaWduZWQtb2ZmLWJ5OiBBbmRlcnMgUm8gPGFuZGVycy5yb25uYnJhbnRAZ21haWwuY29t
PgotLS0KIHQvdDc0MTItc3VibW9kdWxlLXBpbm5pbmcuc2ggfCA3MyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDczIGlu
c2VydGlvbnMoKykKIGNyZWF0ZSBtb2RlIDEwMDc1NSB0L3Q3NDEyLXN1Ym1vZHVsZS1waW5u
aW5nLnNoCgpkaWZmIC0tZ2l0IGEvdC90NzQxMi1zdWJtb2R1bGUtcGlubmluZy5zaCBiL3Qv
dDc0MTItc3VibW9kdWxlLXBpbm5pbmcuc2gKbmV3IGZpbGUgbW9kZSAxMDA3NTUKaW5kZXgg
MDAwMDAwMC4uMjg0NGIxZQotLS0gL2Rldi9udWxsCisrKyBiL3QvdDc0MTItc3VibW9kdWxl
LXBpbm5pbmcuc2gKQEAgLTAsMCArMSw3MyBAQAorIyEvYmluL3NoCisjCisjIENvcHlyaWdo
dCAoYykgMjAxNSBBbmRlcnMgUm9ubmJyYW50CisjCisKK3Rlc3RfZGVzY3JpcHRpb249IkJy
YW5jaCBuYW1lICdAJyBkaXNhYmxlcyBzdWJtb2R1bGUgdXBkYXRlIC0tcmVtb3RlIGNhbGxz
IgorCisuIC4vdGVzdC1saWIuc2gKKworZ2V0X3NoYSgpIHsKKyAgY2QgJDEgJiYgZ2l0IHJl
di1saXN0IC0tbWF4LWNvdW50PTEgSEVBRAorfQorCitlcXVhbF9zaGEoKSB7CisgIHRlc3Qg
IiQoZ2V0X3NoYSAkMSkiID0gIiQoZ2V0X3NoYSAkMikiCit9CisKK25vdF9lcXVhbF9zaGEo
KSB7CisgIHRlc3QgIiQoZ2V0X3NoYSAkMSkiICE9ICIkKGdldF9zaGEgJDIpIgorfQorCit0
ZXN0X2V4cGVjdF9zdWNjZXNzICdzZXR1cCBzdWJtb2R1bGUgdHJlZSBzdHJ1Y3R1cmUnICcK
K2ZvciBpIGluIDEgMiAzOyBkbyBlY2hvIGZpbGUkaSA+IGZpbGUkaTsgZ2l0IGFkZCBmaWxl
JGk7IGdpdCBjb21taXQgLW0gZmlsZSRpOyBkb25lICYmCit0ZXN0X3RpY2sgJiYKK2dpdCBj
bG9uZSAuIHN1cGVyICYmCitnaXQgY2xvbmUgLiBmb2xsb3cgJiYKK2dpdCBjbG9uZSAuIHBp
bm5lZCAmJgorKGNkIHN1cGVyICYmIGdpdCBzdWJtb2R1bGUgYWRkIC1iIG1hc3RlciAuLi9m
b2xsb3cgZm9sbG93KSAmJgorKGNkIHN1cGVyICYmIGdpdCBzdWJtb2R1bGUgYWRkICAgICAg
ICAgICAuLi9waW5uZWQgcGlubmVkKQorJworCit0ZXN0X2V4cGVjdF9zdWNjZXNzICd2ZXJp
Znkgc3VibW9kdWxlcyBoYXZlIHRoZSBzYW1lIFNIQScgJworZXF1YWxfc2hhIHN1cGVyL2Zv
bGxvdyBzdXBlci9waW5uZWQKKycKKworCit0ZXN0X2V4cGVjdF9zdWNjZXNzICdzd2l0Y2gg
c3VibW9kdWxlIHBpbm5lZCB0byBIRUFEfjEgYW5kIGNvbW1pdCBzdXBlcicgJworKGNkIHN1
cGVyL3Bpbm5lZCAmJiBnaXQgY2hlY2tvdXQgbWFzdGVyICYmIGdpdCByZXNldCAtLWhhcmQg
SEVBRH4xKSAmJgorKGNkIHN1cGVyICYmIGdpdCBhZGQgcGlubmVkICYmIGdpdCBjb21taXQg
LW0gIlN1Ym1vZHVsZSBwaW5uZWQgQCBIRUFEfjEiKSAmJgorKGNkIHN1cGVyICYmIGdpdCBz
dWJtb2R1bGUgc3RhdHVzKQorJworCisKK3Rlc3RfZXhwZWN0X3N1Y2Nlc3MgJ3ZlcmlmeSBz
dWJtb2R1bGVzIG5vdCBoYXZlIHRoZSBzYW1lIFNIQSBhbnltb3JlJyAnCitub3RfZXF1YWxf
c2hhIHN1cGVyL2ZvbGxvdyBzdXBlci9waW5uZWQKKycKKworCit0ZXN0X2V4cGVjdF9zdWNj
ZXNzICdzZXQgYnJhbmNoIG5hbWUgdG8gIkAiIGZvciBzdWJtb2R1bGUgcGlubmVkJyAnCiso
Y2Qgc3VwZXIgJiYgZ2l0IGNvbmZpZyAtLXJlcGxhY2UtYWxsIHN1Ym1vZHVsZS5waW5uZWQu
YnJhbmNoICJAIikgJiYKK3Rlc3QgIiQoY2Qgc3VwZXIgJiYgZ2l0IGNvbmZpZyAtLWdldCBz
dWJtb2R1bGUucGlubmVkLmJyYW5jaCkiID0gIkAiCisnCisKKwordGVzdF9leHBlY3Rfc3Vj
Y2VzcyAncnVuIHN1Ym1vZHVsZSB1cGRhdGUgLS1yZW1vdGUgYW5kIGV4cGVjdCBubyBjaGFu
Z2UnICcKKyhjZCBzdXBlciAmJiBnaXQgc3VibW9kdWxlIHVwZGF0ZSAtLXJlbW90ZSkgJiYK
K25vdF9lcXVhbF9zaGEgc3VwZXIvZm9sbG93IHN1cGVyL3Bpbm5lZAorJworCisKK3Rlc3Rf
ZXhwZWN0X3N1Y2Nlc3MgJ3JlbW92ZSBicmFuY2ggbmFtZSAiQCIgZm9yIHN1Ym1vZHVsZSBw
aW5uZWQgKHVucGluKScgJworKGNkIHN1cGVyICYmIGdpdCBjb25maWcgLS11bnNldC1hbGwg
c3VibW9kdWxlLnBpbm5lZC5icmFuY2gpICYmCisoY2Qgc3VwZXIgJiYgZ2l0IGNvbmZpZyAt
LWxpc3QpCisnCisKKwordGVzdF9leHBlY3Rfc3VjY2VzcyAncnVuIHN1Ym1vZHVsZSB1cGRh
dGUgLS1yZW1vdGUgYW5kIGV4cGVjdCBzYW1lIFNIQTEgYWdhaW4nICcKKyhjZCBzdXBlciAm
JiBnaXQgc3VibW9kdWxlIHVwZGF0ZSAtLXJlbW90ZSkgJiYKK2VxdWFsX3NoYSBzdXBlci9m
b2xsb3cgc3VwZXIvcGlubmVkCisnCisKKwordGVzdF9kb25lCi0tIAoyLjEuNAoK
--------------030706030006060707020801--
