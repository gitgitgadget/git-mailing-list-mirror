Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E5824DFF9
	for <git@vger.kernel.org>; Mon, 18 May 2026 08:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779091603; cv=pass; b=Yhu/ZWq3t8d+SXZ7Nkc9JpIoAgv5Qk1PWsrGWpdMK2kwe9GaKn4hr9cd96N3tQfNspFMkUTJ9gLbbbY3IcIxx9zFF28uX/Mc6PXIsboztAmNgkfITHYtF7FOTorm+Dw985bIUTi2Um6X0xHihNqlHy9j0EjY/bzpRXB/IhHri6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779091603; c=relaxed/simple;
	bh=i7twoR/hUoDQS1OUizH91lllTIGq9GZ/OhsBxiF+E0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pn76LQ+Iv+aXtuXc/OOGx4Lv/APlBWl+3HWY1aNCsas6hqXdvs5b7hypNDiZw9VoaNWn0BVNbEDDCFB4qe5EEG4WtcV7FBg/ox35PwsMrqyF/5qEfDmOA5lK2AKZuKEXv/yyp0n/e0bWYdXbZ4eDcum09mGrVGoWQtEMjbmDp8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roGVXskg; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roGVXskg"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bcda7765d64so606689566b.1
        for <git@vger.kernel.org>; Mon, 18 May 2026 01:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779091599; cv=none;
        d=google.com; s=arc-20240605;
        b=jEPsc2h6LVSktijh2Ycry3dYEh85iwrnFYj0TLvJ9mnXp6mIHl4uBLaQ23fKguKuXZ
         bbCrFG0Aoq2XzVreuyXA97eISalpE3PgdC0Ce3WwjlouiQZQ4ryXtvhmsBOXhHAoNQ4b
         WzynZQnx8GcRxlgn3GyuWf55KAYMOo4Sws/b5gQb0xOUHXGK98ZkdwAm9HelQcd/lQTh
         4bmQFATrS9CGjuCuUQpa5ByHaw90bN+7clYDuSW81m6o3b1EpxAiddAdtp99gw7j7N4f
         EH0ThtweCSmaH9I+kg98GD4vCbacu/sXaPZoUEhTo1CvKaFBpwwaqGYKLzR8EZBdQwbd
         Hn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6eLejAX5THrqIhSeRXVwddB7MRFI+OGS+b9pw1HDqsc=;
        fh=sLNTX4Z7H3LakdfQj+dZUugtzkVWCtENFicjFxBEh2k=;
        b=YqUD75lADk5VPhQiR83nT5RFIx8qlqRSzxszfZuUwGxQHxNBVTzCz8Hu8DEkq61h0R
         XH2rPI9vSg+DcBJtN453gKxkjn4Sgphrb4uULIod41+XUY3lu7VY2vMuR4DF2OH4e/4v
         pcGZtOCaOAFYGh7EeZK5rddGJR6/s863PMh5VxVJcYxcuvgCxV22muzR0g5Mv8j63tDR
         5sk0YenInb5FASnoVfrbp3xmUGkjbkne7vLq6jTjtSqyTmqCEY2zT6vZfjuHwr38YhO8
         eZRfv8Cn0FVlVS/H+vlVlpNhw+XQnIga8U2/EHGGFfi48Y0l+Q3d1pdmoUs3VepnhDSF
         p2dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779091599; x=1779696399; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6eLejAX5THrqIhSeRXVwddB7MRFI+OGS+b9pw1HDqsc=;
        b=roGVXskg2DPRs8k0ilowJi+qmWpMU8YCUD3DFk7IBVxCjAfKpgzsNz9ZgOKw/m4191
         QO4CnYPzOpEAdp4y4DWC5FVaAguQvYqvi54Dtqz3OPQQoKbq9xb7K76rLjPj2VnvOk+Y
         o0XMxTVQM1O163BkPRdqlkor/vsBzRL7GBCjxYeq7t+I6m6wccrZdS55Ekm23+JxyhQO
         gFBj/NnMvJLUSE9/Q+Ppcji7knNzaXPut36P8HQchLhL8AgK3FAorxzoYZFcFG9cQeDt
         WoupqAknlYxrZ3iR75gH17k74THxY/tg1e0fc++t7yuyBTWXrXtygKOn6POTmpyFiogm
         JB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779091599; x=1779696399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eLejAX5THrqIhSeRXVwddB7MRFI+OGS+b9pw1HDqsc=;
        b=KG2nwoBWk3m2xBSd0vg8euvS3CNP00BRgu24FdgpJSkBLD6qc5Bu9jghCSf60LQfQt
         voRalPVQdnyq2TeGe8zQqRQvGLaWhdfjPJr/ycRttrIa3L6V0TBQaWLHHjgbGGeC+c8E
         jvzOWQcRCByK1P0LyH+x5JA473QmlCiw62MqQBhN9M3AdoXnJSIFgzPKIAvFD5JO9+ei
         ABVJaJr/5jsAECxeMVUfP93VATYchWjCitL3bdjxA7h85AF6HaiMqMl28QdO3nB/J5m1
         fiZ2qeRKGlnMyyLyfj861pjbIZmdwML22kktvt8a2sbiyvDduB7fMPw4AQpObQSHXhwA
         KPgA==
X-Forwarded-Encrypted: i=1; AFNElJ/CUwXW35ATohuGUhlObIWviVd1iPsE/RtF4ZgVerA+vrwG9Vf6YXvYuK7deYEjK9Bl8gQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaUZ6ac3wl46tq9+WiPUclrOFqncjLdZm8Ja6Z8RrX/spGaYD+
	PaE5sMq/1Up4+3BjwSS4vlxKIpQ+sHkHHJkQSjvVq/iURliu228KXufRAfsDY0pAw4of8h2nghn
	KoBYalVyoDb8gTnOb6fUc9Du8MZvOw/M=
X-Gm-Gg: Acq92OHhhAWF/8L4VH8pJ4+BjAd1Ne2Pqz/bERAI1kgd87qsq29jA+WiOIi8HDPCUH0
	HEwDOKM1wjYtwW3rB5+e3N8ch17UbcgsVGYrbq6fjqPbCTLjxgu5sw6cPE6vT27Knvi42C0iGI7
	9ueWY+uUZ63jXlL4Kk6wKqXpnjJLcsH7Nouw/V/ReHduQPaQzsJhIGbdd2NofG6bb9Yltx30smu
	GZb2KTvvlCH3UuLqvKddLGO1E85RDl82FUEQSPHkTegVFw6hMZcDMDaRubEWoaq06cYOPf6ZfmQ
	GUL1CnKql7gqe+snQQ==
X-Received: by 2002:a17:907:3e90:b0:bd5:eb9:6a53 with SMTP id
 a640c23a62f3a-bd51534c4acmr602267166b.4.1779091598560; Mon, 18 May 2026
 01:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v7.git.git.1778280727849.gitgitgadget@gmail.com>
 <pull.2281.v8.git.git.1778507225500.gitgitgadget@gmail.com> <xmqqh5odqxh2.fsf@gitster.g>
In-Reply-To: <xmqqh5odqxh2.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 18 May 2026 10:06:02 +0200
X-Gm-Features: AVHnY4IOA7CPwIdYbEkgjlT-4vi6Ir0fpEnuBxhpwccse_y06PxO2LWG_HcvcVY
Message-ID: <CAHwyqnXew558xQYyXvM=fRVETyMt3MVDubBkwSNLQCs7WE7PqA@mail.gmail.com>
Subject: Re: [PATCH v8] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> I do not quite see the point of this extra block.  Can we do without
> it (and move the def of oid up near the beginning of the function,
> of course)?
>
> Even better, as resolve_fetch_target() already looks at "arg" and
> poked at the remote-tracking ref hierarchy, wouldn't it make more
> sense to make that helper function responsible for finding out if
> there already is a usable, albeit potentially stale, ref?

Done. Can I get another review here please?

> > @@ -1244,7 +1398,6 @@ static int git_checkout_config(const char *var, const char *value,
> >               opts->dwim_new_local_branch = git_config_bool(var, value);
> >               return 0;
> >       }
> > -
> >       if (starts_with(var, "submodule."))
> >               return git_default_submodule_config(var, value, NULL);
>
> Unrelated patch noise?

Removed.


Harald
