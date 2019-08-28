Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8E721F461
	for <e@80x24.org>; Wed, 28 Aug 2019 06:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfH1GqC (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 02:46:02 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34451 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfH1GqB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 02:46:01 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so3832679ioa.1
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 23:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MlGqD6mvSv4asdKatGBK2o6i7AnjbohAQWVRrJVpm7Q=;
        b=d5Ea9UFXd7ZiSJBy7rKTCux1wXFuSqNBvRFu5l1e3uqDJ65hRMrwXNu1vG6GVlOd2d
         +MA2TgMALhyDdu+srjtU/xiihCPQYZJWwtEYHbC8Gr3KeVRpnZ4aT30HOENAvvcgPDSZ
         LZGLefQFoZj7C2ixv4wGQUdByH2m3omwio7VcZB+toif0VzmB5llMYvmc1b1O/dQIVHT
         dJqwfHAprRnU7A8coWLh7eKbiyTmpS66Ul7NKoewMpZ/GlGFsMOhoJ4/e5aal8SELQWL
         kcGdSUa7Z3LEoyF4R1RVoePfzR5JpThd+CxrR/G40PDhCF3UAABABKFl5X7hdzT1GXuC
         hk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MlGqD6mvSv4asdKatGBK2o6i7AnjbohAQWVRrJVpm7Q=;
        b=OJd/vO+ER5eKG72+IR60yZYjexY7w5zfmmE88TE0S0kl31/Ob2fH9HQEzr+Vwdp4Zq
         o8zrQ0LvswE+iCPwHz/GlLLbamGCd6e44FNByA6zuXg1qiEndLbau6yG5BYcYpnjqCWj
         0DddUrCJrHzPByfQmMvMK91EBErSaQmfbqewue3C9c/Ozx4Ey44YGz5EaC8GTWdujT9S
         PaJGvCUNkd8wN6+DMoCkCuOKlM1gfqteD817t5sbrzSmGW1gYOb5gDydrA7RcX9YD8Mg
         GijHW/I7/B3zYBorTHVILOn2YBjwDtjb/uHsAL6af9Mm8D/529ZDZISiZeR1ww6Rj1BL
         cJLQ==
X-Gm-Message-State: APjAAAX5MLFyzFj7KX2Z10rfx8lY3q3AyVNpsdXeLZICATIcyalpafH/
        96GNUwZH8bWzHDd/D1VoB30=
X-Google-Smtp-Source: APXvYqyZu0AwGb2GjbR7LX/U+hRMbHdftWXFh/2YJeY3QiQ6Ny0Om4xwnSseRU1are6pbCZPBXRt9A==
X-Received: by 2002:a5d:9dd8:: with SMTP id 24mr2511438ioo.249.1566974760870;
        Tue, 27 Aug 2019 23:46:00 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.89.95])
        by smtp.gmail.com with ESMTPSA id o2sm1220233iob.64.2019.08.27.23.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 23:45:59 -0700 (PDT)
Date:   Wed, 28 Aug 2019 02:45:58 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] status: mention --skip for revert and cherry-pick
Message-ID: <20190828064558.GA2399@archbookpro.localdomain>
References: <cover.1566637431.git.liu.denton@gmail.com>
 <cover.1566880835.git.liu.denton@gmail.com>
 <be64ce1e92c60f9587b137d36e98532604d4a1ff.1566880835.git.liu.denton@gmail.com>
 <xmqqef162rx2.fsf@gitster-ct.c.googlers.com>
 <xmqqwoey0zwa.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwoey0zwa.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 27, 2019 at 07:47:33PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Is this a good thing, though?
> >
> > Giving up (because you do not have enough time or concentration to
> > finish the cherry-pick or revert in progress) with --abort, and
> > committing to the resolution after spending effort to deal with a
> > conflicted cherry-pick or revert with --continue, are both sensible
> > actions after seeing the command stop due to conflicts.  Is "--skip"
> > a recommendable action in the same way?  Doesn't a multi-commit
> > series often break if you drop just one in the middle, especially
> > if the series is sensibly structured as a logical progression?
> 
> Addendum.
> 
> "rebase" (especially with "-i") is fundamentally different from
> "cherry-pick" and it makes tons of sense to suggest "--skip" in the
> former.  "rebase -i" is a tool to take a messy work in progress and
> polish it by reordering, discarding and combining commits.
> "cherry-pick" is to take a finished work already in one integration
> track, and transplant to another, often an older maintenance track,
> and there is no place for "this conflict is too much to resolve so
> let's drop it".
> 

I still believe that it's a good idea to let users know what all of
their options are, including the --skip for cherry-pick and revert even
if it may be rare that it's the right thing to do.

That being said, I'm not passionate enough about this change to pursue
it so when you queue this patchset, please drop this patch.
