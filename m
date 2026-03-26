Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0299620C029
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484134; cv=pass; b=o9zBAXbE+mG0lfTYPXeqpnsPkx2pm19pCph5IlB8HDAFUPOYVJW8GuH3/hqVgrQnECqFTyeWbPe6zrw9IGSUtcH1ityyVWt72AyoP6SFCV/2jASIZFMNPgFgKcDfu0M7MWEhH/z+L0GZPncLRFBlSAyjLGtngs6GJQ10VAqwpe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484134; c=relaxed/simple;
	bh=8KymvvlFf/uhnJah3z0xuWfF5C/n6Et0qkxDAszNJ38=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=en6arDI8CR8QplAMs7QAyXZOPOT9cVQEnkjj4HnMlyvjstNGpbqSILrpN6zg/jC4uG4YWX3OBU+kkaKBrpJnvY0CuX8DMstlzPuF9NDDyc00xYrJ4uCcjJ9mHNxmjgT4vQyg3+i5kqdPE6cCL/YtykpB4cXCHvE+X8bPOGCpI7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FxQ8QLfj; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FxQ8QLfj"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-798374d0f44so22407957b3.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 17:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774484132; cv=none;
        d=google.com; s=arc-20240605;
        b=lhURGrz1pmEB8GysAtKoOxsFDQJRaVuxCozbDFtmJHdOhmEf9P6CUR+6amZjsBoztZ
         spi2wNhXzRFVwdI8Dbnq/kAtUTt6l4M11s8u/9SF6O1fh4ql8aLGNHEiQzQKG4yEZqJq
         zXzC49CEqqwM/AdMi+Id7Xc+7N4Frf1g/5UvBlHMtVaWyYckJsZTDiE+qIc/Lt6FsREM
         9EdVztZuOvnOdVquf0MH/ODx1G1k4snFgE8dk1SfNcfgCR8lVwaf0cZYexZOwdTc4T4h
         t0RnSPyJawcXxYiuCpfoWh8bprfLLDkDJsTaCF/jDcGuT4GP4pxb73/rMxopAxkVG7l7
         h+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=DmOgNXrcpY5MhoIP46MdTDM0otfi3vi2+oBCYJsvFqk=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=hPimvVMTOQA/w+xZjrIgLROV6vwnEhfzZGOD6iEHTEnueqmWnYZjdPm9WUKnIPcjUF
         4VKF1BBGM+nba0MTzXeOTRQbAJAZ2rfnJZCpDc8udf5gD6IW/7+kxyOQOb/w2Z8huTOR
         ODsjOCzs187tzfkp+X2aOsdNtk21jMprb/KDOnC7fX/Ry/vZsMO9fg4oqchQP+An+jAm
         Y8mtg3gW6dFfmaFIOBEnpQsN8KYxuV925fAuBVp82IbVwk9+MixUVPOW6wXp0mMcbgNQ
         fon/8/ZI/q0FdxA8q/q1KBSy/uyfrr2PP78qujFh+wDthz4MStA5Q3IE1jc9SypVMflH
         rs9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774484132; x=1775088932; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DmOgNXrcpY5MhoIP46MdTDM0otfi3vi2+oBCYJsvFqk=;
        b=FxQ8QLfjnK6QtcnHU67jd/j46iM/OXKW5qIetcE2rv2l5i3phsAdZLUyLUWns/OxRS
         6FpkB8XgH5GBVVEhIFYdNg8L/FhZXQ1nlw9slZqNWZVOFfeCseKomeDgTl/khTL7Oq9a
         QvarnrneUy7xU29HAU81JkdO8sqQ7y8uTCGio66HskzC34HDX+xFD/s//5/MXdeZtMNP
         AmFH64Q43Fl3nu/WZtRBRI+8IM4e7mTmMtt1GqKPS6uPTC5Hhmg/fRIoY9x1lGJajF41
         eNhih89dj89pg0pTxY8o/JqyPbq0cOE/ITCfKALHSof6SmU5qqms0Dkx62Aw/bgCRz2U
         ps7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774484132; x=1775088932;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmOgNXrcpY5MhoIP46MdTDM0otfi3vi2+oBCYJsvFqk=;
        b=IQxRKiSt6u6u7BCuqVAlC9stuqd2a+wloevQzizUFSh2V1ZtPnt3J+vlR1Rnoimoe9
         ieDaOGWKj8NbapsD1/y6ZXKu0tYP5xWLY3XFDvIG4yPOLXW2fvqknCc5dRf7uwSd7Bo5
         HjdSVSr/JJdz2Hej0mahfBA5C3JCm0I2qSgN0zYIe9JffOLmbMdGqlh9+OqX1q4D/iWf
         It7m30rTFoaAZ45R0LuwmJTXg4YIdFYb2lGqgrQRhi3luhAHH4eFADuIIC0NO9N/OAsO
         lGtk3B4Sywe6UGvsEfW9mvHjKpnHRVVeYCGxCCP2qv4yqYAeIUjTZ/vE38tnxluAyhs9
         zsXQ==
X-Gm-Message-State: AOJu0YykNtHOduv0Q5Q7spw+XRBDeghzKZYn8DyZ06g44GJxWnv29NDg
	FE6WAlmG86MvtXEYiw1HuGzYZ3Mog+Lv37lR4tmxmNY+a03+amw8Vbk5hEwUKxS3YnWgJxNDP3z
	JTDWiP91lDkKqH4xL8U2gB1ZYSHxuwE4gcZDS
X-Gm-Gg: ATEYQzxnsxqKQSuIQjb/B7hkJhMLXeDv+UfBb0Ce1tvbpRqCsEgKw6WPQGFTKZJfWsd
	aP8YX/fHYl+snA5wdBRlbV5K/TwM5PzpEJmOJa6Rv+XeoI4o/PUmqJIP0TeXtq3kZr6NgzXIWOg
	vkdzQFRPHKhLedpFBm94PD4FNhcdKaNaPp+Q7Wl42VvuTuMBRjpfcaKRQ1em3EmrfQ8Tvwqaf6z
	QTkRCvfjj/b5jOq/YPLw0Baq/4Q4HRIxasnHwo/U0ugZWFm9zqf/p6PNywsmuwrPLp6gpR9Mg1f
	iwRPeBX/zA22uRkqpNjJTPps9yOi9S4THWDSwrnw9FJPw8n1A8Ojo7sxMN7oZZQR09rpOW7VYDW
	JaAnX+eI=
X-Received: by 2002:a05:690e:431b:b0:64c:97af:5b15 with SMTP id
 956f58d0204a3-64ee54e158amr4140637d50.34.1774484131653; Wed, 25 Mar 2026
 17:15:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zakariyah Ali <zakariyahali100@gmail.com>
Date: Thu, 26 Mar 2026 01:15:20 +0100
X-Gm-Features: AaiRm51bmlGd7ZbmpMm_8oXcOfU3twToypIWO160HtE40pMNuUvIY8jCn7Yzt6c
Message-ID: <CAPAKoce5BeXMPtok+dni+WDTkokCAq0o4uMHGg1KZto9-UniXQ@mail.gmail.com>
Subject: Github Patch
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000053e08b064de24838"

--00000000000053e08b064de24838
Content-Type: multipart/alternative; boundary="00000000000053e089064de24836"

--00000000000053e089064de24836
Content-Type: text/plain; charset="UTF-8"



--00000000000053e089064de24836
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><br></div>

--00000000000053e089064de24836--
--00000000000053e08b064de24838
Content-Type: text/x-patch; charset="UTF-8"; 
	name="0001-t-t2000-modernize-path-checks-to-use-test_path-helpe.patch"
Content-Disposition: attachment; 
	filename="0001-t-t2000-modernize-path-checks-to-use-test_path-helpe.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mn6q0z6y0>
X-Attachment-Id: f_mn6q0z6y0

RnJvbSA5MWEzY2NmNDk2Y2RiNjExNDllM2MwMzEyNjVmZTI1MmM2YzhlZjNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhbGliYWJhMDAxMCA8emFrYXJpeWFoYWxpMTAwQGdtYWlsLmNv
bT4KRGF0ZTogVHVlLCAyNCBNYXIgMjAyNiAyMTowNDozOCArMDEwMApTdWJqZWN0OiBbUEFUQ0hd
IHQvdDIwMDA6IG1vZGVybml6ZSBwYXRoIGNoZWNrcyB0byB1c2UgdGVzdF9wYXRoIGhlbHBlcnMK
TUlNRS1WZXJzaW9uOiAxLjAKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBjaGFyc2V0PVVURi04
CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IDhiaXQKClJlcGxhY2Ugb2xkLXN0eWxlIHBhdGgg
Y2hlY2tzIHVzaW5nIGB0ZXN0IC1mYCwgYHRlc3QgLWRgLAphbmQgYHRlc3QgISAtaGAgd2l0aCBk
ZWRpY2F0ZWQgdGVzdCBoZWxwZXIgZnVuY3Rpb25zIGZvcgppbXByb3ZlZCB0ZXN0IGNsYXJpdHkg
YW5kIGNvbnNpc3RlbmN5LgoKVGhpcyBtb2Rlcm5pemF0aW9uIGltcHJvdmVzIHRlc3Qgc2NyaXB0
IHJlYWRhYmlsaXR5IGJ5IHVzaW5nCkdpdCdzIGRlZGljYXRlZCB0ZXN0IGhlbHBlcnM6Ci0gYHRl
c3QgLWZgIOKGkiBgdGVzdF9wYXRoX2lzX2ZpbGVgCi0gYHRlc3QgLWRgIOKGkiBgdGVzdF9wYXRo
X2lzX2RpcmAKLSBgdGVzdCAhIC1oICYmIHRlc3QgLWZgIOKGkgogIGB0ZXN0X3BhdGhfaXNfZmls
ZV9ub3Rfc3ltbGlua2AKLSBgdGVzdCAhIC1oICYmIHRlc3QgLWRgIOKGkgogIGB0ZXN0X3BhdGhf
aXNfZGlyX25vdF9zeW1saW5rYAoKRm91bmQgaW5zdGFuY2VzIHVzaW5nOgogIGdpdCBncmVwICd0
ZXN0IC1bZWZkXScgdC8gfCBncmVwICd0ZXN0IC1bZWZkXS4qJiYnCgpDb252ZXJ0ZWQgNSBpbnN0
YW5jZXMgaW4KdC90MjAwMC1jb25mbGljdC13aGVuLWNoZWNraW5nLWZpbGVzLW91dC5zaAoKU2ln
bmVkLW9mZi1ieTogYWxpYmFiYTAwMTAgPHpha2FyaXlhaGFsaTEwMEBnbWFpbC5jb20+Ci0tLQog
dC90MjAwMC1jb25mbGljdC13aGVuLWNoZWNraW5nLWZpbGVzLW91dC5zaCB8IDEwICsrKysrLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdC90MjAwMC1jb25mbGljdC13aGVuLWNoZWNraW5nLWZpbGVzLW91dC5zaCBiL3Qv
dDIwMDAtY29uZmxpY3Qtd2hlbi1jaGVja2luZy1maWxlcy1vdXQuc2gKaW5kZXggZjE4NjE2YWQy
Yi4uYjUzNWJiMDAyYSAxMDA3NTUKLS0tIGEvdC90MjAwMC1jb25mbGljdC13aGVuLWNoZWNraW5n
LWZpbGVzLW91dC5zaAorKysgYi90L3QyMDAwLWNvbmZsaWN0LXdoZW4tY2hlY2tpbmctZmlsZXMt
b3V0LnNoCkBAIC01OCw3ICs1OCw3IEBAIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAogCiB0ZXN0X2V4
cGVjdF9zdWNjZXNzIFwKICAgICAnZ2l0IGNoZWNrb3V0LWluZGV4IGNvbmZsaWN0aW5nIHBhdGhz
LicgXAotICAgICd0ZXN0IC1mIHBhdGgwICYmIHRlc3QgLWQgcGF0aDEgJiYgdGVzdCAtZiBwYXRo
MS9maWxlMScKKyAgICAndGVzdF9wYXRoX2lzX2ZpbGUgcGF0aDAgJiYgdGVzdF9wYXRoX2lzX2Rp
ciBwYXRoMSAmJiB0ZXN0X3BhdGhfaXNfZmlsZSBwYXRoMS9maWxlMScKIAogdGVzdF9leHBlY3Rf
c3VjY2VzcyBTWU1MSU5LUyAnY2hlY2tvdXQtaW5kZXggLWYgdHdpY2Ugd2l0aCAtLXByZWZpeCcg
JwogCW1rZGlyIC1wIHRhci9nZXQgJiYKQEAgLTEyNyw5ICsxMjcsOSBAQCB0ZXN0X2RlYnVnICdz
aG93X2ZpbGVzICR0cmVlMicKIAogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCiAgICAgJ2NoZWNraW5n
IG91dCBjb25mbGljdGluZyBwYXRoIHdpdGggLWYnIFwKLSAgICAndGVzdCAhIC1oIHBhdGgyICYm
IHRlc3QgLWQgcGF0aDIgJiYKLSAgICAgdGVzdCAhIC1oIHBhdGgzICYmIHRlc3QgLWQgcGF0aDMg
JiYKLSAgICAgdGVzdCAhIC1oIHBhdGgyL2ZpbGUwICYmIHRlc3QgLWYgcGF0aDIvZmlsZTAgJiYK
LSAgICAgdGVzdCAhIC1oIHBhdGgzL2ZpbGUxICYmIHRlc3QgLWYgcGF0aDMvZmlsZTEnCisgICAg
J3Rlc3RfcGF0aF9pc19kaXJfbm90X3N5bWxpbmsgcGF0aDIgJiYKKyAgICAgdGVzdF9wYXRoX2lz
X2Rpcl9ub3Rfc3ltbGluayBwYXRoMyAmJgorICAgICB0ZXN0X3BhdGhfaXNfZmlsZV9ub3Rfc3lt
bGluayBwYXRoMi9maWxlMCAmJgorICAgICB0ZXN0X3BhdGhfaXNfZmlsZV9ub3Rfc3ltbGluayBw
YXRoMy9maWxlMScKIAogdGVzdF9kb25lCi0tIAoyLjQzLjAKCg==
--00000000000053e08b064de24838--
