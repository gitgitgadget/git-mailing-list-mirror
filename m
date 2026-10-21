Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792600223;
	b=v+Az3RDYGXN4/ZK3dOBo9wYSOwakfSw/lRzrdRocjdkaNMsW+HEHEPr2x8uoZikBVtaD
	 xSI3w145tHde7gr0w8rN5p9VIU7TUGUOq4uHz8P5jpT6lo0J6E1l0Rx7DaAdavgMRsxGw
	 tOxaFC38f5iDA4qhIS5mAEiD9oE79S295X8eg3TW6Xv6SmW0eBbWVuZ/ylDc3imSZLPJL
	 Gv0pqJWSDwZhPK6sWdb0ESH6/0CW2PdVe1WtBYdgkzIENfrqIsv4tcedYXPYaGWhaDpmT
	 iMSC0qh+lrBvS46QOIwbajBs5X/SC8/wbHr13mQOQPuiB0Rx9OWFOTVwopjBLaFZl1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792600223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=Dca3ytG1k1JNx9h9yEjkEWF1nZ7xLJzwdtSn/4lRbs4=;
	b=WDU5JCxB5PRxTA+6cWUtt5uqcz6evDFNMALlldyXzIuKqbhanVMO7fvCx/lTKBqJXUhk
	 gempXs0ssrr3Ao9Y2gPRbbNlsDGpg+cLgDo3wlvljYWDtv/64XidNQ95kxZqhOsrMgnm3
	 iy9ad7jIQyMwrxk9zvzyGQJznNEdEgqK7vTItDSsy2X5cWfpxFMjxWj3Ve1Zi8pnjzNSG
	 e10PsceWZRkguXQ62qzHYlJ5OovwVjvpFs3k04/hORD3GrOvPZ1SK32i+8ex2k4OYzJJh
	 ihOf1qbNGC9fRMTF83gE3jmhcWRBpiv2Klt7/yEedaefrrVasDPH4EsvUWCoS7oiZzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jvetz07Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C275606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 16:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C275606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jvetz07Z
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso609181f8f.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 09:30:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792600217; cv=none;
        d=google.com; s=arc-20260327;
        b=c6RZqdSpDdL5Ae/cOzLCOfI8Lg6uQcGBauat7sITFjjJOSBVeZSldZ6fudFLma0pdO
         f6xqMm7IQdbFw4/zMIDPzmSimeaVZdaSTZ+r394BqeYsQGMm+8or7voclGd3suGmslYg
         34EgaOtWqhpwoS/IYVEKYCQFOT431LIS5cLpPLCB/uvYS1MuwWWicAiCX/Qd80s+pvdO
         5MruZDMPKoGaB0zP+HTx6R+SLNz1ePorSE3dpqQHZk20Pc7agqkdcRdOzRE6Ty6XhyWy
         T6e7Z8SIko/S4uG4imG0fRuEp8nXGrQ8esW58t98Fj1lsT2YtNn6qD5hgl3nFqKOeLfv
         cfNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dca3ytG1k1JNx9h9yEjkEWF1nZ7xLJzwdtSn/4lRbs4=;
        fh=sVgKgjB9N04xse+9v6U0NavDcrYEIcNedOh5+NS8TR4=;
        b=Xw1f2D9tSrIutUbWboL4RdizzhF8JDylHU5X+MqnW97bQohCHBKaareyomwfcrIGlw
         iYvE/2DCXRSJji/MkufrZpKfuiLvX6/kI06EEhASpcFscBjVd8vaQ49S4nN+sG+huD/M
         VJC1hK1UJDrz04eZyJPcDJAE9GWL8XRM+nImqVDXL3k7DhTy7RmfZ3nbblybQtJ/EP1w
         dHh7esT+k6GO3kq6qNgfk2ovUznapsJAIdjW8a8gsvwRwXdaVhRM0BPLEWQFUGb8GT5i
         2zU1FdCyzmAhYZX9yHUHDRo4ip9b09dwmKvx/cF7KkwKIQN8YGXeRrsYKyVByoAksb4h
         QjyQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792600217; x=1793205017; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dca3ytG1k1JNx9h9yEjkEWF1nZ7xLJzwdtSn/4lRbs4=;
        b=Jvetz07ZhBLBf8G82o630MJbkheM67zdB9zVWGVhe0rO84jpcPTsg8ISTNGJJuT70s
         CG6PNRgO9xKDelfsJlzvvHLn0Kg8H9G+AM/ikM4RtPm1qKpejtyInbBQTzWk3284rU/k
         AuuA06Sg6zYeeWAEA59eKgBRUxoA5gy2nWiJSzzkW42r/0FxinBkaJqmnLF/67UlTmst
         kKDNfajjkURQwH2uyml5izYJl4Qm/7E2m3/wv0y1SZCV9uj7M1I7fZ1cxzvLXUJYCc9I
         Tpd0URAKGkSO7MhFWb/VGhNVOZfTDZA/g0RLSDnVYhu4nLBOh5rT3la9/GecMSGznmQb
         IOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792600217; x=1793205017;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dca3ytG1k1JNx9h9yEjkEWF1nZ7xLJzwdtSn/4lRbs4=;
        b=bAb3N85OAKtLjXWvs2J+0Ht/rWo+ke21CErrBwyc+ZRdqc5PLb/yWx9h6pvCvdyxqc
         dqJAcksgL5crPSnzX2NxJDu0W52nw8Y4mvKQAJWihqMOBpp4Ug4LERMoPvp2MxPk+9cm
         7isnBrrWLsF5ushDP1jEPSFgWtG1IT3x096wqiSZEzI8UtH99E+Og9e+b+SJtuTjNwsq
         hRHCIA6+zGqwnT7/GFqOP/KIL7ZmweXWZbyDspzPMTrGkiDNsy4ZqDFB8BrRwDez4O5g
         wdjftel+d93vq5Mfxb1ELWrjj07f2WObqWCqW2XDa8TvQpU533UX+UXsODiJ8xRcTA/N
         nBQQ==
X-Gm-Message-State: AFq9FYKQFlS84/PjFGNRYoVCGDgI8iaT+L/xQoLPD3ZBE/6pUV6nnZV9
	GvM+sDql71/Ls2ZL7prPoPA0WdSnp8gmYDkXgg2VVlZTidit3LTBqBzZLqlu+F1EbyTtoh+JphI
	luU+JA8GIo/+J8a+7YbjcnBCl5/X77ls=
X-Gm-Gg: AYBFou0Pjt9ixRvGjcEv4LUnCqdzmNShEHkMaWYroZ5vRNUftuMCSc3TIScCf1iCUTp
	+EjwfvdbHTNrWUBALqwFNCN1NXomBkD1cb1G4XZCQTmndl7rHSQ61rBEYMG8YEgl8ut7b3ieWQI
	Oaqi4nL6AlQsuXo1WqBU59kV9aZZpz49ngyiq/F/bLlLQPZzCG6YyrUrrcnzxbrHGGm2GWaSSMl
	vX2zB62MShSphzJvMia82jJcbVgQbWu4hpPaROEAyBh+Crl+X/nUUbMY9InZePATucc6Xadi1jf
	7eOulTHt/pvbvNrYUxwlKgDY5TqFQtHILqFhqGg5CVTq78yPHCsGQTK0ChipHGM5a1WEMMvkR5F
	gxbgCfq9ecLg/25IPMOWn6j6tRix5DesTehWuKQ==
X-Received: by 2002:a5d:4f92:0:b0:48e:1c2:55a1 with SMTP id
 ffacd0b85a97d-48e2650e700mr4015362f8f.52.1792600216336; Wed, 21 Oct 2026
 09:30:16 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261018235508.848-1-colinlewishinton@gmail.com> <DM94QXU2Y6J7.39IGDUTB5XN1L@lfurio.us>
In-Reply-To: <DM94QXU2Y6J7.39IGDUTB5XN1L@lfurio.us>
From: Colin Hinton <colinlewishinton@gmail.com>
Date: Wed, 21 Oct 2026 09:30:03 -0700
X-Gm-Features: AclHuK9rNVx0kDbekqw2FZsclbWI0XoOHdulonDlmugl2qu9JSpMDOMdCC74kxU
Message-ID: <CAHeTm9N4s744v0bgJJSbPoc4=1omKrhAXNuoY4Wey7FZBw-48A@mail.gmail.com>
Subject: Re: [PATCH v1] remote.c: defer remote.<name>.followRemoteHEAD validation
To: Matt Hunter <m@lfurio.us>
Cc: git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Matt & Junio

> I think a better justification is needed for this.  The intent behind
> 'warn-if-not-<branch>' makes much less sense in the context of the fetch
> variable imo, and if it turns out to be problematic, reverting support
> later will be tricky.
>
I don't have a particularly strong justification for this,  and was
already on the fence about including this change or not.
I likely will revert this addition for fetch, and make it so that this
only works for remote.

> > Messages for an unrecognized or missing value no longer name the
> > fetch. prefix, as the helper now serves both the fetch-level and
> > the remote-level setting.
>
> I agree with Junio that this should be addressed.
>
I also went back and forth on how valuable this is, since if it's a
typo it should be clear which variable is incorrect.
But being detailed doesn't hurt, and in the event of an empty or " "
mistake then it will be even easier to identify the configuration
error.
> >
> > @@ -139,6 +139,9 @@ remove the value for the `fetch.bundleCreationToken` value before fetching.
> >  `warn`;;
> >       Display a warning if the remote advertises a different `HEAD` than what is
> >       set locally.  Behaves like "create" if the local symbolic-ref doesn't exist.
> > +`warn-if-not-<branch>`;;
> > +     Like "warn", but do not display the warning if the remote's `HEAD`
> > +     is `remotes/<name>/<branch>`.
> >  `always`;;
> >       Silently update `remotes/<name>/HEAD` whenever the remote advertises a new
> >       value.
>
> I like the style change from $branch to <branch>
>
If I am reverting the change to fetch and warn-if-not, I will need to
revert the .adoc changes too, but I can make this change back in the
remote.adoc if we believe this is an improvement.

> > +                             follow_remote_head = get_follow_remote_head(transport->remote->follow_remote_head_raw, &no_warn_branch);
> >                       else if (config->follow_remote_head_seen)
> > -                             follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw);
> > +                             follow_remote_head = get_follow_remote_head(config->follow_remote_head_raw, &no_warn_branch);
>
> A couple more overly-long lines
>
I will clean these up, and the ones Junio mentioned, thanks for
pointing these out.
> >                       else
> >                               follow_remote_head = BUILTIN_FOLLOW_REMOTE_HEAD_DFLT;
> >               }
>
> By the way, I had previously made a comment about moving the definition
> of 'enum follow_remote_head_settings' over to the fetch file since that
> is now the only place it is relevant.  Do you think it's worth changing?

Given the change I am proposing in remote.c where the enum is no
longer used, I do see the value in changing the scope of the enum, I
will experiment with this and update this in v2.

-Colin Hinton
