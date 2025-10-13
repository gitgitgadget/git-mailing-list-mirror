Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014021FF46
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343749; cv=none; b=uGDtEq5ig7HLecA0Z2igzvZA4/tSWeHJaxepRprlwWTI292q8oLjIcBcwzTD9LEYjOGpIKDC47qjviixYTrkQuq/PA36RiyQ8a/6zFQe4sLP0h7VB3P6ipA29D35hsnCBpGuyaXtpUHrGCdB4u9f7U8aazIvD/0c3APx1CB5n/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343749; c=relaxed/simple;
	bh=0kJZHjolDQ3GhgdZ7meniWYp38heC/XhxJ8M0Ta6R0Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vA7qA8RNMW1anGrf1FtR1389qfL8Pb2vRyTM8Sdg6WP21R2aiqCmV0Q1PXRnfXXEe/kNcnY9CC4dRtbdjggTZo98oQp2u5hxtJTUqJZ22Bl7YdZXGtkc3pNNcTmHRum/CdfYUAED1DUpkwbr9kvsfGIrnSCmht38qrNFR40BOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUmdAMvy; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUmdAMvy"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-551b9d94603so1147188e0c.1
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760343747; x=1760948547; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/jMAKgWyJtuNH3uLMtvHA4X3xx8is7LsFncfcmqYN8c=;
        b=GUmdAMvyF4eLohEwufjoW3vhyu6Oyq4c37zdrjjaZxKxUEilTsRYDiL8ZwzFc1GAuZ
         73SCRacscKOjFLPr6I3aegVIcOoX7Bv72S0KA4C4LSi/Hg2TvBv8LnoU+KJtQAQYF9db
         +sopKSMqX2lTbTZ9TBQTaR+X19tZ+USOCQQqz1K/t3Jl1LwWCeDIK39nO28NRI/bq1fl
         lgPFn5jxrviVvEpzcAts5amH1cED6kS9yeMiPYOjZDVusfu4UcnAINXCGSMJw7HXylsz
         sc3Hj1G7UtTdSGA0DY7xeUMuaGUepAkfxftsfoFTYyXGL9HPRkj0/cMEfu8Ey/BT1cWA
         cClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343747; x=1760948547;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jMAKgWyJtuNH3uLMtvHA4X3xx8is7LsFncfcmqYN8c=;
        b=W37EiWB5YcktLsbu5PDraaebh6Oj3ANwkdPKfdqMvrd5wE1LixbPsDCSVgc8M9PDXr
         4ZFjYBENq/U3IWGvn1A85dgh1WV+pY0Sx29wAkeDZJwNCaKUzamxCeTQQKRfwG8AFsNR
         OTalQlyL/sRcrh/fcp7Hs85EC3tgBEATqAPX3k+b7vivFg/m4rWe/0AVRQyVT9c6s0SU
         5sphEF+rXscalGFKKAZPPhiIja65k2Ql6l5KpJ3E88sEQGWa1+TM5Jit6u1SlkIm+FIP
         teZyd0K3PI9r3U6TAj88xgUDxBgPjAhwN6Ql8aIBYQ41Si6q7MBUE52DVUa8NLxm0JrH
         ixGg==
X-Gm-Message-State: AOJu0YxgqxT36QDYKaI3V0ROQNx0Ij/kTZTHWLmYkNyDJ/Aq1iAuHkO3
	YUbQIN9NbAKE7FXkMIuWQmhTDDYgq0KvyB3NGzN97on0w8jJ6uTw22ufdOyapA7sgF+DXQGittX
	Rt3NWa4BlKRRJxAfDmDenMonRzGqK+/o=
X-Gm-Gg: ASbGncvBN2oW3sQwPguCA3KB9WdvUYrNSnl1T1bYjwN2NY2aAGF9TP7UUj7UMulAowY
	rM0R3D2j8ciLRLUKpuvlh0KLjxkd6iBQoDwtZCxQ7HRLoDmg+2HdKGErwCluOeKDktzkgXmJA8O
	sUO5HmVlzTfxx6ssvllMjWbeYTLn2leCgzseYqXHY5gCEFO+4HILCXoqqGy+lN7Uy5KR8bipdzk
	omOXfZOJtgicUkw
X-Google-Smtp-Source: AGHT+IE+XvO9guJJ3iP6e//rpWmbqN4ReEI3v0qJxOTGiskdYI2l8WSvkHf+p8ylfsLgsyrpwVQlrQbe+s2KDUdmfpk=
X-Received: by 2002:a05:6122:8c5:b0:54a:2600:bf86 with SMTP id
 71dfb90a1353d-554b8b97c56mr7157579e0c.7.1760343744949; Mon, 13 Oct 2025
 01:22:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 01:22:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 01:22:23 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjsa3UWw3ygo8FU@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-2-c7962be584fa@gmail.com>
 <aOjsa3UWw3ygo8FU@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 01:22:23 -0700
X-Gm-Features: AS18NWAX7Cqp2XVERGReNkW79xFmjUuGJp8IJ1Ux6-FYUakDNDVrH2SuTTsIbx8
Message-ID: <CAOLa=ZQC2jd=ZJjnaVEC-obYfBLipenYDFpQjsxcBX4_ULdUcA@mail.gmail.com>
Subject: Re: [PATCH 2/9] refs: cleanup code around optimization
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000099e6b3064105f7ca"

--00000000000099e6b3064105f7ca
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:06PM +0200, Karthik Nayak wrote:
>> The previous commit, moved all backends to only use/support the
>> 'optimize' function within the `ref_store` structure. With this, cleanup
>> all references to the 'pack_refs' field of the structure and code around
>> it.
>>
>> Modify existing documentation in this regard.
>
> Makes sense.
>
>> diff --git a/refs.h b/refs.h
>> index 2dd7ac1a16..c6c955d78d 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -514,15 +514,11 @@ struct pack_refs_opts {
>>  	struct string_list *includes;
>>  };
>>
>> -/*
>> - * Write a packed-refs file for the current repository.
>> - * flags: Combination of the above PACK_REFS_* flags.
>> - */
>> -int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
>> -
>>  /*
>>   * Optimize the ref store. The exact behavior is up to the backend.
>>   * For the files backend, this is equivalent to packing refs.
>> + *
>> + * flags: Combination of the above PACK_REFS_* flags.
>>   */
>>  int refs_optimize(struct ref_store *refs, struct pack_refs_opts *opts);
>>
>
> I don't think it makes sense to carry over this documentation here. If
> not already the case, we should document the `struct opts::flags` field
> in the structure itself.
>
> Patrick

Fair enough, let me remove this extra line added.

--00000000000099e6b3064105f7ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 47b48f7f075c2033_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qc3RyNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNllTQy80b01DRzJzRHo4TDFhaDAxWGgveE4wWmZsMApiVTVZd2VMc3Mr
N2FMVko5K01CZ2hKZmtrbWo5VEUyaG96QlJNY1hxZFVIVDRnaFlzOFdOMUh4cGxsem5CR0liCk9G
RmVSaENvNWRCc3dtMEtRNWtGWXhDUGM0Z2N4RGc4RWpiRnZqUFovQTRWdjIwZUF5OEpjb1RIbWNp
SU9ZSm4KckN3UTM5UXAxTFJveFB1VytRc1FkM2luVUtNeS9YdC9CamtHZ0VsRjlkejN4Sk9HMGt2
Q1pZUmNYSGZ1cGwvagp3Q3AxclhpcSs0UVI3QWd2dENOd2tabFVnZEZ6VHJLeDcrV2hKWHBXVTN3
SDdvNzIwckxHR25kUGpnaXlPVUUxCmJodUxlQjF3cHJ3c3BzcU02Z2FWU3FmcUlGc3JBTVJiMnNo
eEtBWndUem83N2phazMvODQzVmdjckNSbkVDVXgKY21Ia1lCSERYVVRhcU5qUmJCaGtOYWhGQXFF
SG9CWXhXL0w4Um1kSnFVNnlyV2RpQU5xdEVha1l6dmsvdUwxZApjN2FGTHF4Y0d0MVpoUzhIRFpa
RlVQNUFzTy83a25YUy9UWGl2WHNaQUxNL2QvaEFNK3FERTJtZ3lBSC9LejJECnpzL3BPdzh4US9v
cEZvVFBzaERGWG82TGdyd3JPOWdmejg2anJuaz0KPXhtUW0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000099e6b3064105f7ca--
