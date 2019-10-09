Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8F021F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 02:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbfJICZB (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 22:25:01 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38173 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfJICZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 22:25:00 -0400
Received: by mail-pf1-f179.google.com with SMTP id h195so581846pfe.5
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 19:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Ie1IRlY1V5Nl9hSJuDNCYHJloBAh4pDFvSPdYJk4RI=;
        b=ZQt3HXTtGl8OF56kB3tWq2VN2QiZ8sXtyyWXUAoSy1dmqW5nHXS2vXHwadEheBgDG1
         fhwXFdHzGdZiQuDtc9FGPLPZVNnjoOEtUG9ENDS68aYHWWVhjSukJDvAP1ZBrH/xBCAM
         wGZsDtKAdxt44I1Z0WdZloCNYjzZDmM3YHXUhjoTrwYTl9kDp5Kez8UvHz7eSmkygWMo
         BY5uJc+8UOVYTPBKAt9Hbo7cX28lsT9LRHUH9b9obTjaMoNxJ4GPoZJh3UNxyBvgLORo
         AUzph/bpp1t3RhCOobqVm3YepARA7xq4aYdMjU5J+iNaD/FPYNQfAqrq2vMzZij+cgi0
         Ikbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Ie1IRlY1V5Nl9hSJuDNCYHJloBAh4pDFvSPdYJk4RI=;
        b=XKFtOopf0XEIpGb7o+dDEs6Gzmx+kE9fQVyxW3ySleHW2Bdnw8MIvr+jTDbZlPGWmi
         UUN9yz/I3aDUUeleDcBu2ktsw2VCbSHXBvGvIPNHkm7PML0+ke2WOr77tXx/477Iiywt
         0SOGzOPg8GcFlK/Dnm5YdkHebnMqSqREMc2f1loaGD7vwWz02SAFngk64tmIHxvrbEBc
         KGMr3gkLfBOWOBkRMWDc2Ry8bne6OJrY+H5MJfpSmmAP/K4YeBUsNFIzwYm2e0faWSjL
         m/9B2lJxm2sSa/CDMjgTuvzW7p2VW23kbTm7tIdyYSqa7sXEcbDME7tsw4+XOaxOOZay
         z/Bw==
X-Gm-Message-State: APjAAAUe294BwZgexJ0FEBmo/eobeKMJaMckZfDcvOZoYVopII+gGhDI
        pHKFQpNiVVPNdKWw+1r6SLdoxPx9
X-Google-Smtp-Source: APXvYqzet1PQnQ1rOD6fxSJkjmLuAwqw5sroxJ1HA+g3gug/GHTD7Wt+DTLi7NDG/Kj/eyI8lV9i9A==
X-Received: by 2002:a17:90a:d143:: with SMTP id t3mr1186091pjw.105.1570587899638;
        Tue, 08 Oct 2019 19:24:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id r185sm419456pfr.68.2019.10.08.19.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 19:24:58 -0700 (PDT)
Date:   Tue, 8 Oct 2019 19:24:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Dominik Salvet <dominik.salvet@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fetch origin/HEAD during git fetch
Message-ID: <20191009022457.GB73710@google.com>
References: <CAEXP2g8-reK+u2FaO=mMP-nsvuDDWGpwV_tyKG5L5XpU=1LQeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXP2g8-reK+u2FaO=mMP-nsvuDDWGpwV_tyKG5L5XpU=1LQeg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Dominik Salvet wrote:

> 1) `git fetch origin && git remote set-head origin -a`
> 2) `git fetch origin +refs/heads/*:refs/remotes/origin/*
> HEAD:refs/remotes/origin/HEAD`
> 3) instead of git init and remote, use directly `git clone --no-checkout`
>
> The first solution is not suitable due its delay caused by remote
> access (2 separate invocations). For smaller repositories, delays of
> these individual commands are almost comparable. However, this
> solution is semantically exactly what I want.

Interesting.

For the specific case, it sounds like some kind of "git fetch
--also-set-head" would do the trick for you.  As you can see, I'm awful
at naming command line options --- aside from the need to give it a
better name, any others thoughts on that?  Would you be interested in
taking a stab at implementing it?

For the more general case, there's been some discussion of fetching
and pushing symrefs on-list before.  [1] discusses one possible UI.

[...]
> The third solution has several problems. The first one is the created
> default local branch. So delete it.

Hm, I don't follow.  Does "git checkout --orphan" do what you're
looking for?

Thanks and hope that helps,
Jonathan

[1] https://public-inbox.org/git/20180814214723.GA667@sigill.intra.peff.net/
