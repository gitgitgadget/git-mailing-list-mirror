Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE6338C
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713696350; cv=none; b=Z8mLL9UZRX0mBYSqrcvXVHqAUz+R++lPEJi9thpZUlLKY8RWaaH2AhOO+C2iO2WBd0+dHBgzNWp1KkRXXQsFqv6ZBWcmgidHvfIRDWCq0uI+ZFNmlzALShjlg1z9x5e3FMOKTfluGYR1jGuNw++pehJ/XpmvvZn5NT1KNdwG3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713696350; c=relaxed/simple;
	bh=0y/lF31PRr1PH+HGF4KlPq3VjvUfgRdx0joZAsyYF9o=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UozeiwP6H/BpwE2Xx0E7bHX5H3Qf/CEW1iMuFWJ1gwYQa890l36akxkQQrKR/69m1wrgAV+oeTh4fMljXAUUKJfRXGwGN8rn26H1lHtqTpDPNSSp9oJfglXCZd3Nf3vRZrWV1ia+P+PnGFdKZ/WPNfdr/BtZtkjW56/cWhDQ7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC4+lIue; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC4+lIue"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23333ef4a02so2127877fac.1
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713696348; x=1714301148; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oCSeWHk/10ufXxMI7jBIT1FbtdUZacDV32vg6XmOy5s=;
        b=iC4+lIueDEQZbvCVV9sZhOabDsIE933QV/I+eZtvWtFfyNDkOwi0D1U6T+axglbM9I
         Ap/dEW1BVidpwhqX5Yu5mpSzK6feqXqsl+7Y3KuUVChvdpca+5OCe2o0yiHQtStldLq6
         Pm2YX+rRwRjL303rfr+nC2ggOhSMXlYHXcgzyrfBFeWH/64KxyEUus/jexfWVePd42Ia
         ayJs9XC84W8ZEtDUrL3IiNtgRWOnU4RheDJGsNdKthEXGLD5Cb1t1qzUZiRodZ6dyBpQ
         E5zPnZwuxKBXsSB7FLR7c+kUB5kFJMt3ggUc5VdqzM4YFZ/IxC244WEwrCOnO+9TAQm5
         acqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713696348; x=1714301148;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCSeWHk/10ufXxMI7jBIT1FbtdUZacDV32vg6XmOy5s=;
        b=wc5KUou6eMoK/jce8vMweJvwuiRYAxYop6VYWZM6VaQfFjABxIv/qiBpaMmmSuI2Jq
         73BnsR3bzCH2ghmUPYb4xXUaLgS7Of92+UQrVlYJEXCk+6STWE77owZl7FluILLK8gqa
         qpXfwdFVFOnt/sBSuLdlcuiOgqsvVOOh07EWTeA+gea4p93ANAM1ARqDZ3IyP+QAbIe8
         bLMxP99TsBoyDqjWJry1DFYCRW5PDph+QbABKF+SziL1OUhg+76kN+bV9KOltNNGbvjp
         MNrdbDALpbMjZB50mxlBpBX/QcOJ+miAHXSWzqgIyU5UMVWFBxNf5upBl3HSwH8DqLup
         zHtg==
X-Forwarded-Encrypted: i=1; AJvYcCW4T0Dq82oc5fDhP6AtXM1l47XvgbttxbKXIBbyZwPDxopbL6nbANLSFZMiRZQTuroZWLaNFfd020ImXfr7zcojm8pC
X-Gm-Message-State: AOJu0Yy9je/94jAPLivGHYVzpCA99lBE5WdAWTE9YFzwYQDoDTzqUSVt
	A7ldqxGKPnZo+4THLnp2/10xltnHsCgG0ytf5BERDHSUIiff3SUKKQ2a44YPyiaU/AjHbgA0vLH
	5AIGU9zV8/S6VSkm5vYdf8D+kcGI=
X-Google-Smtp-Source: AGHT+IHqW1zu1QwwV+iH0KS3NQZPT+Y5gYZrSzXv0jW9VHX1LNt/9sPGKt9BaVrvYlVLK+YI42XbdfO99voI7LHNHTE=
X-Received: by 2002:a05:6870:858b:b0:235:458e:c8d0 with SMTP id
 f11-20020a056870858b00b00235458ec8d0mr9309481oal.45.1713696347897; Sun, 21
 Apr 2024 03:45:47 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Apr 2024 06:45:46 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZiI8E2ZJT51akoAk@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-4-knayak@gitlab.com> <ZiI8E2ZJT51akoAk@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Apr 2024 06:45:46 -0400
Message-ID: <CAOLa=ZS7+sqpf2TajahUM95DMVfYyxUOL3BBhT=-EhfnGBi0+w@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] update-ref: add support for symref-delete
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000011e02e0616990629"

--00000000000011e02e0616990629
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 12, 2024 at 11:59:04AM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
> [snip]
>> @@ -302,6 +302,37 @@ static void parse_cmd_delete(struct ref_transaction *transaction,
>>  	strbuf_release(&err);
>>  }
>>
>> +static void parse_cmd_symref_delete(struct ref_transaction *transaction,
>> +				    const char *next, const char *end)
>> +{
>> +	struct strbuf err = STRBUF_INIT;
>> +	char *refname, *old_ref;
>> +
>> +	if (!(update_flags & REF_NO_DEREF))
>> +                die("symref-delete: cannot operate with deref mode");
>
> Again, I'm a bit on the fence regarding this restriction. I feel like it
> ought to be possible to delete both plain and symbolic refs in a single
> git-update-ref(1) command.
>

Yup this is still possible since we have the 'no-deref' option.

>> +	refname = parse_refname(&next);
>> +	if (!refname)
>> +		die("symref-delete: missing <ref>");
>> +
>> +        old_ref = parse_next_refname(&next);
>
> This line is indented with spaces and not tabs.
>

There was a bunch of this, I'll have them all fixed.

> [snip]
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -1715,6 +1715,45 @@ test_expect_success "stdin ${type} symref-verify fails for mistaken null value"
>>  	test_cmp expect actual
>>  '
>>
>> +test_expect_success "stdin ${type} symref-delete fails without --no-deref" '
>> +	git symbolic-ref refs/heads/symref $a &&
>> +	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" &&
>> +	test_must_fail git update-ref --stdin ${type} <stdin 2>err &&
>> +	grep "fatal: symref-delete: cannot operate with deref mode" err
>> +'
>> +
>> +test_expect_success "stdin ${type} fails symref-delete with no ref" '
>> +	create_stdin_buf ${type} "symref-delete " &&
>> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
>> +	grep "fatal: symref-delete: missing <ref>" err
>> +'
>> +
>> +test_expect_success "stdin ${type} fails symref-delete with too many arguments" '
>> +	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$a" "$a" &&
>> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
>> +	if test "$type" = "-z"
>> +	then
>> +		grep "fatal: unknown command: $a" err
>> +	else
>> +		grep "fatal: symref-delete refs/heads/symref: extra input:  $a" err
>> +	fi
>> +'
>> +
>> +test_expect_success "stdin ${type} symref-delete ref fails with wrong old value" '
>> +	create_stdin_buf ${type} "symref-delete refs/heads/symref" "$m" &&
>> +	test_must_fail git update-ref --stdin ${type} --no-deref <stdin 2>err &&
>> +	grep "fatal: cannot lock ref '"'"'refs/heads/symref'"'"'" err &&
>
> You can use "${SQ}" to insert single quotes.
>
> Patrick
>

Neat, this is much better, thanks!

--00000000000011e02e0616990629
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1dab280a69e2f093_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1Zazdsa1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlByQy85UXMwM2VEaktVNnV4empDVUoxR0Zmdm1NeApiWHc2dGV6NnM5
UmNmcGxLaEdwRkl0RGF4TkxEQ2VPVTNCTzVFWUZSUElteHYvRXBXRElHbWFmOVZHejdaTTlPCktB
WTBHUWZHaXdUUVlsY3VheXVGNlNaM3pyUStwU3dINVZGSmlYaUF6YXBmVmIrcERaTVNqZjZGR3I5
WUYzRUcKbjRwNlNTL3h6Zkhzc01JL05RNm5oKytBdGl2VVZ0YXpvb0R6TytZWWJwV1YvK2RnK2VQ
MXA0Ym1nMlJDMytlMApGSTYrR2FVWmRXTlNEa1VxNXhsUS9wc0JQM3ZRRzIxclhCUHZ3SmNjZXdP
bjNrU0tLZmUyWENzQVVsWlVBMUU1ClBwWm5nbnNWdWJDdG9tQlliSFdMb3NNL04xNHBYL21DVFIy
aGMvdGpiRksvN3VnbW8zNHNJckF2ZUlLZlNDQWUKdVJ0ZXdmYnJuRGJac1ZnQVhCSHVDY21oQTBx
U3lJaXZmbEFEdmgxVFBOU1NZTlVjUVdjcTBwNmNKMGJlOHZucgpsb2Z1Z3NYZXVOOWE2WHI3L0Rp
VnowTElkQ25PdHlmUUdOM2RyV1VlcGZZa0pGamR2citpaFdPK3pQbHBEVDczClN3RDJLVXdBcXBO
cVpwQVNYczc5NFhiSFN5R05xQ1d5NmxXa0NDND0KPVp3eEkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000011e02e0616990629--
