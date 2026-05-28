Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7321A262A
	for <git@vger.kernel.org>; Thu, 28 May 2026 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779929027; cv=pass; b=lzalyGXDuZsXGYAii3Yq3Ga7/Jf30c1Y0hlHsAl1j1ha/mPpZnc2gAezjoMUWxqcjoh3PnTU9OWRtF/MCqtnZEVWKHdtAJE9ukMJW42M7SNyLJ2Q+Bq+6xJXJBPxXwmLwGdQrdkLD4gFj9b669vlIncx4WR3JxcSgzaCwQdCokw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779929027; c=relaxed/simple;
	bh=TU+LW1i8Alfty+zHmhgjKbFayvaWIofqQj3wBfgr7zQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgqcDLewNF6qYKfizWLp/llwKRBKxtaVadwpLxgrNau4GaUH8WSsoLdVhtqrsbrFoUsU6Ayk1eOGGa2cpcQkkaSBPqYWP5Fjp3p2hLkl2YpzVkiU7OLNLwBC4DVooJjgp2kY5raXDXRo3B5y/TnPWQZTHaM1fZ3/itjql0T9sRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3FM4DjB; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3FM4DjB"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69df5352d0eso136546eaf.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 17:43:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779929025; cv=none;
        d=google.com; s=arc-20240605;
        b=a3sBYlinQZGJat0JyUMv91YMBHW/N6nsKR7FnKB4reKYrkIlMSJDzckGhs5TH6isNf
         WOD5czuNNKGFPCNAu1Qnh/xiOil53PFmdXwzbQ7zCycB1biBotOz4SRFMBiUxJorWeyN
         e+McsvqtabE4B4DJIx1Zph1/VipFk266wleBq2ssWQ1MvIO/uOqjvTIeYFiwzUB5jecF
         8T2LOMPrhTfF4rx2WKFODAzJxBuSlVS3xdb1tAgUl4x2TdfNEXUH5dz+lY+P+btDIGWM
         wvT735jmWl8gs5yWb2IiUwQoX5iZDvdNG6waLp/nP4zWhWtOmkRrZMjhUMAKMlvmxOvK
         tPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6aD1ms3pBSrGIi1nMKx7flkyDvcE8MTZy3yY8X+CBqA=;
        fh=rkhRy1Bs+h9prhM4gDAf3kqmnHac5faeazeRDO4Qev8=;
        b=K3Lxn+AudsMQGWzFTvZJSRml+0a0t6Htg2pelBaxNYMUpzn8Pq5RWsUyIl8xtEqOrI
         irW0JujHw/sdhaZIgFcJ7m11gydLa6lmjJ7rYBa9RVVcIGtLLz8OpheM2AWiaMJGpFvC
         YxmtRHMEtWlvCZ1GP23rSdCJGCQiHUIJHL1S3raLBv79aIyAwflDUqGJQvN7W/sTcDnX
         spyYKO4L0vljiYx8pBN1yW3ST8euipvGJ0IDgIoEjOFufYHP9yHPjaQaixzavn3ChrUN
         1g1X7hS71DQ1yQM0Tq63pryRBSSdE5sdLv+CIATnTLocYYYls2FjS5PapMwtTFAMFhc9
         70+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779929025; x=1780533825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aD1ms3pBSrGIi1nMKx7flkyDvcE8MTZy3yY8X+CBqA=;
        b=b3FM4DjBtx2ex1rlaK/laoTR0c7bfRyfheUwiLiYsa6POxIfxDiZ6WAOsmulgbKbPc
         3V34pLDpt1V4iciDGBbVHZ6akkmWemFQdLZXgfT0C0Ig45J23VTITw5rUMDONy2Gbqlu
         ChcsrdubHJ8Dc7DT0oBVEe5aGZsBITLKjCxfpd95u6OiL1P01uBXDJ7MnHAUU3au2cU6
         XF6xFmNdDH3KDOx/bnXjWpA1e8NL/aorbvOqD/UXRED0hsBpHMdghBq62NevMwH/OJs/
         R4bN5ubfIXeA7AuZKVuSHYY5oaiNIwTUcPEGBi7kQ3tU+Ykq4FT7dH8cXP8cSqT3azN2
         o0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779929025; x=1780533825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6aD1ms3pBSrGIi1nMKx7flkyDvcE8MTZy3yY8X+CBqA=;
        b=TcS0zQGT/rpW47/T247kJGkiA83TtJwUkcBIr5AN+moEV1+tnSxp+NpuCzkB9/nWKp
         oJqmfGTCcVubD21+PlN9lf4GGq47n338U1yTqzqfbJWzwN8GIqCf/6pmGrK24Gv196GC
         nGLrdTVIW65Tm4IUX2lxOvRjoAkvopyDcYdFgDC4G+fuxTEyQNSGE7lpfY2rZG1VofRT
         3GZgGl5tEmDA9mXPtavYuRc4282/WkJbDeP+cEbYv5ObiWdMo7tmG55H2maqwE8bLCOH
         ba3OlfGBjiowZfc87DBP7Dfic3Nrrn0WfnVCvUn2+dVI/aVY69NB3zKq6rweDwftK/9X
         M/zg==
X-Forwarded-Encrypted: i=1; AFNElJ9LgGejg/kiXgLqLZOKQ53rTNIHQ2fLLmBZ7QDzK7id18mawFfTHlKJw2ytVvWcrHAFL34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNVFPLKrwIfQ8Aly8MEQabdpfq70QdnAZ1czq+/MiQgt7EVFOF
	gTlv2d+GnZ1R6Z49F0VY+QJTAnS8ovvinfFFcRd+qiQsAFf7KE0GmcfH3kVMr27FAO8QXKyAg6b
	Nu5LlzLQq5CekJjSzOMLRaFoMYjXzyhEof59h
X-Gm-Gg: Acq92OEDjpR5f9ria/O4/Pnv91CvpQbvhlm/hHbM1h5U50BcabJrxQeMBkeVnpIl/Bu
	PsECEsEPFDRbkzIm5N1u9qQYTVw9wAn9EU2sl89Uwv4vAf1IaBcOFkCNydAgsippT7vmSU3g3CI
	1FRaDsmuz3QV5OsQRed3KE9p2sx6NkwVuvbAoAa+AGH7r/TuI151RfFXFFanICAjd3m3LPuc6ss
	cBjrrfJwpU38ZiXzk1uoli3JUJ1YfLgzMzz+DEL4Ts6utdXmBN85UnsPp1MeoERHOTrQanyArjG
	+q4fHhb1NXcMe4g=
X-Received: by 2002:a05:6820:16a7:b0:69d:e9bc:5893 with SMTP id
 006d021491bc7-69de9bc5944mr1974161eaf.4.1779929024851; Wed, 27 May 2026
 17:43:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20190226215348.5119-1-jacob.e.keller@intel.com> <20260519083559.onq6r%taahol@utu.fi>
In-Reply-To: <20260519083559.onq6r%taahol@utu.fi>
From: Jacob Keller <jacob.keller@gmail.com>
Date: Wed, 27 May 2026 17:43:32 -0700
X-Gm-Features: AVHnY4IDTd1F5BIKykls57mbNr1Xy9jWdGc4xHZaS7AM-rCuOSFlQXtjxCnMCk0
Message-ID: <CA+P7+xr0tP6Ft3qPwbkxNRgNB2a24_WFC+8DymFnm11Ks=sf5g@mail.gmail.com>
Subject: Re: [PATCH] describe: bail of --contains --all is used with --exclude
 or --match
To: Tuomas Ahola <taahol@utu.fi>
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 1:36=E2=80=AFAM Tuomas Ahola <taahol@utu.fi> wrote:
>
> Jacob Keller <jacob.e.keller@intel.com> wrote:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > If you try to use git describe --contains with --all, the exclude and
> > match patterns are silently ignored.
> >
> > This results in unexpected behavior, as you may try to provide patterns
> > and expect it to change the result.
> >
>
> I got just bitten by that, and yes, it was quite unexpected.
>
> > Check for this, and have describe die when it encounters this, instead
> > of silently ignoring the provided options.
> >
> > Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> > ---
> >
> > I just found this while trying to use it, the patterns weren't being ap=
plied
> > properly.
> >
> > This is pretty quick/dirty, I haven't had time to write a test, or anyt=
hing.
> >
>
> Would you like to resurrect the patch?  It seems it was never merged,
> nor the underlying problem fixed:
>
> ```
> $ git describe --contains --all --match=3Dbogus
> master
> $ git describe --contains --all --exclude=3D"*"
> master
> ```
>

Apologies for a delayed response. I'll try to look into reviving this tomor=
row.
