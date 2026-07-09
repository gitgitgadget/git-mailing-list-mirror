Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109CE31328C
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608538; cv=pass; b=OFgO/an1WJTt5E7JG+4j7dLvadz0a/1j08q4cdIWUB913to3RbG8zIBXEN76q4VwUisFMGXEA1of3ZQFndF70sCAaZ2MVmY8+EQPKYtI+DzxGXEUjwiuYEv029ustvByS1Sf4JW9yRWwjOsONdQq8rcfNswKKdA2n4uocxowhcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608538; c=relaxed/simple;
	bh=lbGmwDal36TWG6nO3SXC14RSBrWDTeEwq69BP++R5vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A+7SL/zNC+U5oXD6qA8ciUaC+oyNDeirzqKS3IGnNslHYUhNC9WgRTWEnUBxIS8SJx21R58t8pkhME5wnqMTrwcIm6eomtemdP6wOPY19Z2ghZ1SfkN6u5YdlDpOeG2X0wJY5gO4AahmBc+cBFKEAREWy25V7Yqo2JR8V2pDWP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=EjSAV+0S; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="EjSAV+0S"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6647bc8f900so1714527d50.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 07:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783608536; cv=none;
        d=google.com; s=arc-20260327;
        b=XCmHQkUNTbLGEaqRYsiJUYMoE+iY8kOxW/3q/ikqiPljceodfXoLFzjk7hwXy/F792
         ZQGWx3BZ4dun1O4nbAOkqXtu4NPcuI69PfNINbkaj7YcT8LxCyPier57q53yCYtTiXoV
         7NweP3pER7pbzvAzsV+s3hh4IFMV3Ds+iiZWQ1Z27JOCnSBCRx7QqZ2PsycalYoUeHcw
         0LwOU66O/l+JDqzKT+1ZwCavw3vsx3fWP7XDUGoUH0BzLE4+I5Cvby9CDG2RlVBmIuI9
         J+7e9ZjWeQd2fokQ6wf9vz4HefRmsbW6bnwJjoxk9fVSXfKlLW0hWfLZnooYhV33x2vK
         JWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y0iCR2UBnXmzy4YK+BN3M6iv23ChYdtXYGOWy8lTpas=;
        fh=wH0Et2MRDzdFqohP+iZSN6SA4SeFK+CO4/su9//BY8s=;
        b=ATU5XHLd0pl87EQfGQzjDtw5VZhGisMkIVrki9JQ3+raV/9XO4FEjdivPsCccNwFuT
         T3w8j64foZhv1y2irnadc/isgOMGAciwQyWyBM0zJ83Qy3aVrPpKXnnGCtVpTV9Qei3U
         IPtyWCAjeYi1yjnzjrAtYMkUoXesHB6FptnWWHoScI7dHN0TT6ZAIGXtOgA4l8SL5cRT
         YNfrGoE3wIuQlNFzK9WgeRGHF6TSIiUMs/o4qqAAVDwRBLkdp0o7JJ/1N91M40IpxWyK
         ihoxFQpNa4JAVvJzEpt5Apg0jS+L028p1mrKNYs1OrO3hO6VVy6nezt1OBFHbsnHjRTZ
         dJTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1783608536; x=1784213336; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y0iCR2UBnXmzy4YK+BN3M6iv23ChYdtXYGOWy8lTpas=;
        b=EjSAV+0Sjo34ZbCXaYs6J64wU2W/tyd6WLr3FWVkVldp4FmEAVuym3jc3GfY8g+h0h
         ao7hjebvr/9G/h/P7DgCcHAFPQ5DahZ0LCMk9LDurL3gQBuYcE/ipDzOpfHSpH2A5vCl
         FUWbKwrnFy+8TIhOLUSGjgxlEcC4u6H9vf+r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608536; x=1784213336;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y0iCR2UBnXmzy4YK+BN3M6iv23ChYdtXYGOWy8lTpas=;
        b=FxRR55Xn7hakrsSc2Mt+Qlh3heJRLqXrema/WrH87DzQo2rxRDC3huSolc7JONZEfW
         bZjgrWyKwuzcnhrMKQqOk9sJHlDTa+UOAYVs++Olvz9/2OS62B+QhIeabXGtv76/gwyi
         jKm9ZpVKl1GuR/N8EHB2IlITT7XryfmML9ss6pOv3YAEOzeuPVKQ8Tlg/idJ2aPkH4Sv
         oT+LKQLky8rGvAUOua4KxPP5h+1usjWrsw78jLhAqg2MApm9RIeSri5Ky0e3USDMmbX+
         en8LnwzsTgI9E1LFadp8XsBuYzgqxYXhXPXeQ4MnVXwTZxBN5SfSh9VkGMNq7VK4W9pe
         47uQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEnuZamYujPcQIqhwFDZrrxXRh/jH4GLtgHBtd0jnFxExhix11HLEXuLq+D8HatZBIIww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkwq80+aogodC4T2GxYMgVk2JzXM0XQjYJIm3mTTg4D2+oK2s4
	sHfDw+4gS+oM/9QNqLjeEIgvGtkNWvh2rXmc5e3hERNg+CZwh/13vvs7oMW6WhNn2Osl86IOozv
	nx5pj98+ilBUBFfC7jF4wRXjHFHcd/G5vegcZsmJsyQ==
X-Gm-Gg: AfdE7cnxrThydgYRqR5zV24FBN5nWU9WVVzvzt1choBZ/dhh4gTtrNZ2OB5u+0WoYAG
	/L6VPNr0KLr2AigaNGebrfv39X5/TINijmrwkppA9vBVsWQhRXuL2Hk/H4HK+w33wr+igLw+VEI
	rRmRWP1K3c/Rn1PYHTA2KSf4DjR9RkcdIlnenHfbK5/yq4CExaosX1Dd8/yGwKDhTj5NRkcCcSS
	V1BbhTD3ZvsE3T0HkVc2zKVljhJB5GsXWlmmw81x1P9e8xyqtHFfy/I3dHzJxz7pPH6JcgXfg==
X-Received: by 2002:a53:ed0f:0:b0:664:d93f:b5f0 with SMTP id
 956f58d0204a3-6679f1d50d7mr3401740d50.50.1783608535886; Thu, 09 Jul 2026
 07:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <pull.2166.v2.git.1783598912.gitgitgadget@gmail.com> <c13f15ddc20f721443fa1d462ea1b7c2356fbffc.1783598912.git.gitgitgadget@gmail.com>
 <ak-n6K4heV2kHviZ@pks.im>
In-Reply-To: <ak-n6K4heV2kHviZ@pks.im>
From: Kristofer Karlsson <krka@spotify.com>
Date: Thu, 9 Jul 2026 16:48:43 +0200
X-Gm-Features: AVVi8Cc2mobzPz5ulXWmOq7P2K3d19TStgyFIDX7mOoFs3r0zb51_drLqVTjv0I
Message-ID: <CAL71e4PrtZwB8TMg3eBj=LzC7ik+C8yxLYEEEP7SDgMPiWSs0Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] reftable: fix quadratic behavior in the presence
 of tombstones
To: Patrick Steinhardt <ps@pks.im>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Jul 2026 at 15:53, Patrick Steinhardt <ps@pks.im> wrote:
>
> On Thu, Jul 09, 2026 at 12:08:31PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > diff --git a/reftable/stack.c b/reftable/stack.c
> > index ab12926708..fd7d8f3f1e 100644
> > --- a/reftable/stack.c
> > +++ b/reftable/stack.c
> > @@ -337,7 +337,6 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
> >       /* Update the stack to point to the new tables. */
> >       if (st->merged)
> >               reftable_merged_table_free(st->merged);
> > -     new_merged->suppress_deletions = 1;
> >       st->merged = new_merged;
> >
> >       if (st->tables)
>
> Okay, we still retain the field after this patch. But the question is:
> how would libgit2 now set it? I think we should rather extend the
> `struct reftable_stack_options` so that the caller can control whether
> or not to suppress deletions at stack creation time.

You are right, I (still) missed the compatibility problem here.

I started thinking about a way to make it fully backwards compatible,
but then I looked at the libgit2 repo and realized it will need
updating anyway since it predates the reftable_stack_options split.

I will add suppress_deletions to reftable_stack_options as you
suggested.

Thanks,
Kristofer
