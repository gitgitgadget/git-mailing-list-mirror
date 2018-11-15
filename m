Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 232A21F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 19:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeKPFfd (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 00:35:33 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:46537 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeKPFfc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 00:35:32 -0500
Received: by mail-pl1-f170.google.com with SMTP id t13so6968018ply.13
        for <git@vger.kernel.org>; Thu, 15 Nov 2018 11:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hx0OSqw+YQz7JfZw6ttnmr5iX9gRLSGWslkzcTLxPiw=;
        b=S/kTigEWxndAqXWfiRLcLUslBdp9X9enDGflKyO7oN4BL5ib/xspu90i/s2PfUieOK
         ToefcuKCjua6BFuJNHH1Q/tD3EdCoE2rDl3hn8e45e+mb5DgY9pVV5cjPRNFUzf1wL5u
         fhHWPlEA0apTeR2z5KohztmxIwLOwaWahn9yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hx0OSqw+YQz7JfZw6ttnmr5iX9gRLSGWslkzcTLxPiw=;
        b=qHgEU1WyZNE2g3zufBny5tdy4QL/wocSig1jV+bvzRh38s2Y+tr/pt8u/35vRuwmSw
         /BWDVdn+TvCM9nrrv57f1UMxQSGUlYAlYPJZwe3sGbPODjpY3My06I3aON7UoCjuK1Fe
         f0t3HbD2CXulw56i5SB3XBn7CK/cls+vGBObpvNfDiW/wwi/VHR8x9kuLtTJkeQ9HNql
         ZmRnPk48TkmcW61nQ87j/a0reMNDWAs6qZ2+Qg1aOg2ia04Cl6aNxlgLyiDoqvgK/ehR
         tHh2oY2TNEkl6tAVpJCAKNF4F0Bdi9kJ2EDENNrs+dVjPrX/4zSI/hAKNyTySUUueoXc
         r3Cw==
X-Gm-Message-State: AGRZ1gKNpFKvdzdd+69iepxjnK6Rsys5hqYHVjnYx+TGrfCQnd2WJapp
        F1O7Ya6SmJdtINYa1sAaIeFqNCafIi0iZg==
X-Google-Smtp-Source: AJdET5eLc6qIy39wFF3JgCrOZVF4ry1gSTmPcI79YxtbvG6MPmhjz2pkKKV1ednUjTvYlt6OUgca0Q==
X-Received: by 2002:a17:902:b091:: with SMTP id p17-v6mr7399775plr.222.1542309987178;
        Thu, 15 Nov 2018 11:26:27 -0800 (PST)
Received: from pure.paranoia.local ([172.83.40.72])
        by smtp.gmail.com with ESMTPSA id b14-v6sm39805615pgn.49.2018.11.15.11.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 11:26:26 -0800 (PST)
Date:   Thu, 15 Nov 2018 14:26:24 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: insteadOf and git-request-pull output
Message-ID: <20181115192624.GA18204@pure.paranoia.local>
Mail-Followup-To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Borislav Petkov <bp@alien8.de>
References: <20181115182826.GB25806@pure.paranoia.local>
 <87pnv6189j.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnv6189j.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 15, 2018 at 07:54:32PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > I think that if we use the "principle of least surprise," insteadOf
> > rules shouldn't be applied for git-request-pull URLs.
> 
> I haven't used request-pull so I don't have much of an opinion on this,
> but do you think the same applies to 'git remote get-url <remote>'?
> 
> I.e. should it also show the original unmunged URL, or the munged one as
> it does now?

I don't know, maybe both? As opposed to git-request-pull, this is not
exposing the insteadOf URL to someone other than the person who set it
up, so even if it does return the munged URL, it wouldn't be unexpected.

-K
