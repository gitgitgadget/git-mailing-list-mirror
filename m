Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA0F1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030233AbeFSRy0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:54:26 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38873 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966706AbeFSRyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:54:25 -0400
Received: by mail-oi0-f68.google.com with SMTP id d5-v6so532600oib.5
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=balZsMvAgCr3nvQ5gs2dhItFjmvpBabErEf66dvhrbU=;
        b=mkbWIUJM+3EyQP97a0eIcBmoAhC0QOvhJ0nfW4JcXO6Z//TPe0t8EEXESRabC+uBUP
         +Vyf1Nwx/UXeOT8k2aPzv5u1wEQuLlRy3w1hnOyUvJyK0lUVH251bRdgxidLJcPjiUEW
         7XFry0aut9LvhgiMGVHmpVoZUjHHB/JQKxzpCFd5zqQIDNdKtKx+/Q+oBkxYoaYCa/td
         reJo3tvnIOAv/eYf3Tqcy3DBS+uu56vDOmbIv7uZN0Ib8GrriJrIF9myTTSA4mRLQWwc
         3fPs9zthqKcQJSVOHfQs8i9zRh1OvBuv316spdNKySpc8cdyNxi4gXLC2CD/566kmGui
         NKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=balZsMvAgCr3nvQ5gs2dhItFjmvpBabErEf66dvhrbU=;
        b=NdBEiNmgQOLasn1a3e7BSaokqg/qL9cOg/351f+6Gv8YgTmxd7PLMaY/Wzx+ruqU/l
         FYpMqelilYtvLNRpDRVC07zk8ILjZOISAEBsnaBXtnqjo0+JkVrercluGwJDTwPeWDta
         i3pULXxtAr8XOn4ZD5m8moPXpMFRM2xJbsIRRIZc30Gj/7DD2ph+Ci/oAdxr8UDoWwHc
         7fJqI8HsBMtfNVEQgCdF6SoJ1O7tpO9o5CepdCj+SYVXvCzZ/6k5H8A6HYRpMlGJeral
         j25Ls5MuEr9ZAQHxkvL7kOkM9UjiM4djhSmRMcSffN9i46ka9CQKJUIAdJu2wQAfNkgc
         Tkjg==
X-Gm-Message-State: APt69E3Z7InMIYZaoJZr1F/21AnTPRQ87J0zDeqfIMJdAZ4OVaLezOe2
        FK8uoZIWz7fpSmgsHRo2J69C1Q==
X-Google-Smtp-Source: ADUXVKI2oBF5j4gWVWn51deVq+PIubsjqKCrPbd1ByQuUHu2CzwP2XhSvqcq5gws0930vCIF7W23hw==
X-Received: by 2002:aca:a6cb:: with SMTP id t72-v6mr10511527oij.261.1529430864847;
        Tue, 19 Jun 2018 10:54:24 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id h10-v6sm105887otf.81.2018.06.19.10.54.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 10:54:23 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 19 Jun 2018 12:54:22 -0500
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619175422.GA48866@syl.attlocal.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174846.GA27820@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180619174846.GA27820@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 01:48:47PM -0400, Jeff King wrote:
> On Tue, Jun 19, 2018 at 07:33:39PM +0200, René Scharfe wrote:
> > Disabling that optimization for --column wouldn't be a regression since
> > it's a new option..  Picking a random result (based on the order of
> > evaluation) seems sloppy and is probably going to surprise users.
>
> I don't see it as a random result; short-circuiting logic is well
> understood and we follow the user's ordering.

Agreed. I would prefer _not_ to apply the patch that I sent to René,
since I think it adds more complexity than its worth (precisely because
the short-circuiting logic is known, though certainly the problem gets
worse as the expression tree grows).

> I think the place where it's _most_ ugly is "--column --color", where we
> may color the short-circuited value in the second pass.

Agreed again, but it's worth noting that --color is the default. To play
devil's advocate, the use-case that I imagine will be most common is
with "git jump," so perhaps that doesn't matter as much.

> > We could add an optimizer pass to reduce the number of regular
> > expressions in certain cases if that is really too slow.  E.g. this:
>
> Yes, we actually discussed this kind of transformation. I think it's way
> out of scope for this patch series, though. If we do anything more, I
> think it should be to disable short-circuiting when --column is in use.

Piggy-backing on what I said to René, agreed again.

> -Peff

Thanks,
Taylor
