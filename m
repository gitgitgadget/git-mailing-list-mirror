Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C8852122D
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790793667; cv=pass; b=Aw1teO+KMpExXsrvn+4gGNSnIi/OUIiQZHTpptlioUBy+qNYLqm8nQs21Sursrf/W93hCESbclUTVm9VENXgjEaLgW6d5oQaO7SLmnFGKNN4ygj1kNlT/Wg4WSVMq9z9OQTxP02dPP1CWA4uROBfNHuneCZYUmi5tLoSAnfZegU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790793667; c=relaxed/simple;
	bh=aatbV1TXtzDZujiJqd3YuzK+owTnprpMVEZoH3FWy8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV25oaSoMWQGDSoQuVLSXQRK8hTR5WzJFl8GYly3Yx+SZVah+SI0o6+k1ItVHzTC69qeVozXDCVmHQKnjW92e3pUkQAWy0QgzR8RENbjNJGGVi1oTXQWWqQXgUhioKYd1C+Jo4kMSniie4oTi0ccZizbrgOeuFOh2bquoDvp26Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcRLAX2R; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcRLAX2R"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c294ad260fdso371862766b.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 11:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790793664; cv=none;
        d=google.com; s=arc-20260327;
        b=k4yaDwfLXH46M57zU7WTCmtBr+H4fua3lx4V078T4sVHq8nBSbYwTJqcVyUc98DMyg
         GDQbf67Cs43dsNbpcFQX/MDuaPzk3YxLSvxXclKcdn0d27auGmuMsgrygvRpCp/CzxRq
         cjMnxO/5RDCsbdwzo2EYlCH3buaFNtx7kGg0vjq5TKhvi8TQAk8p79VNZmt3sxcGDecw
         FRKBGCO42LkNw2dHy+XC27Co8cjSWafnoFlH210gc10ZI0EHEvc0N+GdbDe05yEUbxwq
         R1Y5Hj3itZMwiA9/kl3a9EDS6Urxk3Lvcqeflbz/TmIETBR0YPCMK1ltdsJOqJ3w10ip
         vGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aatbV1TXtzDZujiJqd3YuzK+owTnprpMVEZoH3FWy8M=;
        fh=T5Afz/ThPuoJh0TjS//g6UiQ2CgnsgOC8t1S/wJTeJE=;
        b=g33Jc39Djcem7q2IF4DabejiKiSYDKijDegf68U+MP/cnRewqqcyDLin3P2MdFEGFx
         HrN/YHS9FuttI5VV8MBiYnie/90eHAN5SNg47dchHru5p5e+j+wSsfcvUySlH6xoTx6Z
         j4kwVgyb2pyqqYhXVh4DfPYUA/GtKoSeJcI0zvMttEuPZkuOJYCqDczADTZd+iHIuLY2
         BVaEZWeibqwrXstRj2g+KBCJ6oU400jxNAP4/8/ViPiMuBpdeb7Lu7v96AMUkPZnslIF
         iUX3obKqoLWMtUwoGUOvsHkZ2xHFmtipDg6FfWpGROFN1NZnzbb5MK2PUCFOM8G3oMQZ
         kThQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790793664; x=1791398464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aatbV1TXtzDZujiJqd3YuzK+owTnprpMVEZoH3FWy8M=;
        b=LcRLAX2R/oS060R23t4aXIBImetbFUrrdfyLcq8s8Uh2BihVzr3GgCw8Cn/+YuRGlY
         5trGPKkbkYbn4JmadUPBu7omncuuf+Z1gZrhZ5fhGJDozKQLiYxCQy64bgLMxsWkuTEw
         lPeShM5YckLlSc1LnLmk9CLgEv8BrK4a7OVfxpRWbViVlEARFBSa5plTV05BLfXhWFEL
         lBvl7idnqcsAFPNg8Xs2TJUm3xHqtb2oslWz+6ZAe9q/yYCp7d0DGWyjgbCUmbl5vRO2
         2FEMnu3gzmAKCgsIVDEzoEWo5PauYYEtDNeh+PJdLXyAsXo7zJauueURbmvljnrg85NZ
         D4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790793664; x=1791398464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aatbV1TXtzDZujiJqd3YuzK+owTnprpMVEZoH3FWy8M=;
        b=zCA+qaRn3IVBZmkePbFCTrgDfWFfRf5cbdpVGu6ibTzuaS+NLi2xC/C++vLKsLLKJD
         8YvNtJ0hbictLSqAptAeWHMh3q3K2KEdYmlUw/8RJCRuSbBXlv8BfsNs20Z5wEp+dFgh
         m0jg1UoGantaLhDi0Gl7w7n7sAFCngFvo34PvaTeZLCx8M2qZpB2YwFRqVKmzJ8fZlL1
         LxPILYKQzOqxuauzmeQNIHIVf/dGnKdEpZvLPG+HVM+OQvymNzy8674s84iiX4AsgyFq
         3TsB5TXVDKmahKGJVGj22D5OAOtCmRRQUa6H7E1QUVFegt3TqVaIFvwKeBVS3yo3haOF
         xrWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxy65gpqTvMr7VteRQSvKksiZ8pf0ecD4xxqSYL82RNJlmts4RKn2AEq3nwwrNhdrZaNXI=@vger.kernel.org
X-Gm-Message-State: AFuF++lUxi+ZSUkxX8zwHZHkHsOfK992n4UITGVVxCRidhGf7g8MqygK
	NbzkPMz91FHy11DjWGG07+INeTRzVKvXOOpK4Zq4y2kg+bsrKBO3SBTyTPEAJ7sxTqIrjlItDaN
	/W0OL2cNfCSMCuOek/bHdIdKLV/xYLDY=
X-Gm-Gg: AYBFou0bhgca83z807HRb6H5x4sSDd1Wd25PeYrTIEJUYkr6hobCyGBKs9s+VuYzdDG
	DO60iMF0GXgLQkNA04dO5KjQWk9HqWq0m48CxK/JvmesKcO1DXpscIgYoqgQPNePeYCD6NGz3Kp
	Qmy3tGyhxiaIWqeYYP3WUk3xbsU0yHLmQvje6sXvfDEDs//PL2tLvcjWiGMrYmWjsxTPEVTx3pI
	Fn87owVAZLUQJBThTvOM/RrInvnLc5jR1/f+r3/3pe6z6OJ0qpDuh/XyXo6bEtkn7lWNEgp/+VQ
	9j6621PyPLQbSa5bGoCouVbwSVU4YUQrNGv1mERaxGtzFt+zXnXqdfE=
X-Received: by 2002:a17:907:9625:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c2e33fa28d3mr35051166b.19.1790793664036; Wed, 30 Sep 2026
 11:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2419.git.git.1790362443893.gitgitgadget@gmail.com>
 <pull.2419.v3.git.git.1790748583.gitgitgadget@gmail.com> <750c3605128c268f331b1b9477ca0489ced75543.1790748583.git.gitgitgadget@gmail.com>
 <5529bccf-eeb1-40f9-ae03-8fa19dc26f5a@gmail.com>
In-Reply-To: <5529bccf-eeb1-40f9-ae03-8fa19dc26f5a@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 30 Sep 2026 20:40:27 +0200
X-Gm-Features: AclHuK_0GARABAIMJVutxrBtiN6ptjGq32Jzs_JAz9tqH9BHGYRsAXQMtkJPMEs
Message-ID: <CAHwyqnVt=mSG9u6a_FtuqHDSM+8RVKRNmow7f7MtDvFV4EyOhQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] ci: point test failures and fixed known breakages
 at their file and line
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:56=E2=80=AFPM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Harald
>
> On 30/09/2026 07:09, Harald Nordgren via GitGitGadget wrote:
> > From: Harald Nordgren <haraldnordgren@gmail.com>
> >
> > A test failure or a fixed known breakage gets an annotation that names
> > the test but carries no file or line, so there is nothing to click
> > through to from the GitHub UI.
>
> Have you got an example of this? As I said in my last mail, I can't see
> any links in the output from the linux-leaks job.

That's poor wording on my side, I'll clarify.

> Why do we need to escape the test descriptions when we haven't been
> doing so up to now? Also if the test description is a single line why
> are we worring about '\r'? If it is so important to escape the output
> why does this patch not convert the existing annotations like the
> "group::" on in the trailing context lines?

Yeah, that can be simplified.


Harald
