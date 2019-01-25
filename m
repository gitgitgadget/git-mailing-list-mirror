Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DCE61F453
	for <e@80x24.org>; Fri, 25 Jan 2019 13:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfAYNZu (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 08:25:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45477 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAYNZu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 08:25:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so10248344wrr.12
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 05:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vFRWT8bCngtAQrPO494zJUHechhYdMRGQOmiwRTt71I=;
        b=XXwDeVPoEJmpTYCSMemQsv0he6L6tzemymbDRQbyZ88RNDgibfAD5cYxgtLK5JT6tg
         vk8pNIcFID8R9izrgytkbfAiaLh1oUWQE+0UEfofGKccmCJyXsln4FstdGGf593FUcAk
         BLUZ2lXXgZHHopkAZrChSkgJpeo7IV1s/TQQnD2MoAUikBJCv1AlihyZTN2uknHpDlyZ
         cR+/lwhwcJ/jKOduvDXTMDUs4JZFRxblXbI5eIs2IQcBssBemT1nx6iuX5DUQEcHGwbR
         T5hkszioUqACOwkWonCsSt15IM5+UOwZRCThU/UxRnyLh3er5l9Y5poFWC5DVL67/tq+
         vv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vFRWT8bCngtAQrPO494zJUHechhYdMRGQOmiwRTt71I=;
        b=Qpn6uAMrZKsb108IBriKIYa1NCOqd71jjowbbJ/jnVxY2v5GPEeOlYvjIz2hpiQUiO
         Zv3/8lEDtKeaCjTlDhuSMOS8f5/sZX0QYGOXPJj+cgcEWjbQwaAW1KnrFqkS/i7CxBYX
         cNN8MKuGQEN6tM8uX8l40eMUpXKHKGQbhUrGUwJb3nS/+K6TqjnsDD0SkIE3ChV2j8lY
         6Kv1IKNHmzEeeZf4DhVZr14kTojK97+c14QHrjPiErUzrn5nD93hNjjYPrdfKVPfBLlY
         qF0Sx/2jdW+HitrTPjrqOpo0I1SAaF3WITNRFUnBIZ3y1d9Pl7kbSZ3ek0eHlHrR8cb0
         DZPg==
X-Gm-Message-State: AJcUukcRHXXHjS+u18IIUyCbbLlynCw6QvVjDqR5rb7KOnq7ppCE7h4+
        W+vSLJ7uQ6A9BGkwAJGzizI=
X-Google-Smtp-Source: ALg8bN4KBjbBc20dX94owZFI5x+ReQDAodH/NAkroipULYCbmWJav/oLqFWAE75HLjZRXt8803+63A==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr11888910wrs.117.1548422748612;
        Fri, 25 Jan 2019 05:25:48 -0800 (PST)
Received: from szeder.dev (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id j33sm171682676wre.91.2019.01.25.05.25.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 05:25:47 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:25:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 04/21] ci: inherit --jobs via MAKEFLAGS in
 run-build-and-tests
Message-ID: <20190125132545.GD6702@szeder.dev>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
 <pull.31.v4.git.gitgitgadget@gmail.com>
 <83b92a87e7698cee1e2c44252b934ad436d75a90.1548254412.git.gitgitgadget@gmail.com>
 <xmqqtvhz54gz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvhz54gz.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 23, 2019 at 02:22:10PM -0800, Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Let's not decide in the generic ci/ script how many jobs to run in
> > parallel; it is easy enough to hand that information down via the
> > `MAKEFLAGS`.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  ci/run-build-and-tests.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> > index db342bb6a8..80d72d120f 100755
> > --- a/ci/run-build-and-tests.sh
> > +++ b/ci/run-build-and-tests.sh
> > @@ -7,7 +7,7 @@
> >  
> >  ln -s "$cache_dir/.prove" t/.prove
> >  
> > -make --jobs=2
> > +make
> >  make --quiet test
> >  if test "$jobname" = "linux-gcc"
> >  then
> 
> As there is no assignment to MAKEFLAGS in this patch, is it intended
> for this step to change behaviour (possibly with the intention to
> add "default 2 jobs at least under travis" back later in the
> series)?  Not that it matters too much, but it is unnerving to see
> that the proposed log message promising "it is easy enough" while
> not actually doing so, without expressing an intention.

Furthermore, there are several other 'ci/run-<something>.sh' scripts
that still run 'make -j N'.

