From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/8] config: Improve variable 'type' handling.
Date: Sun, 15 Feb 2009 14:43:15 +0200
Message-ID: <94a0d4530902150443t38d9253bi85ec42f3afbf0a1d@mail.gmail.com>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com>
	 <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com>
	 <alpine.DEB.1.00.0902151323100.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd28750eeeec80462f469ce
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 13:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYgMY-0003RV-DY
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 13:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbZBOMnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 07:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753300AbZBOMnS
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 07:43:18 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:36595 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbZBOMnR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 07:43:17 -0500
Received: by fg-out-1718.google.com with SMTP id 16so118063fgg.17
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 04:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=iI0NjiRhu2gsIYX/LrBWenC2HWjnGDo2pS4eK60LatE=;
        b=RYMKySmmf8lgFaUt18glLLWyFJJBX2wo5JVLnjoghw4jP0LHh13wv3nsRvpgJMwZAe
         IYrTPGsphScLjz4bUPks3yezCdXfnGeMsfhV8vWPjstV6Ua/29SLxcyPI1p8qc6J7By5
         dpJZTkUW9xqKoszFMjlXZ6gIcEac7HkFpjgKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=gGPhruMMpnm7XkC764bSHnuRogOMqrOz3lQryPgcrhQYxSL2BqPPvqq3pX6c6SGb+e
         Vp4sutagNxLosxL3Ji4Nl/w42yHl1cmkuOadWJGT0oW2ul5l8s4kQXTs2USUmxD+bug1
         eeCskfdA27KdTHXXzyYBexmqUhJ5uq9LchzvI=
Received: by 10.86.100.19 with SMTP id x19mr820786fgb.29.1234701795650; Sun, 
	15 Feb 2009 04:43:15 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902151323100.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110003>

--000e0cd28750eeeec80462f469ce
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Sun, Feb 15, 2009 at 2:24 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 15 Feb 2009, Felipe Contreras wrote:
>
>> +     switch (types) {
>> +     case TYPE_BOOL: type = T_BOOL; break;
>> +     case TYPE_INT: type = T_INT; break;
>> +     case TYPE_BOOL_OR_INT: type = T_BOOL_OR_INT; break;
>> +     default: break;
>> +     }
>
> Would it not be nicer to get rid of the variable named "type" and use
> "types == TYPE_BOOL" and similar statements instead?

I'm not too sure about that. If you read the code you might think you
could actually have multiple types, but the same can be said about
actions.

Anyway, attached is a patch with that change.

-- 
Felipe Contreras

--000e0cd28750eeeec80462f469ce
Content-Type: application/octet-stream; 
	name="0004-config-Improve-variable-type-handling.patch"
Content-Disposition: attachment; 
	filename="0004-config-Improve-variable-type-handling.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fr7pk7b50

RnJvbSBhMmNhMDhhY2U5N2UwNzBkMTA0OTZlZWUzZTg0YzhiYTJmMDUyYjUwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBGZWxpcGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdt
YWlsLmNvbT4KRGF0ZTogU3VuLCAxNSBGZWIgMjAwOSAxMDozODowMSArMDIwMApTdWJqZWN0OiBb
UEFUQ0ggNC84XSBjb25maWc6IEltcHJvdmUgdmFyaWFibGUgJ3R5cGUnIGhhbmRsaW5nLgoKU28g
bm93IG9ubHkgZWl0aGVyIC0tYm9vbCwgLS1pbnQsIG9yIC0tYm9vbC1vci1pbnQgY2FuIGJlIHVz
ZWQsIGJ1dCBub3QKYW55IGNvbWJpbmF0aW9uIG9mIHRoZW0uCgpTaWduZWQtb2ZmLWJ5OiBGZWxp
cGUgQ29udHJlcmFzIDxmZWxpcGUuY29udHJlcmFzQGdtYWlsLmNvbT4KLS0tCiBidWlsdGluLWNv
bmZpZy5jIHwgICAzMiArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQogMSBmaWxlcyBj
aGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9i
dWlsdGluLWNvbmZpZy5jIGIvYnVpbHRpbi1jb25maWcuYwppbmRleCAwODQyMjJhLi4zMGRlOTNl
IDEwMDY0NAotLS0gYS9idWlsdGluLWNvbmZpZy5jCisrKyBiL2J1aWx0aW4tY29uZmlnLmMKQEAg
LTE5LDExICsxOSwxMCBAQCBzdGF0aWMgaW50IHNlZW47CiBzdGF0aWMgY2hhciBkZWxpbSA9ICc9
JzsKIHN0YXRpYyBjaGFyIGtleV9kZWxpbSA9ICcgJzsKIHN0YXRpYyBjaGFyIHRlcm0gPSAnXG4n
Owotc3RhdGljIGVudW0geyBUX1JBVywgVF9JTlQsIFRfQk9PTCwgVF9CT09MX09SX0lOVCB9IHR5
cGUgPSBUX1JBVzsKIAogc3RhdGljIGludCB1c2VfZ2xvYmFsX2NvbmZpZywgdXNlX3N5c3RlbV9j
b25maWc7CiBzdGF0aWMgY29uc3QgY2hhciAqZ2l2ZW5fY29uZmlnX2ZpbGU7Ci1zdGF0aWMgaW50
IGFjdGlvbnM7CitzdGF0aWMgaW50IGFjdGlvbnMsIHR5cGVzOwogc3RhdGljIGNvbnN0IGNoYXIg
KmdldF9jb2xvcl9zbG90LCAqZ2V0X2NvbG9yYm9vbF9zbG90Owogc3RhdGljIGludCBlbmRfbnVs
bDsKIApAQCAtMzksNiArMzgsMTAgQEAgc3RhdGljIGludCBlbmRfbnVsbDsKICNkZWZpbmUgQUNU
SU9OX0xJU1QgKDE8PDkpCiAjZGVmaW5lIEFDVElPTl9FRElUICgxPDwxMCkKIAorI2RlZmluZSBU
WVBFX0JPT0wgKDE8PDApCisjZGVmaW5lIFRZUEVfSU5UICgxPDwxKQorI2RlZmluZSBUWVBFX0JP
T0xfT1JfSU5UICgxPDwyKQorCiBzdGF0aWMgc3RydWN0IG9wdGlvbiBidWlsdGluX2NvbmZpZ19v
cHRpb25zW10gPSB7CiAJT1BUX0dST1VQKCJDb25maWcgZmlsZSBsb2NhdGlvbiIpLAogCU9QVF9C
T09MRUFOKDAsICJnbG9iYWwiLCAmdXNlX2dsb2JhbF9jb25maWcsICJ1c2UgZ2xvYmFsIGNvbmZp
ZyBmaWxlIiksCkBAIC01Nyw5ICs2MCw5IEBAIHN0YXRpYyBzdHJ1Y3Qgb3B0aW9uIGJ1aWx0aW5f
Y29uZmlnX29wdGlvbnNbXSA9IHsKIAlPUFRfQklUKCdsJywgImxpc3QiLCAmYWN0aW9ucywgImxp
c3QgYWxsIiwgQUNUSU9OX0xJU1QpLAogCU9QVF9CSVQoJ2UnLCAiZWRpdCIsICZhY3Rpb25zLCAi
b3BlbnMgYW4gZWRpdG9yIiwgQUNUSU9OX0VESVQpLAogCU9QVF9HUk9VUCgiVHlwZSIpLAotCU9Q
VF9TRVRfSU5UKDAsICJib29sIiwgJnR5cGUsICJ2YWx1ZSBpcyBcInRydWVcIiBvciBcImZhbHNl
XCIiLCBUX0JPT0wpLAotCU9QVF9TRVRfSU5UKDAsICJpbnQiLCAmdHlwZSwgInZhbHVlIGlzIGRl
Y2ltYWwgbnVtYmVyIiwgVF9JTlQpLAotCU9QVF9TRVRfSU5UKDAsICJib29sLW9yLWludCIsICZ0
eXBlLCBOVUxMLCBUX0JPT0xfT1JfSU5UKSwKKwlPUFRfQklUKDAsICJib29sIiwgJnR5cGVzLCAi
dmFsdWUgaXMgXCJ0cnVlXCIgb3IgXCJmYWxzZVwiIiwgVFlQRV9CT09MKSwKKwlPUFRfQklUKDAs
ICJpbnQiLCAmdHlwZXMsICJ2YWx1ZSBpcyBkZWNpbWFsIG51bWJlciIsIFRZUEVfSU5UKSwKKwlP
UFRfQklUKDAsICJib29sLW9yLWludCIsICZ0eXBlcywgTlVMTCwgVFlQRV9CT09MX09SX0lOVCks
CiAJT1BUX1NUUklORygwLCAiZ2V0LWNvbG9yIiwgJmdldF9jb2xvcl9zbG90LCAic2xvdCIsICJm
aW5kIHRoZSBjb2xvciBjb25maWd1cmVkOiBbZGVmYXVsdF0iKSwKIAlPUFRfU1RSSU5HKDAsICJn
ZXQtY29sb3Jib29sIiwgJmdldF9jb2xvcmJvb2xfc2xvdCwgInNsb3QiLCAiZmluZCB0aGUgY29s
b3Igc2V0dGluZzogW3N0ZG91dC1pcy10dHldIiksCiAJT1BUX0dST1VQKCJPdGhlciIpLApAQCAt
MTA1LDExICsxMDgsMTEgQEAgc3RhdGljIGludCBzaG93X2NvbmZpZyhjb25zdCBjaGFyKiBrZXlf
LCBjb25zdCBjaGFyKiB2YWx1ZV8sIHZvaWQgKmNiKQogCX0KIAlpZiAoc2VlbiAmJiAhZG9fYWxs
KQogCQlkdXBfZXJyb3IgPSAxOwotCWlmICh0eXBlID09IFRfSU5UKQorCWlmICh0eXBlcyAmIFRZ
UEVfSU5UKQogCQlzcHJpbnRmKHZhbHVlLCAiJWQiLCBnaXRfY29uZmlnX2ludChrZXlfLCB2YWx1
ZV8/dmFsdWVfOiIiKSk7Ci0JZWxzZSBpZiAodHlwZSA9PSBUX0JPT0wpCisJZWxzZSBpZiAodHlw
ZXMgJiBUWVBFX0JPT0wpCiAJCXZwdHIgPSBnaXRfY29uZmlnX2Jvb2woa2V5XywgdmFsdWVfKSA/
ICJ0cnVlIiA6ICJmYWxzZSI7Ci0JZWxzZSBpZiAodHlwZSA9PSBUX0JPT0xfT1JfSU5UKSB7CisJ
ZWxzZSBpZiAodHlwZXMgJiBUWVBFX0JPT0xfT1JfSU5UKSB7CiAJCWludCBpc19ib29sLCB2Owog
CQl2ID0gZ2l0X2NvbmZpZ19ib29sX29yX2ludChrZXlfLCB2YWx1ZV8sICZpc19ib29sKTsKIAkJ
aWYgKGlzX2Jvb2wpCkBAIC0yMDgsMTggKzIxMSwxOCBAQCBzdGF0aWMgY2hhciAqbm9ybWFsaXpl
X3ZhbHVlKGNvbnN0IGNoYXIgKmtleSwgY29uc3QgY2hhciAqdmFsdWUpCiAJaWYgKCF2YWx1ZSkK
IAkJcmV0dXJuIE5VTEw7CiAKLQlpZiAodHlwZSA9PSBUX1JBVykKKwlpZiAodHlwZXMgPT0gMCkK
IAkJbm9ybWFsaXplZCA9IHhzdHJkdXAodmFsdWUpOwogCWVsc2UgewogCQlub3JtYWxpemVkID0g
eG1hbGxvYyg2NCk7Ci0JCWlmICh0eXBlID09IFRfSU5UKSB7CisJCWlmICh0eXBlcyAmIFRZUEVf
SU5UKSB7CiAJCQlpbnQgdiA9IGdpdF9jb25maWdfaW50KGtleSwgdmFsdWUpOwogCQkJc3ByaW50
Zihub3JtYWxpemVkLCAiJWQiLCB2KTsKIAkJfQotCQllbHNlIGlmICh0eXBlID09IFRfQk9PTCkK
KwkJZWxzZSBpZiAodHlwZXMgJiBUWVBFX0JPT0wpCiAJCQlzcHJpbnRmKG5vcm1hbGl6ZWQsICIl
cyIsCiAJCQkJZ2l0X2NvbmZpZ19ib29sKGtleSwgdmFsdWUpID8gInRydWUiIDogImZhbHNlIik7
Ci0JCWVsc2UgaWYgKHR5cGUgPT0gVF9CT09MX09SX0lOVCkgeworCQllbHNlIGlmICh0eXBlcyAm
IFRZUEVfQk9PTF9PUl9JTlQpIHsKIAkJCWludCBpc19ib29sLCB2OwogCQkJdiA9IGdpdF9jb25m
aWdfYm9vbF9vcl9pbnQoa2V5LCB2YWx1ZSwgJmlzX2Jvb2wpOwogCQkJaWYgKCFpc19ib29sKQpA
QCAtMzM2LDYgKzMzOSwxMSBAQCBpbnQgY21kX2NvbmZpZyhpbnQgYXJnYywgY29uc3QgY2hhciAq
KmFyZ3YsIGNvbnN0IGNoYXIgKnVudXNlZF9wcmVmaXgpCiAJCWtleV9kZWxpbSA9ICdcbic7CiAJ
fQogCisJaWYgKEhBU19NVUxUSV9CSVRTKHR5cGVzKSkgeworCQllcnJvcigib25seSBvbmUgdHlw
ZSBhdCBhIHRpbWUuIik7CisJCXVzYWdlX3dpdGhfb3B0aW9ucyhidWlsdGluX2NvbmZpZ191c2Fn
ZSwgYnVpbHRpbl9jb25maWdfb3B0aW9ucyk7CisJfQorCiAJaWYgKEhBU19NVUxUSV9CSVRTKGFj
dGlvbnMpKSB7CiAJCWVycm9yKCJvbmx5IG9uZSBhY3Rpb24gYXQgYSB0aW1lLiIpOwogCQl1c2Fn
ZV93aXRoX29wdGlvbnMoYnVpbHRpbl9jb25maWdfdXNhZ2UsIGJ1aWx0aW5fY29uZmlnX29wdGlv
bnMpOwotLSAKMS42LjEuMwoK
--000e0cd28750eeeec80462f469ce--
