Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D871229993F
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 14:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255180; cv=none; b=RDdcPu4PHrnCeBliDPsrMlnElqxbjzgBOUWDf3goIj+7VascZKDOokJBlcpRfylFVC8AQVPdMl06YCpx7AB+3dh3kc97lfpUCCsvofLe675GOZ8H38vec0MruSUuYhaSUAVHYuBElcSmf5bS5rLOtuEFkWAdL8+18UsXeculxn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255180; c=relaxed/simple;
	bh=RwomHKgealjd9NXFcbl6MXZDScJgwX6mWFaoInUdaSc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0QktB/CWglqlz6PypgFRdsqn45iN07FCua10qn5J6U8s1V2kQEf+TaeJk/RTKdN1cZtvYRyclcbENSNFFmS1gCAnsGSqGU5oscA/+ZvfwExqk/cQUbLCpqLunQonScYZ+Ip8BYClUX9E7li291SxZ/hxUdQCY3fB4bIwppuyEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1gFW2VO; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1gFW2VO"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-5dfd380cd9eso583137137.2
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 06:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764255178; x=1764859978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tkq7Lr2jmonqqXUZPkOm0ptdo/umKEaj2sC5u8PUWwo=;
        b=R1gFW2VO6lQl3zXAchyGXlM+mSQzsYDhbqzuo6sczfOPO3MZ8q3/WpJdmBN30FS8xu
         XZP8lvvNkHNsynShyFoLrflG6MROnQHaq7o6iGuvl+mDG1Eui+z6xlEN3VJo0zdxipnl
         UoZucCEGnZe4tzkmFKwGdtXxepMkocqSx09GZluFrx6jeVSRfAadepsQ+gtOpaRz6fcw
         cTjCHIVGvGfd2vbXqp3VcVma9zKFEOYz2lKo1rGKtN6Cmnca9UF7pxMKDTWLXqohuv26
         dOUdU7RXQlnOr5JrUiqoJcLsJNP1wxtP/gIAyF66Ak5oqNS9Mn7v+/6ZvLzA+oOlFLLt
         wXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764255178; x=1764859978;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tkq7Lr2jmonqqXUZPkOm0ptdo/umKEaj2sC5u8PUWwo=;
        b=WVCDcqqIHMLYAuVJMUGTni6oybYUgOF5Rrqj/W2GdqZo9/sN9UHPHkZhkNR/LHovWO
         vT+7R3bonGqOoLKloCPFR+ruA2PWJ7ki33E2iQb9rMm34RPmgFI0qm6mSaRozrlX/o/F
         zs2TYHPMXf/rFPG6ZL2r+pjQlQWdHHMJ7d8HRo/WfsxVap3G/NEykQBs9e/BjqZ9NXsn
         Gv79NdNvNTUIZk5n05ATx39gW4yv5rARtoBg8ZH3lfdETPcqiTE8CvkpultJYy2cylRf
         rZBjpyiYKB6vSCR3jOTPtz7ld3dhNjR2jPdiyQ1LqVEVL5iR3ozZPL5sA8UfvEWukHUN
         pW9w==
X-Gm-Message-State: AOJu0YxRRFgKPjsnCm/v+AYLvJRWYd3MnISmm5caJM1MSpBzfrbuMVTE
	owMH6Xx9uPhiexmjuezWuZMCdplvHLv8E0+bvUlJB2aHar7tUeeyuCyr2Gs1gLOyei3r0EW8JZN
	aEEcK4aKHrGhQGNT3dujoKijL0eqe9cw=
X-Gm-Gg: ASbGncvkyGfzwSYjuNOrtagrbcNIDG5d5Z04jqZF/KLGnXjhMT3KrpTDg7sgpOdKnz/
	on0L6DsqlTGikilR4XXWZvLfgHbwUw/eBIrWE8QnSLXh0HIHmdXHMmLgtov2mfSkjfS5bWoxZbM
	IJ0CcPkax8JYZZJtSpirD0lDS1lzjF2yVaKn/AUD9QFFERHQDAwVPw6PxXdkNMLO0S76A38MwKI
	vl6YrFtzUFH0z9Csu7DlBP4cp1Q0Zg9SXOqGWYbSazOGe8H4ePDvN2bapfMYXY5MdUOGNhgRL0/
	qBq23cab/aeJjdk25kS1tTNsvasPNa61boohRNIH
X-Google-Smtp-Source: AGHT+IEfiNAY5i1AZmRS07XA+b0dnnqCiSdW/y5mYLTqto/XDQaes4TCzaH1QbKwJWYh0glwT331+2UpKNLuNPuJIgM=
X-Received: by 2002:a05:6102:5807:b0:5db:25b5:9b5e with SMTP id
 ada2fe7eead31-5e1de273ca2mr8560998137.22.1764255177597; Thu, 27 Nov 2025
 06:52:57 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 06:52:56 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 06:52:56 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq7bvcpy35.fsf@gitster.g>
References: <20251126-kn-alternate-ref-dir-v2-0-8b9f6f18f635@gmail.com>
 <20251126-kn-alternate-ref-dir-v2-2-8b9f6f18f635@gmail.com> <xmqq7bvcpy35.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 27 Nov 2025 06:52:56 -0800
X-Gm-Features: AWmQ_blXpyYPKxYuN7MmOJK-oi1E9jpRnwc0VHqodZ_BBH8j4Y4GIVg6TffFPaM
Message-ID: <CAOLa=ZRPYUJu4hVuZrXdJ1vq89=Pkiyw0-As=0B6pL1-cymR8w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, toon@iotcl.com, 
	sunshine@sunshineco.com, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000278949064494ab5e"

--000000000000278949064494ab5e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> +`GIT_REF_URI`::
>> +    Specify which reference backend to be used along with its URI. Reference
>> +    backends like the files, reftable backend use the $GIT_DIR as their URI.
>> ++
>> +Expects the format `<ref_backend>://<URI-for-resource>`, where the
>> +_<ref_backend>_ specifies the reference backend and the _<URI-for-resource>_
>> +specifies the URI used by the backend.
>
> It is more like "<directory>" that specifies the local directory the
> backend is told to use to store its data.  It feels way too broad
> for what the initial implementation achieves and what the design can
> potentially include, to say "URI-for-resource", I would think.
>

Well I'm okay either ways, my first version was very specific as it
mention '<path>'. I changed it based on the discussion with you and Toon
about how the '<path>' is the URI for the reference backend.

>> diff --git a/environment.h b/environment.h
>> index 51898c99cd..9bc380bba4 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -42,6 +42,7 @@
>>  #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
>>  #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
>>  #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
>> +#define GIT_REF_URI_ENVIRONMENT "GIT_REF_URI"
>>
>>  /*
>>   * Environment variable used to propagate the --no-advice global option to the
>> diff --git a/refs.c b/refs.c
>> index 23f46867f2..a7af228799 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2186,15 +2186,73 @@ static struct ref_store *get_ref_store_for_dir(struct repository *r,
>>  	return maybe_debug_wrap_ref_store(dir, ref_store);
>>  }
>>
>> +static struct ref_store *get_ref_store_from_uri(struct repository *repo,
>> +						const char *uri)
>> +{
>> +	struct string_list ref_backend_info = STRING_LIST_INIT_DUP;
>> +	enum ref_storage_format format;
>> +	struct ref_store *store = NULL;
>> +	char *format_string;
>> +	char *dir;
>> +
>> +	if (!uri || !uri[0]) {
>> +		error("reference backend uri is empty");
>> +		goto cleanup;
>> +	}
>
> Equating !uri and !uri[0] and giving the same message would not help
> diagnosing an error, and not _("localizing") the message is of dubious
> value (after all, the message is not being given to somebody coming
> over the network, but meant to be given to the local user, right?).
>

I think that's fair. I also missed localizing all the errors, I think
someone did point that out too.

> If we remove the !uri[0] from the check, shouldn't the later check
> catch it as "invalid format" anyway, and print '%s' it to show that
> what was given was empty clearly enough?
>

Yeah, it should I'll remove the latter and modify the test.

>> +	if (string_list_split(&ref_backend_info, uri, ":", 2) != 2) {
>> +		error("invalid reference backend uri format '%s'", uri);
>> +		goto cleanup;
>> +	}
>> +
>> +	format_string = ref_backend_info.items[0].string;
>> +	if (!starts_with(ref_backend_info.items[1].string, "//")) {
>> +		error("invalid reference backend uri format '%s'", uri);
>> +		goto cleanup;
>> +	}
>> +	dir = ref_backend_info.items[1].string + 2;
>
> Two questions.  (1) do we still want the double-slash after the
> colon?  (2) if so, would it make it simpler to string-list-split
> using "://" as the separator?
>

(1) Yes.
(2) My understanding of `string_list_split()` was that the `delim`
argument are a set of characters to split the string on.

So:
    string_list_split(l, "abc:def/ghi/jkl", "://", -1) -> ["abc",
"def", "ghi", "jkl"]
    string_list_split(l, "reftable://foo", "://", -1) -> ["reftable",
"", "", "foo", "bar"]

But this isn't what we want.

>> +	format_string = ref_backend_info.items[0].string;
>> +	dir = ref_backend_info.items[1].string + 2;
>
> These two lines are fishy.  Perhaps leftover from an earlier draft
> that did not have an error checking before the previous 5 lines were
> added?
>

Yes, will cleanup.

>> +	if (!dir || !dir[0]) {
>> +		error("invalid path in uri '%s'", uri);
>> +		goto cleanup;
>> +	}
>
> At this point it is very unlikely for "dir" to be NULL, no?  Even if
> the .string member after splitting were NULL, adding 2 to it would
> not leave it NULL.
>
> Being defensive and checking for NULL is good, but then exactly the
> same question on "NULL vs an empty string" applies here.
>

Yea, the '!dir[0]' should definitely be enough here.

>>  struct ref_store *get_main_ref_store(struct repository *r)
>>  {
>> +	char *ref_uri;
>> +
>>  	if (r->refs_private)
>>  		return r->refs_private;
>>
>>  	if (!r->gitdir)
>>  		BUG("attempting to get main_ref_store outside of repository");
>>
>> -	r->refs_private = get_ref_store_for_dir(r, r->gitdir, r->ref_storage_format);
>> +	ref_uri = getenv(GIT_REF_URI_ENVIRONMENT);
>> +	if (ref_uri) {
>> +		r->refs_private = get_ref_store_from_uri(r, ref_uri);
>> +		if (!r->refs_private)
>> +			die("failed to initialize ref store from URI: %s", ref_uri);
>> +
>> +	} else {
>> +		r->refs_private = get_ref_store_for_dir(r, r->gitdir,
>> +							r->ref_storage_format);
>> +	}
>>  	return r->refs_private;
>>  }
>
> If this mechanism is for consumption by "git refs migrate", is it
> possible to reduce the blast radius by giving the command a command
> line option to do an equivalent of this?  I really am not happy with
> this environment variable that can change the behaviour of such a
> low level layer from unsuspecting programs that are not ready.
>

But the mechanism isn't for 'git refs migrate', but rather we want to
add/update references via 'git update-ref' into the dry-run folder
created by the 'git refs migrate'. In the broader sense, we want to
manipulate references within this dry-run folder as if it is the
reference folder for the underlying repository.

I get the comprehension behind the environment variable and am happy to
work on something alternative if we can achieve something similar. The
reason to pick the ENV variable was mostly because this isn't a regular
user flag which we expect users to use. Also, this is very similar to
the already existing GIT_OBJECT_DIRECTORY.

> Instead of tweaking the behaviour of this function via environment
> that can affect any programs, can't we give these callers like "git
> refs migrate" with specific needs set_main_ref_store() function that
> takes a ref_store and a repository.  Then they can use to call into
> get_ref_store_for_dir() to obtain a ref they need.  "git refs migrate"
> already takes "--ref-format" variable, so all it needs is another
> "--ref-directory" command line option, right?
>

Something like this would require us to add these flags to all commands,
currently I can think of 'git update-ref' and 'git refs' but it could
spread to all reference oriented commands.

> If the ability to set the ref backend location for arbitrary program
> proves to be useful, we _could_ give the same --ref-format and
> --ref-direcctory command line options to "git" itself (like "git -C
> there" runs any subcommand in the named directory), which does the
> the get_ref_store_for_dir() plus set_main_ref_store() dance,
> modelled after how "git refs migrate" does them.
>
> Hmm?

This could work indeed, I would instead swap it out for a single
"--ref-uri=<backend>://<uri>" which would make it much simpler for users
and future implementations which might not have a 'directory' like the
current backends do.

Overall the ENV variable seemed the best based on the constraints and
the existing similar variables. Wdyt?

--000000000000278949064494ab5e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 26757d110929520_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rb1pjUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWU5REFDZHd3MWRDbllFV21qb29yRDFTVGg0RWo5UApmY0VqY2JoNlQ5
bFpnRU9May80WGRyQm5uVVA1ZHcyemdxSDBZMDI0VFJISlZYNnZsQzVPalVIczIzYVhSK1VSClRs
QjY0cFlYSmZtc213T1FBYkNybnc3NGJ2WlpSbUpIZ1NIN1Z6c2R0a3REd3MxTVZCdzBwTUx1ZVpu
MmszOUUKU2NsTnhWOTVNM2FtUzhOa3BROFU5NkJ2MUpiMGNZM1Y4NklCUzBQdDEvNm14T2xwdXQy
OE5VblhLVlBBOW5LLwpVTmZibXJDdm5Gb3BUcE8rbWVmSmk3V2F2Rm9RVGxvS1ZTdGMrd25lRUhN
WEdxVW9nb3MzVVBXQkhJdEV1WVJ2ClpxdXNudmx5d2Q5VmJqWkhkYThGSVIzaDJBbTNrL1ZIaEZV
Y0NDRWdmYkoxaWx2eWpiMmFMUlZJZmdHVnhlV0oKcDlUbmh3Rll6aE9aejh4SzFpUUpXSVRIU244
MjliQUEyRXNrY3dOVWRWc1RWWUI4RjBHekQ1N1hCNGE0L2hsagpNZXJhZTczN0tTVWNWbldMaFpM
ZmpZNEpDSkk2UGM2MWJBTlpldlFGc3pRNFIrdUpDY1VvZUxLV1RRN2F6TzlGCnZwMWRheGluaFVm
dEE2Y1RJRFVwckhPbExadkZ1TzZVVXZBV1VDcz0KPVJ0RHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000278949064494ab5e--
