Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 276731F403
	for <e@80x24.org>; Thu, 14 Jun 2018 21:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936098AbeFNVZF (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 17:25:05 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36122 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755429AbeFNVZB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 17:25:01 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so4219541plp.3
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 14:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IpAn2Sm3Z5AV34Oy5/lD9wkNw/HBmO/5KFf8lCVjNuA=;
        b=LvfTrQIRQ39w8MUbo2aJlVG++uvt1FXTrJ4fhVXIaY+YTDt/F0FHdTWk23yUomDtzL
         n6kuKYZFL8GlWUexBl4Sknlicz2x8Fm9LsN7UC8cYgQCjNOKArNUtzroBxYkCArPywFn
         FG8DBacZx291IAfxVz+BTZL1AUBTYBZygvfdBz8Qn8ZJaRGbDhku+vQTuJCo+EJPMh1M
         3rNmrU1lFRoc6Xw/A4vqjDOCTCXdaInzPfEgxUbF/qd6YaCMyLo96ugBE0AXIN4k+F55
         KYlH29pi3C4V4hEh/jYXQ7cR8dtuPJsQ29dChNPhh0WCdyjRDuLzCTFTW806vMZ6Dpbi
         LSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IpAn2Sm3Z5AV34Oy5/lD9wkNw/HBmO/5KFf8lCVjNuA=;
        b=KSwosn0v05oNJYmEcYcdmyNVsWSizGXGqlDIEEaayyGV4lsoWLM8gL/2szLCQuHlST
         /RTpSWfRVUe5jSXfMeWxTUeWc0gP81X9fpj6Q8PV9C6SQlAV5B8peAZyKuqJBK29GNzA
         eZV9BUZMZpb4JMoLA1sNXBI5tqlc8uIG2X3e2f82xCEKpXCoMkCKPghOC2mImZx2zz9V
         ZKVxPmY+/jbjJ4sQpaIeifQKL4civx26ecwHL1AC9qdPCCizWOUYQ0wE/MN/mYQGxyQW
         thU/B27RAZ6YAZqr+AKM4fUNQ+9nwgVIMw6v8xOIpJwxDC0rumKcp4p4Hfi99CVuGFoD
         Y2hg==
X-Gm-Message-State: APt69E3oywbr3/EfXdVWz89SmHju73ApfloX/QWF0/8fdl0nprncYVin
        FE7C9UIJw0LQSlbYgqlalS0RCA==
X-Google-Smtp-Source: ADUXVKJv4RM7+lnciFKMQqbZ2IFGmu5eGh+Q+MiU78KMp2J+Ri+8C/rhonSe6u2uLhZ6wwGZ4RU3uQ==
X-Received: by 2002:a17:902:be0b:: with SMTP id r11-v6mr4966070pls.182.1529011500906;
        Thu, 14 Jun 2018 14:25:00 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id k15-v6sm8967770pfi.37.2018.06.14.14.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 14:24:58 -0700 (PDT)
Date:   Thu, 14 Jun 2018 14:24:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 10/35] commit: add repository argument to lookup_commit
Message-ID: <20180614212457.GB68349@google.com>
References: <20180530004810.30076-1-sbeller@google.com>
 <20180530004810.30076-11-sbeller@google.com>
 <CACsJy8D2JbeWvBg9F69tAJgq1874=ROFBG-QKfCHeUMZwcY-VQ@mail.gmail.com>
 <CAGZ79kapzeBc1KJFCS2Q4UsZDssaFpf6xamva68LAp+gQcTCCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kapzeBc1KJFCS2Q4UsZDssaFpf6xamva68LAp+gQcTCCw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/14, Stefan Beller wrote:
> On Thu, Jun 14, 2018 at 9:22 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > On Wed, May 30, 2018 at 2:51 AM Stefan Beller <sbeller@google.com> wrote:
> > > diff --git a/shallow.c b/shallow.c
> > > index 9bb07a56dca..60fe1fe1e58 100644
> > > --- a/shallow.c
> > > +++ b/shallow.c
> > > @@ -31,7 +31,7 @@ int register_shallow(struct repository *r, const struct object_id *oid)
> > >  {
> > >         struct commit_graft *graft =
> > >                 xmalloc(sizeof(struct commit_graft));
> > > -       struct commit *commit = lookup_commit(oid);
> > > +       struct commit *commit = lookup_commit(the_repository, oid);
> >
> > This looks wrong. register_shallow() has struct repository argument
> > 'r' and it should be used here instead.
> 
> Right.
> 
> > If this is a mechanical conversion, I will also be happy that the
> > switch from the_repo to r is done in a separate patch.
> 
> This part of the code is not touched later in this series,
> so I'll fix it if a reroll is needed.

Yeah maybe at some point when lookup_commit can understand arbitrary
repositories we can change this from the_repository to r.  This patch is
part of that mechanical change and has to be the_repository till
lookup_commit has been fully converted.

> 
> > FYI I noticed this because I'm in a quest to kill the_index by passing
> > 'struct index_state *' throughout library code, and sometimes I pass
> > 'struct repository *' instead when I see that code uses more things
> > that just the index.  And I have started to replace the_repository in
> > some places with a function argument.
> >
> > If some of my patches come first while you have not finished
> > repository conversion (very likely), you and I will have to pay
> > attention to this more often.

-- 
Brandon Williams
