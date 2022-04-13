Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4DBC433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 14:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbiDMOjN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiDMOjL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 10:39:11 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E743860A95
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:36:49 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-dacc470e03so2205120fac.5
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 07:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WcKAVrk9SM/dW6J8gq3Wx4lqPPfUNTTApewW795S0Q8=;
        b=idhjjeq096HiyzSdNXV5yrgZc3Dv5kJkatXpCiqG2Gd7jq8n1prvnNoFv/ieYjsgh5
         jW8VPBVUmzMcYtgSOGFgW4HSBs15z6DrMwTj+7LsYKS/YVQS7Kf8qY5E4rprVmQOXLER
         Dkn0R2CiNGjoC7/fEg5X0KLokSkCEgQZBKr0N94L+0DKaz5mTCjfsyf80Mh6lQw/CC1/
         RGfhEQLtEK0xuE/sZjm6XJSuDuekD0gXCBGbmTdKNZkK+EzyFutzPW0QEH7s9q/QBIhe
         xv3KtICCu/W94uOuN4mdomNh74jPf0EeHxWRtSNzc/Dhh+JgWDIEZeMd7/F8AO8QShTd
         s27w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WcKAVrk9SM/dW6J8gq3Wx4lqPPfUNTTApewW795S0Q8=;
        b=Z5WiAnyoxD6dkpO2I4NlQknrLjQLvfP/TaHD+i/H7iEfnH4mhV04iKsoeApxeA/8iD
         KRGpsrghcWIQbNkXkc+sCWxemP7yKrZ6ijcrY7g7i5qRu7Lx2nYadbXMBvDzumuXkA16
         4b6tDwNnh9gfzeRLsaTWD2kE6kn+Oy+GaCcU9UNJHOseUYs01lb0V+Fc26QowNCggCXu
         mjFFPW7yW3cE8Mp7wpBxp8eGKwAPdvNSp0oxo/ClS+r57L52kxk0qdTyp0IKddpZRFLk
         sxxA3SowbDKXrjq93tgQsU87ZbLXSkD3US7pn00Ot7LVCLTQaQV7WwPADU9zkqwwdWxk
         Gdhg==
X-Gm-Message-State: AOAM530Bxzq34IpgbnFQhSIbjD8bBbZVPTLX1iAvZRm25+by3AkVS9nX
        QtX0+aiDZoZVUpy14tuhDBSorfL/EN6FrQyT19w=
X-Google-Smtp-Source: ABdhPJzP+4rU6ZJN/X+V0o0A0jn2m29miSBj0QJpcWsFZJVO1JwpUUe1IQmNP69rX42GbIsuZoD5Ba4mEeiJwessLDI=
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id
 el23-20020a056870f69700b000da0b3f3268mr4424019oab.280.1649860607796; Wed, 13
 Apr 2022 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220412202557.32101-1-cogoni.guillaume@gmail.com>
In-Reply-To: <20220412202557.32101-1-cogoni.guillaume@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 13 Apr 2022 22:36:36 +0800
Message-ID: <CAJyCBOS=xCEmX3yPduDEQfkVYUUiawQ7sYgNHi2dGe-R2W5r-g@mail.gmail.com>
Subject: Re: [PATCH 0/1] documentation: guide of best practices for GIT developer
To:     COGONI Guillaume <cogoni.guillaume@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@univ-lyon1.fr,
        git.jonathan.bressat@gmail.com, derrickstolee@github.com,
        guillaume.cogoni@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 7:29 AM COGONI Guillaume
<cogoni.guillaume@gmail.com> wrote:
>
> Hello,
>
> This patch has for purpose to introduce a file where GIT developers can share
> their own best practices, tools or workflows to the community in order to
> help the GIT developer.

Wouldn't there be a possibility that this doc can degrade into a list of
personal taste? I think the rules that new developers *should* know have
already been documented in 'MyFirstContribution.txt' or 'SubmittingPatches'
and things like that. If there is a *common* recommended practice, if not
"their own", I guess it can be added into existing documentations.

> The discussion about this idea begin in this thread:
> Message-Id: <20220407204001.112287-2-cogoni.guillaume@gmail.com>
>
> Derrick Stolee and I agreed that is can be a good idea.
> And, I think, it can help a newcomer, but not necessarily people with a
> lot of experience on various projects. But, we can give it a try and
> see where it goes.
>
> PS:
> I do not believe it is a good idea to give detailed tutorials because there
> are a lot on the internet. However, give the reader pros, cons and curiosity
> to test those tools, practice or workflow can be really good.

The tools that people use can vary in an incredible way, thus the workflow
defined by multiple tools can go even further. I think a workflow here is highly
opinionated, and such a thing may disturb newcomers?

Wouldn't it be better to let people decide on their own tools and Git
should stay
respectful? Let alone most people come into the community as developer, if they
are going to be "WorkingOnGit", so they may already be well-suited in their own
workflow?

-- 
Thanks & Regards,
Shaoxuan
