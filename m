Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36421FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdBHWhO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:37:14 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34599 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbdBHWhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:37:13 -0500
Received: by mail-pf0-f182.google.com with SMTP id e4so44537086pfg.1
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AOfjfbiDGmeJYmpsvETCigASYtJkKZRwiP7K4HQQkE8=;
        b=leT5SW/TDuqUiIcNRJH2PHNgE8E22YP2K9nqXGD+6Hjr3BpfS9xSe5Yw5WFRBi46mb
         j5KJYlb70xSz0MY7kb2OYgcbnEDvfDOCe1TodtbWzm6beVGuRedPUOzvGgB7ZX7woonK
         9Jfu7s7X0fSxdh6py/VNmNra/Wl9RdWqQFlWhMR34VNpNMz4wRo089psCt5V8aXHQdpg
         1dVNq5OxDCInTL5JUj2s3r0y8EmRPHzGm0CjFgxSKICQgWaKnr4upCrMm8iWdH3Eex2M
         FKTpL3T3ROsNO7B8LoHI2yp2YfET2rcp/1D9cJTbItKTVc8GyTaJguLSJhtOblmkmnX+
         g8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AOfjfbiDGmeJYmpsvETCigASYtJkKZRwiP7K4HQQkE8=;
        b=do41ggnEidCh2iMcD53NPKTPSHx+IOD7ALUwY1V7NQDhlIs6UeHP9hwCCs2427Xmnl
         M2Di8vhoR43jUzQfp1EcMaXNFd/Zl5BPaZGzBa5t8/jNNuZyLHqeCTO6K17dlRA2h0+T
         P+2O3pGd+ucgtwE+AItXYkSmU9B2F3aNCtwSfeJ18VBcgPMzKlGDt0ejy1MZQUze5YUj
         RmAXXS5ASCrlhOXlQk9eEiyDTDbasmyBM+8gwm+gInmtAJCQkPMHxdGn1j07Fw9MXsoF
         jAXtY1HCSODcLjbg2o9qGSBrErZ/sZ+ws8SijZUcbgNd2Nh/wfCErMTmlNA7NsDz/L5b
         oU1Q==
X-Gm-Message-State: AIkVDXKrF6r1mGAi00nPwBT36LXYDvGZnyzyQVhUIPSAXQcDhJIi0AWxwzsL9bR2n6tvCUKl
X-Received: by 10.99.108.74 with SMTP id h71mr28989655pgc.99.1486593334201;
        Wed, 08 Feb 2017 14:35:34 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:2d1c:e524:99eb:f617])
        by smtp.gmail.com with ESMTPSA id j7sm22801182pfe.84.2017.02.08.14.35.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 14:35:33 -0800 (PST)
Date:   Wed, 8 Feb 2017 14:35:32 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] pathspec magic: add '^' as alias for '!'
Message-ID: <20170208223532.GB108686@google.com>
References: <alpine.LFD.2.20.1702072113040.25002@i7.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.20.1702072113040.25002@i7.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/07, Linus Torvalds wrote:
> 
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 7 Feb 2017 21:05:28 -0800
> Subject: [PATCH 1/2] pathspec magic: add '^' as alias for '!'
> 
> The choice of '!' for a negative pathspec ends up not only not matching
> what we do for revisions, it's also a horrible character for shell
> expansion since it needs quoting.
> 
> So add '^' as an alternative alias for an excluding pathspec entry.
> 
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  pathspec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 7ababb315..ecad03406 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -224,6 +224,12 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
>  		char ch = *pos;
>  		int i;
>  
> +		/* Special case alias for '!' */
> +		if (ch == '^') {
> +			*magic |= PATHSPEC_EXCLUDE;
> +			continue;
> +		}
> +
>  		if (!is_pathspec_magic(ch))
>  			break;

I like adding '^' to be an alias for excluding patterns.  There have
been numerous times where I have wanted to use exclude patterns and
forgotten that I've needed to do some escape magic to get my shell to
leave '!' alone.

The only issue I see with doing this is that if a user supplies an
exclude pattern for a command which doesn't support exclude pathspec
magic the unsupported_magic() function will have slightly cryptic
output.

git cmd -- :^dir

would produce some output which says:
':^dir': pathspec magic not supported by this command: 'exclude' (mnemonic: '!')

And the user may scratch their head for a second since they didn't
supply the '!' character, but rather '^'.  That being said I think it
should be fine since the long name of the magic is also printed so the
user should be able to figure out what's wrong.  I also don't think
there are any users of pathspecs which disallow exclude magic so this
may not even be an issue.

-- 
Brandon Williams
