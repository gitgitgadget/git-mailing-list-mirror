Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B87F41F4B5
	for <e@80x24.org>; Thu, 14 Nov 2019 21:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKNVzz (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Nov 2019 16:55:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40014 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfKNVzz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Nov 2019 16:55:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id 15so4635532pgt.7
        for <git@vger.kernel.org>; Thu, 14 Nov 2019 13:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p1NSQ0YRg+CFHKfJ5ca9Tg4pPyzZcWHfnuKn9yehbDI=;
        b=NxCeI0S2YWEr4/Rsv7stT2He2Uz/kB8nUurZpMJwjqNF9h/Hj4QWmMCehY8ZR9C3lQ
         nHPwNc+x8CHkOpznJyuD0ApKfDaZ81WuzX3/OkciRl32mH+Hbexh0QtIt60FNzVwiiB2
         sCox2277gVm87c64X0TCLa0jDl0xmw90Q4IK6vGY0fLUdVzv/8nUDsb2JVKe0w43XAgF
         VL+jPyfwr76tNahv5f+zbl3jKTH+9qHFE84SEEj07r7LggEsIYI3UC2+H/Ba94zOKHw4
         /hTSbX656hoXFCcnU2KrMgwcRzi4SQc4nuW/nAx6MXMLvHNDzSpXxuoyQMO18Yo1kKFO
         /iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p1NSQ0YRg+CFHKfJ5ca9Tg4pPyzZcWHfnuKn9yehbDI=;
        b=OQ1X7cAYSPlH7Ml7lWa5OP5UYTvLgcoE6sx1hhIjyJYEoSYZLfdfbT+yQesbiwDAux
         cIPwCdnpw8fxQzFSZWk6Tzgrsydg9g/fh9Se0kPERxErHlmomm4eJRGeSNj5tRrbx+q3
         HzIjtutX/y+6ms7qG59vBA8Mej//1PIN7UX/rVRD16iRCjUx5kEFttzwhNzv1ZRT2TbE
         3vrIUS7IHA0Q20356Z6WhxUKfMrfETn3sTO9sXtReXARm/T+ROPLG57Va/+YNajtidCn
         NyVApuuKpGcFZ3kBkvx0B9nD9xqMV4vM7UDrDtwRtjJ469n+B4SdBbUa0ELZLvyVsrFH
         H39A==
X-Gm-Message-State: APjAAAUQFYsmynACbxNUUn5BE1oIsxfGKDZV3XXqQFR9i6rj4PM/MDfG
        lXhACnFe1LG8ihW8rMhtOD7C0g==
X-Google-Smtp-Source: APXvYqzH1W1UvxvwbgY5oHvVkjkaqQyOM4tjtr21KmuQlNTo37pNtvjnVEo7YS/jICNJmYv4Q0F3AQ==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr12983448pgi.128.1573768553628;
        Thu, 14 Nov 2019 13:55:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id k4sm7999541pfa.25.2019.11.14.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 13:55:52 -0800 (PST)
Date:   Thu, 14 Nov 2019 13:55:48 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 4/9] bugreport: add config values from whitelist
Message-ID: <20191114215548.GC38770@google.com>
References: <20191025025129.250049-1-emilyshaffer@google.com>
 <20191025025129.250049-5-emilyshaffer@google.com>
 <20191029205823.GC12243@google.com>
 <xmqqwocn3tfa.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwocn3tfa.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 30, 2019 at 10:37:13AM +0900, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > This and git_config_bugreport() below should both be static as well.
> > Rather than repeating advice on the later patches, I'll just note that
> > any new functions that don't show up in the corresponding .h file should
> > be marked static.
> 
> Good advice.  
> 
> More importantly, given that "git bugreport" itself has no service
> of itself to offer other existing parts of Git (it is just a "gather
> various pieces of information from different places, and then
> produce a text file output" application), I do not see much point in
> it having its own header file that others would #include (i.e. the
> include file is to define services that are offered by it).  If
> there are common enough service routines invented to support the
> need of bugreport.c (e.g. perhaps it wants to give more info than
> what is currently available via the existing API on the contents of
> in-core index), by definition of being them common enough, they
> should be added to the header that can be used by both bugreport.c
> and other existing users of the same subsystem (e.g. if it is about
> in-core index, perhaps cache.h).

Are you asking me to have only builtin/bugreport.c and implement each
function there, and eliminate both <basedir>/bugreport.[ch]?

It may be true that deciding to put this functionality into a library
"in case someone needs it later" was premature, so I can do that - I
just want to make sure I understand you.

 - Emily
