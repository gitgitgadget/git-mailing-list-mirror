Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EB620248
	for <e@80x24.org>; Thu,  4 Apr 2019 03:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbfDDD0K (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 23:26:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45765 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDDD0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 23:26:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so594571pfi.12
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 20:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GxHwfTGOSW2Q7HP5Xbhkq6IKxJLVragVLO3TTSsXNwU=;
        b=dHM5FyYmNT9+6dwS7bZeqdB3L2u+B2rqFBRMrCmn/eIHfadhw1RI9rO4pM3Ai3ssl4
         uQyDffPBIQHfde+VYrWzDuLFWfJAcuUfrUb9TmAgFvrL9dKeDOgVWIcUtWzcW0+JEr5F
         lEAP28b04KH6SQBzgOyn0s4n8j2ZenzSnfRANtf9569axeRa+FzkNp510bI0cgxQsdn4
         1RbwzUfgUUUZCZEaXT1YlxL+nNqPsWfeKMcB8/hrFnoEpP7/nEtX5vfPgqBM0L57mFfj
         Eiylvn4tB99nvFs/QOw+CNEB95dyU/Eigx0iDB7ByVejcGaZpUL3BFmuwT6Q2lIOrLYG
         6Pkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GxHwfTGOSW2Q7HP5Xbhkq6IKxJLVragVLO3TTSsXNwU=;
        b=fuiNI0UyLikjq2YbTbZq5fhKCuQINSORN3cKPnYN1Htxf6UliNl3H3novlg/GySe9e
         ftMFd/k3w8JMzUO8yXRIGKHooWRcypEh/8ai8vWxFRtZ8Df5f9GuJqV8I/FmucyAFDt/
         QSOFL5qPkF8vPldM6Y27K8e0x9TwuQvmbCs8bCKaW8AvGAq+hK1l/oKuPBeGgNXP+3gf
         EB/pojVcdnfD+FHyUzsnf5pMl1BcifUciS6W1d+4Q2vq2WgIoPZ6qVIiTBE5Jm/jsV1n
         pWLT8PI0f1b/92BIVFUdVIq8wPZqLe7FNe6dIaQsWUSstUlFo12jlPERwEquvomurjNq
         aw4A==
X-Gm-Message-State: APjAAAU5L04ZyCfek543Eas4390t3xSMIudbDs3zQujx2qwvwIzbXaNT
        +pMK/AVOtd1+b8FtBDy1T7jkhQ==
X-Google-Smtp-Source: APXvYqy5wjDWnsRzJ+jqVsAEXntPsXQWILCpZdoNXaVBKj6lXLu9xLTME65K6fspTcKler7VW9eXUg==
X-Received: by 2002:aa7:8384:: with SMTP id u4mr3285556pfm.214.1554348368909;
        Wed, 03 Apr 2019 20:26:08 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:9872:5c59:bf42:220b])
        by smtp.gmail.com with ESMTPSA id g4sm31383593pfm.115.2019.04.03.20.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 20:26:08 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 3 Apr 2019 20:26:06 -0700
To:     Jeff King <peff@peff.net>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>, Git <git@vger.kernel.org>
Subject: Re: Feature request: Add --no-edit to git tag command
Message-ID: <20190404032606.GA39148@Taylors-MBP.hsd1.wa.comcast.net>
References: <CAHd499BM6M+=zRE1WFVXr7b+VhJHFeDind5xLqXcwZLv7QeDvw@mail.gmail.com>
 <20190404015744.GF4409@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404015744.GF4409@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, Apr 03, 2019 at 09:57:44PM -0400, Jeff King wrote:
> On Wed, Apr 03, 2019 at 09:38:02AM -0500, Robert Dailey wrote:
>
> > Similar to git commit, it would be nice to have a --no-edit option for
> > git tag. Use case is when I force-recreate a tag:
> >
> > $ git tag -af 1.0 123abc
> >
> > An editor will be prompted with the previous annotated tag message. I
> > would like to add --no-edit to instruct it to use any previously
> > provided message and without prompting the editor:
> >
> > $ git tag --no-edit -af 1.0 123abc
>
> Yeah, that sounds like a good idea.

Agreed.

I think that the implement is a little different than "add a --no-edit"
flag, though. 'git tag' already has a OPT_BOOL for '--edit', which means
that '--no-edit' exists, too.

But, when we look and see how the edit option is passed around, we find
that the check whether or not to launch the editor (again, in
builtin/tag.c within 'create_tag()') is:

  if (!opt->message_given || opt->use_editor)

So, it's not that we didn't take '--no-edit', it's that we didn't get a
_message_, so we'll open the editor to get one (even if '--no-edit' was
given).

This makes me think that we should do two things:

  1. Make !opt->message_give && !opt->use_editor an invalid invocation.
     If I (1) didn't give a message but I did (2) give '--no-edit', I'd
     expect a complaint, not an editor window.

  2. Then, do what Robert suggests, which is to "make opt->message_given
     true", by re-using the previous tag's message.

> I think it wouldn't be very hard to implement, either. Maybe a good
> starter project or #leftoverbits for somebody.

Maybe. I think that it's made a little more complicated by the above,
but it's certainly doable. Maybe good for GSoC?

> -Peff

Thanks,
Taylor
