Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17EE81F954
	for <e@80x24.org>; Thu, 23 Aug 2018 18:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeHWWBy (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 18:01:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41964 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbeHWWBy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 18:01:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id z96-v6so5411633wrb.8
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F8PuDym/eGlKV7SnX7jQ7xC1pt4tRp/U8r/17B1OpZ4=;
        b=mpHQUpM/QczBpCUs+rUDGSA5ySXrvFO9Th9TrxMfRyn9ivINqrR0rMMAGFAZO//oUq
         1zPvVnDRdo6YW4jUqLlMNA1gCFcl3D5Tfb2HPwAITnAwtBHFGD3Hnrb03ivqdo/Qr15N
         iMRGtaxdK+QSYBnBFUh7mZycblEyx8kHE1kb7BLbdX+jILbirTnD2Kv6j+jCbbFucHbM
         CzE77HpBlq1xvgmKjLOtAz4f84rP9bo9kcK8kn4b5VeZ+u8xN/fa7CyhgBKFCPy3DU5A
         8kS5Yq3wk3p+64EhW66ZSobNVE1LBr9Spcew2in1fJ7RQRQSowOnFtsgfjmpO+ACXC5W
         0zqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F8PuDym/eGlKV7SnX7jQ7xC1pt4tRp/U8r/17B1OpZ4=;
        b=VR20O6ctQGnA1lm5mMRjv4ojl/tkvZ+cBEUNuB8Y6tp0vV7hUO2CJNXn6mL6C/ulu+
         VbnWE1dy7KbCSXBKJFo54yYWRY4P6ZuixDsn22wRlE3YNu+YpKZunm4aD0g+fYGyHauC
         m+xpAKW+qalhHIeJrGNCS7O4sdSdDH6uTkhkeV6a4uDxykCBeJxFqSKVr4IDXxQhaZ0W
         0q/8cEPWiWPieOVawdFY6DTGM65NL7cUYN5MPtIm6y5lZ0YKsyXlPWjcKFLag0+2fepq
         oxxh2vEtS3Qr70fXJIjVARjGxcomwTmul9941tJfsvL6STfqbGAvf5HJeVAmuqc2C6tI
         tMGg==
X-Gm-Message-State: AOUpUlHWNsaOtGbSVLZrehQ6BZxDNVsqkUGZTJYIPOKPHfDcGI9BBxNQ
        J6DSqnUAQO42ONhsgokkEpDMlmZI
X-Google-Smtp-Source: AA+uWPy9MLdXmubY4jOVJdcO/GAp4C/sMiac+C2tgNZF8SI6RpojdTTqd9WiwHGjgldm805UuwZcxg==
X-Received: by 2002:a5d:514d:: with SMTP id u13-v6mr39873129wrt.162.1535049056173;
        Thu, 23 Aug 2018 11:30:56 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 34-v6sm6952220wra.20.2018.08.23.11.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 11:30:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/9] trailer-parsing false positives
References: <20180821184140.GA24165@sigill.intra.peff.net>
        <20180821190705.GF30764@sigill.intra.peff.net>
        <xmqqin438pze.fsf@gitster-ct.c.googlers.com>
        <xmqqbm9v8pou.fsf@gitster-ct.c.googlers.com>
        <20180821200747.GA21955@sigill.intra.peff.net>
        <xmqq36v78ml8.fsf@gitster-ct.c.googlers.com>
        <20180823004300.GA1355@sigill.intra.peff.net>
Date:   Thu, 23 Aug 2018 11:30:54 -0700
In-Reply-To: <20180823004300.GA1355@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 22 Aug 2018 20:43:01 -0400")
Message-ID: <xmqqefephr4x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So this turned into a bit of a rabbit hole. Here's what I have so far
> (which I think is not quite ready, but I wanted to start discussing).
>
> Issues (2) and (3) are actually the same issue. The caller that does the
> bogus appending for (2) is always append_signoff(). But it always has
> just a commit message (modulo some complications, which I'll get to in a
> minute), and so fixing it with respect to (3) magically solves (2).
> I.e., the code was simply not prepared for the case of "end of string is
> not end of trailers". But since that case cannot exist, we do not have
> to deal with it. :)
>
> Now here's the tricky part. I think patches 1-8 are mostly sensible.

Yeah, nothing that made me go "Huh?" in these 8 patches.  Thanks.

> So I think there may be further opportunities for cleanup here. I'm not
> sure if we'd need to retain this behavior for git-interpret-trailers.
> AFAICT it is not documented, and I suspect is mostly historical
> accident, and not anything anybody ever wanted.

I tend to think the behaviour was not designed but it "just happens
to work that way".

> If we do keep it by default, then the "--no-divider" option I added in
> patch 4 should probably get a more generic name and cover this.
> Something like "--verbatim-input".

Perhaps.  Even if this is not covered, --verbatim-input would be a
good name for the option ;-)

> I'm going to sleep on it and see how I feel tomorrow.
>
>   [1/9]: trailer: use size_t for string offsets
>   [2/9]: trailer: use size_t for iterating trailer list
>   [3/9]: trailer: pass process_trailer_opts to trailer_info_get()
>   [4/9]: interpret-trailers: tighten check for "---" patch boundary
>   [5/9]: interpret-trailers: allow suppressing "---" divider
>   [6/9]: pretty, ref-filter: format %(trailers) with no_divider option
>   [7/9]: sequencer: ignore "---" divider when parsing trailers
>   [8/9]: append_signoff: use size_t for string offsets
>   [9/9]: sequencer: handle ignore_footer when parsing trailers
>
>  Documentation/git-interpret-trailers.txt | 10 +++-
>  builtin/interpret-trailers.c             |  1 +
>  commit.c                                 |  6 +--
>  commit.h                                 |  2 +-
>  pretty.c                                 |  3 ++
>  ref-filter.c                             |  2 +
>  sequencer.c                              | 20 ++++++--
>  sequencer.h                              |  9 +++-
>  t/t4205-log-pretty-formats.sh            | 23 +++++++++
>  t/t6300-for-each-ref.sh                  | 23 +++++++++
>  t/t7501-commit.sh                        | 16 ++++++
>  t/t7513-interpret-trailers.sh            | 42 ++++++++++++++++
>  trailer.c                                | 62 +++++++++++++-----------
>  trailer.h                                |  4 +-
>  14 files changed, 184 insertions(+), 39 deletions(-)
>
> -Peff
