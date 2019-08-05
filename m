Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF061F731
	for <e@80x24.org>; Mon,  5 Aug 2019 18:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbfHESJI (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 14:09:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45641 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfHESJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 14:09:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id o13so40122132pgp.12
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gkCugHqekOsOdarbIQns1X46kyClMUElD0yospFENQg=;
        b=E1lZtQ0IgEChjPiJrU6BCA7UxVuHdEw3Y7rhWC5VRQj+xPJvyStYeXhK2+rrI1KYjB
         zInm7SRAK3+vU/7lwb+RNYiTHbbkaeV8ubMI1OTf5KQHQEUhfXS4tDWWR1PH4SukcHE5
         RnkIW3KQ2l8INaGMBArbgf1/wRtUnbqpGfnsRbVaY0krb7D3MIU3yM0OFVNyVyVTQco1
         RbYPROX07voGM3RTTGEO/XRTWfSRV9OtjAPf2j6V2Wl9F85t4jpyGxAwO15nPWCNMgc/
         9hasH4qxqNEWUyCHzWRJGYc9upWxNgzb4fpkzVxgkSc+weNuxWIp+w+z69g9yCEWaFdW
         zYNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=gkCugHqekOsOdarbIQns1X46kyClMUElD0yospFENQg=;
        b=kuKbGjNhkrL08aRck57ADTPbhApujzP9mzZSO+t8LdY3LB44prkQV5daWWhwIcNsi/
         rP930BjoVB+BvOa9ltdapG6oI5W2c+L6az66VK29InMmXFo01S4rwAl23anrYvOP0rVH
         qsibUZioPbJaO1hzNl+EBmvvNfOQN+w6EDTS6EG1yF/JjW2BxHSpjLnsVWlVhnyoI1WG
         PxTzps2a6EgEL+UrQIkcFHPEmwQm4purx3Egy3Eajwn4M988YKGjg9ja4nXKPOwn2reN
         cmo+u0fLqdSZh5I9F/uiOg7WO1chOiPLeBgIGbR7mNZulgy+yFZQWBz3wlPF0Rm6yjr3
         kALQ==
X-Gm-Message-State: APjAAAV8KXeWvFNA64D4rUqgIWP1EXPR2mSbMzf/bYyrHXw3PxFVG1x2
        cV56TYBJT3DRlfSoOhFNhfQPe9X0Y0Z2fg==
X-Google-Smtp-Source: APXvYqxLhCZZ+6jJfnpq5G9NofXJz3AfHBmBRa/TY3fADNXQcPLQEj6EjQKRpyPrFL4/P1uiWpZR7A==
X-Received: by 2002:a17:90a:80c4:: with SMTP id k4mr19736072pjw.74.1565028546789;
        Mon, 05 Aug 2019 11:09:06 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id i3sm91703467pfo.138.2019.08.05.11.09.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 11:09:05 -0700 (PDT)
Date:   Mon, 5 Aug 2019 11:09:00 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
Subject: Re: [RFC PATCH v2 2/2] trace2: don't overload target directories
Message-ID: <20190805180900.GT43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, git@jeffhostetler.com
References: <99e4a0fe409a236d210d95e54cd03fce61daa291.1564438745.git.steadmon@google.com>
 <cover.1564771000.git.steadmon@google.com>
 <a779e272df958702c0df06ab58f1f6d6f8086a30.1564771000.git.steadmon@google.com>
 <20190805180135.GD20404@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190805180135.GD20404@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.08.05 20:01, SZEDER Gábor wrote:
> On Fri, Aug 02, 2019 at 03:02:35PM -0700, Josh Steadmon wrote:
> > +test_expect_success "don't overload target directory" '
> > +	mkdir trace_target_dir &&
> > +	test_when_finished "rm -r trace_target_dir" &&
> > +	(
> > +		GIT_TRACE2_MAX_FILES=5 &&
> > +		export GIT_TRACE2_MAX_FILES &&
> > +		cd trace_target_dir &&
> > +		test_seq $GIT_TRACE2_MAX_FILES >../expected_filenames.txt &&
> > +		xargs touch <../expected_filenames.txt &&
> > +		cd .. &&
> > +		ls trace_target_dir >first_ls_output.txt &&
> > +		test_cmp expected_filenames.txt first_ls_output.txt &&
> 
> Nit: what's the purpose of this 'ls' and 'test_cmp'?
> 
> It looks like they check that xargs created all the files it was told
> to create.  I think that this falls into the category "We are not in
> the business of verifying that the world given to us sanely works."
> and is unnecessary.

Understood. Will remove in V3.
