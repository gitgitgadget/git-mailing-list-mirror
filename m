Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7070202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 22:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935787AbdIYWQM (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 18:16:12 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:49400 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935505AbdIYWQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 18:16:11 -0400
Received: by mail-pg0-f43.google.com with SMTP id m30so4798531pgn.6
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0mJLVUa/5IafcCJBWjAOWBGv5y6Nb2wJWR+DB9Htwps=;
        b=pIeWL+bDB21esMA67NlDDxRhfuFGqhj2NADkH/EcOwDbdYDHDneeqQjlNaJdnXsJJf
         kC4K9vXGhJOh5RcwFn4AbZs7qkL9Yj1pN4uRvTwV//pvH+VthCMfrts5AlxMt1kdL5gR
         1ggSqk8ePDvKM9HyXXDiHUGVHeerud3TJHhexfhkajjz8i4VjvowkpjfzWIlxmA1dj40
         WOFQEH8PObASv/i24GqqxlZAThUbq1dG0lYWlls1AeNsAw+zcu9zmFFuc7EvQ4MLtTO4
         HtWhrpBnh2fhQD77Wpjd2+9hFcWA8JXIDGMiTO6OHieMH2Qecg9CA+PBg+xQQSvzd+Bs
         vXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0mJLVUa/5IafcCJBWjAOWBGv5y6Nb2wJWR+DB9Htwps=;
        b=Qklz7cbAm2jSpANUawtxP4laTM2R0eDjYq1bjQPlmjMj8ybkNTtTACu3CB1tyFlngG
         Zp8ztOzvw3E7uJlcqpsSkNqhlJ8kLnJUQg7V7dl63Yu1ce7cja82X0tHko8h3BXaEiJb
         Bt74kIfv4Co8OWa4dEZwm0Ns9V7LfoPZtWEAj2zRKw+nSEYU2oBQZOqRPIjLOpi7xBXi
         0Jj7yvMEUlV62RuNmuxcYD4l41FRFkv8a3McwRFXMqlyh6a1t6XQCDrOlP0pFXYO9w3o
         QSY6z6x6NevyfIHLLZw/aBgdXK+FrPDyNPL3IQgjePHPxXxlMVQTyc/fMUhoVd2VCXzE
         k/Pw==
X-Gm-Message-State: AHPjjUgxAGLmWxwgWFJv/rrNUnFFX8JRk6QxwrgDhuRkcaAIrQsIO3LZ
        X8nqgFqdtuO7IXRgTUZQvDY=
X-Google-Smtp-Source: AOwi7QBi7afRqDl+/Mpq8mBRRolDvcTYaYbXkAJtsJ2Py547r2Bfj3WL+zKmdkM0OZOOepPKmofy5w==
X-Received: by 10.98.89.151 with SMTP id k23mr9065988pfj.69.1506377770909;
        Mon, 25 Sep 2017 15:16:10 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id s86sm12136556pfi.74.2017.09.25.15.16.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 15:16:10 -0700 (PDT)
Date:   Mon, 25 Sep 2017 15:16:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 7/7] add xread_in_full() helper
Message-ID: <20170925221608.GF27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925203323.rmm3i5kx266ma3wu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925203323.rmm3i5kx266ma3wu@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Many callers of read_in_full() expect to see exactly "len"
> bytes, and die if that isn't the case.

micronit: Can this be named read_in_full_or_die?

Otherwise it's too easy to mistake for a function like xread, which
has different semantics.

I realize that xmalloc, xmemdupz, etc use a different convention.
That's yet another reason to be explicit, IMHO.

Thanks,
Jonathan
