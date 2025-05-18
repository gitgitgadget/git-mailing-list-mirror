Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947841FFC46
	for <git@vger.kernel.org>; Sun, 18 May 2025 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747567828; cv=none; b=XM+3lN3hl0TczQPnr9lMHJjGD0X4Jrq6v/mo8DioL9IQ71IRwck1t7t0pArFQJ4HkEfHwmzUzEazOPf9pMGcrFGOAL3e7W4RCLOJP+PMi4eMOiBqp1SjNVZ/9n0IxJ2wfRxyhH04fmakhhA2eB745gyqvS28hzeBqMh+c3VX9rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747567828; c=relaxed/simple;
	bh=5HhgPfuLygUE/2BZUPtr/boTbWwBdZUNZTqQNm7G5R4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UqwrDxBvvFlkKMHlF1qzBUcywNH9o/bWeTvJ8NaXQFwAOKtaJfYOPH2PFnsI2GdtNC6+mFvU1gHIptCQ5R6zIog7egGANvydNP/qWZXDSwhHgAHQ+gn4mia3lJW4Kq+9FpZePCwKMgxKIfPaaHngXKCtYWnHqu7DnIkHaZJSC50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHQUoOyy; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHQUoOyy"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-87bfd1499f0so252475241.0
        for <git@vger.kernel.org>; Sun, 18 May 2025 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747567825; x=1748172625; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fThJ/HWjs/+vpbIpIwF4SXoB2R3Qg/7e4eqqn36WoRE=;
        b=kHQUoOyy7vQMJuruAZcqp2AvzaCG4/wI1P+YGKVX+k+gzZ30JLJGzptv2mzanulkvG
         3x5I2ivSw9LV9IK8rH0Y+fXVdmIYjIliqBZDt832InlfnB7dXiccjLvgtMeGjKF4+pT0
         FDML6IBYSHmXerAM9/+7Yq4OMyvJs6ksJUVhBrPKNSeNpalCRi5qhIy/ZTeePZ+43gYY
         heyz6tlFZXVANrfaNNyDjqXfLCSu+dTbtI3/mQG+A3izXxcRtGTXS0VEs81T/ixPI0Jy
         r555VJMByTCzfPEojDBKzCaiQvBQc0U6xgcLvJFgaIdFkvGMYni2AcX02NdJwdpOh52K
         J4NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747567825; x=1748172625;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fThJ/HWjs/+vpbIpIwF4SXoB2R3Qg/7e4eqqn36WoRE=;
        b=KCtzcLKw60WujPaRhvIXqssZHvGP/J/iogk/fLMWj6Dc7hyg5WjvenAy0x/4MIk3Eo
         zsWUot9EAbPyNZ26S9otzTmvMckmJEivNW/oYfRVMtjfqBQpurKyL52Yr/Jj74rbVVGx
         RPRdro1kitobRWMqK0bKIFnIZiWtNaf2MhMk5fiTYx3tfivjcVHEnQH/FN9R1yMP8f6p
         EZqqXvjLsLZu1PVS+2lbO08fQH8yPlTCbX/96jKgjNYnqr/SUVhRdWfbrQtkARmzi04V
         WDBXbhGXsVaCl5k8uU/K+8JcnXPq2OpUr/TMZgB/FZ9D5APrDmLwplCEVskdzdEmSjlI
         ASqw==
X-Gm-Message-State: AOJu0YyCI96UfARkq9canyU4m/VvWE++OB1CUaPxpdpcb/2PHWx3oqu+
	GYJ3UVfdkMcSIc7/agJagVmJFCtiqRPxLTMSqho0Ys4bp66x578l4fAWrwQlqEInoAWeb768I75
	fKerGJDjuMoLXpnISniK60K2nv+dN7sI=
X-Gm-Gg: ASbGnctW4+Scm3IOKRCWguN9+WyzmYE94qg++c6jGI+LZ1IkjR+v9yCRjncLu6TFp0w
	hjnr6aG97yrDt5US3wSW2nU8o9EbojcJCPJbric/nYfA7m6gyCnPRlywqu0uBME7ZYUP2o+oClU
	AwQGl6ijNTkxZ0obEHDwlpuN/42uBCoAKfDM92baF04UgHmdVmNHJppd75YjHfpZiVWB4=
X-Google-Smtp-Source: AGHT+IFmrIAAtEoIR6YUr6G8HhyaDdZhqqem2AC2uqLWOzJDyvxTLt4e/xQo+6HIzRlnUTLcZq3HRD0dt7LmA3qmbs0=
X-Received: by 2002:a05:6122:65a0:b0:518:7ab7:afbb with SMTP id
 71dfb90a1353d-52dba94a50amr8084882e0c.8.1747567825395; Sun, 18 May 2025
 04:30:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 04:30:24 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 18 May 2025 04:30:24 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aCcM0QK6QBdWO2jj@pks.im>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-2-80cbaaa55d2e@gmail.com>
 <aCbP1SxncSVw2fCa@pks.im> <CAOLa=ZR+3RPDHucjEVx8s64nrVGjzNTu9gX6Nw5vwQGg8PtpUw@mail.gmail.com>
 <aCcM0QK6QBdWO2jj@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 18 May 2025 04:30:24 -0700
X-Gm-Features: AX0GCFtNsZay0SYRGeK4oD15OWYRZM3QdfygcCjjJXQH9jL9ZULRm0IglyMkKnw
Message-ID: <CAOLa=ZT4LnyG33=atULuFxoCa2V5rO70aCmMQYsxzhieQDp5iA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] fetch: use batched reference updates
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000074597e063567576d"

--00000000000074597e063567576d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 16, 2025 at 02:53:22AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > On Thu, May 15, 2025 at 04:07:26PM +0200, Karthik Nayak wrote:
>> >> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> >> index 5279997c96..15eac2b1c2 100644
>> >> --- a/builtin/fetch.c
>> >> +++ b/builtin/fetch.c
>> >> @@ -1688,6 +1644,37 @@ static int set_head(const struct ref *remote_refs, struct remote *remote)
>> >>  	return result;
>> >>  }
>> >>
>> >> +struct ref_rejection_data {
>> >> +	int *retcode;
>> >> +	int conflict_msg_shown;
>> >> +	const char *remote_name;
>> >> +};
>> >> +
>> >> +static void ref_transaction_rejection_handler(const char *refname,
>> >> +					      const struct object_id *old_oid UNUSED,
>> >> +					      const struct object_id *new_oid UNUSED,
>> >> +					      const char *old_target UNUSED,
>> >> +					      const char *new_target UNUSED,
>> >> +					      enum ref_transaction_error err,
>> >> +					      void *cb_data)
>> >> +{
>> >> +	struct ref_rejection_data *data = (struct ref_rejection_data *)cb_data;
>> >
>> > Nit: unnecessary cast.
>> >
>> >> +	if (err == REF_TRANSACTION_ERROR_NAME_CONFLICT && !data->conflict_msg_shown) {
>> >> +		error(_("some local refs could not be updated; try running\n"
>> >> +			" 'git remote prune %s' to remove any old, conflicting "
>> >> +			"branches"), data->remote_name);
>> >> +		data->conflict_msg_shown = 1;
>> >> +	} else {
>> >> +		char *reason = ref_transaction_error_msg(err);
>> >> +
>> >> +		error(_("fetching ref %s failed: %s"), refname, reason);
>> >> +		free(reason);
>> >> +	}
>> >> +
>> >> +	*data->retcode = 1;
>> >> +}
>> >
>> > Okay, we stopped ignoring generic errors now and will print them. What
>> > I'm still unclear about: which exact errors do we accept now that
>> > `REF_TRANSACTION_ALLOW_FAILURE` is specified? Most of the error codes we
>> > probably want to accept, but what about `REF_TRANSACTION_ERROR_GENERIC`?
>>
>> The current mechanism in `ref_transaction_maybe_set_rejected()` doesn't
>> handle `REF_TRANSACTION_ERROR_GENERIC` errors. This was a design choice
>> (more of a requirement of what this error represents), where
>> `REF_TRANSACTION_ERROR_GENERIC` errors cannot be resolved on an
>> individual reference level. It includes:
>>
>>   - System errors such as I/O errors
>>   - Duplicates present
>>
>> Both of these represent issues which are bigger than a single ref
>> update, so we have to propagate these errors up.
>
> The second case is also why the behaviour changes now, right? If we were
> able to handle duplicates via the same mechanism then it would become
> possible to retain current behaviour for git-receive-pack(1)?
>

Yeah indeed, but if we want to allow users supporting conflict
resolution of duplicates, we'll also have to think about how that would
look. Our discussion till now was around allowing a callback for each
reference update with the associated error.

With duplicates, we'd also want to provide the context of which N
updates are duplicated.

> Not that I'm proposing this -- I very much think that the current
> behaviour in git-receive-pack(1) is a bug that should be fixed. Mostly
> trying to understand.
>

Yeah I agree with you on this!

>> > This makes me wonder a bit about the current layout of how we handle
>> > these errors. If the rejection handler was invoked while preparing the
>> > transaction for each reference as we go instead of afterwards we could
>> > decide on-the-fly whether a specific error should be ignored or not.
>> > That might lead to a design that is both more flexible and more obvious
>> > at the same time because error handling is now handled explicitly by the
>> > callsite that wants to ignore some errors.
>> >
>>
>> I did ponder on this while I was building the batched transaction
>> mechanism. I decided to take it iteratively. We can, for instance,
>> modify `ref_transaction_maybe_set_rejected()` to work with a callback
>> function which would allow the users to accept/reject errors.
>>
>> However, even if we go down that route, `REF_TRANSACTION_ERROR_GENERIC`
>> errors still cannot be overlooked, these errors will abort the entire
>> transaction.
>
> Okay, good.
>
>> That said, I'm not trying to avoid going down that route. I do agree
>> with the flexibility it does provide. Once we hit such a usecase, we
>> should make that change.
>>
>> For 'git-fetch(1)' and 'git-recieve-pack(1)', do you see a usecase?
>
> No, I don't right now. I just want to avoid that we have to eventually
> refactor all of this to support an alternative API. But agreed, there
> isn't really much of a reason why we wouldn't be able to introduce such
> a mechanism retroactively while keeping existing callers intact.
>
> So let's stick with what we have and keep this in the back of our minds
> if we ever need such a mechanism going forward.
>

I think this makes sense!

>> > Last but not least, I think that it would also allow us to decide ahead
>> > of time whether we want to commit. Right now we basically say "just
>> > commit it, whatever happens". But if I'm not mistaken, all the errors
>> > that we care about and that callers may want to ignore are already
>> > detected at prepare time. So if we already bubbled up relevant info
>> > while calling `ref_transaction_prepare()` the caller may then decide to
>> > not commit at all based on some criteria.
>> >
>>
>> Indeed, that is correct. I can confirm that even now all the calls to
>> `ref_transaction_maybe_set_rejected()` are made in the prepare phase, so
>> we could already do this, since `transaction->rejections` is already
>> populated at this stage.
>
> Good. After all, we shouldn't have to perform checks in the "commit"
> phase. Things are locked, things have been checked, so it should
> basically be a mere "let's move everything into place now". Which of
> course can still fail, but the only valid reason should be system
> failures.
>
> Patrick
>

Exactly, totally agreed.

Thanks for the discussion Patrick!

--00000000000074597e063567576d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f7601f28f5054cf4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ncHhNMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM09pQy93UE5GWHRUaWl2YU85V01KbzhkKzBYelJWSApCRUhUUit6anlM
S01qcEZsT0wwQW5lZXVuRWxzRXpGZEpPZDA1VXpKdENsMUpYNnVFcy85QTJ3VGVHRXV0enl5CnFa
VXFjbmU2UXF5eElDNnIwWjZvT3Qyb0lCaFBpcjlaN1R5VHFoUVpaTTNyVUhob0NIYndDaHhRZTQ4
NTl4cGIKNDlSMitWT1V2M3VsaGhoMnNoRTBlTEZ6M1ZkekdBMkU2czBuK1Npb1BzRGptVnI1SW1s
aWE4SHFGWTZPZS90VwpvaEg2M0xTc0VWZmlqb21tR3ZobStzQlZGQVlVTy9BbXVseDFVRkEzK0U3
UmN3d2h0eGVJY0x2Q25PZDhPS2pnCjFzcWVLRHdrT09UaVpWZGxWNmg2VEp2eDV2RVdvblk0bFBh
bzVvaXp0YTN0YkxZMnJTaGlDMlBjSnRaUXlJelYKT1pxeWtMNzZKV2o5bmJWckplYlpuVHRNQjA5
NkhNaTByY3Y5RGg5NUwxQkxmSjg1aTRtQVhIb1A0TDRSeUJHTAoxU0RVNGQrOGVjUmh6OTdkMk02
MGNWRnJESHdoaUoyZW1FQ3RTa3Vrd2xFQjFkdGtyazlBV01nazhxd0VmdXNpClU5VDB4Ni9JUGVV
b3pGSFpTSFAzZU5wQkdPMUMrRUNhZTNHcEJjOD0KPUVocnAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000074597e063567576d--
