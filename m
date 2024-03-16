Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1586139
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710566441; cv=none; b=Igcr4xxLJoNyekOTiiQTfvBMse/4zW+CDl2vcbwFP45GCYlN2FtPO9ZvXJJNuQHf+xlC3I8V+c6m4YyUcAiFxJ+99+NYaYkr1mJXj6fUeDmRQlQ6RnTbYB+Feu9XdUc4q4ZwCfkSMKkSJUtZo0Lgbc37ogGkXhD9SduaLxI0StQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710566441; c=relaxed/simple;
	bh=Bz3pENOHJaaA772tYM7lwX/ph77GVPPFJzqQdCaPXdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYMlnRUi42Zj3/R74ByqaktvtH8Qh06TbKB4rdBa8EtCSk1q0TH/KLXCa6+bI9hnQzw4Iajx5FBmgPa2d9jxp76FwcnZ+lSGMAZfnd7oTJhuw+J9XekEeO/Jf5r15sgF4YdWUseJFIppPPPfF6bRJvdbmOjfnVCrcNRjjhFdiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q//wa8yD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q//wa8yD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-413fffcc472so11791355e9.3
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 22:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710566438; x=1711171238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVphFnMKvqhK5UgdEv69IzqNN//xY854LrotDuVOE6U=;
        b=Q//wa8yDqmEY1BrpQvSQdfztrMJw974B7Yla8T1pcb9MK9WmTkunrBs76t7HBvZDIf
         TXOaEiWasRuy3Ydn4WItuXTq2yiT4FFxiiMx8Sa4eXNmD7kLWzF9xFzkCJN9kQbAYMiN
         vQ7vwI56jdu3j+TJgOV8pSfelpl1o9fyU8CvnGdoPYPAEINkUvAJFANuTM1s91KhrRDc
         /87YOntcCi1BUn6s+yD+0n6eKo0MUNGNayMpCOOAT/bg2hsn/6rvh3f8+ADXkkOOrAFU
         2Ldqz5nM3hX+kpH5/ZQXpkh9kGhd3aG6ceS1CwhC0+h3SGPCNmuXIk5NjtpUCDDjpslJ
         JDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710566438; x=1711171238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVphFnMKvqhK5UgdEv69IzqNN//xY854LrotDuVOE6U=;
        b=ooow8PPvrk/2LcZB+voZ7wSYnWtJoe7/PwnSiJpn4SvXQf9LvpmqT9S9wgNARhvKnO
         uvB0BPHikqscucUI+9JO6tPsRrSti3O5o1L3D7lDbeTpBUdGwoeHB50opBSWAgv753Mm
         c78exOcC5vJjcr1dnDuNNufhfsIsoqtBxGfbbXOoqOYgBIDkWYHqxxz39eTxGxPZFClj
         V8Aa5VfyRSoFNWIAjHmcD/O21lxqz9ddPCSdmlBOJ1qcidu3NqPBxoKI6ioTO4yMd8UB
         TrnH3aVdH2znLZNBAUit/h2ecMZK1P4e/LVeCW+nn52M1yj/P7tvObO/ScpaOSd76AZr
         Zgog==
X-Forwarded-Encrypted: i=1; AJvYcCVUu4gZQeu6g8CcWq/08tIC2g235QyfFBD8Vh/WWGV0cKeYdgt7BBW6TaU4TGcDi5SOwhV1rMk4+9u+pJN8Yf95SS3n
X-Gm-Message-State: AOJu0YzB1ifpz7JncybR/Kso54VJCcIK3YhYqJmbOYkHqp033zMzBMbf
	/rywYaSsdqatg6NSqc6bt+jr13myXs/gybD0XVx7iAZtv0zVfRryCJUdVRdOBaKuNfh2LEzpgrF
	XDg1jOWbqzJ3gvRE7aFePt+k+sLo=
X-Google-Smtp-Source: AGHT+IFYbRlgQY6gDeT83lDN44byYmdppmtJ5ZFIUR7uEB0GuG9E9rKu+nPzufoR3KhmAVxarc9BPI1IOFHrQVAcTrk=
X-Received: by 2002:adf:db44:0:b0:33e:9311:5fda with SMTP id
 f4-20020adfdb44000000b0033e93115fdamr3503866wrj.29.1710566437554; Fri, 15 Mar
 2024 22:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
 <20240310184602.539656-8-brianmlyles@gmail.com> <d7c926ce-8a2d-4828-a3b0-3c4a9bcfe92a@gmail.com>
 <xmqq1q8edpb4.fsf@gitster.g>
In-Reply-To: <xmqq1q8edpb4.fsf@gitster.g>
From: Brian Lyles <brianmlyles@gmail.com>
Date: Sat, 16 Mar 2024 00:20:01 -0500
Message-ID: <CAHPHrSfiMbU55K2=8+hJZy1cMSRbYM77pCK8BdcAPHLvapHO_A@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood123@gmail.com, git@vger.kernel.org, newren@gmail.com, 
	me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Phillip and Junio

Apologies in advance if this is a duplicate message -- it appears that my r=
eply
never showed up on the public archive at https://lore.kernel.org/git/ for s=
ome
reason, and I'm unsure if those CC'd received it either. As such, I am rese=
nding
it.

On Wed, Mar 13, 2024 at 12:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:

> phillip.wood123@gmail.com writes:
>
>>> +Note that this option specifies how to handle a commit that was not in=
itially
>>> +empty, but rather became empty due to a previous commit. Commits that =
were
>>> +initially empty will cause the cherry-pick to fail. To force the inclu=
sion of
>>> +those commits, use `--allow-empty`.
>>
>> I found this last paragraph is slightly confusing now --empty=3Dkeep
>> implies --allow-empty. Maybe we could change the middle sentence to
>> say something like
>>
>>     With the exception of `--empty=3Dkeep` commits that were initially
>>     empty will cause the cherry-pick to fail.
>
> That is certainly easier to read and much less confusing.

I agree that this paragraph is slightly confusing. I tried this
suggestion on but found it to not sit quite right, I think because the
two exceptions (--empty=3Dkeep and --allow-empty) were not part of the
same sentence, so it felt a little disjointed. How would you feel about
the following instead, which aims to be more clear and specific about
the behavior?

        Note that `--empty=3Ddrop` and `--empty=3Dstop` only specify how to
        handle a commit that was not initially empty, but rather became
        empty due to a previous commit. Commits that were initially empty
        will still cause the cherry-pick to fail unless one of
        `--empty=3Dkeep` or `--allow-empty` are specified.

Thank you both again for your time reviewing this!

--=20
Thank you,
Brian Lyles
