Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D17A1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 20:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbdLHUMe (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 15:12:34 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:40884 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdLHUMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 15:12:33 -0500
Received: by mail-it0-f66.google.com with SMTP id f190so7055212ita.5
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 12:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PBj1p8CUBqwE/nxA0IGjdOc1WEyqxiKVI6wHoBTbOwI=;
        b=Z7SNqekyeiZ13CR6Y+XYKsPMy9rl6ZrmktiYTCurcVy/eTRZ8RXsUnNdXqsFdLOLjr
         V1PgeHvL3sh97vT1IGKukDZh1KqAZBN6HQQBil8ySBbt/yScyBRGfFN4qJ7io4R269Ks
         cRpS0V4hDmCx9KUzrr6R9LFIO+JtMBTYWnCUSP1f2XouXNSKCufYwug2AnlbAAP0hH2e
         q6AAotbGzTmdowoxDEXKdK69T53iV72d7FC6WmjFWG7qq1gHNQb2k9O6kLZxI/v7oMdO
         p0oAKk50sNChNkSFwutx3+5UzJsVmcgVv/GDvOnr/SR7o8GbrhQ+W/yXF59/7u3oekhS
         js3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PBj1p8CUBqwE/nxA0IGjdOc1WEyqxiKVI6wHoBTbOwI=;
        b=OJRxhlTgGrdSOPMgd94rmzobw+OkYq+5iowE6KVSAVevMTdzCFgJcuDSEf/H50Kw6Q
         ZzJBtDAR5hEIPY309S9YeuPve6ayLNL4RlvPaBdoejnHAzpLYv0/xHOTfdZNv3qEzqVS
         o/HGn3fqUssvAO1xRXN6n5nxA8QX6Oo5Dw3rn0k93B1gvVTltjvsq/O3mBUc6aaCNHx5
         DbM94qdcx2tyY4rCPTG4N3OxpctMwStT54phCs5GKmSPmRqhLz1PtsQW6/vAaWERa4jZ
         bJ/33QVy8pJLm/WFtFX2qhyVp9TFoj2x/x3QDM6fRimDxXnV9TEXf9oVE7qGlP/8tlv0
         cOzQ==
X-Gm-Message-State: AKGB3mI7YYZFU8PNNJ9Dq8cy5mEV37E7zAORu6AGGol5/moCMdA3AEJk
        SwpSu8hOy7wGkkcF8lUUcSVJqkAsELo=
X-Google-Smtp-Source: AGs4zMYP6lqNH/lN13VAZULcrgn+xqnZR/NXqr9CQmwCQ0L1g06maq3shfFRQiCTaUUAwkWOX+6Rpw==
X-Received: by 10.36.159.197 with SMTP id c188mr7242398ite.142.1512763952408;
        Fri, 08 Dec 2017 12:12:32 -0800 (PST)
Received: from google.com ([2620:0:100e:422:e4f1:b67a:70f2:4fbe])
        by smtp.gmail.com with ESMTPSA id 97sm3828114ioh.22.2017.12.08.12.12.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 12:12:31 -0800 (PST)
Date:   Fri, 8 Dec 2017 12:12:30 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 04/15] upload-pack: convert to a builtin
Message-ID: <20171208201230.GC140529@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <20171204235823.63299-1-bmwill@google.com>
 <20171204235823.63299-5-bmwill@google.com>
 <xmqqr2s7frga.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2s7frga.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/06, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > In order to allow for code sharing with the server-side of fetch in
> > protocol-v2 convert upload-pack to be a builtin.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> 
> This looks obvious and straight-forward to a cursory look.
> 
> I vaguely recalled and feared that we on purpose kept this program
> separate from the rest of the system for a reason, but my mailing
> list search is coming up empty.
> 
> >  Makefile      | 3 ++-
> >  builtin.h     | 1 +
> >  git.c         | 1 +
> >  upload-pack.c | 2 +-
> >  4 files changed, 5 insertions(+), 2 deletions(-)
> > ...
> > diff --git a/upload-pack.c b/upload-pack.c
> > index ef99a029c..2d16952a3 100644
> > --- a/upload-pack.c
> > +++ b/upload-pack.c
> > @@ -1033,7 +1033,7 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
> >  	return parse_hide_refs_config(var, value, "uploadpack");
> >  }
> >  
> > -int cmd_main(int argc, const char **argv)
> > +int cmd_upload_pack(int argc, const char **argv, const char *prefix)
> >  {
> >  	const char *dir;
> >  	int strict = 0;
> 
> Shouldn't this file be moved to builtin/ directory, though?

I can definitely move the file to builtin if you would prefer.

-- 
Brandon Williams
