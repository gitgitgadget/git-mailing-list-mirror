Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C50520248
	for <e@80x24.org>; Thu,  7 Mar 2019 09:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfCGJTJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 04:19:09 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40261 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCGJTI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 04:19:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id u9so10778408pgo.7
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 01:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/PywHpKWj8zRhQqC3duMdjPj466ERRJmbb8tAVyBD7s=;
        b=gtINhX7bRngMvBfok30LmOQYmM5vAqusgY1tHo+HemYDo0BjwgMNH6da6iQme2n2AS
         GjzbR3/uNnOTFHBQnvQhv/gvPLx8SxlSiIbUq15aDTnQAKXLJsTzeghxVDJgfk//pDhK
         7DAt543pxGcJKhZ+6SH3tHrI9/jepbDn07d/sFJHItrma+RdwdiMriZM4dwtM6CBji5m
         SpwH6KRV6kXhW1DfsjNNGppxcD5vWTOhBbz+TECS8FdLAosA1Q2LZGXP4mrnqrFjmhoW
         rq0Hd0JfSe2KC09ZHeD2M6gAfI5YRsi4yDsU+GhLGSbKBoh/HhA9+HbHWAcrIl6MBgrN
         k+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/PywHpKWj8zRhQqC3duMdjPj466ERRJmbb8tAVyBD7s=;
        b=dSH/FA+ASMNHz7aOgyoiuqtnmOOCnh0dx32niuoJKp0Ccr3MM4KWhyxlTuWN5BeVo+
         Sgv/4DhYKTaZJ8Nsc6EPAPRV3xaRlSfM9TUjUaycM55EUTtfuyPUqgfJ/gBPfd8+qnIr
         +GDqBaOYLRuRx0Su3bG2bMvL7+GZeL7QLPpUtYJJRg66Q3G2Y3Kud1K8uQlUbfxgMEuj
         pZQBX2zd8Fj+9+POEwCOzafzfMPZstO0xdtdCMZmJX5XvdGBM2nvS2cr0sehrrrAvZ8D
         Sf3/jEpVIReXbnIabj+Y8/TsZ52bICDrScXMVMdFTeALuHBdT/9IPsNMuJ1BqKMaxcOb
         dZCg==
X-Gm-Message-State: APjAAAWMJ1YZu/jRgtBalnp6Cw15B1uCBl7t/a46RVYPeuo6yTRk4SuZ
        vkbgadcgGVKi5n+lG0QZfQE=
X-Google-Smtp-Source: APXvYqxxl1nu+JRgTExwp9TdAP4iPSgWYP5jQ2+KMNWLbyD0mZMD7BWlIYRbSi6DyP3MVfAX0UjJBQ==
X-Received: by 2002:a17:902:9a09:: with SMTP id v9mr11528332plp.225.1551950347535;
        Thu, 07 Mar 2019 01:19:07 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id l72sm5218623pge.39.2019.03.07.01.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 01:19:05 -0800 (PST)
Date:   Thu, 7 Mar 2019 01:19:03 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/3] cherry-pick/revert: add scissors line on merge
 conflict
Message-ID: <20190307091903.GA7970@archbookpro.localdomain>
References: <cover.1551867827.git.liu.denton@gmail.com>
 <cover.1551940635.git.liu.denton@gmail.com>
 <8fdc5bfb151e4224eba01021c6f0be3e61e1f535.1551940635.git.liu.denton@gmail.com>
 <xmqqa7i7m886.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7i7m886.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, Mar 07, 2019 at 04:52:57PM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> > diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
> > index d35d771fc8..5c086d78c8 100644
> > diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
> > index 837707a8fd..1894010e60 100644
> > --- a/Documentation/git-revert.txt
> > +++ b/Documentation/git-revert.txt
> > @@ -66,6 +66,13 @@ more details.
> >  	With this option, 'git revert' will not start the commit
> >  	message editor.
> >  
> > +--cleanup=<mode>::
> > +	This option determines how the commit message will be cleaned up before
> > +	being passed on. See linkgit:git-commit[1] for more details. In
> > +	addition, if the '<mode>' is given a value of `scissors`, scissors will
> > +	be prepended to MERGE_MSG before being passed on in the case of a
> > +	conflict.
> 
> These both say "prepended", but shouldn't the code
> 
>  - add the merge message proper, with the expectation that it would
>    be used more or less intact in the final commit message; then
> 
>  - add the scissors; then
> 
>  - append informative cruft that would be removed, only to help
>    human users.
> 
> in this order?  I'd expect that most people would consider that the
> primary payload of MERGE_MSG file is the part that would become the
> commit message, so I would have expected the second step would be
> described as "appended to".

I copied this over from 6f06b6aeef (merge: add scissors line on merge
conflict, 2019-01-22). I guess I'll have to fix it up in git-merge too.

> 
> Another thing I notice is that this singles out "scissors" mode;
> doesn't the code do anything worth describing with other clean-up
> modes?

The revert/cherry-pick code doesn't really do anything with the cleanup
mode. It's only used to determine whether to generate the scissors line
in the case of a conflict.
