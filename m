Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7BB11F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 14:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJJVrL (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 17:47:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39262 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJVrL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 17:47:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id 61-v6so5972228wrb.6
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Qt0SkGoQcKAdZozDP/WYfDMHhtJrwoT8HlfTiy36ieg=;
        b=cNpsRs2OCsqZ9q2ahQe5wSWOpjsxlR2WtnaeikPY/BdRU1Q72gz1eLK6e+/jp6FIFC
         3yvbW+1hpqeGW6M6zkfRAR0H0Ulq5lZaSuFgyqTcLZRXZfrJW+KttxpnFjUwMft1Jjem
         izPD+eCaQP8yTAjtSjkl+wl2jJp5KbgtfZ2JjKPUjagYKzu5PI2eFQv/CBIzF0a8TeW9
         VgSXs4AJKdFK0isQkOmeGkiCbW5ZyqRwUW4zlnlhdhM9FjibijutCMvkBpwTAjWVnfL/
         e1a26nZ+ABd0tqSii/404Qos5CZmYStxZ8lVN76oQZIkHcrDT4YWA+BvmIy1qb+f5oql
         TsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Qt0SkGoQcKAdZozDP/WYfDMHhtJrwoT8HlfTiy36ieg=;
        b=Drhi7uUrPME6AGj4vo65VN87u7vuqU4sGkkSivRGFuXz/qr5nBjNjb8Yz70nSsbkzS
         KBAd9AWobR6x4QkJiPE2n1EF86DBMD0P482pbukpUb1ivtfIMDzF/e5mNZQII6Ex82p4
         VQfHzvfcqF3eDnfYKpAS5BX21lCAdiKBV7JNGYHWofY+HTsVwYpzRQfbYv8krrOlgx2G
         wrK8Ice4i0ql+V5042Z6sFEOnq7DAkgVHotl0Fyko1kAtDkIQsTBjjbtDUzKJ3QEDs+G
         cv4j4gnDDeOFO9DkI0chKez8EEEKPeqL0Vp824tbBixASqs0ab3Nm5DMiYtUatosR4t9
         U1rA==
X-Gm-Message-State: ABuFfojUBmHNF/ApB9TqwfHeVIddxofq+IJL0pIcADuonbwDtafaT/i+
        J3sCpc4M6aVocBkZxNh16ec=
X-Google-Smtp-Source: ACcGV61V05wHOBowVCjTT11K5v2GLIeEpqb+rOjJ4mgQq34GhEcEGMv8TuRg9+9CFry58gYpSfsnQA==
X-Received: by 2002:a5d:44ce:: with SMTP id z14-v6mr20395998wrr.286.1539181485138;
        Wed, 10 Oct 2018 07:24:45 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id q200-v6sm18424689wmd.2.2018.10.10.07.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 07:24:44 -0700 (PDT)
Date:   Wed, 10 Oct 2018 15:24:34 +0100
From:   Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] branch: introduce --current display option
Message-ID: <20181010142423.GA3390@rigel>
References: <20181009182006.9446-1-daniels@umanovskis.se>
 <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8t36q1k6.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 05:59:05AM +0900, Junio C Hamano wrote:
>
> But I do not think that is what is going on.  There is "--list" that
> lists branches whose name match given patterns, and at the end-user
> level (I haven't seen the implementation) this is another mode of
> that operation that limits itself to the one that is currently
> checked out
>

Given the idea that showing the current branch is a particular case of
what --list does, one option could be to treat the 'HEAD' pattern
specially.

[After writing another version of this email, I found that we
already special case the pattern 'HEAD']

$git branch; already treats the 'HEAD' pattern specially to print
something like: "* (HEAD detached at e83c516331)" when the HEAD is
detached. But returns without output when the HEAD is attached.

We could make $git branch --list HEAD; print the current branch
paralleling nicely with what $git rev-parse --abrev-ref HEAD; already
does when given attached and detached HEAD; But keeping the perks of the
more human-readable output (color, * marker, formatting, etc).

Since the output of git branch isn't meant to be parsable, changing this
behaviour shouldn't affect users, and introduce the feature without the
need of new options.

But I suspect this approach may be diverging from the spirit of this
patch.

From my time spent on #git, I find that the concept of 'HEAD' is
something that many new users misunderstand. So, if the original
motivation behind this patch is to be able to determine the current
branch without using the concept of 'HEAD', my suggestion falls short.

Cheers,
Rafael Ascensão

