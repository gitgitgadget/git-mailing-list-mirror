Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726954BD8
	for <git@vger.kernel.org>; Fri,  3 May 2024 22:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714775150; cv=none; b=GhXcqcyj9Eg36gZXk3/XLN6eplNcIYt9111+eMFC3+t0GInVXTn6zIaRGZzdehmS91c1Ym79ZGzEFx8qE7teVYJxbjFhjzCOB0UYKgszATFVxXEv7X+GdJW64Ax1FHPJgHsItPY7V4HFONyNeuXrKfQC9kyG8SOPg4HQFLcshzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714775150; c=relaxed/simple;
	bh=digegB4Gf9212lFjSPCI2LzKb3lyCdcPFNGMTDZckOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJU4JeYal6b1ZWG7fuzOccjwaPDXXRRA4gPTUErFfQDfpD9f8y9sIPasPy3ZJFbtTCvdQm0K51e9oK1q1yd9b4gvl5WLXlvjgSTHCdvjJ45itieNevMuL1ykjXuSUCwrpJvRfvZgPXQ6UxCvj56nIPpb1IA0CmXtNV4aBpzVj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiokRg+6; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiokRg+6"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a599a298990so21628966b.2
        for <git@vger.kernel.org>; Fri, 03 May 2024 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714775147; x=1715379947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZivCmZ1FcpNdW6R7FfoopkEBOCqxwYjofk3LHlUmIC8=;
        b=YiokRg+6o7X+P/wUgtJ3z10XmX6NCzq1htrcWBFBmuGG/4KWu1yhe8nov8ObLI01zA
         /gdN/46jgaVaQcfW6HItAG5sSSzM2tRwWIUTJq+ED6/Xu3ueLkdvXVenv+99GrtqClc8
         ZPIFGtohjqdUZ/fKUezeUdg/nBtP2Ar6OSYFHIfc2r4rbMaHeQoTCzJVhv0BFz99eDiI
         rv+5LUhq/Vr4ICoZ9/Dlqqy2zTv3xaMZuEpR2oef1oLRRvTRbVBHw61Am8jXFoRfZ2jl
         3yXkesF/ggg5oc4YLxJ8Ys76auMXRFNoFei9kfSV6rgtDgdpc6QiBtGt9AexL2W4mc4f
         jBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714775147; x=1715379947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZivCmZ1FcpNdW6R7FfoopkEBOCqxwYjofk3LHlUmIC8=;
        b=pkasj6ONQocp4IOrYcrho+aqvr81pCJkhGzBlwc607tMrAl2hFLixlIE9jq0H+WS9K
         SV047Qo2OPPCeRQMe9BRGvh4+5FjF63SZGUUMBgnVenX2IGKe1dehzjJFNlrM38KVRag
         KdtesYVOx3rkCQAN83I3cIwGGkZjEv11+o5K/KcfotFLt7Y+pkjECQ7Ri0mU4LDidhaQ
         1+O35KOTQXPOdfSZCvJ8mNADvvd8DmcFUoWE5sbXiQEjmRHMkSmCXaIvLLGKDmXQuLHb
         hrnbU1Vm/rmagiGZ72RYFRzdM1t4dThajxYajpA32OQAEkRGyxC0BBd/o1HiAg7GNC1T
         vZwA==
X-Gm-Message-State: AOJu0YyMvEmnvNqx8kRicddNWaHddGjOzglD3pVvSv4l86M+SbziltHC
	FS2T1dVavJW+VggQm2dC70nLzzgFNyopP0a/rTqu+i43WnHBW0fM7fSdNhflEnowb/6NysTNzCZ
	yYFqdyMpyQOUENaccKuagZDiDqWlnog==
X-Google-Smtp-Source: AGHT+IEBJHbZdgsADJwLSL/A1BNkzBDcB8JfXPFloBYxzPcO/L1z8S2MQvee2LlUvjgU7aY7R7mhHjAC8dSEAoBszmc=
X-Received: by 2002:a50:9998:0:b0:565:dfac:a686 with SMTP id
 m24-20020a509998000000b00565dfaca686mr2391644edb.38.1714775146997; Fri, 03
 May 2024 15:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADDzAfNz3R5yj1SdJYbBe0f8m3Sp-R+X6dRpYoJ8Foj6zijcDA@mail.gmail.com>
 <xmqqmsp7aqoa.fsf@gitster.g> <CADDzAfPbSv00AfzdJ5DZbXM8YjAr=po6Y_1Y0weyw5dvVA6qFg@mail.gmail.com>
 <xmqqjzka65ry.fsf@gitster.g>
In-Reply-To: <xmqqjzka65ry.fsf@gitster.g>
From: Kang-Che Sung <explorer09@gmail.com>
Date: Sat, 4 May 2024 06:25:35 +0800
Message-ID: <CADDzAfN4gXVcqUVdoA12Z+o63JbsTk8zUpNdiVFSFmTFZtrVzg@mail.gmail.com>
Subject: Re: Combined diff format: Show all filenames by default?
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 3:42=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> >> As the format HAS ALREADY lasted for a long time since its
> >> introduction in d8f4790e (diff-tree --cc: denser combined diff
> >> output for a merge commit., 2006-01-24), it is too late to change
> >> the default.
> >
> > I wonder what things would break if we change the default behavior of t=
his?
>
> Human users who rarely if ever rename files will start complaining
> for wasted vertical screen real estates taken by the extra lines.
>
> Nothing is broken, and you are proposing to break things.  Be more
> gentle to existing users; "what would break if we change?" is an
> absolutely wrong attitude to approach this.

I would disagree with this.

1. Most uses of diff command are on a scrollable terminal screen (with
"less", "vi", or another text editor). It's just one line of vertical
screen taken - very subtle unless you have 4-way or more diffs. And
it's not just about renames. It's a much easier indicator that the
diff is a multi-way comparison.
2. It's a usability problem - like an Ok/Cancel dialog that took years
to realize they are badly designed. I consider the two filename only
header lines a "paper cut" usability bug. Git is able to output more
than two filenames; it just doesn't have a way to make it the default
(even as a per-user default option).

>
> > Well, I won't expect the default to be changed for uses in scripts or
> > GUI frontends. I wish to change the default for interactive, terminal
> > uses, so that usability comes in "out of the box".
>
> How would a script that is running by interactive users whose
> standard input and output streams are connected to a terminal adjust
> to sudden change of the default?  The "git" invocation in such an
> environment would not be able to tell if you typed it or if you
> typed the name of the script.
>

How is it _not_ possible to tell? If user runs "git diff" from the
script, then it would just print to standard output without running a
"less" pager. If I want to execute a set of commands with
interactivity, I would write a script and then "source my-script-name"
rather than "./my-script-name", so it's still possible to tell.
