Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189352E338E
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742846423; cv=none; b=XaMDNfnLrZ6PkBpzuuRxeSKbT9xqlLV6gv0GYsQ0nGPngwsEF5JY6nXlnGzVM2TQBl4xCFDeOPwxBumh6MY9cludCIPw9sdbMa9ETmCb1dCTeR5AGhZli/8uHDow7dCav2zUBN7z173/Rxri63hmF7ZeSzv5xzSByd0N6PzCiI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742846423; c=relaxed/simple;
	bh=H00FYXzqr1bo0NF9w25/DN7cSALRDJO4r0iZuPNOkpI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzc8FOj9I1AhLnLXXixyaRcmL34K1VHhIZzhHjQnUq5jRhNyfT0T/sdtRIGiDxyqRDjGCCsXCoigqLj6tfGIlUXR7GnsMsMYyvhCpKVGjlDVedOhHCEUkiIH20QZ6q/0bTlrIbjZPtmbxVwTpYXN0bwnEV2vHwDI94ayx9kwans=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At1Pf0sf; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At1Pf0sf"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d3ac0fec0so4365468241.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 13:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742846421; x=1743451221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qcv82wyRCOd1pKXka0RJjD+nHO+tfI3OTa7U3Kg601I=;
        b=At1Pf0sffceskc4dzsXnu9k3VDjHIvWsUlaE9hs3vIRJAZlwBmRCMueO+z8XMfd1JW
         lgl6m943n/efJFfOE3JvjWAO6SKIly9Svq7uR4vncumCbQvL59AC/I0GImonGo4bfefy
         NrRV48yk6hT66GWGZP6DROgMePV4M+kCQYpX22bJTgg92EOdQDnw2F5l4CCcjyEpvu9u
         pcleSN+6iGjlHoNgPQ4SbE6AQr8ew1pNuMkmt/p7z4ODp1b6U41Lis7oVjPQT7f6mlDE
         vX6MRKfi7kpo3gjmtqxQBU7QFBOwafBd3XNAeiKZHiH8NHXgw7ntzFYtsJWaseYRi/iO
         nR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742846421; x=1743451221;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcv82wyRCOd1pKXka0RJjD+nHO+tfI3OTa7U3Kg601I=;
        b=vpjdfLoDkrwjUMUjlRE18C+EiDbNLfnCwt+Z13zsfkTUOFc3FkAmsrvTyAfB94UE6Q
         SbhZ7vdhctCakHMCkJ0Su3rmdwJ6q2Jvw1GjSHmvhVdInCLwQOYJx0Hn1VTmi9+uKXNt
         aqyFTY1stQSwX4qqNa/087/e+6X6pMx2C3znKIZKe4h316kAXCa93hSPDL6dwDYkgrvM
         q3b42453l6+UMhZoucF/bcZ+xTfqfXDiWcxs7LmALLB18LiiF2baP57U5Znl4U4z/eED
         05qH82wGUpGBrAfpKLrNm+NNFWtC43kA1bP0CA7Rl/gaMuQty1LwulUm2FJ3zuDFt396
         ScCg==
X-Gm-Message-State: AOJu0Ywx8IwmV//QXq+RuKCthO+pi68mP8AmXxsiQ7QzRzW53Vy/xdk5
	eDAN1PZzGb1a1vT999StH4npCoZ0Y9/MA9A+ebjPWDBdLZNwj7z0hcKhFR8r4Cs8FiIXY+YxKy4
	jy9WcvvmA76U0LbEbNRolJmH3NLs=
X-Gm-Gg: ASbGncuFvwmHleM3RxT7igspFqc6jDZ4+gb8B10WKvjiX+ABJzpq4m02Hfhd1MJoers
	9CzjTlfmwnm2MFHSn3vUTqVcra59GK8xv7puDp+Q9aUuXcA4Kvk1K6N1UhS7Wey3Ko1HXGGyGkV
	8qUUmT5jxC20eULppATHDclCAyeuoVV+7pfIZGyp+Ohhm7q45ULOgLnafbeuA=
X-Google-Smtp-Source: AGHT+IH4JQsYtWdFra20P3YaccpzKPYa1wSR3nNfxOfd/a2zQUN+R07UM4MYvuaNS0a0kOFb3Z50GyjkIuy9t41LMhA=
X-Received: by 2002:a05:6102:3a13:b0:4c1:7c38:135 with SMTP id
 ada2fe7eead31-4c50d2779admr11914461137.0.1742846420574; Mon, 24 Mar 2025
 13:00:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 16:00:19 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z-Ew_12NWX_5qATN@pks.im>
References: <20250321-514-git-blame-1-s-porcelain-output-does-not-emit-unblamable-and-ignored-markers-v1-1-44b562d9beb8@gmail.com>
 <xmqqzfhbrb78.fsf@gitster.g> <Z-Ew_12NWX_5qATN@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 16:00:19 -0400
X-Gm-Features: AQ5f1JqNnxa114TyA9L-oOvsijyEorqlrTEn2S7gnIuz1VjfdThpuhqP7zholZ0
Message-ID: <CAOLa=ZS5vwVDFNTV3_bHcg7_AjimevPj8u_rFBhotu--y1ukGQ@mail.gmail.com>
Subject: Re: [PATCH] blame: fix unblamable and ignored lines in porcelain mode
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000cc08b706311c0def"

--000000000000cc08b706311c0def
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Mar 23, 2025 at 08:58:03AM -0700, Junio C Hamano wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> > However, this option was never extended to the porcelain mode of
>> > 'git-blame(1)'. Since the documentation does not indicate this
>> > exclusion, it is a bug.
>>
>> I agree it is a bug when people added ignore or unblamable support
>> that they did not _consider_ what to do with their new pieces of
>> information to help porcelain writers.  It is not a bug in the code
>> per-se, but it is a bug in the brain of these people ;-)
>>
>> But prefixing random garbage to the commit object name line in the
>> porcelain mode output does not sound like the right solution to the
>> bug, either.
>>
>> When enhancing an existing output format, make sure that your
>> changes will have minimum empact to existing parsers that do not
>> know about your extension.  It is reasonably expected that existing
>> Porcelain scripts reading from --porcelain mode output works by
>>
>>  - Recognizing a line that match "^[0-9a-f]{40} \d+ \d+ \d+$" and
>>    take it as the beginning of a new record;
>>
>>  - Collect all info lines before the payload line.  Lines that
>>    describe per-commit information are not repeated if it is already
>>    shown, so remember them when you see the commit for the first
>>    time, and recall them when you recognize the commit you already
>>    saw.
>>
>>  - A payload line is indented with HT and terminates the record.
>>
>> If you start to add unrecognizable garbage to the line with very
>> well known fixed format that is used as record delimiter, you would
>> break the existing parsers, which is not a very nice thing to do.
>> Are there other and better ways you can think of to add new pieces
>> of information like this in a way with less severe damage?
>
> I think the porcelain mode is already built so that it can be extended
> with arbitrary new information, no? In `emit_one_suspect_detail()` we
> end up printing one line per info we want to display. I would have
> expected that we can extend that function to also print information
> around unblamable or ignored commits, like we already do for boundary
> commits. E.g. something like the patch further down.
>

This indeed looks like a much better way of doing this. Let me

> Thanks!
>
> Patrick
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index c470654c7ec..cd8322e2619 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -255,7 +255,8 @@ static void write_filename_info(struct blame_origin *suspect)
>   * the first time each commit appears in the output (unless the
>   * user has specifically asked for us to repeat).
>   */
> -static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
> +static int emit_one_suspect_detail(struct blame_entry *ent,
> +				   struct blame_origin *suspect, int repeat)
>  {
>  	struct commit_info ci = COMMIT_INFO_INIT;
>
> @@ -275,6 +276,10 @@ static int emit_one_suspect_detail(struct blame_origin *suspect, int repeat)
>  	printf("summary %s\n", ci.summary.buf);
>  	if (suspect->commit->object.flags & UNINTERESTING)
>  		printf("boundary\n");
> +	if (mark_unblamable_lines && ent->unblamable)
> +		printf("unblamable\n");
> +	if (mark_ignored_lines && ent->ignored)
> +		printf("ignored\n");
>
>  	commit_info_destroy(&ci);
>
> @@ -295,7 +300,7 @@ static void found_guilty_entry(struct blame_entry *ent, void *data)
>  		printf("%s %d %d %d\n",
>  		       oid_to_hex(&suspect->commit->object.oid),
>  		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
> -		emit_one_suspect_detail(suspect, 0);
> +		emit_one_suspect_detail(ent, suspect, 0);
>  		write_filename_info(suspect);
>  		maybe_flush_or_die(stdout, "stdout");
>  	}
> @@ -344,9 +349,10 @@ static const char *format_time(timestamp_t time, const char *tz_str,
>  #define OUTPUT_COLOR_LINE           (1U<<10)
>  #define OUTPUT_SHOW_AGE_WITH_COLOR  (1U<<11)
>
> -static void emit_porcelain_details(struct blame_origin *suspect, int repeat)
> +static void emit_porcelain_details(struct blame_entry *ent,
> +				   struct blame_origin *suspect, int repeat)
>  {
> -	if (emit_one_suspect_detail(suspect, repeat) ||
> +	if (emit_one_suspect_detail(ent, suspect, repeat) ||
>  	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
>  		write_filename_info(suspect);
>  }
> @@ -366,7 +372,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
>  	       ent->s_lno + 1,
>  	       ent->lno + 1,
>  	       ent->num_lines);
> -	emit_porcelain_details(suspect, repeat);
> +	emit_porcelain_details(ent, suspect, repeat);
>
>  	cp = blame_nth_line(sb, ent->lno);
>  	for (cnt = 0; cnt < ent->num_lines; cnt++) {
> @@ -376,7 +382,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
>  			       ent->s_lno + 1 + cnt,
>  			       ent->lno + 1 + cnt);
>  			if (repeat)
> -				emit_porcelain_details(suspect, 1);
> +				emit_porcelain_details(ent, suspect, 1);
>  		}
>  		putchar('\t');
>  		do {

Thanks Patrick, I will send in the new version with this and modified
tests.

--000000000000cc08b706311c0def
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: a636ccf43871c110_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maHVkSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVhtQy8wY0Y0amZabUU0SVBZZFoxb2RRUTFRRVFOSApIZ3ZUUWxkQ3Q3
R0REVkhEMUJVcTA5WVNlT2UvUHpScHByL0ZkbXlWdStobUxnUDBCMWxZeTRPY2wxMjZUMzFJCmpk
dXJjV1RGaVJVSW1XTGMvT0pxUVJuc0Izd1k4RDlGcVByWUZra1NwclVSM21ueGVaUXFyait6VVlu
R3h5V1gKYThqTEIzaHVvallpVWhueU9IcUgvUW5NNi91d1F0SndRVzRzZHFlQ0p5UG40NGJ0T09N
MEJWczRYNUZ4aU12dApId284T2lRWXY4cFFBa0NqOHFBbytIem00UDZVZmFSankwcTc2am5ndUpC
V2Q4UkRBbUJmZ1pzaUlQcmZITEhFClovZ1ZUMmxlVTZqNTBINVdNbHUzcERCTW16SUpSRXU2aTQ4
OU1IaWJEMFUvREwxdDNzbVRqVUZtN3VBc3lHcTIKNmJVZXdOYSs1RUhyUVJmVEp6T1gzVENsOW0v
L3d5REp4OWFMK29ySWZIR002b0EzVDZhQVh1WmowcmE3NEpvUApYOG1BbGRrd2RJaUJSVllUTkdn
NmlQYkdSTko3L2lXN25OOCtvVmVTRHh6c29PVFpBL2pyYm9MUFk5Qi95NktoCm1vbzhJQUVtN1hN
aGk3ZGp0b3greWRpNEpIZXdLaGZYZDhWNWt0ND0KPVpTN2gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000cc08b706311c0def--
