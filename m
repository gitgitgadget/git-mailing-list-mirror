Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC281D90DF
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017047; cv=pass; b=R+36vYLcKzUWGMHuV7J9Yk2/OodMjAF7ckWkVQ9xEWwQqU7dPo8l4b+jZmvmJBw6aCI7dq+c7mHlJmI9UVgJdFF/caMcT9fuLlRDsUTFsVd6dLdpez631ITDY8bWOU+dk1z5lO7ai+gFgo+juDYlROok20OINZH+wD3vRJ9tKeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017047; c=relaxed/simple;
	bh=DG7SLdXAGVRMZc5jwmKJFjs/1BwWojcWJoyipxf7bow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VdNQMsH2yBGMMPHi/sV3Bmg3z84B5V5fn1gtF96EEZTQ4LXms+2TMU2rO9dzH3Y8YF/nJd/r6UgFdTnHok+X8Tk+DuqsGlspoSwuc8Nz1eH3Y1KGSeC+UM8GU87lTiq4zAdxeSAUT7bDYkXYz+jiIqoyR34yGuvWdjEJLnzihCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc9YWCAP; arc=pass smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc9YWCAP"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-56af6737b4fso1739434e0c.3
        for <git@vger.kernel.org>; Sun, 08 Mar 2026 17:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773017045; cv=none;
        d=google.com; s=arc-20240605;
        b=ctmcW2yWdpMQ7S2So614XSXSBcPA//gjKNMoRmwQouU1Zz7cGgilJ3IFckXvboif58
         d2ZwgxQYjuPT4w/cyG2AWHabp7rTs347c7RC7XsfoEcYrgfIHV7P2rYKM3Ijv0EV7BTk
         4M3lLmutpxp4323gtZxUCRTHKuiJUl1MVqYYru3t+bkxC1HhvZLx+1p/1tnHXbIIJ8Wp
         vtQv/rNoDzGTOKvbfni3TuRIT79ddMj/AOHRu5jR29JIBezE4IQTin5SRxix8l8mW9QK
         sB+NZ6mpC4wJpgfXicNUKvesIgpkK021ZGUd+UIITMkyklQwTLiH33OuMvmed2ke89iE
         hh0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e47fPDxVUXltAuymvnMJ9pPYv5+E5N+T+7pBs/VqQw8=;
        fh=l9w/CK7gb8pPgxsIND20cpOgEiDBd+vkaJjFjHCeOFg=;
        b=IUqnplTnQVxo1+I8RQjTm46sTN0rmXwnlVdHeYc2tXKYoMJC5gfT70Dx9s2uGxZe1P
         vM32rKMW+VFIIO87GqGHnyqAMa0kx8mBUGzOps7rrGa1kw94MgorYoiMBNSw/so0+YBg
         +Bkvqtl1pzYQlXI29TKaC+L754Dkj9e6nZfolfqCAre7NEM02LPw7UQ5pqYAz30vJXO2
         jpE/NXSDCtvJOvZ7xL2pdhEpuudAIxlt+JSrqHBNwBF59usIh/bmPkOYo8fmeEycNiMr
         UIpedd3nMDF+pAKAvoq7P44KS7//qqh2ijMwz1lNi8RZQLPc15yRwJmcUONWLkYmdwEj
         cqKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773017045; x=1773621845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e47fPDxVUXltAuymvnMJ9pPYv5+E5N+T+7pBs/VqQw8=;
        b=Gc9YWCAPduFq2zcQcXyJSBha+x7ibBF/R9XzfH03ccxa815tFaO9BFVMXQG6RGU/fS
         C3bbLxjbARteOVuCYMBmwH3Pr9f7+iPVfaFNjWnpRQVmuDUJCtW7sCbK++bSfpmlHR3u
         tzaDD1ErysoYEnslXF2FclyUBlotHt2vR0bWTGxegvsIj1BVMcaFnfnOqhYkeI7Fya25
         ZHQr3E9gk5d7OhY4ZuG8ZHzdK9Xvut4caCF14ed0A7do33dYdzyGyD23gZDv+aLvgi3d
         QoEC9rXGmRaiPdJqu3uyPYZXxHwaf1+k/Jdhs3RH4KJ5X5m04SfU5hPJyVN5tBWGvy4V
         JSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773017045; x=1773621845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e47fPDxVUXltAuymvnMJ9pPYv5+E5N+T+7pBs/VqQw8=;
        b=N136MdKD773Vd5IZ1RKFQSWjZ+KtnbZDa5Y6ADiyVS6H9HMSPsvCGNuZH7gRiRxfkn
         0ShkVYs/0iNV4m3izNS5IrtZr615F07ZFDPYGGa16R/Rvr4b3AFPLo8vkkcJVAXy+036
         nOVXbs7KauIEGhtCyK6CsYIjc7T9XqTqTEDlr26lIZD8O3Z0IDt4PsJmK837PVDErdgP
         V6CGmr253FIahITmOwIfmNDPXyky38BQ/Qf7J1qHEasjjMqywUsISlaMM0QSonO3fT78
         02wRpto6gc5YZJp4K8jgWSFf4sepOVYdvFXW1mAa5cLX31nODItePkYl7sylTd0HZwK+
         FR7w==
X-Gm-Message-State: AOJu0YyOiABaZLY6+W4PEMo1d5UgkocIZTvorFmbmLuiG7PjuOaIaAri
	Dw3pHOPL2Xy8pKVx6RH2aDgQIYKAzW1btTp2aiBlzn5dqHNMHTW/qetDXlwrGFamT1OYteYYNoB
	U4U/LNtcBvu7RtLMTeV/+TAl1JmJYtKo=
X-Gm-Gg: ATEYQzz6N/Ec3xbbB0j2nkkEEnH3wZuWFtFkQZLqgMDOMGMKeYC47Z4e8KtHBRXo39S
	oUANsYH6hqlfi5vjsYzVhPPILAsy5RcX8X/0eWytvUgC4JpPQkzriX3EceEgLUKwrdC92Woe4Yo
	H6SGQsK7eB0+JN7e1W6f5e8NgUoJ0wygfGOhVBz8pSXnqNf/rXh/k+p6N1E29ZbLKdwvemiesY4
	gzYU5dfaGWZDOJJv3vjGM74GKlvgX8LxZm700f6S8UDKFW+S0Azz1k7uo84IwE1f0/LBirYUCNr
	swAjw8HvPUN7wYPWoqghPPImTREhRSQC6V7rSD+xSSr7LyTNWw==
X-Received: by 2002:a05:6122:62a8:b0:567:44ba:bd87 with SMTP id
 71dfb90a1353d-56b07d487efmr3330009e0c.1.1773017045510; Sun, 08 Mar 2026
 17:44:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
 <20260305223248.170785-2-usmanakinyemi202@gmail.com> <xmqqcy1g25fl.fsf@gitster.g>
In-Reply-To: <xmqqcy1g25fl.fsf@gitster.g>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 9 Mar 2026 06:13:54 +0530
X-Gm-Features: AaiRm511uuZqaAIXK6a6PcI5nHkF9KLFIUF2d51KlynT2V4OoTfmkmbXJmAjCCk
Message-ID: <CAPSxiM83ejdkO5pbtHT5Svsm2iePtuEAA1UE0-H0Txoe0aNckA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] remote: move remote group resolution to remote.c
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, me@ttaylorr.com, 
	phillip.wood123@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

> > +int get_remote_group(const char *key, const char *value,
> > +                         const struct config_context *ctx UNUSED,
> > +                         void *priv);
>
> It is dubious to carry UNUESD over to an external declaration in a
> public header file, unless it is a "static inline" definition that
> comes with the implementation.
Noted, thanks.
>
> Other than that, move looks correct and it is generally a good idea.
>
> When moving functions and types that have been private to the
> implementation of a subsystem to public namespace, we need to be
> careful to consider if the names of these things are specific
> enough.  With "remote_group" in them, they are all good as-is in
> this case, and can go public without giving them "better" names.
Noted, thanks.
>
> Thanks.
>
