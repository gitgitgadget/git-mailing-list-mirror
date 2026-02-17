Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B6308F23
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320575; cv=pass; b=YOwn5R8C88LuIO2NiyPLmazrOGWsZ1XmvTry35nkxffKRNrhFWTH9BMdbPvbuqcwzhy2vFPJu1FBpc9E/Az/jT83J70jiesefxK5n7v/nyik4JdaV5XhFBail1P0AA3IYuqBuN3aZ5df6ZA9YpOi57ZE8ldEim1sr14ryckQu+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320575; c=relaxed/simple;
	bh=wU9qlcwZNjswKGYu0uZG+OlFF5bmoW/3ItUC4Yj+1Y4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H+pg1b/dAZX6TQMKW6iWIt7a5Aw37w2uoO/nJwIDQ4tB+fQQbmdplh0mdx0cKazEFrlG4oE+FbuGlHIh+C0SEp52ry7ZROng52txBU7517mKdq5pZYM7F7i686VcVJC+/4szmKRO/ptbp6xcKYYN8M8AHLoVePPTkOVz+LQUcyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nos55zKr; arc=pass smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nos55zKr"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5fc66c49d03so2334795137.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 01:29:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771320573; cv=none;
        d=google.com; s=arc-20240605;
        b=Z5tm0APCW8hkKwJNR5PenOBSck7MPKIJOO5x1gTyOsVdZMRdHXybvnEUDRMYOIFMtT
         zEe/ThN2Y2M3gSkspR7K7QKKPFLM23DqDOgAC3hFbq4xTR9drWp3B+jNUiMfuBPZ9AVq
         ayhvHrkPkPwmez2TsU1xXHbxzZhrAI6JmtzJ8aNCssAzYG30Pk+QudfJGtGU3XvOZ1xR
         /8aiA6AI5rpXkWiPPXDhhSMOcEwspxzgrPfua53S4+Z8Fp5cQ+6AwiA9WWQTmJ+6FyvN
         bd/5al1h83j/rFjsuRaKo0Vezbpjl0fC2z1fKJwsu4bRIP3jf5gP+0VL2nTmMmQu32C9
         uFng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=5FqBO3Tfpwn/lDgFYZE5prH22pql9VMGnTi7j4fpJq0=;
        fh=ty73qu/mjp6olkAb0/G4VGZeH6SWOLNBs8YQa03/qaY=;
        b=d5Sd+7uTS78Qb6wVC0GIIg76H7ReIRFYEZ9XaB28djLTrEK1w8S1DRTPIvvEDChw0K
         PFA/xoXwzytXYEcUn+y5yDYSwwP951JzEYow08cwQUVMvXis6Vmo7UAQQ0yS8lSCfG3A
         JnxOFvq+KR+ExAxi1xBbWA80DVQ2Rdezzh0mxqyL14yBJkRV0k3ogJQhc3yrrVmZUzZJ
         skkpl+StOsraWthgP5zAqEw9e97fMrHjzpO1RDecoIWc0ODVSiXytZsOrO5CeHdbahnK
         KcrlRk39rQkNEkQMsFpP9miR7F+6b0eeWP3HfPqCD8Z2E7Tz63jqJaM5coW0z7b4ssGw
         +64A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771320573; x=1771925373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5FqBO3Tfpwn/lDgFYZE5prH22pql9VMGnTi7j4fpJq0=;
        b=nos55zKrR8irPL1/EnI6eaHtWE2jCWvdWkXZGJ/j1aqgZTls5SxL7uprZ7iJur14Wl
         T/gpcXXNiYEswKjr3N5oG35OHjxwID7uqwM8g50uUnb8587zJ/cRA4cNSk0bjamA82UP
         /ZpvE5f/taaqZreSt9flULg1HHzOrZMgGoP9zfIQgJbOHO25ey9lp75NwriOwqTt1/Vp
         K31pqX/eic9b9HQeMf6WbxFkYfFEUEa/YnJdhjNliKMReAtuKNaN7QrcBI3C4VcENPlC
         MPQAknB49sjRwyqieKocWb5t8gOyDANN7M+HyaVXP6A1M0lBELLSZG4qX2p//BoVb1Rq
         muRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771320573; x=1771925373;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FqBO3Tfpwn/lDgFYZE5prH22pql9VMGnTi7j4fpJq0=;
        b=B2mlY0LWyNXvQyPV7qH5kHbwxaAQ1lvle79utgGKAF9puU8KpZrMLHcNKSZfFw4S+k
         ub1IeLRhammWUErMEPFlViLeKylCqU4w/6lnhjGPlpOQAFR+8NY3KUVZsJ2feUxbi16U
         uPNJr/r/O7EUNuLYV5v5g/ZW9TOVjdTe1xVgmtXWobHL+8YvJUs+y2yYZRjfKMYfX+Nj
         DwpAhGMpV3Jw/WvY8xU6U0/xREMwjFPLuipm/YiPqEpf4Hu1F9W/VTC5HrMJwDJJ1xhW
         SIAqImSFg3soVT5h07L7j+xv6N64GGS5jN8KOxocHU9veJ6BqgC7e02ZQIPJyu3XXSKT
         bu0g==
X-Gm-Message-State: AOJu0YyBTPOsZ5PkD0C2OByfLyls2OCkH1naB3f6+Ui3sY9s4g5XX4OC
	4XsLO3nAjgio8bnIeuBdReWzuiUJQ/kuJpmlHtOCnqbjCsSr/7UDPBz/cgvbl3KYnkHwoMyS1yG
	uuX1qIKOIqGedhOcR5aCYlE6h+4A3mQc=
X-Gm-Gg: AZuq6aJ3VhNpQTNnGJ8sfdpv+rhmMFy1qP8f2dHJg6TmRzwwEjW0kv9vx5JJt4TDYPs
	iZNGUMSfhp+XYVbr+ERfZ78F+ptbFTEfmDBdNjeSwg73nYyfGRfFtP2uCYd9eRh04/MICOHWolA
	ok8Scvz7zAlCwFJvq/upB4L3lOysLCpByEHCHvoNM+F9vvvLVCTH40MuuSaUbRKkSzrkpVYS5P3
	8kB32lRPgCwQKiAo+LOIJSkaq9upMoUP2+UFl31Qw5XZAjRWzxS/DB1EsB/UDLIJv6NyWqqflBL
	Kksjnp4tiL+quRjTBVwVPc9hTpwM4K56HwvMaZIB9A==
X-Received: by 2002:a05:6102:3f46:b0:5f1:c561:8dc7 with SMTP id
 ada2fe7eead31-5fe1afb77ccmr5608931137.38.1771320572667; Tue, 17 Feb 2026
 01:29:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 01:29:31 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 01:29:31 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aZQXpb7RMW83eGxe@pks.im>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-4-86a82c77cf59@gmail.com> <aZQXpb7RMW83eGxe@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Feb 2026 01:29:31 -0800
X-Gm-Features: AaiRm531byYKw7qMrISDUNh7WXdbpJ8B_n6dLwVqb88yfED3Dd8z8IhxjhvSPVw
Message-ID: <CAOLa=ZQwrOGpZfVtfTfPFhnkJ_qnEhv8mxO3Ot7nQXusbkJkYw@mail.gmail.com>
Subject: Re: [PATCH v6 4/6] refs: move out stub modification to generic layer
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000849160064b01b52e"

--000000000000849160064b01b52e
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Feb 14, 2026 at 11:34:17PM +0100, Karthik Nayak wrote:
>> When creating the reftable reference backend on disk, we create stubs to
>> ensure that the directory can be recognized as a Git repository. This is
>> done by calling `refs_create_refdir_stubs()`. Move this to the generic
>> layer as this is needed for all backends excluding from the files
>> backends. In an upcoming commit, we'll also need to extend this logic to
>> create stubs when using alternate reference directories.
>>
>> Similarly, move the logic for deletion of stubs to the generic layer.
>> The files backend recursively calls the remove function of the
>> 'packed-backend', here skip calling the generic function since that
>> would try to delete stubs.
>
> Tiniest nit: it might make sense to reorder patches a bit so that the
> creation of `refs_create_refdir_stubs()` and this patch here sit next to
> each other.
>

I think that would be nice, let me do that.

> What's missing a bit in the commit message is the motivation. What does
> this step enable us to do that we couldn't do before?
>

I did add a line

  In an upcoming commit, we'll also need to extend this logic to create
  stubs when using alternate reference directories.

I'll expand a little on that.

>> diff --git a/refs.c b/refs.c
>> index 11d028232b..a24602c9bf 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2190,12 +2190,59 @@ void refs_create_refdir_stubs(struct repository *repo, const char *refdir,
>>  /* backend functions */
>>  int ref_store_create_on_disk(struct ref_store *refs, int flags, struct strbuf *err)
>>  {
>> -	return refs->be->create_on_disk(refs, flags, err);
>> +	int ret = refs->be->create_on_disk(refs, flags, err);
>> +
>> +	if (!ret &&
>> +	    ref_storage_format_by_name(refs->be->name) != REF_STORAGE_FORMAT_FILES) {
>> +		struct strbuf msg = STRBUF_INIT;
>> +
>> +		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name);
>> +		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
>> +		strbuf_release(&msg);
>> +	}
>> +
>> +	return ret;
>>  }
>
> This makes me wonder: if we called `refs_create_refdir_stubs()` before
> we call `->create_on_disk()`, could we even do it for the "files"
> backend? Just a thought though.
>

Well, there is some nuance there

1. 'refs/heads', 'refs/tags' is not created for linked worktrees.
2. 'HEAD' is only created lazily, not in `create_on_disk()`.

Also the intent is totally different, the stubs are for backward
compatibility. So I think its better to let that logic stay within the
files-backend.

>>  int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
>>  {
>> -	return refs->be->remove_on_disk(refs, err);
>> +	int ret = refs->be->remove_on_disk(refs, err);
>> +
>> +	if (!ret) {
>> +		enum ref_storage_format format = ref_storage_format_by_name(refs->be->name);
>> +		struct strbuf sb = STRBUF_INIT;
>> +
>> +		/* Backends apart from the files backend create stubs. */
>> +		if (format == REF_STORAGE_FORMAT_FILES)
>> +			return ret;
>
> For symmetry it would be nice to not have an early return here, but also
> format the condition for this block in the same way as we have it for
> `ref_store_create_on_disk()`.
>
> Patrick

Yeah sure, we can do that here, in the last commit, we'll have to modify
that anyway back to something like this. But it definitely would be
easier to review this commit. Will add.

--000000000000849160064b01b52e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9281e0e3dcb0f05d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tVU5Qa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlpxQy85TklKTGl6aXRpNVozU2tWd2VFeHpSaEhXdwplYktIOGFOWUJC
MVQ0VmJSSjFBNy9TRzJETFNYK0lhbkVOWXhhZUJaSStGZnI4R3hGYlEzZldHOUhCYXlzOUdYCmhv
cnRUNW5vTkhiNmpwYnltaEtQWXdadUh3eEFJTWpkby8vQVhSZW5sZllLMStiRFpNMW00UktnempW
b1pxa0cKSHJFY0VqT0svQi9oM1VUOWs4WHVYQ1BFRUx3UTI0bnRicEhnTVI4QklLN0pSRVZ2VFBR
ZlVlcU9rR2JJclJEYQpkUElCWUFQZVNHSDh3bHcvQm9oMGVZMG5JYnlmTnVvUUdjT1IxazFTSFpC
Mzh4OTRJYUJhS2FnUXZaR2RUZTRTCmpzYWd1VlRXN0xQQnVGWkJ4RDE3Z1F2YUVObkxsTUF2ZzNV
U0dldzRtMHppNk83NGRBRW9QTVBGN2JJbnZMbDAKcldabW1HNjJwQ2p1RFovaDBjK3RSU0pYWDcz
RVJPcWNOcUcxYmcyU2xQM3ZVcUd0d2phOVIzNXpyZDQ4bVMyaAo0TGpqdlJVUUJsK3ZkVnExbWMy
QkswY1ptTnlvczFZSzh4aUszVTE0QWhKaGpnWjBibEZMQnBjYXV0cDE2SWVTClZjTzVrakdnVTlU
bkdSUnV5bmplZVJja0xocmpESTd3cnNVdGZ1RT0KPUJwS1oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000849160064b01b52e--
