Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E7A1E9B07
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 10:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740134021; cv=none; b=tVYVoZnA0Pfvf9UNdZvFqpYx3b+m9ZsAjb2DG0bSzoJUy5neVt8u+HeZQ8qJdu1hU/OvY8Gf9VuvRsI8ovsL7s35XlFk7HeLREtf1ogNtmVIdazIAqty3GGShOfiRzvhp0pJVdPYYZh1NNBE3QcpjEp9+aQAhgk7tDUO4te6qp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740134021; c=relaxed/simple;
	bh=E9qvfsVcrTS8YuqVybv4P/tV4rK66NP5mJfPDLY9ZRE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcXxP1HSYXz+tb9Ujt43UHJqW+9TNiboWcTDewDtt0ZDjw5bJyunW8yqKMSN9bqDItmSOKJAYobEf5PtUeYQlX5s+dCbbiCade7vYOahxPumiRlRWiXz4gB5qig2LgSu6bYRkjNkWHIt9E9ESCpoVZidiIVeRY2L6hY59jarZeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OG/YBooQ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OG/YBooQ"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4b68cb2abacso583060137.3
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740134019; x=1740738819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=HaWs27qvwE8wcso+ezZFz+OFcsLapSa8kBhtgMrD8SU=;
        b=OG/YBooQagjMk0MxIgaOI77QItThpM90EFmC1NX7rFQub4WU0SNyaWVqqu+H5mrxyu
         NZOhPUBGtbwlpKgRjyfp3wWAOd4+MaSk9WyGDywpmHBdbFqUSyi3+rAkOwGVowa4l96K
         FB745ordqG/ciqzd1JUKgNOQV9LFJNZkleWjwE5g/7QhxOuNrwp44xtFnrUv+TFW9y0P
         Mkq7dFQZr6thuZi+DvPwaIHubZfGPnifhMKzgLsvTHiVvY0C+HttdSLgh4VpELX/3HEC
         gJbkV6+9orM9CBRT83UyT0GGXrVi6WUwnfM4pV5CbePmB0YqQYI1PQ71usKiyBZKL5cq
         +AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740134019; x=1740738819;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HaWs27qvwE8wcso+ezZFz+OFcsLapSa8kBhtgMrD8SU=;
        b=CVbFTf3szHQ7yTPo0LZBvq7UZgmMji0woY2hOzUfTYnPqfrGo6SKZlj8xNytrElQB5
         2zfg+flZ4B7fJu7Jcxy7w72eMPqjvO0R1U8MaX416iFZinzc+n5UBjynZaUpBFmctH8N
         czVf7kuUKZtQAOvsfaJ2vzZ2uW0ad+lg0s9QbelOsPLcr9FL2b69SXpMYj1Ar1iZtHjv
         XUn28cil6D09gPHaOjaCf1/41pEvJjEJbifSVcd3ETD02I6Hh6QhAuyzj4SDdAtLFZbk
         8Mfd0tmS5CkTxrdABTQLH+b0LNx3Z/3jz1vYHvYW+umujwpUoNdgcowyZp7J9KIfpWJK
         ePtA==
X-Gm-Message-State: AOJu0YyMxDXZhDxsCCj89hX1tPLi/HN9J68XRtLYsciguwN3ls4Kxvua
	sIGLsCX86gXH6XmiQNXegLmwkRaziktQK1DGQEqwKnjNCfKloetI+HAtLroprUT2PbJx2W4f4Sh
	Ge8Yy1jlJwgpTKOt2j00Zvdo74zQ=
X-Gm-Gg: ASbGncuviPTAgroiAjmA98K53BkezyqYnMptrRvxQT6dYBZkARuhnMYHds4of9UV99A
	YUHg9dD1WtXcrYk4W8RR+rxdpEUhhRz4SLCU0fEPBXpmgacMVMt2t4q/574Ck/9K/7Fl0p4ijBx
	rF4xoUl5QJ+OyfXGDifocI7scvSZOZsOdtZJ+TWOb1sg==
X-Google-Smtp-Source: AGHT+IFjdEDW/XRuguvzo1EQjCiC8QC2XenIQC6Xp8uzUEbxJtrRTc54DdwsvaxtLTEkbYeURAIsDgmRwZrtveMNldg=
X-Received: by 2002:a05:6102:3585:b0:4bb:d7f0:6e65 with SMTP id
 ada2fe7eead31-4bfc004d0e5mr1729126137.2.1740134018801; Fri, 21 Feb 2025
 02:33:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Feb 2025 05:33:38 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z6YxA4BlhNwbeYk-@pks.im>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250207-245-partially-atomic-ref-updates-v1-5-e6a3690ff23a@gmail.com> <Z6YxA4BlhNwbeYk-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Feb 2025 05:33:38 -0500
X-Gm-Features: AWEUYZmlLaDvAWvlCTAvvuXz3XQ27wPcaSNucRqWToNjqUbMSCrahfmGzA2SgDI
Message-ID: <CAOLa=ZQG7UOiYf94jXJwm5SC69hwXCpv2HRCXxMCOUONnzKaUA@mail.gmail.com>
Subject: Re: [PATCH 5/6] refs: implement partial reference transaction support
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com
Content-Type: multipart/mixed; boundary="0000000000000d81e8062ea48669"

--0000000000000d81e8062ea48669
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Feb 07, 2025 at 08:34:40AM +0100, Karthik Nayak wrote:
>> Git's reference transactions are all-or-nothing: either all updates
>> succeed, or none do. While this atomic behavior is generally desirable,
>> it can be suboptimal when using the reftable backend, where batching
>> multiple reference updates into a single transaction is more efficient
>> than performing them sequentially.
>
> In fact it's even inefficient for the "files" backend. The whole
> machinery around creating a new transaction, preparing it, committing it
> and then cleaning up its state does bring a bunch of overhead with it.
> But true, for the "reftable" backend it's way more impactful.
>
>> diff --git a/refs.c b/refs.c
>> index b420a120102b3793168598b885bba68e4f5f5f03..75dbd84acbc41658d4b8b6b5e7763c04e78d0061 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1211,6 +1212,14 @@ void ref_transaction_free(struct ref_transaction *transaction)
>>  	free(transaction);
>>  }
>>
>> +void ref_transaction_add_rejection(struct ref_transaction *transaction,
>> +				   size_t update_idx, struct strbuf *err)
>
> "add" to me sounds like you're adding a new thingy to the transaction,
> but you rather update something. How about `ref_update_set_rejected()`
> or `ref_transacton_set_rejected()`?
>

Fair enough, I've changed it to `ref_transacton_set_rejected()`.

>> +{
>> +	struct ref_update *update = transaction->updates[update_idx];
>
> Do we want to `BUG()` in case `update_idx >= transaction->nr`?
>

Good point, let me add that in.

>> +	update->rejected = 1;
>> +	strbuf_addbuf(&update->rejection_err, err);
>> +}
>
> Do we really need a string as rejection error? I'd expect that the set
> of failures that lead to rejection should be rather limited, which means
> that we could use an enum instead. This would unify the errors across
> backends and also allows us to figure out the root cause of rejection in
> other subsystems.
>
> If we introduced an enum, we could eventually even iterate a bit on the
> mechanism and rather trivially tell the backends which kind of failures
> are acceptable. As an example, a conflicting ref update may for example
> be ignored and not cause failure, a conflicting path name might cause
> failure.
>

That's a good point, This also allows us to eventually extend the flag
to do something like you mentioned where `--allow-partial=all` would
skip all errors. But one could optimize to also say
`--allow-partial=name_conflict,old_value` to only skip errors due to
refname conflicts and invalid/incorrect old_value.

I'll add another commit to introduce and add 'enum transaction_error'
and build around it.

>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 9fc5454678340dd7c72539bfa0f15ee7eb24b1ff..99ec29164fbd30635125cc2325aab3d300cf906c 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2852,8 +2852,18 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>>
>>  		ret = lock_ref_for_update(refs, update, transaction,
>>  					  head_ref, err);
>> -		if (ret)
>> +		if (ret) {
>
> I wonder whether we want to accept all failures. Some failures are
> certainly benign, like for example mismatching expected OIDs or a
> conflict due to a preexisting ref that blocks the path. But other kinds
> of failures which are unexpected might be a bit more on the dangerous
> side to accept, so I think we should be careful here.
>

Fair point. For the current implementation with the enum design
discussed above. I think it would be best to skip over all user
oriented errors. But any system errors would actually cease the
transaction. We can further iterate on this later.

> The same comment also applies to the other backends.
>
> Patrick

--0000000000000d81e8062ea48669
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4d756ce569d25226_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lNFZvQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mLzJUREFDYzZKeWswTjBNOW5vTXZHZmNKc0dSTytaZQppTkxUMk9INFBv
MDhXV0xON3o1R3R3TnFvM1NzRDZWaTRRT1JyZkZicWJkYi8rcnpORWtGSFhBalZpbGhNbjYvCjZj
b1BUT2pKWVlXTERCOTdaSTFxeGEzRXhMZ2luRURpZnd0TWE4ekFoMnJJeENwRmYxVVVqck4wckhQ
NWRpd3kKd0VjaHVuSXRtZEdValpIcnl0RWJsVjcvVkl5aTdVaVNZdTdiRjdXbWlCemZPN0g3WXI0
Y1Y5OGFaZXlqVE5YcAplbHQ1YTgxd2t2bDc1SjYzWGgrMkpsa2FybHZwbnJ0TVJvOGJOcG5LMktq
cG9BYUJjeEw5TkFMMXYyZ3NTbUV5ClBqeVpFMWo1QjFxMnVaMzY1SW1hMjVQd2x2N0Fud0hVbDI0
YUxMRDMzNjJ4djRQVklkbUw1T3ROMnF2dWx2NzQKY3dRMkVnZ1BYN3lsVFFLWFcyMWNmc3V2K3Qz
YmRLOGlMNzhCaHRQZndPRDFGM2F6RnlNamE2cy9CSmJOSE5vKwpqbjJIdDQ4R082WFJxc3o1aWhk
OXF6SE1tWTU0dDBnaHNJVlZsTmRJRVFuWnR0cDh1dVFpVW9wK28rT29ZaWhPCmh6a0s3aC9SeWIx
eFE5MmJuSThnV3ExcU1KUVh4Yk93cGZjeEJ6TT0KPWVoUFAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000d81e8062ea48669--
