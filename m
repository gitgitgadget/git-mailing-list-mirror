Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453F9230BF9
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389218; cv=none; b=LiLm1vwAf8tbXZRrUFcDy5VmpKOnAAACzjsbodikb9z1+fH5gthobElEjIxujHEn924HbN10WyEcrOuTO5CQ91cFd0Sc8V1kbJdinKgbprJKeO9d+UkEg87ffZtjSO6fTS2RrooHBjDicX9XHhFtib5hi9PpdRmdlNdJaRfGg5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389218; c=relaxed/simple;
	bh=4Lyiuj3KY7c5N6EP5w54KlVyT/6sqlbdCYauTNht0SM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzcqp6dKtL1QqfRy+BPZVkiBoM4pUCLilfZwdT5Eg+Gr/i+5kQOwVv01D8hWLBvwZ2IfK/b9cktdi+i10+lvURi1Ctp+RbqVqHXduROv+JwNLbila3SEdFHVIFEZTUK4K2A2U7QQtf1NYHIFvujGqk2SFg/GIjlA3A0KHq52K1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfpCcxkp; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfpCcxkp"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c55500cf80so158531185a.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 02:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747389215; x=1747994015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLVx31vtRJ4D4yyf8k4PBDipF+zm4DJLkQ9mvtAGdeA=;
        b=gfpCcxkpF781Vi2xC3n30aotbYVZ/Knaz2+QnQfHIXnV/31axTB7+MjYptTJSVIqZo
         EU99w8wzgUrWzwaqBjGvKcP/CCX8yJjRJsOsbUB3lWy43OpwKd8+K12EaqvS/RU37niW
         qTPQppWKQbikfc5vlJBBFEr7VvN+xdSIvXY1mqcrrkkmaEDvfbDbVXt/p1s5ONyHtSvT
         AZlyVpN38PnhoTtlsmdQmwowd/PG8CJ+AHNb6ovbSVgTo6cV8pJJ2uOefYcxPn0/Kv1m
         4CmeaTeZ73J3YTjWnR6q8LCxXNnfg6YhAXyVNih7hPl6HUkhNqnTj5y7j3cLIVzlLc8e
         X/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747389215; x=1747994015;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLVx31vtRJ4D4yyf8k4PBDipF+zm4DJLkQ9mvtAGdeA=;
        b=ivOuiziREOsYHtKw77uIN3dt9gZeQQkvL8clZVSsws+sGZfWAJg6J6wDTUwB74UXkm
         KGwArHdFY0O99CJsQ0DpIvEgG9BpD5UzDNY6hBEVZ/v4CRfdIs082bgZroGXoL1kEb1y
         BMx2Tzy4C8ux97koUbQJXFd9/lmj060fQDI/SN/V9SY2bWNkFUG9QHaDeialP3BPBMuw
         OH5Nz1RFemXAI7TDB93V9VTTb5Yr08E4hKGBpajmsYLJCJ5h/rSE73DuXARA36iCE/LU
         Vkkg8QRYxzEmogztApV3dwFB7iRYR3pfYuCIEnFhKLiygfAAfeK6z0v33FTPNHexN+GI
         BSag==
X-Gm-Message-State: AOJu0YzKeT4Zbn7SHtlPjUpFyBhi4B0oyFdG5f+XtEHwfh7rUxZHPfxO
	P1G/XsUp7tFSYQ2fAEceGl08tUcTeEknCUeexe4J3gWgD8CMJ7easm8ZvW0IviD6OZcoWhmj5yA
	A5BmliwrtK6+4F2FAA84Y6iGdLHVqiM+2cOlD
X-Gm-Gg: ASbGnctngHVnfVY+sqFsS3A3OYi/Mt9Fsnlnki5w9B5yc5R7hRirSI4+CizixeV0g+0
	Q4dAexpQJ2ky94Ol9mi0tJx4qz32LhtnI9QBjyyevJWiBoaHb2rVeAazaM8Ohjt0EZPvGIDVdkS
	qCs52GbGue65itEOJVBaW9G3If8kvig+bNrtK84VC2vX/nroAvuJ1vpsNiyHheyJAsQ2YTET8Il
	cgc4A==
X-Google-Smtp-Source: AGHT+IFTgdWg+s9dhSu5L4c3WxyD9mZ4/pbTOiD6zaW8n0t/m622tl1YZPutN8WuViGLTZ1FnNgb15v8y9k744yIN+A=
X-Received: by 2002:a05:6122:31a0:b0:52c:5590:72c9 with SMTP id
 71dfb90a1353d-52dba8909a4mr3720579e0c.5.1747389203970; Fri, 16 May 2025
 02:53:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 02:53:22 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 May 2025 02:53:22 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aCbP1SxncSVw2fCa@pks.im>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-2-80cbaaa55d2e@gmail.com>
 <aCbP1SxncSVw2fCa@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 May 2025 02:53:22 -0700
X-Gm-Features: AX0GCFuHgY1cdZ_u4cCFxmgbIlgEu3sarNBCLVQgKZzfxopFc1dExLiUuHYzW58
Message-ID: <CAOLa=ZR+3RPDHucjEVx8s64nrVGjzNTu9gX6Nw5vwQGg8PtpUw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fetch: use batched reference updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="000000000000c9a5f106353dc0d7"

--000000000000c9a5f106353dc0d7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, May 15, 2025 at 04:07:26PM +0200, Karthik Nayak wrote:
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 5279997c96..15eac2b1c2 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1688,6 +1644,37 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>>  	return result;
>>  }
>>
>> +struct ref_rejection_data {
>> +	int *retcode;
>> +	int conflict_msg_shown;
>> +	const char *remote_name;
>> +};
>> +
>> +static void ref_transaction_rejection_handler(const char *refname,
>> +					      const struct object_id *old_oid UNUSED,
>> +					      const struct object_id *new_oid UNUSED,
>> +					      const char *old_target UNUSED,
>> +					      const char *new_target UNUSED,
>> +					      enum ref_transaction_error err,
>> +					      void *cb_data)
>> +{
>> +	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;
>
> Nit: unnecessary cast.
>
>> +	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
>> +		error(_("some local refs could not be updated; try running\n"
>> +			" 'git remote prune %s' to remove any old, conflicting "
>> +			"branches"), data->remote_name);
>> +		data->conflict_msg_shown = 1;
>> +	} else {
>> +		char *reason = ref_transaction_error_msg(err);
>> +
>> +		error(_("fetching ref %s failed: %s"), refname, reason);
>> +		free(reason);
>> +	}
>> +
>> +	*data->retcode = 1;
>> +}
>
> Okay, we stopped ignoring generic errors now and will print them. What
> I'm still unclear about: which exact errors do we accept now that
> `REF_TRANSACTION_ALLOW_FAILURE` is specified? Most of the error codes we
> probably want to accept, but what about `REF_TRANSACTION_ERROR_GENERIC`?

The current mechanism in `ref_transaction_maybe_set_rejected()` doesn't
handle `REF_TRANSACTION_ERROR_GENERIC` errors. This was a design choice
(more of a requirement of what this error represents), where
`REF_TRANSACTION_ERROR_GENERIC` errors cannot be resolved on an
individual reference level. It includes:

  - System errors such as I/O errors
  - Duplicates present

Both of these represent issues which are bigger than a single ref
update, so we have to propagate these errors up.

>
> This makes me wonder a bit about the current layout of how we handle
> these errors. If the rejection handler was invoked while preparing the
> transaction for each reference as we go instead of afterwards we could
> decide on-the-fly whether a specific error should be ignored or not.
> That might lead to a design that is both more flexible and more obvious
> at the same time because error handling is now handled explicitly by the
> callsite that wants to ignore some errors.
>

I did ponder on this while I was building the batched transaction
mechanism. I decided to take it iteratively. We can, for instance,
modify `ref_transaction_maybe_set_rejected()` to work with a callback
function which would allow the users to accept/reject errors.

However, even if we go down that route, `REF_TRANSACTION_ERROR_GENERIC`
errors still cannot be overlooked, these errors will abort the entire
transaction.

That said, I'm not trying to avoid going down that route. I do agree
with the flexibility it does provide. Once we hit such a usecase, we
should make that change.

For 'git-fetch(1)' and 'git-recieve-pack(1)', do you see a usecase?

> Last but not least, I think that it would also allow us to decide ahead
> of time whether we want to commit. Right now we basically say "just
> commit it, whatever happens". But if I'm not mistaken, all the errors
> that we care about and that callers may want to ignore are already
> detected at prepare time. So if we already bubbled up relevant info
> while calling `ref_transaction_prepare()` the caller may then decide to
> not commit at all based on some criteria.
>

Indeed, that is correct. I can confirm that even now all the calls to
`ref_transaction_maybe_set_rejected()` are made in the prepare phase, so
we could already do this, since `transaction->rejections` is already
populated at this stage.

> Sorry, I should've probably proposed this when you introducued this
> mechanism. But sometimes you only see things like that as we gain more
> users.
>

You don't have to apologize. Such discussions are very important and you
shouldn't hesitate to bring up such points.

>> @@ -1808,6 +1795,24 @@ static int do_fetch(struct transport *transport,
>>  			retcode = 1;
>>  	}
>>
>> +	/*
>> +	 * If not atomic, we can still use batched updates, which would be much
>> +	 * more performant. We don't initiate the transaction before pruning,
>> +	 * since pruning must be an independent step, to avoid F/D conflicts.
>> +	 *
>> +	 * TODO: if reference transactions gain logical conflict resolution, we
>> +	 * can delete and create refs (with F/D conflicts) in the same transaction
>> +	 * and this can be moved about the 'prune_refs()' block.
>
> s/about/above/?
>

Indeed!

> Patrick

--000000000000c9a5f106353dc0d7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 88c6a161437359e6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1nbkN4RVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmlXQy85bGFFS3VCMUYyR3Yrc2lpSU5UOFhtUGN3dQpMZWdpcEJxeVlI
ZzZmZU43S1dwTyt6SC8zUDBiUHZmV3FqVDlZUmhHU3llSUorK0J4VFJRZGhZNU13Uk1DWlhhClVC
VE05NGQyTTg5bHZFUjdIbzR4aHdRb29ZZC9GUTJrUkQwMlVqQ3IvSGlmZURXcnREYXpQMmNSSWRz
d09PSHAKL21ZN3NXemt4cjJ5OEZQMDhSbnVRcGpZcEdBVWNBMDBHdVNyaTRQYTFTM2UxOUpVdWp2
Q3gvVlQzYVJVS1M2WQpSZlYvSnRsbWl2WDJGOVZkeXV4WitqZzNibFhYaGZTd0F1b1FsYmZDWWZs
Tnc5dHl6QjZuQzFrMEZsaTEvYzNiCnc3bk9taFR5YkFYSmIzaVR0cUI2N1FDK0NLbXhzNHFNcmc2
UFREeUV1M0MyNEJpb0Z1YnJhSUlzaUVVTU9WYisKcmVqS1FJcTkwc3Fxb0MzK3QxQi9JRm9nNkZV
N3dqMUN1SmNva1VhQkFxKzNtQStQUzRZYk9JYnZNOFJ6NyswUwpQRHZ2WC8yWktkK3Z3UmNCYVh4
SlpERFVrQytYbHRxY0tKc1dmRlRqdEo0UEpNeU5tZVVPcDhLbVhvK3BuWmtNCklxbXBrTFQ3MGZm
RXQrbW5KTjFyOUs2ZmlNb1lmQzJTKzFEcmI3MD0KPWNmZ2QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c9a5f106353dc0d7--
