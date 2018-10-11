Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116DC1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeJLEFO (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 00:05:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43565 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeJLEFO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 00:05:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id n1-v6so11105100wrt.10
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=icn1sdIod36KWWnKJfkNkCVTXEnzRnITftkTEKnOTpA=;
        b=nmIfsgbDsXeu+aNR6AVMkBHseCzu9lEFrnMbqgomC93kDOhJQJHUEkxQr70byGrWcW
         5eelUIpqsAu2epH5cc0Smt+oo3enRUBtJahUcBBBA4waKOgFMKdUiK1OaNMwfbCf4bNH
         OJsF1Ztnxm8+rLu5F1L/ilFsBEr25/aj/L4SG7oQlBmnq9hRSfpOFgpG8/W8+rTKaU5r
         AAKTwXglM2SDT5YpTgHvUb1h98MUKut/k6MJrK0UFr9oxFIZwIQKPqCehnL1+Alm/SBo
         /Iw3FDr/bQtEi//AF/0ryFXlGqdpxMJr1yPN7yRKw5gbQe4EFhahnBMXBfDw0g6jNri2
         Qing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=icn1sdIod36KWWnKJfkNkCVTXEnzRnITftkTEKnOTpA=;
        b=jZpx6H0xnF0H2DtgLwNmDM4w9hgkwcWPXPwKc9E/sNHuI1xGnooyS6rc9FseYjee3H
         8zPVdYHaLE6ofX55NPkatVhhh4VfJR3/nHkxEwiTjlouEHFbvS64vZgLig56HU5D2sbB
         Q4R4ChVZza32y7lYsyyOEj32ZGKcFcKFGYowXh6CqrTo0kgFu+MqW6cg4hgBLTOA7JmM
         PdQHAs6AF0v0peoXq6ig0PTuf/nmStOmrNWHA8j1IqeSzJLBgKC0G3h3kFsLfFGGdv48
         +6k2qNQUSJdR0Xhshj6dx0vzioveWEVqlhXCKn6pTL/evpBtol30XzFPNzBP+mceYObY
         ZlwQ==
X-Gm-Message-State: ABuFfogIm+9+PHM6aB4VUDNesSEsdlSdGp199tv66+IK/Xy7JgU6DOQ4
        fQPYZq9mGSFcx350gWgNQVkP0u8e
X-Google-Smtp-Source: ACcGV63SdNiv/+bxEB4Buf8kCPT0HtCTNfW61HKnuQwuOZ86KTnvdlUKvOUVTuB34RF9+clNA7BRew==
X-Received: by 2002:a5d:60c3:: with SMTP id x3-v6mr2998181wrt.193.1539290177836;
        Thu, 11 Oct 2018 13:36:17 -0700 (PDT)
Received: from rigel (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id o201-v6sm25933064wmg.16.2018.10.11.13.36.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 13:36:16 -0700 (PDT)
Date:   Thu, 11 Oct 2018 21:35:28 +0100
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: introduce --show-current display option
Message-ID: <20181011203518.GA2385@rigel>
References: <20181010205432.11990-1-daniels@umanovskis.se>
 <20181010205432.11990-2-daniels@umanovskis.se>
 <20181011003440.GD13853@sigill.intra.peff.net>
 <20181011154319.GA6386@rigel>
 <1409ebd2-d72c-fbd6-bf5c-777342723ca2@umanovskis.se>
 <20181011175136.GA8825@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181011175136.GA8825@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 11, 2018 at 06:36:02PM +0200, Daniels Umanovskis wrote:
> I am not a fan because it would be yet another inconsistency in the Git
> command interface.

The output of the proposed command is also a bit inconsistent with the
usual output given by git branch, specifically the space alignment on
the left, color and * marker.

In addition to not respecting --color, it also ignores --verbose and
--format. At this stage it's closer to what I would expect from
$git rev-parse --abbrev-ref HEAD; than something coming out of
$git branch; Resolving HEAD makes it consistent with rest.

On Thu, Oct 11, 2018 at 01:51:36PM -0400, Jeff King wrote:
> Yeah, I agree.

Not sure which parts you meant, so I'll assume you didn't agree
with me.

I doesn't seem far fetched to ask for an overview of my current branch,
feature1, feature2 and all hotfixes with something like:

  $ git branch --verbose --list HEAD feature1 feature2 hotfix-*;

The 'what's my current branch' could be just a particular case of this
form.

My defense to treat HEAD specially comes in the form that from the user
perspective, HEAD is already being resolved to a commit when HEAD is
detached (Showing the detached at <hash> message.)

Is there a strong reason to *not* "resolve" HEAD when it is attached?
Would it be that bad to have some DWIM behaviour here? After all, as
HEAD is an invalid name for a branch, nothing would ever match it
anyways.


Thanks for the input. :)
--
Cheers
Rafael Ascensão

