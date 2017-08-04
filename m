Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF35F2047F
	for <e@80x24.org>; Fri,  4 Aug 2017 21:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752381AbdHDVxP (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Aug 2017 17:53:15 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:37455 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752031AbdHDVxO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Aug 2017 17:53:14 -0400
Received: by mail-pg0-f53.google.com with SMTP id y129so12568104pgy.4
        for <git@vger.kernel.org>; Fri, 04 Aug 2017 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=taxL2mPnOkcnDjv7PDHOxTyppLSIC9wQ4sYf3pBqQzE=;
        b=v3HPsoIw6h5jepU+cCVtUjxl2NQzLIuhELAt5PBb9kfqjUE20VwyGZS2X5qFKIb5z9
         RLoq8bE6BEuruDkWExD2hhIBzkGVnW0ZuGtRQ5Bc2nyPeWMn5AeYysRfWVgMvZ4cWUIa
         9Nuf3+Jc+KQ9t0gnoqk7GiwBIBph+Lv/K2T40lYVdGAWsHEVCYQsxH3Nh0De2XNOkTp8
         NEjEmnXRG4xBve5Zomlgz8TEJ+h1r9XOwJMlE/gRJQeH6FHUXLHjm1zdIAc2jhje+tii
         dTdCddWoHgMbrH8SVUJKapEBnWq3c88NjeVOlltI0Cd/qkhH51bl3hSf3KdyhIqSbsYG
         ZG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=taxL2mPnOkcnDjv7PDHOxTyppLSIC9wQ4sYf3pBqQzE=;
        b=G9ZlJEBVARt8+8nukWOCLe+IyiBrmdY6afkkyURl7DbYD9WQPfRhgxVowshf8Uq9ja
         sahmP25ehWkXxz5hydhujz6KRXi6aRoaCIwPLpWhqXfM61Euk2sMdKzMRT3F8S5Wy+Ga
         jJCxGSMjDlctmJJ6ogKBzohiE4rt3lgTy1JSO2g8txBt+HEVrYYUgbCP3+TxKmw3fAAS
         OtUk1cs9hnHoR6nPzgbJI/rdPIdf1Q1HQI2Q/hF3Ah0ftGZl78tiicNEcT7tGZ5R930v
         DdY3EVEMEk2e7SjGQVesjeCVYZOX6WUj0B2LA8kp3YmUuXJAftLmFafLAaANCFDV20Gp
         C9Xg==
X-Gm-Message-State: AIVw1113Em81YoLpPQdUadJ8nr8L5SyS+tJozqUtSrr5GROYqbIFUkUE
        5dsWTCkjaJERuEVU
X-Received: by 10.84.217.140 with SMTP id p12mr4446555pli.323.1501883593576;
        Fri, 04 Aug 2017 14:53:13 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:12e:3e2a:b3e7:da91])
        by smtp.gmail.com with ESMTPSA id 84sm3009082pgd.48.2017.08.04.14.53.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 04 Aug 2017 14:53:12 -0700 (PDT)
Date:   Fri, 4 Aug 2017 14:53:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 02/15] submodule: don't use submodule_from_name
Message-ID: <20170804215311.GB126093@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
 <20170803182000.179328-3-bmwill@google.com>
 <CAGZ79kaZcpZ-6+=19CbW1v+h-njguXZH9z9GMYA3Ci=acfreKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kaZcpZ-6+=19CbW1v+h-njguXZH9z9GMYA3Ci=acfreKQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03, Stefan Beller wrote:
> On Thu, Aug 3, 2017 at 11:19 AM, Brandon Williams <bmwill@google.com> wrote:
> > The function 'submodule_from_name()' is being used incorrectly here as a
> > submodule path is being used instead of a submodule name.  Since the
> > correct function to use with a path to a submodule is already being used
> > ('submodule_from_path()') let's remove the call to
> > 'submodule_from_name()'.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> In case a reroll is needed, you could incorperate Jens feedback
> stating that 851e18c385 should have done it.

K I'll add that into the commit message.

> 
> > ---
> >  submodule.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/submodule.c b/submodule.c
> > index 5139b9256..19bd13bb2 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -1177,8 +1177,6 @@ static int get_next_submodule(struct child_process *cp,
> >                         continue;
> >
> >                 submodule = submodule_from_path(&null_oid, ce->name);
> > -               if (!submodule)
> > -                       submodule = submodule_from_name(&null_oid, ce->name);
> >
> >                 default_argv = "yes";
> >                 if (spf->command_line_option == RECURSE_SUBMODULES_DEFAULT) {
> > --
> > 2.14.0.rc1.383.gd1ce394fe2-goog
> >

-- 
Brandon Williams
