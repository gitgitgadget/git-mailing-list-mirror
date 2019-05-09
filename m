Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28C41F45F
	for <e@80x24.org>; Thu,  9 May 2019 00:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfEIAUH (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 20:20:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEIAUH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 20:20:07 -0400
Received: by mail-pl1-f195.google.com with SMTP id p15so203891pll.4
        for <git@vger.kernel.org>; Wed, 08 May 2019 17:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VRC7MtRSv4VShlNXgj9+DiMyA7VznxOySSaoWi0viEk=;
        b=kKjzdjWFEbVYrNcy1lVAUjhe1/xXpPFMSOlNn2IDkKKqEWSsd0goJEZvEABVz4jeN7
         hOFRboacHQLvcUr8HpcpWVdrX8LRDW9mDNCXB1qGDaYGkUrQKI8sJf40P8wiyK7M6dyT
         8gaALkGNWlxJMa8ZEytE/HXUtbt54nvJJwfRD85xjgdx+f9MTVO3dzd04YmdyHBYsLau
         vFOp6wDy0Zs40S9zonFxxZxILN2QSo/iRMQgjN0qTYK08wRtFXSlBvgm5tn0iHlK7Gi4
         y+gWIo0H2RmolZgwCIht8S2BWipwX4vB1v/1aC16lxPqbJIGoO85DxjTDHKv1au92NjV
         GVpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VRC7MtRSv4VShlNXgj9+DiMyA7VznxOySSaoWi0viEk=;
        b=buxQ9j6u0U61k/IcmBRzUkDvD2lwrQSicK64oT4a8cEv6uBOF8mf2D7AownQrWmqOz
         BD4PNp65ua3OOWGDq8hzydrcn6OKlXsm1fUp+ypNZv29acMvui6rL9ORo1qNsDsfeQx1
         3PhCdk3ZU+qaYc1RkcutGaocpP7EnZ99y7DNoHbcKoUYzyxOBZICBGRLbBlOx9ICTwc0
         hPJEsNw1S+E4rXdzL4a/LFPaggZpMCdAomR73dMho5t/sQqucI4Qu7+hyME0irJOtaCG
         m7vFDd/cyVZswCwZeKvGkHJP1bcB0AzEZcJc4JEdlF4BoDQ5f2n17gVWe3cs6IhGs20C
         SIpw==
X-Gm-Message-State: APjAAAXRpQKI5YH+2k40zzSEOBaiTleKTfsePhAB38COm33316eaRTn2
        kw757JSxxneEKZ0cLmCNqmGG4VeeENzOZg==
X-Google-Smtp-Source: APXvYqy4OFQlHIxf88mV+wkOzjtwr1lROh5LWbO3Po22KkGUedJyaV68mzei2O8JLnoQphcfx9AelQ==
X-Received: by 2002:a17:902:7e04:: with SMTP id b4mr870682plm.211.1557361205308;
        Wed, 08 May 2019 17:20:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id p2sm532274pfi.73.2019.05.08.17.20.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 17:20:04 -0700 (PDT)
Date:   Wed, 8 May 2019 17:19:59 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: Proposal: Remembering message IDs sent with git send-email
Message-ID: <20190509001959.GB14000@google.com>
References: <20190508231013.GA25216@homura.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508231013.GA25216@homura.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 07:10:13PM -0400, Drew DeVault wrote:
> I want to gather some thoughts about this. Say you've written a patch
> series and are getting ready to send a -v2. If you set
> --in-reply-to=ask, it'll show you a list of emails you've recently sent,
> and their subject lines, and ask you to pick one to use the message ID
> from. It'll set the In-Reply-To header to your selection.

It sounds to me like you mean to call this during `git format-patch` -
that is, `git format-patch -v2 --cover-letter --in-reply-to=ask master..branch
-o branch/`. That should set the In-Reply-To: header on your cover
letter.

There's also the possibility that you mean `git send-email
--in-reply-to=ask branch/v2*` - in which case I imagine the In-Reply-To:
is added as the message is sent, but not added to the cover letter text
file.

> 
> I'd also like to add a custom header, X-Patch-Supersedes: <message ID>,
> with a similar behavior & purpose.

Is the hope to store the message ID you choose from --in-reply-to=ask
into the X-Patch-Supersedes: header? I'm not sure I understand what
you're trying to solve; if you use `git format-patch --in-reply-to` it
sounds like the X-Patch-Supersedes: and In-Reply-To: would be redundant.

Is it possible you mean you want (sorry for pseudocode scribblings)
[PATCH v2 1/1]->X-Patch-Supersedes = [PATCH 1/1]->Message-Id ? I think that
wouldn't look good in a threaded mail client?

> 
> Thoughts?

Or maybe I totally misunderstood :)

What I think might be useful (and what I was hoping you were going to
talk about when I saw the subject line) would be if the Message-Id is
conveniently stored during `git send-email` on v1 and somehow saved in a
useful place in order to apply to the In-Reply-To field on v2
automatically upon `git format-patch -v2`. I'll admit I didn't know
about --in-reply-to=ask and that helps with the pain point I've
experienced sending out v2 before.

 - Emily
