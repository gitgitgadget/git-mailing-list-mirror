Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975EC1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 10:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404692AbfFLKZm (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 06:25:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46345 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391669AbfFLKZm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 06:25:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so16235866wrw.13
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 03:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cHDGM3UL1xdgDL+HQFTyZECNRtZVznhFuhHpdAo8ZV8=;
        b=TGDqCnH1ParCXUmjV0mwidYxsmsvFwYyfG4vHTjG+xMwI/Aj9u0ftwFF2aKwyKW4sh
         EH4++GR5K7nXIKS2JQSNdObEQzxgPSQKXjOPuCyswP1922tg/CvB/pDt4r1TzdKnhHwv
         JaUutBid9HrcbWVDbHpmI+NlQNfJTJGNDZhMkvzteaW39cYOqMEwV3FqE977JV6aYCGf
         5qa2qj1v4yCy7qDdT782S28kV20bdV63MX5VKMaCN3b5uNNHK57kXF50GmhLwlZ5DkNK
         EGMmryhxdnmGL4XnysoD/QvAqZUnIYZuQORzWL41QaBxhqLlsCkDytCzKlcKJ7umfZw4
         avVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cHDGM3UL1xdgDL+HQFTyZECNRtZVznhFuhHpdAo8ZV8=;
        b=X+gK8qE1/qbneLBi4cS5s5pPBbb2dZzOC4K4vZTjDfgHhLtzzSjeOMsQD5V5HvyUip
         0iqrnsKOF1F+4G5/ZvLKj9uCyJ/hACLXDTeE4AJM8i6rO2DIW+8qqhkRguFz+YuRfBgG
         dyFRXY/HUlzQrfWt0lTh/1ZB8t+gs8VWisW+MWgBqAeGcdEVY3ajYz7KMrDQOgjaZgKM
         2qT8M60UWRkG5ltmFyR3USx1gwN69rmsiy2yB7jGUp4sU2pi/elZEXkOr1PCCfwapv7l
         2vkySkKUZt6zj3iqyXFNYmJKb6xB1bLKcqK06YHcZavRe72sROFN/KcRwMoMq6hvGj3D
         g5dQ==
X-Gm-Message-State: APjAAAX2vE6wgMItKPMCbAmBHSPAXJEeSsXD7aUsgeJC6B4RSevU1tAE
        hok8sGtG48wyATDTrLbUe34=
X-Google-Smtp-Source: APXvYqxGnAFrMdHrtApmNLrHvS6SccvaukcAfwKT9lhud/HJGzZOe2RKHqmCBl0XyBYFjEkIxjqndQ==
X-Received: by 2002:adf:e705:: with SMTP id c5mr24218613wrm.270.1560335140492;
        Wed, 12 Jun 2019 03:25:40 -0700 (PDT)
Received: from szeder.dev (x4db4038e.dyn.telefonica.de. [77.180.3.142])
        by smtp.gmail.com with ESMTPSA id r131sm5531248wmf.4.2019.06.12.03.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 03:25:39 -0700 (PDT)
Date:   Wed, 12 Jun 2019 12:25:37 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elmar Pruesse <p@ucdenver.edu>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reducing git size by building libgit.so
Message-ID: <20190612102537.GI4012@szeder.dev>
References: <21f1f334-755e-3283-d0da-ec0ab9231cfc@ucdenver.edu>
 <87y32787k9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87y32787k9.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 11:41:10AM +0200, Ævar Arnfjörð Bjarmason wrote:
> On Tue, Jun 11 2019, Elmar Pruesse wrote:
> > The total compiled size of libexec/git-core is currently somewhere
> > around 30 MB. This is largely due to a number of binaries linking
> > statically against libgit.a. For some folks, every byte counts.

I wonder whether those folks actually need such non-builtin git
binaries like 'git-shell' or 'git-daemon' in the first place.


> We still have some stand-alone binaries, but IIRC there's under 5 of
> those with INSTALL_SYMLINKS. We could probably also just make those
> built-ins to get the rest of the size benefits.
> 
> I.e. we'd just have one git binary, everything else symlinking to that,
> and we'd route to the right program by inspecting argv, which we mostly
> do already.

Let's not forget that commands like 'git-daemon' and 'git-shell' are
better left as stand-alone programs.

