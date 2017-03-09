Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB9D9202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 17:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932387AbdCIR5J (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 12:57:09 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:32958 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754853AbdCIR5H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 12:57:07 -0500
Received: by mail-pg0-f52.google.com with SMTP id 25so28983708pgy.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pE7LHVNlWDcH157rDtoaHZhTPAD2+dkrpKj1EC1Dt7M=;
        b=PCV1BhGOJiqo048hBW+oX37S1vwG2+dphnY7hyVRNw3gVNTsJ72zYegyL4PU9W4kXD
         rQEG/tYE3goGU7c4owj4BD4czyJlUJAwb4LHrA6nUo4KyL9NdIatE/8hRKqinni2S9H/
         R3ZFKkAwaPrgaW++iOpDDxAQIrGtMnIT6cx3AKYeGk9GjRLjvSC501PQx+lLAbLrMDT0
         51Sd3F9mjf62fDs0YRJ4DjjREke/eh7DnhkGefIlXNpvZxC5d7VlLNymEYgUrvIZ9+eD
         tqhcTFNK5VJxbT/LOK0M5GtrEhrmiApaOdbehGon5XdYFiRYNShxkyAOT/Yy/f2bKA6Z
         Bbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pE7LHVNlWDcH157rDtoaHZhTPAD2+dkrpKj1EC1Dt7M=;
        b=EjBjGirwiP9SZuQizOIMZ4XpJtqCPjmkYuAbHSV4eRX7sHaQdN0FkQBXkgoivOtZXl
         f6xYlL8C7lAPmYyyy2Jgm8yM95JBj70RUP3W2DVCe7L2iBNHV6sofrssfyqTu4C9FW1V
         Cw4bgOpZzhqrjg42aH/2n+pK+sRHOZE+mtChKkwuqfx1w7u6h8vwW5b2k/DWL3U3N6AL
         TGW+kM9If3oqC8CufqPairm5KKs5DpaCXxQhHkdD28TAztjEBGHcsiDisL6XJO/ImlHq
         yrwId34X/pL/LSllbjzCZ+tBfceigxLjeWdracReUQMbqne8aVwvQEwBnRNyQe92sCft
         MYlw==
X-Gm-Message-State: AMke39lOdzbAPIWMVb3NoX2gxbviIujPkT6VYrLZlzAXDwraExzBtggZ7eYHtSnIzlXxkIVt
X-Received: by 10.99.53.1 with SMTP id c1mr15523645pga.42.1489082183841;
        Thu, 09 Mar 2017 09:56:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:24ad:64a3:afd2:c7bd])
        by smtp.gmail.com with ESMTPSA id r13sm13778314pfg.55.2017.03.09.09.56.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 09:56:22 -0800 (PST)
Date:   Thu, 9 Mar 2017 09:56:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/11] submodule--helper init: set
 submodule.<name>.active
Message-ID: <20170309175621.GC153031@google.com>
References: <20170223234728.164111-1-bmwill@google.com>
 <20170309012345.180702-1-bmwill@google.com>
 <20170309012345.180702-11-bmwill@google.com>
 <CAGZ79kYspNw4=dSnDtyWp7bEhggAM-gRo3g9GJ78jZ8HW7pUFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYspNw4=dSnDtyWp7bEhggAM-gRo3g9GJ78jZ8HW7pUFQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/08, Stefan Beller wrote:
> On Wed, Mar 8, 2017 at 5:23 PM, Brandon Williams <bmwill@google.com> wrote:
> > When initializing a submodule set the submodule.<name>.active config to
> > true to indicate that the submodule is active.
> 
> So by this patch an init of a submodule performs both
> a "regular init" (copy URL and the update setting)
> as well as setting the new submodule.<name>.active.
> 
> And both happens in the same config file (i.e. no worktree
> support here)

Well there isn't any per-worktree config yet (unless that series managed
to land and I didn't notice that).  So once their are per-worktree
configs we would need to push this to there.

> 
> Later on we *could* remove the URL as the .active is the new
> flag of existence.
> 
> But enough of my speculation, I am left wondering what this
> patch accomplishes, as this states no agenda as why it is useful
> on its own.
> 
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/submodule--helper.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> > index bceb62a20..44f2c02ba 100644
> > --- a/builtin/submodule--helper.c
> > +++ b/builtin/submodule--helper.c
> > @@ -329,6 +329,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
> >                 die(_("No url found for submodule path '%s' in .gitmodules"),
> >                         displaypath);
> >
> > +       /* Set active flag for the submodule being initialized */
> > +       if (!is_submodule_initialized(path)) {
> > +               strbuf_reset(&sb);
> > +               strbuf_addf(&sb, "submodule.%s.active", sub->name);
> > +               git_config_set_gently(sb.buf, "true");
> > +       }
> > +
> >         /*
> >          * Copy url setting when it is not set yet.
> >          * To look up the url in .git/config, we must not fall back to
> > --
> > 2.12.0.246.ga2ecc84866-goog
> >

-- 
Brandon Williams
