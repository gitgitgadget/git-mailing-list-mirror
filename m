Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD281F404
	for <e@80x24.org>; Mon, 26 Feb 2018 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751544AbeBZSX1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 13:23:27 -0500
Received: from mail-pl0-f52.google.com ([209.85.160.52]:35630 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbeBZSX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 13:23:27 -0500
Received: by mail-pl0-f52.google.com with SMTP id bb3so9747912plb.2
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 10:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TznRTNc0skZwDiBt7c6u5++pqcqgfDndQwPRERFgsOk=;
        b=EUqxz4mpphGBOwU4xLqgB6jmqQR92pyTXMXrjAc/U7TA7ES4QKlIpaJNk+zjDdvyIL
         RmrRIteddZ1z2mZmTXigx8da2dJoNV6osRsOz0oDd+mqPSSAp0TQ29DwhMhqXq55af5q
         ou1jU1kTpX0wxuOYBk2JETv1TvIegrlLtTqGTX6szRT1Jc5AjJ+HMXhMnDnTb/QLXsvZ
         7jMnAorcjFlLApFoo9LccTKv7sdIlG3CPxDJvlQm5uUfD/+LQBVAtdbbVkDWfmliOsLc
         75pJx/ofkMi6lX26I3/T2l7CUem9+n3IyEI/PUg5xqyxDnkSaEWlYujShS3QD3nZewHH
         N3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TznRTNc0skZwDiBt7c6u5++pqcqgfDndQwPRERFgsOk=;
        b=UOOz9IRz0WwbPMiwmfKRRKsTWz73ZcDmSMuEJWkXtryQei5YflcrjBpCNGQHkpHpxu
         v7noUhgY0p5ujwPqpoz2Avv7rf3dmiP4y0Zp5+12UkBb2LfMAwLuZ7HLCRZ1Rg6OkNAS
         29WXE+inHQP7tFaWfUXrZH/VQ3ubsTiOGp3bR+63bpnjbBEQCS97U+ssHR4u69w/d4tj
         bGIIhDhC7u9KCUxu/QSVzRux+r5Eyxw5kARLmvmYoRl7k1OxED+XtNVbxUMXY53TpZ2i
         VeIKURY1MqhvdC7vde3uW3MFueL7Zp1RUcDXqxE+NNybxJUgJk5ybeCO/oIKx/kK4Ay7
         nvsw==
X-Gm-Message-State: APf1xPB/WJ6ckSi4ByX1tRawDja6c/zavlAfs9d8uizGbKA+Sq3u+KUy
        ZAYYS6vjoLZey5yIRrE7BJ4Df34OxUs=
X-Google-Smtp-Source: AH8x225uKIxxVgeYtB3nBtc7GeedtUbkD8US0Ehc5OObq15/9cC5cgXaJ1lX3CMg6sk1N5viiWv7Jw==
X-Received: by 2002:a17:902:7282:: with SMTP id d2-v6mr10363763pll.303.1519669406135;
        Mon, 26 Feb 2018 10:23:26 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id a13sm17706982pgd.1.2018.02.26.10.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 10:23:25 -0800 (PST)
Date:   Mon, 26 Feb 2018 10:23:24 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv4 01/27] repository: introduce raw object store field
Message-ID: <20180226182324.GA60857@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
 <20180224004754.129721-2-sbeller@google.com>
 <20180226093040.GA10479@ash>
 <xmqqo9kbr4u7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9kbr4u7.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/26, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > diff --git a/common-main.c b/common-main.c
> > index 6a689007e7..a13ab981aa 100644
> > --- a/common-main.c
> > +++ b/common-main.c
> > @@ -1,6 +1,7 @@
> >  #include "cache.h"
> >  #include "exec_cmd.h"
> >  #include "attr.h"
> > +#include "repository.h"
> >  
> >  /*
> >   * Many parts of Git have subprograms communicate via pipe, expect the
> > @@ -32,6 +33,8 @@ int main(int argc, const char **argv)
> >  	 */
> >  	sanitize_stdfds();
> >  
> > +	init_the_repository();
> > +
> >  	git_setup_gettext();
> > ...
> > +void init_the_repository(void)
> > +{
> > +	the_repository = &the_repo;
> > +	repo_pre_init(the_repository);
> > +	the_repository->index = &the_index;
> > +	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> > +}
> 
> I see what you did here, and I like it.

I thought this would be a good idea to do eventually but back when I
first introduced struct repository there wasn't enough to justify it
till now.  This definitely makes it much easier to read the
initialization and I prefer this over the initializer.  Thanks for
working on this :)

-- 
Brandon Williams
