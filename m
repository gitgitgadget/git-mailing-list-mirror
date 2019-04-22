Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B9D1F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 08:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfDVIfV (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 04:35:21 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34421 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfDVIfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 04:35:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so5400143pfd.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YfdTqHQaZdoovaf+CqdtTpE1Cg+EmKjt+M0amaZuGfI=;
        b=JDTGXQKynfr0fRd64Lo1H3q4249Tm24INt6uD/FlN9LLxqaeiPgRAE0T835GgpPqUb
         JF/H7h6n/TTdHrnT+ULdXjVQ/OxC15hzGBPj6TQqWj8H9tQKpfNW+l+aibEpqCAnjzz3
         DW04MycbDdYKqsXw1EB4WT6Om2wN2sQkT9Y2b2m0z362+JVdnF1ZFNg3CI1WpsuMhxsY
         PUNKwFGw6R9ye0VwotdZx8gU6o/ESvHedcXco8enC/tkfNdiASAQ3aNCAj8Ju/2r1WWu
         WME9o4vZHVR8J4WPEN3YkzpqaGTvupNNzII8b6nD6IzTj4CDqb1BGFguwl3VBNmhOHRT
         OThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YfdTqHQaZdoovaf+CqdtTpE1Cg+EmKjt+M0amaZuGfI=;
        b=haW7fKWvpVPUsJJVJXKvBAwLepFWGeiT4oohvs2w9SxhKzWsnQ+nVOT6V/L1rHws0s
         Zh1fSpbakdr/tAQDSw9YmArIlnhnFAGAANy10Eb/zsIae2RbzmW7Y4TVmUemVCXKmF/J
         /Eh2h5ObwBioHH5mx1S5DV141KCClI779WqK32BaTvLRbMwq3++QOuQj1pIukYgipJ/R
         zAHWEoixF43a6BA9WqoNnoibUrZ33S7gb5rbh+0+ULHkAn8cbOexlLKUetmZBnsGRXu0
         icx2kvLFUzo0eQJeNE2p1eVPf1IJKoia0ARxFfToe+bo8HMJfzOEBVz1PLys0+jJR5JC
         vSbA==
X-Gm-Message-State: APjAAAUR19JP6ok/euC0HyhreNy24EtCriopK9AXuuc7BsKONVercdxa
        s8an5akwjrB6ep7v01X1/52f3/Ei
X-Google-Smtp-Source: APXvYqx6pJI3+ALj5egfvRBIT+lPrxvvafGFcqPO7PJz7wxk/d1P0uqMlz5hbx3KGFvM7Ziyyb/iEA==
X-Received: by 2002:a62:69c2:: with SMTP id e185mr19200290pfc.119.1555922120795;
        Mon, 22 Apr 2019 01:35:20 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id b14sm16047361pfi.92.2019.04.22.01.35.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 01:35:19 -0700 (PDT)
Date:   Mon, 22 Apr 2019 01:35:17 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/5] mergetool: use get_merge_tool function
Message-ID: <20190422083517.GA12094@archbookpro.localdomain>
References: <cover.1555880168.git.liu.denton@gmail.com>
 <692875cf4baaeee8b47fd7e95d0b787d1a08f64e.1555880168.git.liu.denton@gmail.com>
 <CAPig+cTJf_2psxrtsOi2h7c3ZbDj25WqLGPNaLqBmoVpM+6FRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cTJf_2psxrtsOi2h7c3ZbDj25WqLGPNaLqBmoVpM+6FRg@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, Apr 22, 2019 at 03:07:25AM -0400, Eric Sunshine wrote:
> On Mon, Apr 22, 2019 at 1:07 AM Denton Liu <liu.denton@gmail.com> wrote:
> > [...]
> > Rewrite `get_merge_tool` to return whether or not the tool was guessed
> > and make git-mergetool call this function instead of duplicating the
> > logic. Also, let `$GIT_MERGETOOL_GUI` be set to determine whether or not
> > the guitool will be selected.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> > diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
> > @@ -28,7 +28,10 @@ to define the operation mode for the functions listed below.
> >  get_merge_tool::
> > -       returns a merge tool.
> > +       returns '$is_guessed:$merge_tool'. '$is_guessed' is 'true' if
> > +       the tool was guessed, else 'false'. '$merge_tool' is the merge
> > +       tool to use. '$GIT_MERGETOOL_GUI' may be set to 'true' to search
> > +       for the appropriate guitool.
> 
> What is the likelihood that code outside of our control is using this
> function? If there is such code, this backward-incompatible change
> will break that code. If the likelihood is excessively small, perhaps
> it is not worth worrying about, otherwise, perhaps this warrants a new
> function with a distinct name.

Thanks for considering this, I hadn't thought about it myself. I assumed
this was an internal function but I guess I was wrong.

I did a bit of digging on GitHub and Google and I found that
git-diffall[1] uses it, although it seems quite old and unmaintained.
Aside from this, I can't find any other open-source programs which use
git-mergetool--lib (and in particular, get_merge_tool) so I believe that
it is pretty rare.

That being said, I'm open to writing a new function so that the change
will be backwards compatible. I'll see what the list has to say.

Thanks,

Denton

[1]: https://github.com/thenigan/git-diffall
