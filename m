Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792971341;
	b=NVVw1Fa5A3z6V0BN/70hKzPC9uxPPohuvF1SoYjWmyUuzrJOlRJ5JP2hmppFLaYHD7VH
	 1EjanQ5mmHPPAHew+SEyD1gF8lYGhyopvQMvewcm1oSBciu+xSNqk7zXSBCMYSEAKijg2
	 3MFhES+namJ4sG2Tl4CCNz3aba99AG5Ig+/QwwpoTdW1hTT5NP4pUEs62KH10fJdBLrRw
	 qRYWLoqr0etcIU8hfiHH9UsZ3PmTy3HFTiCyb+cnSgyoUB/Pd4RwCU8iHZViGGqa4GqeT
	 7k0zBOk/2V2b/8Qmm2iNtX/N6MgM3PdnnoKAqRzwkB7SUiTJ8gdsr+uNwSl9LZQ0XfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971341;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=To+x6dFj+Enyt0NpaSPHjAkVe3OA6PcFfdcYdnAppl0=;
	b=QNOkxNJPA9bu47CAfbPnmipX1pz01d5ZhTKp87R+sNyIA6o6ae22o2wGmfDbtU/mx0Ih
	 FiBXZNyxcKQiHqKH5HEIRpVBiroHVH+8oYrDQ2FBnWhJZGaASVqT4djab1cknnMQ08AYG
	 liAv1To0MEtVv2HJvHXZtbhAc59iPKgrs6sRMBcDzWC63sZSrjHgyNzbZdDt4IoGGekQ7
	 KjgXkHgOH+XjqEZlFpdfei7tGy+65+r4yfDM1gIqOIvnFcPNHCzo3f/hDZD44Eoha6i3K
	 GpzNsHUgEwmONLm1uptqDlTZsorq7eX5vOuianXGsdemme7rDK9t/aLROCyO+5SCRBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hudcZ4et;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.179
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F263606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 23:35:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F263606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hudcZ4et
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5364d86f7f0so32260061cf.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 16:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792971340; cv=none;
        d=google.com; s=arc-20260327;
        b=a5wDAS461B4pFMj2b0IysH8nhxg5TvK0v3zs09RMs3oJo0h5/N/vLhv3DFd8H80fJH
         anvvHHBJGWTec6VX2BBjoFGSFks1FtBYnzjMPLQ5ZVbLXi997yvzX1QZLicoYhm45cg7
         NkEqbniTmwlCAeskNxA6JTQkO01RUG5GIPyAfZ7pcMW1hKB1ZPfMe6GzfZo+T1poXf6U
         Q/+zBMy2QFjrFJ5rw1IuKPCGs+BPAFFP/BEREF/eq+/xCDEXNDuGWCrGTqDApFba7mib
         3PZqRzReQN3iH97Jge7iuIxU+s5nVr2tbx/rrx/hgg0eJQBHF/UEHlqmujH9z1gRolLt
         yo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=To+x6dFj+Enyt0NpaSPHjAkVe3OA6PcFfdcYdnAppl0=;
        fh=Lp104/UWeXhWG3Phrqyv2DSl+ObxqqSY6/sP1v/kqp4=;
        b=hY7BCEF5XnRr38vJmczrnAChzsdcZ0Zgt1De6KlTEAdXQq6ApsafXPF6C2gpn4M6h4
         sNITXwCop3R+NdYz9f8Omy/85jUhviSxAkm05/p3oR/3BYg6JspIhnO2oH/k87ybxJcB
         2lfsuheLQwnjpfIcZGi5NDCROIyvb9tZrf45NGk/RMLrVUXeRTSaTRHupo6njGRX2XpQ
         Z2qTJUwmAjh8iLSGaa5d2ggecsAiKLNUti91A5ynSx51ShCStf5jSzmn7H29D7H/OokE
         rluKjnXsUlS6w/PUtJaYVnarIB1RLZARKMpABIb4g1esJYl1SQoh5/JNQIOdZpnc/fv4
         Bwtw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792971340; x=1793576140; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=To+x6dFj+Enyt0NpaSPHjAkVe3OA6PcFfdcYdnAppl0=;
        b=hudcZ4etSftkiDRn448bJ6I6bDo/hsNnh8ZAnTdlQvYSCJkwLE2YEmLM5ytw5wynJd
         ta02C3EtQJl/8eICCpOJk310IWGWEdEdCw27TkZIiGueCx3mRl9c0oAcI4qV9rrp0dMi
         R4YRpXpWgAbRt/hf57QCS9xqOY5LkHy4RXq2ko5uAEj+kTERm3MOZudF40K2NbPNjIa8
         WstYIx3Y9WVFnmnf+hZwJQtq/ysncaC0xOVHzIW22jXRQS7M8sDdg86P8/DrflfRJW0F
         E/QZvkVlGx+ieo7poqgR66F5HbltGDZxIz7JC696V7ehQOe3rB3epfP1HXHeABdXk42M
         Fgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792971340; x=1793576140;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=To+x6dFj+Enyt0NpaSPHjAkVe3OA6PcFfdcYdnAppl0=;
        b=Kgh4S8FCxQ4pNQM84gsZHly2GsBnlGLd61O8MYh7YgroFJQK1C2VbRtW5yZPlesKwp
         AMziz8dtpmlKupPGjlBjFw5BvhVbzSlFm//plnSCgMnm5R9PiSy0egLbzXTr6Be0SFeg
         hN1ZTya8E3toEuvqUE/0igtQdypi5Sf28sWvWPbkH9IQSBNCPfbJs+BVgu0VS+tyb0Oh
         zIDXzenaTgvEpOZlYazlBEBCYdhPh3BJDfe5EV6HXVAdWs3VAeJ6pT/shZUiJrGRnly3
         T8OO8DeXuMdzN4r3byrNhjAk1LRwEHoKe4yE0ZAQcA2zbVzoA0LUD1vrwBhrRq1pkWl1
         Y63A==
X-Gm-Message-State: AFq9FYLJSapU856xZeeNwqoaK5L9Iieza1g0tCX1hHtF3N0DzJd15nZa
	wo3SBvtIPhBc+jIBNBMLAxn7N2/erCqXy7urR+Pqf9NvzsXgp6be//V/j8TzN+u9zJQ7RCj9hLQ
	r/5kpe3W8HKza9wpdecEAhKfd0EugQBY=
X-Gm-Gg: AYBFou0aI6+icc3/0KdOaMmKqSriwIlPWdcGWI0cXx6CtruNa8kFOdIZqaV1nuDBdTj
	U6POIK+bYzmAP+v36dlI94NoNuca60CrMcYCfmp8NmycXTeCQjawpKSGM+vwQU17LwVSYFj8Hda
	ayBjFCs2u1/uk9QCrfK4bG4XXQW5o4IOFCS6UdiaLEz3Sg6t7DcBx/y9mun1wbV9YVsnrpnO2S2
	IbzaKcNgm7wu9i7qSr7PI/OD4vB7144ih7sjMprmkGxG9vQmENDjx7xV0saSUhggl3H4oroK7Te
	sl/bJxP+Gea2V/st3ZfqzC/m+Wu7flj8kcT6VZTqGHvT3hQ3AnEt/f/l9yI1JuqOnAoyM1880MH
	JAA0ZuXzlgnTyWj2oWx2H+Sov/OIlCdLQV0OanC6aRHI+lJa4mFqdEQyg22jK2vSPYvaLbkZttb
	/eUfrAb0YeRZ6l/touT95mM86Vcbi+bKEO/ltfWbPbbyqMaN5On48=
X-Received: by 2002:a05:622a:c0a:b0:536:1f7a:610e with SMTP id
 d75a77b69052e-5383b3d1c08mr70826581cf.6.1792971340067; Sun, 25 Oct 2026
 16:35:40 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CA+ew3JtPJuVNC0PR_wY=8Wxp4-JpJ0wCPvm+a=BdJ33QaMpJMQ@mail.gmail.com>
 <xmqq5wythc57.fsf@gitster.g>
In-Reply-To: <xmqq5wythc57.fsf@gitster.g>
From: Wasswa Edson <edsonwasswa54@gmail.com>
Date: Mon, 26 Oct 2026 02:35:27 +0300
X-Gm-Features: AclHuK_95mC2kwq7uOXi01BTRn3GU4ghHGNTF7TyRN3n9QfJ1lr38TcQyUS3Egg
Message-ID: <CA+ew3Ju1N0bCFkTzrop5+ckNCrgGWRzMcrLHu7DAYufzw7Gncg@mail.gmail.com>
Subject: Re: [Outreachy PATCH] doc: clarify promisor remote fetch ordering
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Thanks so much about that but if i look into the codebase, Your
concern is valid from a security perspective, but the implementation
already has safeguards that prevent arbitrary injection
Then about the Git server my say is a No, coz a server cannot
arbitrarily inject a brand-new, untrusted promisor remote onto a
client by default. The client must explicitly configure acceptance
policies before any server-advertised remote will be accepted.
If I am wrong let me be guided.
I am re-doing the patch again following the doc you have provided
Thank you

On Thu, 22 Oct 2026 at 20:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> Wasswa Edson <edsonwasswa54@gmail.com> writes:
>
> > From fe5f35b00eafa1eb2756178445d3e88c4e9d6787 Mon Sep 17 00:00:00 2001
> > From: Edson <edsonwasswa54@gmail.com>
> > Date: Thu, 22 Oct 2026 13:09:21 +0300
> > Subject: [PATCH] doc: clarify promisor remote fetch ordering
>
> None of the above should be included in the e-mailed patch.  Your
> MUA would record your name in the "From:" header, the commit title
> in the "Subject:" header, and the date when the public first saw
> this contribution from you in the "Date:" header, which should
> become the author date recorded in the project history.
>
> On the other hand, there needs to be an explanation to convince
> the project that it should want this change before your sign-off.
>
> > Signed-off-by: Edson <edsonwasswa54@gmail.com>
>
> See Documentation/SubmittingPatches [[dco]] and [[real-name]].
>
> > diff --git a/Documentation/technical/partial-clone.adoc
> > b/Documentation/technical/partial-clone.adoc
> > index 18718a3840..a1104930fb 100644
> > --- a/Documentation/technical/partial-clone.adoc
> > +++ b/Documentation/technical/partial-clone.adoc
> > @@ -196,6 +196,11 @@ filtered `git-fetch` commands from the central server.
> >
> >  When fetching objects, promisor remotes are tried one after the other
> >  until all the objects have been fetched.
> > +When a server advertises promisor remotes via the protocol v2
> > +"promisor-remote" capability and the client accepts them (see
> > +linkgit:gitprotocol-v2[5]), those accepted remotes are tried first.
> > +After trying the accepted remotes, Git then tries the other configured
> > +promisor remotes as described below.
>
> Just fact checking.
>
> I thought that a remote Git server cannot arbitrarily inject,
> advertise, or force a brand-new, untrusted promisor remote config
> onto a client during a protocol exchange (such as a standard git
> fetch or git clone) if the client doesn't already have it configured
> locally.  But the above description makes it sound as if the server
> can advertise a remote repository that the client does not know or
> care about and direct the client to go there first.  Is that true
> (yes, I am wondering if there is a security implication around
> here)?
>
> Thanks.
>
