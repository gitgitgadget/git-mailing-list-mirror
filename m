Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94294C9E13
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790352991; cv=pass; b=Lt74b1cVLp9vodIKOSt0cOS3qMa5aRqyeG2lTF+ZIDuGxoh6QTezTOWJfkf7bauMEmp+TcLN4tHTScdlHiyxXUbcQ+TWU56tJxDiRap34iJp4vygz8ViU+YKKukldxFouXji8zJqAsn0tgI1dMaGUVD/8yJWR/tv9Onnxmn3/oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790352991; c=relaxed/simple;
	bh=frchCUzbI+qSk3sponC24xyMO4PTzdHDwL68o7qFQYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQbCr2euEYsX+geNN+ykjh2lAfZB9bh/0aFMbXSCrN1BN2U9BgCLcUdMC0NX256ocAeB/W2sheXx2zevQk6zJoyOc0vR898g8KWK1Th5YFD2hQvoHBtlTd7CVkTPDEpTKNazFJnN/CWzYwjX0MABljXSoSWXDiZbrxYH6n4xg5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5I77I6m; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5I77I6m"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so6484085ad.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 09:16:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790352989; cv=none;
        d=google.com; s=arc-20260327;
        b=RFYVhWDyKPwr6K1Ud41MJ/KGPONkC0lE7LriQwDiCToP+oO2nyXZx6pELfBKPYfd90
         0gSfvZ9EpSHl3UEZjp/VK+nycXRWNJRQg4KXr3/9+O+BXyIW0moal3vty/UlCcB48Rfx
         NOMsFAQsyhdekQ5/bfGeSaIbFoD/cI0HLN28Kg1gUOCAVvSpcToIYXnC+iIXc701KInN
         Nym/3rQIIFJUQA9wyHdU+rWNBtJC7wl4MvjX4fWd15uOEqB53r8GivlDiZUzEyd54k4q
         FgXFoOfx2FvREzSpNaPjEGojsmFvbyEjEBAei81UquDwOVC3d1rkKxRTBlXp8qmwsnos
         ZBmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=frchCUzbI+qSk3sponC24xyMO4PTzdHDwL68o7qFQYI=;
        fh=f01fq+WVgncbxFGCkL4Sg49FsiA+NYBLlF+Uh+09I2s=;
        b=fuQmLvmvyFFFFxKPniBZfnwy+DsaaVVVFUKojJm2yLwK+QqJ9zhud3Ta+lYBUirH0z
         6VLDQuoQfNcuNmgF8vQQYVOkJeeMuWVdXJqRJllX5F3wysRU/GUB/sy/R/ptgoaFdrHm
         qI5ZbXI8hfalIGffuQ/5jg7zyTVWgAfM9Cc5v63J4+zZhLOHAxsqb+HDQwXdmz3L1R/9
         8lP27VL9gIBjXZt4I4S55iwgPWprGSQeUrTWnwb1oVJOhYaFfvrkwtA2CeAhV5MxdXwS
         alibQLTPjPE+fpzvteQRyH3e2LOO5w37KbMcPA4hwd1u/pE1fu6BmUIcxQ+8/MHoSYEC
         isbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790352989; x=1790957789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=frchCUzbI+qSk3sponC24xyMO4PTzdHDwL68o7qFQYI=;
        b=D5I77I6mihpmdzweuRHjpdZrOchAh6NILTapn0bM2J4rur7GNHBz260ToXdri+jhZC
         cCs6iHAqYWKTk+1H5GWR3+/R4lfjQI3FhT+aYWKJUJdCojF2tG8pWpiNBToPlW4fYyIr
         nzfxQjr+tvYAh7N1XTzwWnQ2DrndH25mvEP/2XkNbr+wViUzbBCbEvWBlQBtE5exYJeS
         l9t6ilG87BOAWEiejdeXLMFnjGCG08RUQ3P2PUESdJ2aQRunQotu1sjA96JKloVhhG4n
         j9Ul/jXMZXRDkgJfuFPt2JyAebcq9bRJvPReZQVpUujQk6ttNEpHbpRTIypN4QyMVPdk
         4nRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790352989; x=1790957789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=frchCUzbI+qSk3sponC24xyMO4PTzdHDwL68o7qFQYI=;
        b=s66pI640tmp5ohOIl71V/VnKlB4VsxIRi/DUNILEAj4draZ7seY2jxclcErOefN3M8
         l6m7KlIt5rDPIhkxtFIdS/54nO0tHEZIfKdydnf74pWdJ0beig/4AST2/Yoh35ij/OrX
         6oqSGEDKcDuCIL1uGtm+UC9o5W4vhvOb67cb2wxTTC6uYN38gGNEg5BqWIWhHkEf4qSf
         xdMxlu8psEKdEi4Nw2Nb+hLWSUO236yMZFD7wQ6XxT2xADTMziP5Bu7h8hwQehdXkDZG
         9DaP3HiZE/S+Kmz7PnYjcSkJDZXMRkAZILPDVZyqwVFGo7jkfd9Yfm1/tQgotSas9OQ6
         FzZQ==
X-Gm-Message-State: AFuF++lf5aAcdpPG5HbxJxnN0GaM5mtokoSlJ1HsWcCLH+onnMVnj5Ot
	bs/hu30kEk+QGHsi7wgK+8NxJEClWFhGtFYEjDpsgODFC3qgzApraDodSZBos/TBokAjPW3AW4u
	O4bIk79l81k4sNxHxMNbFMel4PYp6CV0=
X-Gm-Gg: AYBFou1h4m8AotNsCb9crsNKcDjoh0LhsVLDko/y5N1bqeluiEeY04WyoIBnh/1+Yny
	6r1UveyQnfG99MVRjujTNAsbnu0/UPgAWcXw2/639i9fUiMyYoKmBUw5GchmvFax/EihNxPlCRg
	5BiWNjrNFYzs2JBMlIjx41e9TxvQWfSpFUG3UMTHrFqw3AaI7LKQ2VAk2PLkorTOtu+JS+IsbuC
	tX8+UuLm13BmSgyfNBHNnZGzyWMjeMT+GeGbA5teo4yUXKlfB6S76Vry4UQXwuFuq+ZmvysEjt3
	nrJ3s9zDiK4D9+4oLLPl3QQTJXWTi7x7ZyYsWbMh+UOColTGlSUnJoOcuXkKlBzraH7IdJFYJf1
	vfkYHU4bBeeQPTc2yLBVQacZjqdef/5/cGGtiFvJtPy1WmV0c6AiVUUEm58aIQiLYt8ib/DPsOh
	tXNMGqNsxmOog6E1ktENc5+cm0dYqEzeM=
X-Received: by 2002:a17:902:c404:b0:2dd:c0ff:e728 with SMTP id
 d9443c01a7336-2df7dfdda93mr51682905ad.58.1790352988731; Fri, 25 Sep 2026
 09:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <68e83baa-6ccb-4ca8-a1df-f09d51749c67@gmail.com> <CALnO6CDpS9GQfONKJs=LAUvwYzYyMby+rGAUtvFQruj-ERXt-g@mail.gmail.com>
 <36e1073e-fa55-4d7d-8b8b-ba9ac34976fa@gmail.com>
In-Reply-To: <36e1073e-fa55-4d7d-8b8b-ba9ac34976fa@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 12:16:17 -0400
X-Gm-Features: AclHuK-IYYssBaYmNSl-ri72wUxT9E81n61Rc5DzRXXWKcvP9MgNOWBkugVEQBw
Message-ID: <CALnO6CB1ptzX1QC=ou4V+tRp9RKHSCKoyh5KqXdBCjGuhKxnnQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, Adam Johnson <me@adamj.eu>, 
	Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 11:58=E2=80=AFAM Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 25/09/2026 13:55, D. Ben Knoble wrote:
> > On Thu, Sep 24, 2026 at 5:42=E2=80=AFAM Phillip Wood <phillip.wood123@g=
mail.com> wrote:
> >>
> >> Sorry, I missed this last time, but we should finalize the merge befor=
e
> >> returning to ensure the allocations in result are freed.
> >
> > Yeah, I think CI caught this:
> > https://github.com/benknoble/git/actions/runs/36033463504/job/107747745=
741#step:5:31
> >
> > But I'm not sure I could have understood what it was telling me
> > without your hint, thanks!
>
> Yes, that output is terrible - to see the leaks you have to scroll to
> line 28282 of "print test failures" which is ridiculous. See
> https://github.com/benknoble/git/actions/runs/36033463504/job/10774774574=
1#step:10:28282

Ah, sorry. My link was sloppy.

I did get that far, but the allocation backtrace doesn't make it
obvious that merge_result is what leaked, and that's where I was
saying an especial thank you ;)

--=20
D. Ben Knoble
