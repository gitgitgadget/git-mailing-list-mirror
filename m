Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B7C338591
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094687; cv=pass; b=N3a00F4NEeqGSz1J7l4KiAf7M0ZBbA6LBNIbwHJ4rpgDeCMRjGDIrVpcZbCbR1w5ufVtDn2uqqq/Mm5IW2y+iAFCn2vPnk8hVBsGuGTpJgNe0AyG3UeMPWPcuZY3vIpfuttzlZ95jMl9mF68NGhSMrPJ+PWqv1HNoF9iG47+UFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094687; c=relaxed/simple;
	bh=nkdRw5tq2X/tV/S4eAmpuOO5qA2F/+y0rQgaw98oVKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5LFz8Ay4h5nckWWbPzLc5gPIgtRvbDxlCS4Yc5/ZIL4/i6tvMnbCqjpVISuQ6dbteske1T0AxukE3mfLrmnYOh0p7mHaAaIRVayljTOOA+n+qqJC1PSnTsMYIbjGEYJqxpS4KIYKjonODDear1CCL70fK9kGCOAGBikWLrUT34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BE80nNAt; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BE80nNAt"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1233b953bebso2357569c88.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2026 07:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769094685; cv=none;
        d=google.com; s=arc-20240605;
        b=YL07Tiq40UwTGlsSdpfyKiakyf0HY1YSv+EwuaeKU1nOuqbwSsEfHcSi2isnW9aP19
         FHLMtAAEPfbz6zt9Cho541PomLZPzkJoLSkMPw61yoeSUgsPh4uid0SIoqWPk2nkVsbH
         UvFzRf/naK+0AsnRXcesLpWvfqmbXh3QQcY7KwIem2QdqK9QloC16WtoR6fUtdT4z3wC
         W3P6A5y9Lr49eFmKZLrt0k0NVfrqssNsMeJsrDJGai1PR7XCPYcM3p6Kxgd8Xku1G2I+
         GS5xI7evKIWX8m05Byt071QIZEP+Cl+BGD26GCMwygzNrbzZCaCrutFDnzZv66I2Pxth
         9K4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Q6kFOUEnI62nQXHhQPS3D2HTdgOd+Vy29pwl6i1O4G0=;
        fh=SUtS5Uxcs1MaW7qAkYHaLrxMI/luGLAfuRKahcKGaig=;
        b=AVu+qo9i+O9rmUf4m14Q1JfJXE3J+tmV0VBd6oAQezQugZI0DPyXv5LUGR8NIE1iW9
         E5ERDWYVbzIqFBJriVVIJo63N8U6PzWM6V4PxT9haJfYL6jIYScxt08UQuJPZRNbesJn
         eCqhrchrQ/Jav1+OKX9f42O6+2UrrkW0OAqyT+Y0KZXS9k8qqBI3oYoTfOUEJpXO1cgo
         omTjmGqEnbsFacevH9eohQfBzFLVBB0sa99/SHGlnWhFqoKDCS6mIdZnE8lTTXFgLbtR
         rZoy4WEBuW5qO2KALq2tb6fpCtJtjtwofpE9kA9an3pPtNRekJy9tqmpTnzlhmUIiVOD
         yHkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769094685; x=1769699485; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6kFOUEnI62nQXHhQPS3D2HTdgOd+Vy29pwl6i1O4G0=;
        b=BE80nNAtCA+uxllEsm7pUJXd7cwLvMk006R911RTy59M6I9MzcIQJunwVjaRb9fCpZ
         yu3sZ1aGRJo7jmNcNoiCoOpH2LEpdVDuVike46/F6/sGNgVLKu+nmgwq4zv9pmGNJGGU
         7cbeHnuxwhwSEXSl2/FBmqge7MMdY9YnHxudDcwbrH2VUgALdl0fK6AY8j0WSug7LrPx
         dX9liK9eVzSVSzNjEfIVvq2Nc+TSv8F+uK59k9at5dd9PMSvUvjS5tjf/cIuYaQxdikK
         HetN2OVjdjG699q5eHzpB1Lx3WmUk8JAnyBrtXoxDM9s/3jFYp014aH+vkZNu1j/esAs
         Fa+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769094685; x=1769699485;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6kFOUEnI62nQXHhQPS3D2HTdgOd+Vy29pwl6i1O4G0=;
        b=hqtV/RcOahaXWmbFA0j9J3pn1T8IK1iF8hxvj+TVINQKUBiHYR/D3CFzrMosj0EZtC
         HAnworzHK73um2a0RyBWlepSCFCLR/9vnz/Fx/lJAT5WeIYrfQHCAJi5n1UMIUvsRQSK
         SjIJNt6qjsz3nVobxQyYhXpVtS+JBVI99TD5wLrCLnfozlBdDh5xGReo4uTZM+ygGJLR
         gNfiHzb4DJDWNrgVeYH/TJQ4VnAdDqzIESjusxKL9NU73AetZ4QgO8kogOTgoRiPV0vO
         2MzyDwZkY5PQkxYHY1AJ+anAKbeUXbsVeJcNRTHTVPUSouh37E+nfvWa+J5YyDsPB7i2
         dUHA==
X-Gm-Message-State: AOJu0YwToG9x1tISbWO2067VZ0a4ab9F2XZR3nRvvWFeGO4OncKICBc6
	eB75p1i5WbFnIc/opeh4ySLEWmMrkg/aekpd0ak7duG2rw4jlPjisXhu9XiPI9iRWU69EVrDguP
	5RP3ek+0lTfpHssZxH0zY82Pf3+zUyLc=
X-Gm-Gg: AZuq6aKp1SKET00yYAWEcNcigwtPgD2Bb1pP5Smt7CANMBlp7H6qelW7d531tWM7Xrw
	nN41Q9cQFbdJOs5Ck3AveTERXCmvnEADyuO2dh3YU39OlWOPFyAz4vc2mcFItuGokOgrROGoVby
	ZlSeTzVTWB1+Kla3dHX44VGcJ4BB1ZyQUC72SaaTLDpo+9I9K4YA/DQqNgde03ls1Q8cxX5GKk4
	ngqyXAwmnjZTWiWbu/z7yg2wTSjgqt6NOQWlxubltb+ioWdfQtS8MGSkcktkdpqgMVVGMTxA2g=
X-Received: by 2002:a05:7022:608e:b0:11f:3483:bba6 with SMTP id
 a92af1059eb24-1246aa78d38mr6909412c88.13.1769094685399; Thu, 22 Jan 2026
 07:11:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768681947.git.belkid98@gmail.com> <1aa41da8334296e4c1063b81fc40ec3b1dcdcb7b.1768681947.git.belkid98@gmail.com>
 <60dfb907-c2b8-4fd4-b975-742f7ec18721@gmail.com>
In-Reply-To: <60dfb907-c2b8-4fd4-b975-742f7ec18721@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 22 Jan 2026 16:11:26 +0100
X-Gm-Features: AZwV_QgnJ3lf5zIUzDk_JKsQPX1gsoE2I9xgjMaZb3e2U3W_AqCzfJTWK6QGF2k
Message-ID: <CAD=f0L9BAjFeURkngMM6kzK+6_8TmLHy9zvFKXcz3ZYPvDG=_g@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 1/3] environment: stop storing
 `core.attributesFile` globally
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com, Toon Claes <toon@iotcl.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 15:40, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Olamide

Hello Phillip

>
> On 17/01/2026 20:59, Olamide Caleb Bello wrote:
> > The config value is parsed in git_default_core_config(), loaded eagerly
> > and stored in the global variable `git_attributes_file`.
> > Storing this value in a global variable can lead to unexpected
> > behaviours when more than one Git repository run in the same Git process.
>
> It would maybe be helpful to explain what the unexpected behavior is and
> how it is caused.

Okay thank you.

>
> > diff --git a/environment.h b/environment.h
> > index 51898c99cd..aea73ff25b 100644
> > --- a/environment.h
> > +++ b/environment.h
> > @@ -84,6 +84,12 @@ extern const char * const local_repo_env[];
> >
> >   struct strvec;
> >
> > +/* Config values parsed by git_default_config() */
> > +struct repo_config_values {
> > +     /* core config values */
> > +     char *attributes_file_path;
>
> The variable we're converting is called "attributes_file", do we really
> need to add a "_path" suffix?

Okay I will remove it

>
> Apart from that everything here looks good
>
> Thanks
>
> Phillip

Thank you
