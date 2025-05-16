Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E03C230274
	for <git@vger.kernel.org>; Fri, 16 May 2025 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424979; cv=none; b=EMx1lH0PdKWq50aeN+vyFf+X4QzhB0lzRnPeN6xxvuwunHZ5jSq+0YtbzLf87ik8/9h9gJUFe5zpp7Dp2MThpyk9W7IwdMYtcSh/LP+2OiWE0WB5xTcjUmeiKPotZdd0n+8o9fl8odCl8s3zq4sKnEvo/cweIceUneXhqp6JMi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424979; c=relaxed/simple;
	bh=JiE8V6zEOtT57omYg1+G27ivAHkOvtbyunDaoiX+tWY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwjrFfUltnc8cGIS6xXaWXAHZjCBqzmai/axiY9s+67fLg18ajCjoNZeAXVyBvKVxEg0De0W2Su9bmt1kqdCUzVUb0pDwkKk2rmTMSzr+B0QZfY09lKKe3LzqIaG2WSQ0xxC2xy42Ds3e/z/FZ4+b1YMT07BS+YOupPP2HSaRVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWeDp01r; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWeDp01r"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86715793b1fso728753241.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747424976; x=1748029776; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AP7ubWv+pyy9vwEKuLo+RSxRXITps9Toa81Ki1AKBPo=;
        b=nWeDp01rrGh3BEaZwrsSelHvH2iC2xbSAJvRb7CAgBJ/s2/3Lv07ZluKEGl89HFHC5
         WppwcJp6H+vVQISQtxlcxSptI8nEgDVhNysfmWhQwvbHQvfS++ArnlRhQtJOwtNg/+wM
         gatCuBPNu0t3B8pyB6Re7ylepTsch0ydetmPUZOJXu9Ti+77NB8CeF11szENGZIq2q3e
         oGKRLj2QJF94+Qsh3xpXu5g8BrnB02oknz9pj7Ykb/PQrtmjDytKoEhyodXTqvyE6w9E
         d2uSkfQtXxb7/4y9eTRP12HiAs3ok0mB2Ubyzw5i2iae0WHuIIteDKIBN+aeoQxdKJL0
         Q4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424976; x=1748029776;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AP7ubWv+pyy9vwEKuLo+RSxRXITps9Toa81Ki1AKBPo=;
        b=fRPgH9JdE8HoSHs81h8JKfN/mF2vzU2G+AR1hAQkLLs8+0NaEyHcNy3QK5M1Jo7US3
         PoB0duHR3gdQhSEnuCerDlX//rCuIErzvAawe0nc6sveHSqk4Fo3Vpg5upBN0Y4zOb2l
         oNGXP3uEYlRUXxll1TrGTn/dA4fRyjCINi41ok4KLcPyp8sSNhF48keB8hfkq29hN5Ai
         2ZUey61w/CpQM/uA3bLXz6eBnfc0v1icUya/Evn8pTjS2qCJqyv70wlpU9+MxR5AwG0e
         sIqz86A4z0jn5Afc2ejVvGmZDXBHESUIwKRp1fDMUA3gB/6bSL2TR8/vCkQIzMQ+Fa3u
         QAvA==
X-Gm-Message-State: AOJu0YzIvdIWSYq+X1ZwOEX8HlbpoK30wRPSAOsl8ov31e1NggawHi5T
	Rlb+c9tnLxh/32OL1lczQFKC25YsQAHuSK7QUlQRENjTm/TAQSES/ubk0GACFVRM4US5a3dHzGJ
	ohd6gEuXRiZKWNJ/D3O8WlBmr3o5Hygw=
X-Gm-Gg: ASbGncsSnUWeOaXfqklhSJAdeg0tCUvuBOC03adKdhqNP4luD79q3nrpuJtO8/ab/KX
	rZxbLhYmyc3Fj1/FnvD/zne1mPqdBFtBTO1NXdkzSo9XXdhgmykif9GtUeL4ncGgbLhhvKm/Ry1
	8eWlZdGzQfBzDAC+4teD1JXLaDmH8mHJoL9pqcjzjxRVvrkwQdU51Mwz87r33X0GwvGHQ=
X-Google-Smtp-Source: AGHT+IEn2d9jrpdZUabYyHn/sdFPFBFtyYmhtie1LirNLXh+bJiRR4VkjI0Rk7Jx3B7K6fUjOBrAqJRRjyhn8UNcqDY=
X-Received: by 2002:a05:6102:570d:b0:4ba:971a:41fd with SMTP id
 ada2fe7eead31-4e053657fc2mr4457173137.19.1747424976023; Fri, 16 May 2025
 12:49:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 12:49:35 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 12:49:35 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250515190909.GA3320028@coredump.intra.peff.net>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-4-80cbaaa55d2e@gmail.com>
 <20250515185535.GA3309052@coredump.intra.peff.net> <20250515190909.GA3320028@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 May 2025 12:49:35 -0700
X-Gm-Features: AX0GCFsuxD6QsHj8Kqa6YkI7d6Sz1YpIFvl9muhxZ3j9-IH6RRDcoExJrCLLrSk
Message-ID: <CAOLa=ZSwzWm=43daWfu7aAb7q9gnseT=bifh0DUS3Cr02taCRQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] receive-pack: use batched reference updates
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000f7d0110635461473"

--000000000000f7d0110635461473
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Thu, May 15, 2025 at 02:55:36PM -0400, Jeff King wrote:
>
>> On Thu, May 15, 2025 at 04:07:28PM +0200, Karthik Nayak wrote:
>>
>> > +failure:
>> > +	for (cmd = commands; cmd; cmd = cmd->next) {
>> > +		if (reported_error)
>> > +			cmd->error_string = reported_error;
>> > +		else if (strmap_contains(&failed_refs, cmd->ref_name))
>> > +			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
>> >  	}
>
> BTW, one other funny thing about this code: we duplicate the strings
> that we assign to cmd->error_string. But no other call path does so. So
> now we have allocated memory, but nobody can ever free() it because
> often it is not allocated!
>
> I'm surprised LSan does not report a leak here, so I might be missing
> something.
>

Yeah, indeed that is a leak and surprising that this wasn't caught by
LSan.

> It looks like there is some magic in the struct here to handle this
> like:
>
>   cmd->error_string = cmd->error_string_owned = xstrdup(...);
>
> which would solve it. But I wonder: do these need to be allocated at
> all? We are pulling out strings owned by the strmap, which will free
> them. So as-is, yes, we need to make our own copies.
>
> But does the strmap need to own them in the first place? It is taking
> the values from ref_transaction_error_msg(). That returns an allocated
> string, but it doesn't need to. It could just return the string literals
> directly, which are valid for the life of the program. That would save
> other callers from having to call free(), though it does mean we have to
> cast away the constness when putting them into the strmap (since it
> accepts a non-const void pointer). Something like:
>

Thanks Jeff, this does make a lot of sense, I think with Junio's
suggestion in the first patch, making `ref_transaction_error_msg()`
return a 'const char *' solves this issue too, we no longer will hold
allocated strings here and as such no longer have to worry about
allocation/freeing of memory. Much cleaner.

In the end it looks similar to you patch below!

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 4a3c46eca7..cf0bcf1ad0 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1665,10 +1665,9 @@ static void ref_transaction_rejection_handler(const char *refname,
>  			"branches"), data->remote_name);
>  		data->conflict_msg_shown = 1;
>  	} else {
> -		char *reason = ref_transaction_error_msg(err);
> +		const char *reason = ref_transaction_error_msg(err);
>
>  		error(_("fetching ref %s failed: %s"), refname, reason);
> -		free(reason);
>  	}
>
>  	*data->retcode = 1;
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index bd0fb729ff..4cef2ddd3d 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1855,7 +1855,7 @@ static void ref_transaction_rejection_handler(const char *refname,
>  {
>  	struct strmap *failed_refs = cb_data;
>
> -	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
> +	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
>  }
>
>  static void execute_commands_non_atomic(struct command *commands,
> @@ -1897,15 +1897,16 @@ static void execute_commands_non_atomic(struct command *commands,
>
>  failure:
>  	for (cmd = commands; cmd; cmd = cmd->next) {
> +		const char *reason;
>  		if (reported_error)
>  			cmd->error_string = reported_error;
> -		else if (strmap_contains(&failed_refs, cmd->ref_name))
> -			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
> +		else if ((reason = strmap_get(&failed_refs, cmd->ref_name)))
> +			cmd->error_string = reason;
>  	}
>
>  cleanup:
>  	ref_transaction_free(transaction);
> -	strmap_clear(&failed_refs, 1);
> +	strmap_clear(&failed_refs, 0);
>  	strbuf_release(&err);
>  }
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 09b99143bf..1e6131e04a 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -575,15 +575,14 @@ static void print_rejected_refs(const char *refname,
>  				void *cb_data UNUSED)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	char *reason = ref_transaction_error_msg(err);
> +	const char *reason = ref_transaction_error_msg(err);
>
>  	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
>  		    new_oid ? oid_to_hex(new_oid) : new_target,
>  		    old_oid ? oid_to_hex(old_oid) : old_target,
>  		    reason);
>
>  	fwrite(sb.buf, sb.len, 1, stdout);
> -	free(reason);
>  	strbuf_release(&sb);
>  }
>
> diff --git a/refs.c b/refs.c
> index 351ed52deb..953f83bb52 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3315,7 +3315,7 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
>  		(!is_null_oid(&update->old_oid) || update->old_target);
>  }
>
> -char *ref_transaction_error_msg(enum ref_transaction_error err)
> +const char *ref_transaction_error_msg(enum ref_transaction_error err)
>  {
>  	const char *reason = "";
>
> @@ -3342,5 +3342,5 @@ char *ref_transaction_error_msg(enum ref_transaction_error err)
>  		reason = "unkown failure";
>  	}
>
> -	return xstrdup(reason);
> +	return reason;
>  }
> diff --git a/refs.h b/refs.h
> index a0b2e3c43d..2d58af3d88 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -910,7 +910,7 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
>  /*
>   * Translate errors to human readable error messages.
>   */
> -char *ref_transaction_error_msg(enum ref_transaction_error err);
> +const char *ref_transaction_error_msg(enum ref_transaction_error err);
>
>  /*
>   * Free `*transaction` and all associated data.
>
> -Peff

--000000000000f7d0110635461473
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b0d00a062a1d6e69_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbmxzMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUtSQy80NmdsUXpFQzFIb2hld3I5bEJjQmZBNVVyKwpLWi9heXp2UlJv
cjF0MU8vSkozNGpEc2hHRHR5RVFWOXc3eTBxdHFyVXJxKzRVK3dSb0ZwWHZJTHA4bW9rMVlLCkJE
WHhpQm1PVjBhZnpDKzJIN1RaNXFOQ3ZzTXNJVTNEbDVBOXh1Q3Jsa0VBdEgyUWlDajVTajdSdFp5
SHBwSDIKRUJuV3p0MnkzL0E2MDliSWd5V202QUtuS3pHUFNHOWFGTC82SXM1YVVESVI2TXFFRmEw
bDE4VkdLQnJ0ZFJFaAppaEtIVmo1aXFCRVVSblk5NjZPOERnS0FsQ0dGY0ZyY3FDUk5zMlpqOFdE
UFppYk1Gcnc2dXZpNnpETDJBZ0VqCjljSzVSc1VlTlFLSkdGRmdleWQ1dW9BMmJONUdtdWZ5U0tq
QVl1UzlJd1REWEhYdXY1K1FiY2RwamJRbjZyOW4KcEd0NXNKa3EyMklqT0VBU0VMcG9jdmJxSEJo
S1A3aEQzdmh3bDE0N2NJOTVLMlljMHhTbzFHWWlxZ215Z3djZwpGaEZYdTI4dlF0VERyUGIyUTU5
VmxwMURrM3hoRVpRUkxwK09TbVo4em1SMEoxMHJJVWFnRHNBT3g4Um52MmFKCjNwejdZbHJZV3Q1
QThWa25XaUlmLzMrTlY2dUVCT3VwK2lNSFVUTT0KPXNsNjMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f7d0110635461473--
