Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F5B45C710
	for <git@vger.kernel.org>; Fri, 14 Aug 2026 17:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729066; cv=pass; b=HVVc+rB6/qL1BYNQhqHAXONvtotdIOlqcGn8YcAue25yJS4Ljjc6urxXg9aXaj9oKcnEMGocVhYY8lTXCwnCEH9AcE//vBG0sTVkeKwcxNF69oU9YsUoEUP4o6vsImzjPb/jpaAy9eROS87mzczvOxgUkmrqH6XiL2AsoEAUSN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729066; c=relaxed/simple;
	bh=9HNGYL+fXLzstZSbNP7bWvn3P+JzzHjVseFFKuJ3vHY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MILud/JGEYeA4GLc6l9CeZ1JHIrCFgtfN6PrC9YBb1A5ow74vVXICjSy9IptX85uAz0fsnlaBbRWYc7FD9piQVnynXfBc9Sqdayuy7Wl0nVA1iWKbCOaSm0h9ZixpEzq2gm3DA30XaaTxPL1y7QD9vjqk/V7d50AdZ0JDrSGSqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqxCg6l6; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqxCg6l6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso1936180a12.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2026 10:37:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786729063; cv=none;
        d=google.com; s=arc-20260327;
        b=YAWCiYF1qvdXMCXsIof09wuP61RdMxXo1GWkVXlgOKKJvR17FqVVfGYGbmQ3qEYNMK
         PLQe/eIsr6fqImbYKbHUBozAi+cXcDWIOFYQZcLOZ6Ru10tGAxIAdP9XR4mgK/1lCSh0
         rPrK0chsVVF6AX4uttLwtGcamHCJhSNwus/BqoSEcPeJrhYeeRuxFFga/++fF9Z4xUG4
         IrTFuM6+Xzvcke1wG4G3COh2TWcK9l5eCHe6N8DbQ3qKRqi/5eMAWj0LnEk3qqMihQB7
         aFq3RCnUMDZ3Wufz11gQEn/7z2U0ozEh3E0ix29JvzVEI+2ha+55PVvp6okeNFUqtuRx
         EOpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=9W+9ZCCbOZn4alz8qWaKZ8s/RaXlGg3vIWXIY7sIj5Q=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ikGYVRIn6uadeFje2WINatbyWhs3HoTGl814nKA739jfqxDXphrtgQu/AqVrJ8Dhgc
         xiKW3aeROzaZztZN6DoDnffTEEHToUHmTf9zgWLIWEwlhaKUqtnVOcNHhAlM9FBA8NY2
         T4NBhybqnp2DYIOW/lUVAeF1If3YILnRhdYO3ks66HE7f8iJ7rva2uXeY2kLCFVBDWmc
         Y5BQDQCv/l2+VDQ7s4CBK28Cu5PToYvp00u7r9F5FHj5h5MgnXylmSFvFp5Vru9dmxU3
         DaVdKqsxSP/vyUmDJ9QH8/exMoyy83UHc65yawrUUR7BRczh+oB2IJ19bPlFXKscEPzN
         DM4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786729063; x=1787333863; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9W+9ZCCbOZn4alz8qWaKZ8s/RaXlGg3vIWXIY7sIj5Q=;
        b=sqxCg6l6cV6lmAXpjRsKmUaXqxXzr2ulFo5XV4te9g1/9r28tXywLkK1664LwFMhQq
         f7USOVAiNSPWaBsqo2LbOLEXbSziLopUqmpPlJaC9GKOYstm+TJFQDZ2waUcgkCUYW1S
         aCd87S8sWGfSlBzHDUs7z3NC9SJgjpYgJTX5zPfP/IQ+LSC0CAk+cflF3h0FztvIvj+p
         MOEYgbA9rMS4q7Yq3MZQyRDFzHtmSbkwFzP/7l4rPFc+czJGx8Z2POJ8Pfrg+Bq5PIf8
         FRjPdnto8+T9FB605mrWZVN58jzDpAUh5C7am8PIhZTv+93BXie5VHFaco7NE/vgsju7
         l3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786729063; x=1787333863;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9W+9ZCCbOZn4alz8qWaKZ8s/RaXlGg3vIWXIY7sIj5Q=;
        b=RtN/ugpuabOauy/johdgmXsx2eOClN5nS3Bir6xnDPUz74HHgQVdvAABsMrdkfnzrF
         Ugsos8fvFcLCDnFnevHHJvslDx1me0HP8W4bx/9EJr8D16OK/zVChxIhZ7S+U/PSeZ8y
         158+yqlw0IOlhuqSDVhfSXL6fZgun5uEtjd6DMAMYKVYG6ifvxJzrjMfZ55VyBj99PWB
         qE9peaOae8NTX9eCPZacxNgCZL/FTPXu7UTgh2H5XRuVvQuXfG/vBVExLhjO/cR/R3Qs
         grmVhjwRZ8Z2C9GCNAzwdLBLncfkMrWP3utGUFtwSnQDFEq85Hw+bBYZ9MzDFFWco59x
         XEeg==
X-Gm-Message-State: AOJu0YyGmE+NXKxI9eRCLAH8hfi0U3K/MOnSEZi6kgpSfQ2BgpQ3EO9E
	GCWkYUyLY2EKThzr5lQjxmhmMgV4CT5scIrz6IR6GNrdicZka6jZF8ncPqbfPri5nLytVlAfaOz
	RwvaEzfrCW0fW5nEn3cp6zXRBpT8dg7+HgDAAcZ0=
X-Gm-Gg: AR+sD121mNL1I4kmTAMX90Kwx3Rh5DBzcT8zwZFYD+M7NjAXl4yAorxaMEb67QQxMS+
	w2cBcRKFNLreq6WFCA/FW+INIl39Q6MEu7AE3EPs0a5O9Aplw+bTKXzF1I1+BaWNRBZd6UQcAHZ
	c9BGwYEDRnDDFyZ0h1MBDjc+dxrQ/p0WoTqTJwtHY/BX8FbLq+/X+UWbQIQy4ipKPxBaSdqOFgZ
	QqabXscZmNZYsjsE4UesnYBtr4Dp7/96m0XR5kDdE0aZlvTazW0V4Kp36yQs0oZUYqLIkTWPT31
	ZcdqJ3W95aepp4ugeVfFRB6Tws4OZy72PyyBmsnBZsDoFkhirg==
X-Received: by 2002:a05:6402:4513:b0:6a0:926e:f907 with SMTP id
 4fb4d7f45d1cf-6a38a8bea9fmr3736825a12.1.1786729062554; Fri, 14 Aug 2026
 10:37:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tilak Raaz <raaztilak07@gmail.com>
Date: Fri, 14 Aug 2026 23:07:29 +0530
X-Gm-Features: AUfX_mzVbwZ7dDNaudvJVtR3uGWju7EoZSlMFcuELzTmRARt-PV0-FA5eAMozN0
Message-ID: <CABB4Jh3UUXvmAJpefaiP-xVRQfGRdTF2jW8GkdhbA1BXe6Okdw@mail.gmail.com>
Subject: [GSoC PATCH] submodule: warn on valueless active config
To: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000015959406590547bc"

--00000000000015959406590547bc
Content-Type: multipart/alternative; boundary="00000000000015959306590547ba"

--00000000000015959306590547ba
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

My name is Tilak  (he/him), and I am a second-year Electronics and
Instrumentation Engineering student at NIT Rourkela. I am preparing to
apply for GSoC 2027 and am starting my contributions to Git.

Regarding my background with Git: I have built Git from source,
successfully
navigated the codebase, and tackled the NEEDSWORK comment regarding
valueless 'submodule.active' configurations in submodule.c.

Below is my microproject patch resolving this issue by switching from
repo_config_get_string_multi() to repo_config_get_value_multi() and
adding an automated test case in t7400-submodule-basic.sh.

I look forward to your feedback!

Thanks,
Tilak

--00000000000015959306590547ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi everyone,<br><br>My name is Tilak =C2=A0(he/him), and I=
 am a second-year Electronics and <br>Instrumentation Engineering student a=
t NIT Rourkela. I am preparing to <br>apply for GSoC 2027 and am starting m=
y contributions to Git.<br><br>Regarding my background with Git: I have bui=
lt Git from source, successfully <br>navigated the codebase, and tackled th=
e NEEDSWORK comment regarding <br>valueless &#39;submodule.active&#39; conf=
igurations in submodule.c. <br><br>Below is my microproject patch resolving=
 this issue by switching from <br>repo_config_get_string_multi() to repo_co=
nfig_get_value_multi() and <br>adding an automated test case in t7400-submo=
dule-basic.sh.<br><br>I look forward to your feedback!<br><br>Thanks,<br>Ti=
lak=C2=A0<br></div>

--00000000000015959306590547ba--
--00000000000015959406590547bc
Content-Type: application/octet-stream; 
	name="0001-submodule-warn-on-valueless-active-config.patch"
Content-Disposition: attachment; 
	filename="0001-submodule-warn-on-valueless-active-config.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mst8aopf0>
X-Attachment-Id: f_mst8aopf0

RnJvbSAwOGEyZjI0NGVmYWI2ZTRjZjIxNjM4ZDg3YTcyMWNhNjY0ZWQ5NDMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB0aWxhay1yYWF6IDxyYWF6dGlsYWswN0BnbWFpbC5jb20+CkRh
dGU6IEZyaSwgMTQgQXVnIDIwMjYgMjI6NTA6MTEgKzA1MzAKU3ViamVjdDogW0dTb0MgUEFUQ0hd
IHN1Ym1vZHVsZTogd2FybiBvbiB2YWx1ZWxlc3MgYWN0aXZlIGNvbmZpZwoKVGhlIGNvbmZpZyBw
YXJzZXIgcHJldmlvdXNseSB0aHJldyBhIGhhcmQgZXJyb3IgaWYgJ3N1Ym1vZHVsZS5hY3RpdmUn
CndhcyBwcm92aWRlZCB3aXRob3V0IGEgdmFsdWUsIGNhdXNpbmcgY29tbWFuZHMgdG8gYWJvcnQu
CgpTd2FwIHJlcG9fY29uZmlnX2dldF9zdHJpbmdfbXVsdGkoKSB0byByZXBvX2NvbmZpZ19nZXRf
dmFsdWVfbXVsdGkoKQp0byBwYXJzZSB2YWx1ZWxlc3Mga2V5cyBzYWZlbHksIGFuZCBlbWl0IGEg
d2FybmluZyB0byB0aGUgdXNlciByYXRoZXIKdGhhbiBjcmFzaGluZy4KClRoaXMgcmVzb2x2ZXMg
YSBORUVEU1dPUksgY29tbWVudCBpbiBzdWJtb2R1bGUuYy4KClNpZ25lZC1vZmYtYnk6IHRpbGFr
LXJhYXogPHJhYXp0aWxhazA3QGdtYWlsLmNvbT4KLS0tCiBzdWJtb2R1bGUuYyAgICAgICAgICAg
ICAgICB8IDE2ICsrKysrKysrLS0tLS0tLS0KIHQvdDc0MDAtc3VibW9kdWxlLWJhc2ljLnNoIHwg
MTEgKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9zdWJtb2R1bGUuYyBiL3N1Ym1vZHVsZS5jCmluZGV4IDVj
OTI1NzU4ODguLmI3MDljNDI5YmEgMTAwNjQ0Ci0tLSBhL3N1Ym1vZHVsZS5jCisrKyBiL3N1Ym1v
ZHVsZS5jCkBAIC0yMzEsMTEgKzIzMSw3IEBAIGludCBvcHRpb25fcGFyc2VfcmVjdXJzZV9zdWJt
b2R1bGVzX3dvcmt0cmVlX3VwZGF0ZXIoY29uc3Qgc3RydWN0IG9wdGlvbiAqb3B0LAogLyoKICAq
IERldGVybWluZSBpZiBhIHN1Ym1vZHVsZSBoYXMgYmVlbiBpbml0aWFsaXplZCBhdCBhIGdpdmVu
ICdwYXRoJwogICovCi0vKgotICogTkVFRFNXT1JLOiBFbWl0IGEgd2FybmluZyBpZiBzdWJtb2R1
bGUuYWN0aXZlIGV4aXN0cywgYnV0IGlzIHZhbHVlbGVzcywKLSAqIGllLCB0aGUgY29uZmlnIGxv
b2tzIGxpa2U6ICJbc3VibW9kdWxlXSBhY3RpdmVcbiIuCi0gKiBTaW5jZSB0aGF0IGlzIGFuIGlu
dmFsaWQgcGF0aHNwZWMsIHdlIHNob3VsZCBpbmZvcm0gdGhlIHVzZXIuCi0gKi8KKwogaW50IGlz
X3RyZWVfc3VibW9kdWxlX2FjdGl2ZShzdHJ1Y3QgcmVwb3NpdG9yeSAqcmVwbywKIAkJCSAgICAg
Y29uc3Qgc3RydWN0IG9iamVjdF9pZCAqdHJlZWlzaF9uYW1lLAogCQkJICAgICBjb25zdCBjaGFy
ICpwYXRoKQpAQCAtMjYxLDE0ICsyNTcsMTggQEAgaW50IGlzX3RyZWVfc3VibW9kdWxlX2FjdGl2
ZShzdHJ1Y3QgcmVwb3NpdG9yeSAqcmVwbywKIAlmcmVlKGtleSk7CiAKIAkvKiBzdWJtb2R1bGUu
YWN0aXZlIGlzIHNldCAqLwotCWlmICghcmVwb19jb25maWdfZ2V0X3N0cmluZ19tdWx0aShyZXBv
LCAic3VibW9kdWxlLmFjdGl2ZSIsICZzbCkpIHsKKwlpZiAoIXJlcG9fY29uZmlnX2dldF92YWx1
ZV9tdWx0aShyZXBvLCAic3VibW9kdWxlLmFjdGl2ZSIsICZzbCkpIHsKIAkJc3RydWN0IHBhdGhz
cGVjIHBzOwogCQlzdHJ1Y3Qgc3RydmVjIGFyZ3MgPSBTVFJWRUNfSU5JVDsKIAkJY29uc3Qgc3Ry
dWN0IHN0cmluZ19saXN0X2l0ZW0gKml0ZW07CiAKIAkJZm9yX2VhY2hfc3RyaW5nX2xpc3RfaXRl
bShpdGVtLCBzbCkgewotCQkJc3RydmVjX3B1c2goJmFyZ3MsIGl0ZW0tPnN0cmluZyk7Ci0JCX0K
KyAgICAgICAgICAgICAgICBpZiAoIWl0ZW0tPnN0cmluZykgeworICAgICAgICAgICAgICAgICAg
ICAgICAgd2FybmluZyhfKCJzdWJtb2R1bGUuYWN0aXZlIGlzIHByZXNlbnQgYnV0IGhhcyBubyB2
YWx1ZSIpKTsKKyAgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOworICAgICAgICAgICAg
ICAgIH0KKyAgICAgICAgICAgICAgICBzdHJ2ZWNfcHVzaCgmYXJncywgaXRlbS0+c3RyaW5nKTsK
KyAgICAgICAgfQogCiAJCXBhcnNlX3BhdGhzcGVjKCZwcywgMCwgMCwgTlVMTCwgYXJncy52KTsK
IAkJcmV0ID0gbWF0Y2hfcGF0aHNwZWMocmVwby0+aW5kZXgsICZwcywgcGF0aCwgc3RybGVuKHBh
dGgpLCAwLCBOVUxMLCAxKTsKZGlmZiAtLWdpdCBhL3QvdDc0MDAtc3VibW9kdWxlLWJhc2ljLnNo
IGIvdC90NzQwMC1zdWJtb2R1bGUtYmFzaWMuc2gKaW5kZXggZWVmZGVjYjBiZC4uYWZjNjJmZmEw
YiAxMDA3NTUKLS0tIGEvdC90NzQwMC1zdWJtb2R1bGUtYmFzaWMuc2gKKysrIGIvdC90NzQwMC1z
dWJtb2R1bGUtYmFzaWMuc2gKQEAgLTE1NDksNCArMTU0OSwxNSBAQCB0ZXN0X2V4cGVjdF9zdWNj
ZXNzICdzdWJtb2R1bGUgYWRkIGZhaWxzIHdoZW4gbmFtZSBpcyByZXVzZWQnICcKIAkpCiAnCiAK
KwordGVzdF9leHBlY3Rfc3VjY2VzcyAnd2FybiBvbiB2YWx1ZWxlc3Mgc3VibW9kdWxlLmFjdGl2
ZScgJworICAgICAgICB0ZXN0X3doZW5fZmluaXNoZWQgInJtIC1yZiBlbXB0eS1hY3RpdmUiICYm
CisgICAgICAgIGdpdCBpbml0IGVtcHR5LWFjdGl2ZSAmJgorICAgICAgICB0ZXN0X2NvbW1pdCAt
QyBlbXB0eS1hY3RpdmUgaW5pdGlhbCAmJgorICAgICAgICBnaXQgLWMgcHJvdG9jb2wuZmlsZS5h
bGxvdz1hbHdheXMgLUMgZW1wdHktYWN0aXZlIHN1Ym1vZHVsZSBhZGQgLi4vZW1wdHktYWN0aXZl
IHN1YiAmJgorICAgICAgICBnaXQgLUMgZW1wdHktYWN0aXZlIGNvbmZpZyAtLXVuc2V0IHN1Ym1v
ZHVsZS5zdWIuYWN0aXZlICYmCisgICAgICAgIHByaW50ZiAiW3N1Ym1vZHVsZV1cblx0YWN0aXZl
XG4iID4+ZW1wdHktYWN0aXZlLy5naXQvY29uZmlnICYmCisgICAgICAgIGdpdCAtQyBlbXB0eS1h
Y3RpdmUgc3VibW9kdWxlIHN0YXR1cyAyPmVyciAmJgorICAgICAgICBncmVwICJzdWJtb2R1bGUu
YWN0aXZlIGlzIHByZXNlbnQgYnV0IGhhcyBubyB2YWx1ZSIgZXJyCisnCiB0ZXN0X2RvbmUKLS0g
CjIuNTAuMSAoQXBwbGUgR2l0LTE1NSkKCg==
--00000000000015959406590547bc--
