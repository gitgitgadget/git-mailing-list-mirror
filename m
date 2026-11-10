Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794316525;
	b=knyyfNVflxir+6Ulminkl35qDgOdLbJsDMhcauafIr4b/SKHlmwV3B3f+8B9rSU5lU6g
	 XP6nbSFQVWFpi7abqa9mMOdMH+6gcUmyS528OsRHIEkRAiS7BYh433f0xDvWq6iZW+AEQ
	 vBYVknnoYZdlTlAS6qaWKo90amGza9Ol8qqKUZD/jLuomDKEWkr58c/ounf9fl1ddYpv5
	 3Uqm6SBx+cSTesmA9isRXSn4ywcamfMwIMTlYpM7+KLwaK+hfwEYoya9NZIZ7KaNSPwJU
	 dsjLEudQUlUro5kOz5iUdVuJR/9CHUVw+WiOOzX0z1jB89YfnW+xk1JEiRHTVBitu5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:In-Reply-To:
	 References:MIME-Version:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=nLCUn49wpxJnVLtytyLdDsf43/aB5IUETd6qtwIPWu0=;
	b=MVC8aD6oOA9/XdoJgMEgKSs5xjBLxZfLYXOEQ8snri/Cdg7OSrmquHNTSgHTaMD4k5OD
	 9hckDNIW6Ja8y2ScugSXoIF4ViZXPM4T0fCen/yDvIco8xE6Nh9aG78smOU7VWY6khUe5
	 L2lrUm+GR7y7Lw8zKNKq+5xj5q/D88XFC0FDAFZPxjFQ65YBdw3GnJ00aDeXEHixhnV9X
	 hC1SOzorxPWZJe16Slvo+sQTR+BJ8uxiMqAOjtjLZuRtGTQMP20XB1vuVXHIz8fohN4aZ
	 950P+clylgtZn1UqdalXxygzaNpw5NbdSeCXFelZU9t8HcFF6p2UhnYXA2MA0T0p+uQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hKsK3xKs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAF6606B2C2
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 13:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EAF6606B2C2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hKsK3xKs
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-745497ac8fcso686359137.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 05:15:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794316524; cv=none;
        d=google.com; s=arc-20260327;
        b=gY3GlnDdlKFh0JFdaWqf/uWgoE5y4s+vYxLXTj6CllB9Jj4ETqliRJEIJF0RArTNGC
         vENNcpVEzl0e2pdUmRVXUT9Pv1rmqPrhNd3A/Wp4sFkG17ZPRnsalwyKJrJdGe/wtXSU
         hrcGx3/dx0EgTHNxE8ox6dbL6A2fFOa5ZaMta4YGBtHKTWUzfbmax+vKVhIQ0hS/uoZf
         lTGfmj2e/tArl3wGruPv39uqmuMYYcu+mMDS1McdnQVCD3RdBIYGMQeZdC3VP3x4AOwr
         8zUmuu0/klQNo2dvSaETKSQOYrcE1TmfnTWvMkLiW98TNDyTL4ZClEoeS6d+h9xBlyk1
         i1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=nLCUn49wpxJnVLtytyLdDsf43/aB5IUETd6qtwIPWu0=;
        fh=9HqPOFh6o/KiPVJ5WYm1z6ScGx/tG+tvN/x72pLgIFo=;
        b=EW7OA7wHPuxhrDqbWEB0ZHXYJnZLt4ubmQCd6WBaHL3ImDj+jwGVbobq3V6l42gv7s
         i994jtcf1y0E0d06KHT92KYz7aIxWlxw98EcUcFWgMQlr6rExEMiG3N3t577aFXZsRKp
         hhHGsxIo/Q4efUmO1jcAGJ7198Qvog8sXImcdsTG3QaZGlMKeXVneRXAqc1DUrpU64hV
         61ESHWNV/wS4HYUqgIFGJqsyloHAeQRSv/L9K5BB5tQR70OUAv+RQtSFS9p0928OPB9b
         aPEICptcRSj4TBlqwtmkW5alXWFxaZSr9oMR1bLmaLzna1S+UJxjyKKoXttgYwcopf40
         hcNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794316524; x=1794921324; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLCUn49wpxJnVLtytyLdDsf43/aB5IUETd6qtwIPWu0=;
        b=hKsK3xKspK7/If/A4wmieAWIfu7uWZU/pcKZlJToUqL8+w/Ou5ra2uG8KKdqHpIt7q
         5yCmgt59xZ64suBg6R5jK4dFI+0qgYh+BjsH9HjAaWkl258STLMVt7pehPBcgaUJCEkd
         uZSrLJ4PZTjHQJkRPjiUhFeMRuYiYtFTo05hSJRrZ1WQLt394pVl+XOi2roQFxW0Edsa
         4OLCdHi7bS+ym+GEgwmLIIEsOZD7eJOwAhGSMYGxqYWOVHXy4aDbXk++52UjOIseyx7w
         6jmpchXqLkcpk9DA48J3qANfjKM355k2s+K1MDl4+SzMZCEkRv6dQxUtscSyEezoJ3QN
         uH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316524; x=1794921324;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nLCUn49wpxJnVLtytyLdDsf43/aB5IUETd6qtwIPWu0=;
        b=D2l7J/tukxbC4A/EWQZEtQPCEnJr1eTvsMNkpITVWOE/aL2UYyz5AM9bY+RigdhtUo
         g4KQxhPkGSj42kBe0ejfmheKJYpDg+XPRK3GIZCz0e4ZpJOvvRpaY8+pyG7Iegttc/G2
         EKbDffYjh2RnVlfP8Z9QoQN9J6RSmm+ehCXk4oL6rmhd5YHHHsDwLu5NGPkllwkqvN8l
         qsNT7URbl1tbbVVrnRVpC6mqjyakik+QJsZLk1BV08lWnnTzHRKRoLQZlC3muVGToN6O
         4GlsGOdXFIDDO2iMvu0kDZ0yLpiX6R8PvvoXldDZvkmGT3r0zv3UZvgI6f8Cj3CBK2fo
         nsBQ==
X-Gm-Message-State: APuU4Z8jh1+oy7giK6w+GyPWfDuUbozJx35VotynWsQcsGfcBEVo9eSI
	gT1Qe1IypEXicRtwj6GkkbrKlJobvnv70dIdJteETaTONtSMsDG25baCEi8Txuj6dk1NQHG2hOg
	++H5UHvesNn3EFpy8ha6KUTMeoe9PqrQ=
X-Gm-Gg: AYBFou3KUNB91FxZLZCyEuSfJNgs0Kom5M+JB69akVGQUqp/GOjAfs7pboe4HJ/mY+d
	PF/yAIjx2f0a5VB1+zdI0i1wd3wI0UfBl/W7DRnSpgHO5pLXfLbRydFMXVIAceB+0UWR6jnjbwC
	H+C2Ra/jHIYDZh65cFrNFYvfGMghwzoptwiMPtes52tstIsqZOd+i1rrKw4SkRg/ejSmEMsSKT1
	JOOov6uF7QPzd7zvlGyDBzcwO4Mfhb4un+FK+JxBDwmb5Dj+3LdkGLj4Z6AIv7EasXTmvSv0AA4
	53lAmmtXSD1iPIL6x9NBgvbIws4gtPCfkj2fama/e9m6ziaYIkZaj8xHJJygfaNsxiV3+QC/3zj
	ayrhtyTVa9dGtlOPqQtxH+N+L7CwXJmN79o5/RwtRe2OJdEbI5ojfEEglT3qxIquuHXF3Xpk0pL
	OTy23Z1cBQx88Oo/9tm/VFGakl5co=
X-Received: by 2002:a05:6102:c4a:b0:7cc:2152:4f95 with SMTP id
 ada2fe7eead31-7d301addaf8mr634962137.3.1794316523857; Tue, 10 Nov 2026
 05:15:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Nov 2026 05:15:22 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqse19zv8k.fsf@gitster.g>
References: <20261105-kn-parse-options-doc-v1-1-403edda5947a@gmail.com>
 <20261109-kn-parse-options-doc-v3-1-e60022942721@gmail.com> <xmqqse19zv8k.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 05:15:22 -0800
X-Gm-Features: AclHuK84r9sQX62cQ5p-9eOkv_SY2HrI-SSW_loByWfLjGGquGL6FMurWdipn1g
Message-ID: <CAOLa=ZTakzuQQ87Znf9oPVBWd8NcqiGqqjwq2k2y-b=ZW5vMkw@mail.gmail.com>
Subject: Re: [PATCH v3] api-parse-options: add missing flags and macros
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, herroyalpriestess@gmail.com
Content-Type: multipart/mixed; boundary="000000000000051b5d065febdfe8"

--000000000000051b5d065febdfe8
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I was reading the docs while reviewing another series and ended
>> up finding some missing documentation. This patch tries to cover
>> that. Some of these might be options/flags we rarely use, but I
>> strongly feel its easier to make choices when there is adequate
>> documentation.
>> ---
>> Changes in v3:
>> - Fix typo and rename the variable
>
> OK.  Matching the parameters of OPT_ALIAS() the documentation uses
> to what is actually used in parse-options.h header makes sense.
>
> Have we reached the point of diminishing returns now?
>
> Thanks.

Yup. We can merge this and future improvements can be made as needed
with new patches :)

Thanks

--000000000000051b5d065febdfe8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ed52094ae31c4fc6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yekdPZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNU5CREFDYUczQktYSEVVN2luZmpwRUhsOWFUVUJ5RQpkWFE1ZVR3NmNR
KzNCaFZaOGdab2d3ZFBvQWIzZ3ZjOVI1YkxCS1FIMjNnZXNHd05HYzFDQjQ0L21kNnRsbjVXCkll
bG9pam5vcFMxNlF4c29WYzZlb1Q2c3RTWWs0eURjQWhLSFNxSVU2NDdmRVphdzdrOS9DcmpFMnho
RGZ0bkIKa3ltVzJyRmJCUGYvSGE1OE1HVlpQK2RreWNjTmdGRmpNWDBFV0FIRlB6YVZjSUVReWpp
V21TUWJJR3VvMk9MZAptOTFXZFhITUFEa1JYelcrZzFocmx0cWczdzhQZnhLOFZDb1RkcmcweGZq
QjBYeHNDZ2hMZ2ptOFRWd3I3b2hFCjdQaWdObVdpdlBSMHlBV2dHOWttSFZtM1VNL0ZtVXlmTE9a
SlppYzVNcmwzckZ6VkNtOHdnWU9IMG56TWV3aG0KQWRWOUhHQ0xsdU55UlF6akVhRXZwZnhhOE5K
YXgveVlqTENoaC9iVFM4cXZ3N2czWU16V2VBYzdPeW1raE9aUwo2TnN6ZnRnMnBLK3VubXVYZFFT
Z3dGWkJMRG1lN3VCb1JqbDgyOGhPQStSdEhmNTJVRVo4UFJXcHFnV3NwaWltCmJKNDhYRWNRdVpu
TVA2bjgyVmlUSEtWZExVRC91bXJiTkpKWW5PUT0KPVEwQkgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000051b5d065febdfe8--
