Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790577111
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727936952; cv=none; b=F1XRa0IpA0mgeD3ZMrCa6IxkH1ecZFnm5MWx6/VxY7FZiCAo2ZtKt+Tmuu03cOh9L6mxTtOCIbUejQGY1t3oJdEj7osYsG1bitLlBAc11M1RKQZy58lIElr+0CP60LKdHfABpn/YYj3dU+ZQFwv0ZWAMRjn1pveFR2juoFb+EEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727936952; c=relaxed/simple;
	bh=mw/GwniZHCRdbCXRR2zJud0EpvZAGwGSg5P/Rz6FXYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIaAIAmXr9HLLyo/TStWeZ3fMB8SfVlLtnqG61u4dboyqUMYH5x9GQ96Dr4MGUoGPNEiAvOh1F3ju5ekC2qz5de9Y0zVlwwLTxfLg/oxYAt6SwxtVrHxr7Lbf4GMbZ24AF0u8T5vrWQR+uS3qrdJJCoQ9eC00AulIVAPvMnUW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-458150a2593so1038871cf.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 23:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727936949; x=1728541749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q32dwCNTlmMAhoe0pAnxjivpAInhB6IDEigVIbtx64E=;
        b=KT8ybvSQXlzRKZmBhSevnrnhnTAuXZjYachtvSKMqmbHCbnmP6CnkOv3vK/UxUGfKZ
         tnKtM1z7qs0erYZOaEPB0DiWwOM1FqJWLGa9llIdZRuaMb2BO9CIWzIA37Jp7/d5mp9Z
         xSql95gEZiv0Cxl6WdSyqo7HCn4wKx9vv4RtZOUV/KwM40G8jkua0a+6EbyUz4BSmI7h
         QtxRIl0gvCNpf88LVIsCFc2lyZBUGjlylQdV9OKqAtJzrrMZDEJqL0S8gOXTpyUCQy++
         hdLI5iZ3WW8mu+VGoXMmNCGrrkYmeAVuCqsMBWTrHxYDQkLVSf+FgpHbhGity3kW22gF
         afdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoXQHpp0D5KkkP6n0zG2X0QCfDJ6XAfB04znqAwH8tbDBGB6y0jU7OsL0NrCuiO9JehkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFl+nTMKpqHJZVucUvSHocG8EIUbQ6wCJknSwrT5dCdrlUM4F
	A/XUeF81hJGmxOsQL3RlYWoQTOZ/RJF547GjORisT2FCX0ZcdMJPvWP4BiVnnvK67rI1LpAo/xg
	Y42ROHRHL1gCGChBDeK4Q60c+Q+B/q/yv
X-Google-Smtp-Source: AGHT+IHRZ/lkFrgr6C04mYj4Nu7p+uCKkkGbsYOSgwBMvjztGtWF0e4gA6VdNtE3EsB4bB7Aayc7ewj/RSKpdhxUovM=
X-Received: by 2002:a05:6214:ca1:b0:6cb:6e29:bad4 with SMTP id
 6a1803df08f44-6cb81ddb743mr37015856d6.11.1727936949294; Wed, 02 Oct 2024
 23:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <E1sr5iF-0007zV-2k@binarylane-bailey.stuart.id.au>
 <CAPig+cQ8=Y6sVvN_dBo_GQ5nLkQ4GJ7AM6mE2kt_2QV7CR0omg@mail.gmail.com>
 <3b579ddd-b386-4daa-ad63-1e75522b7462@stuart.id.au> <CAPig+cTkpLLoTxTa-8xfycNGFibN_M71+kkHtT-wgp6HRPi-aw@mail.gmail.com>
 <4781ff6e-c20a-4340-851b-c9d324d1fac8@stuart.id.au> <CAPig+cTop=2+k0XbqYbsCTbJVo77evY+_a+FqDV_ziKf2q+Dzw@mail.gmail.com>
 <87afa860-52f4-414a-82da-09e7eeac1301@gmail.com>
In-Reply-To: <87afa860-52f4-414a-82da-09e7eeac1301@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 3 Oct 2024 02:28:57 -0400
Message-ID: <CAPig+cSSDnq_kh9ERuYZmUCNrVvWmGFF8OSfBCy8bHrkx6fz3g@mail.gmail.com>
Subject: Re: "git worktree repair" modifies the wrong repository
To: phillip.wood@dunelm.org.uk
Cc: Russell Stuart <russell+git.vger.kernel.org@stuart.id.au>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 9:53=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
> On 23/09/2024 19:52, Eric Sunshine wrote:
> > On Thu, Sep 19, 2024 at 7:40=E2=80=AFAM Russell Stuart
> > <russell+git.vger.kernel.org@stuart.id.au> wrote:
> >> Interestingly, people (including me as it happens) start out by trying
> >> to emulate the hg approach using a single parent directory to hold a
> >> bare repository, and the child worktree directories.  Then they discov=
er
> >> bare repositories mangle the remote links, and give up on the idea.
> >
> > Can you provide more details about this "mangling"? Although the
> > use-case you describe was not directly considered in the initial
> > design, worktrees hanging off a bare repository became an
> > explicitly-supported use-case not long after worktrees were
> > introduced. So, it should work properly and we know that people use
> > worktrees this way, but we haven't had any reports of mangling in this
> > scenario.
>
> I can't speak for Russell but a while ago when I added a worktree to an
> existing bare repository I had to update remote.origin.fetch and
> remote.origin.mirror because "git clone --bare" implies "--mirror". I
> also needed to enable extensions.worktreeConfig and ensure core.bare was
> set appropriately.

Thanks, Phillip. This is interesting information, but I'm not sure I
understand what the actual problems are that you encountered. When you
say that --bare implies --mirror, do you mean the other way around?
The documentation states the opposite; that --mirror implies --bare,
and my own testing seems to confirm that.

That aside, I played around a bit again with bare and mirror
repositories with worktrees hanging off them, but didn't encounter any
anomalous behavior, which (almost certainly) indicates that I'm not
exercising it thoroughly enough. Thus, can you provide more detail
about the actual problems you encountered which required the manual
adjustments you made to the configuration? (Does this also imply that
Documentation/git-worktree.txt could use an update to discuss how to
use them with a bare repository?)

Regarding core.bare: That's one of the settings which is special-cased
(hard-coded) to work "properly" when extensions.worktreeConfig is not
enabled, so it's not clear what problem you were experiencing in that
regard. In my testing, `git rev-parse --is-bare-repository` correctly
reported "true" in the bare repository, and "false" in a worktree
hanging off the bare repository even when extensions.worktreeConfig
was not enabled.
