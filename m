Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285AE1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 02:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbfHBCn0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 22:43:26 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:39574 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfHBCn0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 22:43:26 -0400
Received: by mail-pg1-f182.google.com with SMTP id u17so35270520pgi.6
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 19:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZPWYdK6cGMsrtGBbdBc/X5wLyyIF/dgIWlKG2SCLY7o=;
        b=sKUnDuzYhJaFt+Nt9fMrnxexa1ZC7WMbg30A/sjXZXB+TyVQGo7eLPwgswwR/gixwZ
         LttsMmI+rKqRNE/tkdOQm58sSqZ13Gb85J/qvyxyS9Yo3QpAn7uj5+Gs5mBEljIbVYPx
         XFDsFJtt7e4qlnjCaziOKomCeNpcrxnRLEo+/C74TrGDxGBxUdaEqEcH7rIRI9/WbWIG
         sIICimcdb1eHzJ/rG//7sI0UvBvTCb9JJ74Rmt9x59YZsy0Xb+D009ZW//w/mgFtGAoR
         s7Hlj0CE522D/IOiNculD27AyJws7qSmwzHgYRkad5xxNtm3JYw2XCLKXDN/6XtveK9F
         NyLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZPWYdK6cGMsrtGBbdBc/X5wLyyIF/dgIWlKG2SCLY7o=;
        b=cjTuHRTF1vmMz6z1pmmLZMhzg3YIum/dYYQUrcsKZi2Wy6VRIWhNg6JRtQfU+YKSY8
         ecGDMObYr1htk8ATq/gGZ2+DHiJoMlLyzZlpy+VV33q5jLPrY9nhut/t2QoSnirCTt22
         qY/G+/midX5+IuHbDu8CZjEllgAGnsKccsls1ZNCKfhR/2+KoYZgTmKUBXJNKwz9JXLe
         e3kElx1/QSZpAI6Ac1jCBh/bH8A9PoNTQ+O0SoJVPn8CZjBa/wE5nszVsSUbsVJixeML
         mdwMg3oIKybMSueEnMQrTIzyLBCa91e00E0kS9Blcu69zRGeJ2B4YasSadqJ4jEIl60y
         PtFg==
X-Gm-Message-State: APjAAAVghQycRKPGPJZGpC6dRwvW52utbcloGmsne6S3crT2w3lYZtR1
        vc+sx8u57STodKhNcrVNKBE=
X-Google-Smtp-Source: APXvYqyArYh/9OQQISt+oP8OA8EnWJqgwA8OefLyGdXxPBrT1ykAJ7XJFAOyTZmyGG/yzoiaEmDjxQ==
X-Received: by 2002:aa7:82da:: with SMTP id f26mr57328499pfn.82.1564713804994;
        Thu, 01 Aug 2019 19:43:24 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f15sm59866531pgu.2.2019.08.01.19.43.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 19:43:24 -0700 (PDT)
Date:   Thu, 1 Aug 2019 19:43:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Alexander Mills <alexander.d.mills@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: cannot clone --single-commit instead of --single-branch
Message-ID: <20190802024322.GC54514@google.com>
References: <CA+KyZp6mYx4C22syAu=W2Okf7tDwtQ+7vVUBaQ-2D70PTS+GaA@mail.gmail.com>
 <CAGyf7-F2qs2=51hdA-1BB=12w7GiwaVZ974eYKFzu-=OKj8Q=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGyf7-F2qs2=51hdA-1BB=12w7GiwaVZ974eYKFzu-=OKj8Q=g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Bryan Turner wrote:

> Promisor remotes and other in-flight changes might help provide some
> of what you're looking for, but I'm not aware of any already-available
> solution.

You can do

	git clone --no-checkout --filter=blob:none $url repo
	cd repo
	git checkout $commit

That gives you commits and trees from other commits, but the only blobs
it downloads are from the named commit.

Using the existing tree filtering features to limit the trees fetched
and/or writing a patch for commit filtering are left as exercises to
the reader.

Thanks and hope that helps,
Jonathan
