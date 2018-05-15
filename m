Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C02C91F406
	for <e@80x24.org>; Tue, 15 May 2018 17:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbeEORAF (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 13:00:05 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34342 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754174AbeEORAC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 13:00:02 -0400
Received: by mail-pl0-f66.google.com with SMTP id ay10-v6so409960plb.1
        for <git@vger.kernel.org>; Tue, 15 May 2018 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+FD7Cecr+yIKoi9kwJMgPEpODFpqalEgCjkd7JA4fnw=;
        b=Rz97UmBBbdKb1WrRLGayhWpXCV43IiXIE+xsIaaaLZGrSpGu6iyZaFB/YeUh4ycaji
         yIDr4VRp+CchotyOhxPS0EbTpIw/018oUHSJLJYfqPWez6VNuuPEdKkrDQSHhSMhHDz8
         0nF2jg6ZYFDHgnmRGqxYZkZ7PKE8gIIC7tchH5MNbEhyjMA7tnhwHjN0nDzB8Z8C40mo
         0Ixuusx1tfA446WOXjK+Ijjee8eSuVp862LdK441OE63bkNDH77zRYaeGxUI+myxTGq5
         4C5gikmxzjfY66fPAfupdynT6d7PBZgR1FNo60gDFaLaDrT5MYgIUyNcfWelD3aadOt7
         c+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+FD7Cecr+yIKoi9kwJMgPEpODFpqalEgCjkd7JA4fnw=;
        b=Vbr/P1h8HUla+Tek8rxWSrEBG6tZaHEbX6QuVS3j8pE6O6IgHRNgV/pxdtT6i1W6Jp
         WJsiKGy0UCq43f/QpSkzpJY95+iSPnDhRyFzlmvxb7zuO5exd9xfG0lYdb7k6ujAD5I+
         wX160MBBqxviL0G3E/wnAb9RROnMkRLCJG7EAvtdncP2YQ4teVwgZ28s45twvYu0YnNr
         /wJa3mTsgI/N71oJG5QJU49moSWgJcgmwzY9OXNQaICwlH1yjcVwxCpCrqatSAl+CMvH
         GCAN7OFoYUU9RMFnrVJn48KzwEMAdzbx2PnyFZ/TxcM1+SBo/D82I6ij6j5ADAclL0aZ
         ebsg==
X-Gm-Message-State: ALKqPwe6b96qJr09gtdc56KhiKwa+vDLl80lpQNdgQf2yPuFfMsJK/LL
        ZJrc0RDFaLebafDbpIxA4XW/mQCtsuc=
X-Google-Smtp-Source: AB8JxZpfFWwiR0h6hW5G9JDaXmEdETwqLZeAUYrJE382pw4mXgyKvMiqIW6O9z7hujcWMA113JJslg==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr13508060plg.135.1526403601162;
        Tue, 15 May 2018 10:00:01 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id n18-v6sm931307pfg.36.2018.05.15.09.59.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 10:00:00 -0700 (PDT)
Date:   Tue, 15 May 2018 09:59:59 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 35/35] submodule: convert push_unpushed_submodules to
 take a struct refspec
Message-ID: <20180515165959.GB72551@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
 <20180514215626.164960-36-bmwill@google.com>
 <87k1s52va3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k1s52va3.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/15, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, May 14 2018, Brandon Williams wrote:
> 
> > Convert 'push_unpushed_submodules()' to take a 'struct refspec' as a
> > parameter instead of an array of 'const char *'.
> > [...]
> > diff --git a/submodule.h b/submodule.h
> > index e5526f6aa..aae0c9c8f 100644
> > --- a/submodule.h
> > +++ b/submodule.h
> > @@ -100,9 +100,10 @@ extern int submodule_touches_in_range(struct object_id *a,
> >  extern int find_unpushed_submodules(struct oid_array *commits,
> >  				    const char *remotes_name,
> >  				    struct string_list *needs_pushing);
> > +struct refspec;
> >  extern int push_unpushed_submodules(struct oid_array *commits,
> >  				    const struct remote *remote,
> > -				    const char **refspec, int refspec_nr,
> > +				    const struct refspec *rs,
> >  				    const struct string_list *push_options,
> >  				    int dry_run);
> >  /*
> 
> Why do you prefer doing this to having this on top?:
>     
>     diff --git a/submodule.h b/submodule.h
>     index aae0c9c8ff..c3f206ce17 100644
>     --- a/submodule.h
>     +++ b/submodule.h
>     @@ -1,5 +1,6 @@
>      #ifndef SUBMODULE_H
>      #define SUBMODULE_H
>     +#include "refspec.h"
>      
>      struct repository;
>      struct diff_options;
>     @@ -100,7 +101,6 @@ extern int submodule_touches_in_range(struct object_id *a,
>      extern int find_unpushed_submodules(struct oid_array *commits,
>                                         const char *remotes_name,
>                                         struct string_list *needs_pushing);
>     -struct refspec;
>      extern int push_unpushed_submodules(struct oid_array *commits,
>                                         const struct remote *remote,
>                                         const struct refspec *rs,

Basically for the reason that stefan pointed out, though in practice I
don't know how much that would actually impact compile times given we
already are including cache.h and a bunch of others everywhere.

-- 
Brandon Williams
