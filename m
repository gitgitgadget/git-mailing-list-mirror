Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5A305687
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348057; cv=pass; b=qz3W0Vdq+eEjfvr/xfA4Urp9ODDjZwKtMdkQi1RtsT5qpvtdVqLdhZMMeJl212OCiPZP2S7SpubVDHoG9YeARJE9kvJuv2fEn7b+abzL3PeIXqkOemLzyIBFSpoMQsO6dnVTXQw0FKYWmJDHSRN+YX+LnUdGFbhxJpyOlKPiUMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348057; c=relaxed/simple;
	bh=0ftZjxyQI3qcooTPCLdHhoRjLze6VPc6gg2d0YQnC0A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OrCJN6ctYE+fOPjJUiucuKwZzNQCs00CAy0VNbP5XhfWydYxhv6u9w3+buabAz7d+U/f2m5xLx12G45+Ing2NefSvewcsu+mzytLd8Fjaz/5DVRJpKOANT417eYU6FWIGHIBFnjmOiqltBXTAG9lb5Q86yG+NsLZFRsOfQhfwsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdfRTCO0; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdfRTCO0"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97e986f1996so238445241.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 04:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788348054; cv=none;
        d=google.com; s=arc-20260327;
        b=DTznSkUSq0sbQ+fAtraJtyFWDBITwcn+HbTPCZTMWqXLh5y/vpDKgPozqV2NTKip5G
         6nMpcnCAl3TzcvuvR+PAAFW2NcW5+0zx+poJMJMBctK45AH/p6l8rm+VGL9XcOhHvSfS
         xtuZA7KVfWEigpeMDMMl6H8+Xx2iPivzDGUyEmSRauRU7zucGTQI/qCqq1yrE40/Oygl
         mpbABVEnih4EwFOhSY3ajpo2AyfR2k+KK5Xm5NskSfyx1pJ0/CPIjwOIIpJkvK+qLX3F
         n/o5Zsby6Kg5ODjux6N7Wqc2mvfT32KvZY4RArTRuACghPlfI0Gy4wA3oYFnZn2crw2h
         +MLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5F28CjwuLhRJbU+yn7+UJqpnNVddE+a/5WCM8hjjPXY=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=b50ifcPMwx1JdTjh4JFhyU9VtoNUKbwvPM7u4uWCuqZ48W75fIRcnmk/Fj2zCdwcIu
         dESBYXP4EDy5Uo/9BIUbhsbTQhPZWtZnLcSIlphwEyqVU2lsIrFb/i6/qDtF1roIreU4
         cvMvjXIJ8vu5aemPVLm6XqBmtUyanJp1eh36tTwPOSYkUDYkHuMbP3C6oCLDvOb4enKW
         N6vXlDOYTXIohJfm+/E8AgVcoRluqWVBvYIqjgUJotiuPS53b6wwZmdw1tOsqjctaWao
         NK6sJmwhruGoA8jbWHNLTMTXIvzHlqK8czsDdfVjhKmgiP31hIPlEsHHJyoWZpn0a1S0
         ONRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348054; x=1788952854; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5F28CjwuLhRJbU+yn7+UJqpnNVddE+a/5WCM8hjjPXY=;
        b=UdfRTCO0lNzVD1ydrYmZVwA0cgrCpBaytWgky61pPeKSI4JO4HYoLv+g1FEeF1M9Ak
         AoCus1O9uMS91BpUXrb20J1p8V68vqyaOsoPSRO6mIsyeVQ7F/tXyUI14Go2oCzjJax6
         h5P2XSwJy8Vs/8YXb6KhuvMfgFy/smNHrLdiIeWj2eMdmywf7uKg/0ug/SHnanrfnkWG
         0jwrqG+LoS0Xw4Jp77BXEA1R0iUohCrG8J//k8I4PogSjHmvSgG1FkCCXp6/YWJYrTOE
         BIdG2wx/zlEKk6ryKU7CrTgAyI6pspBRIl5Nc+52BePv1bi5PbOzczvX2A1LF+whG/Rb
         GotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348054; x=1788952854;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5F28CjwuLhRJbU+yn7+UJqpnNVddE+a/5WCM8hjjPXY=;
        b=st++R8a0ma/IkstEnz74byl1uWT4d4Zh77wPTTkTcV0WJOVZvimIWNRV63upgG0Sh0
         VvsNUFORsgR6CWRQGFmZYmAMJWzjnAFxV7K1MmW+2b5oEBoUF68HIos61YIY3vtGOmx4
         oMHA7O9kBA+NS2LqGWb1uQo6l2RXJyTTj2g0q9ogcFO5iSBNiKpewK+m8OXwdimqe9Zs
         Pbp99sbqwjun7Aq/jyFJEPA96bajJBgW9kMJ9hmpdzmakJQ8eaHwOtWClKCF3JIK56rJ
         SfCzO0hfic3XpuuuzeCkSRr98bfpOzDL2vjErVW6nrrPA+x0sPIPlwqr4eyNFvDJ7pjX
         ZVlA==
X-Gm-Message-State: AFuF++koW3xzEJGKZMFcWRpM+UPfJ0SlLi0EHrcPjNHBiDHGmCDRp374
	GDSzxqmVpOItPGND4ucHdnkWqcFlS/UdebbviIGcC8h96jNBKSr7pMA1KM+4rsDbGIT/zFAI2re
	89KvYN98oLvPtcnVi6UkYpZp33bt+Deh+3rGd
X-Gm-Gg: AYBFou3EHwT3mGSQ/XwzQIUyja91gLgZ0ZI4+rKYk6yKIYhaoGWvhyUkEHUXm6OOiDm
	XrdBTHR5mi/L40V6labCz2sQ1n1Q8L7eH1E5cpMp9ye3OJdjQTlqCto7pSDUdtKXQYYevzKhGXh
	HFxVZMPcejKAH28QZgHtxwv2vaWu7wW7JqkcNnkb1z+yY3snh0bA4SwH2Ax7GLf6yyKBMnq3j+N
	QD//sNUm7+1/eTaTe2Rk+zYxM9+/kRpXgKbW6nNidBiKNHpBj0tVQhPYUIQk6/n2O3uhxLFDWg5
	3AFyx8eG3ioLYZcxV8UjTN3urEgD/+qg6r0kcfQQFuX2QDlxxwLipDVcn1byiSeM4CRYEAknW7f
	SXtqwuhQJiVxKRqwis6Dj/suRDPKdFqPDXeY=
X-Received: by 2002:a05:6102:948:b0:778:71e5:45d3 with SMTP id
 ada2fe7eead31-78a1f34b329mr1048569137.9.1788348054138; Wed, 02 Sep 2026
 04:20:54 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 04:20:53 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 04:20:53 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqld9ksw26.fsf@gitster.g>
References: <20260828225206.310500-1-gitster@pobox.com> <20260830204835.1040408-1-gitster@pobox.com>
 <20260830204835.1040408-4-gitster@pobox.com> <CAOLa=ZTA=xmPnEkMsncwd=3iZA62nsXq0jk-KiUr=GU7OUhh1Q@mail.gmail.com>
 <xmqqld9ksw26.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 2 Sep 2026 04:20:53 -0700
X-Gm-Features: AcwNN1VHHWDtEtDT3MXQnPuvKIpKO6MyGUdC3AO7GF4UIWx1CzTTYmkiCccGvi8
Message-ID: <CAOLa=ZSQs5umaTxT6RKQJdnnAEbK+AHgj0n5yiTM0jsbZcyiig@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] checkout: validate stage and merge option
 compatibility in checkout_paths()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000080aa5b065a7e3a20"

--00000000000080aa5b065a7e3a20
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>>> @@ -591,6 +591,10 @@ static int checkout_paths(const struct checkout_opts *opts,
>>>  		die(_("'%s', '%s', or '%s' cannot be used when checking out of a tree"),
>>>  		    "--merge", "--ours", "--theirs");
>>>
>>> +	if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
>>> +		die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
>>> +		      "checking out of the index."));
>>> +
>>
>> Doesn't checkout_paths() also get triggered when using '--patch',
>> shouldn't this go below...
>>
>>>  	if (opts->patch_mode) {
>>>  		enum add_p_mode patch_mode;
>>>  		struct interactive_options interactive_opts = {
>>>
>>
>> ...this block? As the original checked for `opts->patchspec.nr`
>
> Sorry, I do not quite understand your question.
>
> The "if (opts->patch_mode)" block indeed appears in checkout_paths()
> and when "--patch" is given the control comes here.  Are you worried
> about
>
>     git restore --patch --merge --theirs
>
> triggering the option compatibility check, instead of ignoring it
> and directly jumping into the patch mode?
>

Sorry if I was unclear. I was stating that the condition udner which the
check runs is now difference. Previously we checked `opts->pathspec.nr`,
but now `checkout_paths()` is also entered for '--patch' without any
path spec.

Having a closer look, it seems to be okay. Because in patch mode, each
of the combinations is already rejected before in `checkout_paths()`.

It still might be good to have a sentence in a the commit message, since
the guard did change and the reasoning why that is safe is not so
obvious.

This does however change the precedence of the error messages:

  $ git.master restore --staged --theirs --merge foo
  fatal: git checkout: --ours/--theirs, --force and --merge are
  incompatible when checking out of the index.

  $ git.patch restore --staged --theirs --merge foo
  fatal: '--ours' or '--theirs' cannot be used with --staged

This seems okay to me, not sure if we have tests to validate this
behavior.

>>> @@ -2063,11 +2067,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>>>
>>>  	opts->pathspec.recursive = 1;
>>>
>>> -	if (opts->pathspec.nr) {
>>> -		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
>>> -			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
>>> -			      "checking out of the index."));
>>> -	} else {
>>> +	if (!opts->pathspec.nr) {
>>>  		if (opts->accept_pathspec && !opts->empty_pathspec_ok &&
>>>  		    !opts->patch_mode)	/* patch mode is special */
>>>  			die(_("you must specify path(s) to restore"));
>>> --
>>> 2.55.0-884-g76cf8659c2

--00000000000080aa5b065a7e3a20
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6bf2a1b3b4713def_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xWUJwTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUxYREFDQ2hxbHptR0gvWlYzYUFYdmJqNnkyanJMWQp3RWhRMTJSZ2Q5
Y3hrSytMM0tYR3FieXNOMkRORE11NHVGMEsxK3g2RjYyZzYrUGRSWW1rQnF2WHk5c1NHdXFDCmtC
YVZSTTVsTFI3L3Y3RkxyNjdwMFVVZENITEZEN2ZwVm1pejBSTEtJclF6bTlOV282aUVQMzNHOU5h
L3BiQm0KTU1KV1VSeHBHUld2VEJWQ0gxc1QwVzZydFVwYlVKWGFYK1k3RU9ac3FLS0xoZGkrNGtQ
Wjl4Nm9tM1JyVFNvMQpyVUxQVTY2ejF0VFFjc2NTcFZVZVZGcXVsSXFjNy9tRS9NWTd2WnZqcm8y
akhtZGJKcGZnYlZDdWl5M0VhNWtnCkg1UWE2NGJEZmc5QzdWcmFuRGorZ3QxVmNweU5RQ0NhUlc2
VmkyVjhnYmpUNlZSZ1E4SEdFTEszVXZ1aFhlWmgKdnk1YmdhRk5yK0srL054SkdYQXplU2VtQnpX
T3lETit6MDN1ODFyZUsvdWtPc1MyWjRaT0cxUGtDK1dodDRxZQoxR1hGbEp2SnY3OGdISjZRRjJ0
OHBSeGs1TnNPVk1qR0M2TkEwUWpaaDl1djdQaXFRQ1g4ZEJHVVJRTFk0Slo0Cjc1WWVtdnE2Nkl1
SEdjQ3FyQVIwVWY3RmZlTkhXMndrRkhYYU5MVT0KPW42dDIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000080aa5b065a7e3a20--
