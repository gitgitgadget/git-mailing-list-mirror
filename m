Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7954E1F462
	for <e@80x24.org>; Tue, 21 May 2019 02:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfEUCAM (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 22:00:12 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:45577 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfEUCAM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 22:00:12 -0400
Received: by mail-pf1-f180.google.com with SMTP id s11so8150692pfm.12
        for <git@vger.kernel.org>; Mon, 20 May 2019 19:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=35KvLNJ/3cmFY6ypiRK01JhG2/gqq5o75SnZrVMLBDc=;
        b=ReKAaT/9DVp8nyEi4uhGul1wW3+kbmBWkzP2kb3kbP7sXdSSVimT5KjTJZQsTUHgqP
         kCi4fawpkRX/DzIe2TSIgx0fEEZBffB1+IDVkD6so5cv+NIVfEP04fu0CkYywij5uQOp
         okWpmmH4sDavr04SeAfwq8+BAyas9cSFXJvmw/I/k6JtpOTxreqaJeumNqmCM45mjS4G
         wx2XF9OW9mKuRXYTjsCqaQohsviAUy4k4DmkVRSBGJVkKcKrpaYY3HEpFJGItvM/rj39
         eW3pNpM+IQYdoB0P159jykHiyXo0CJ5YsX74/ZftGHHByt95dWrNj+xrfT0Q1VX9uOW2
         sKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=35KvLNJ/3cmFY6ypiRK01JhG2/gqq5o75SnZrVMLBDc=;
        b=JW2BxxYwwWLJgCVrsZfpfyiMk1xOJFOj583EGxD7o4kc8Wmd3jZqGInyt8ZxnNntcS
         f0tQy1xP+kYlcwgIjNkr+bkVvTMWqQAwuzYHS14m/3Mpc1m7+3R69qob++vV8bOD/nmg
         QiaoJL7LCVv8BQUO1TZjcjBCSXesIHBkvVee9g+kJK2bnvw9dQZmTzJEMksH1r96wuRG
         uzSxHkMdKLgLLzTooSpGOqNBnnZbAL8XzOnn4GMdFAhGhs2iqp1HpLdbodxyfNmMfGei
         fjVeY89nItxaAET3a6dXSY7qMUiqDXh2nmrz+2PC/qaaV43Dc5Q86hEXudKCG8nPlx5O
         xlAg==
X-Gm-Message-State: APjAAAW9be30FdtHYXv4Gae55+E3ZApXcJatbfgMY1VZVHIL08EWTQZf
        18n35B3zSbQ2y7a7D9aBw9ySqhj2
X-Google-Smtp-Source: APXvYqy5MsECbAuF0HJzTzheKH61zRU4bbWSakjBajT3U4Rkm07IAsl7dLAPFq8uhbCwHlqFMwD/lw==
X-Received: by 2002:aa7:860a:: with SMTP id p10mr66908489pfn.214.1558404011113;
        Mon, 20 May 2019 19:00:11 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 85sm12926909pfa.131.2019.05.20.19.00.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 19:00:10 -0700 (PDT)
Date:   Mon, 20 May 2019 19:00:09 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
Message-ID: <20190521020009.GC32230@google.com>
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190518015005.GA951@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor wrote:
> On Sat, May 18, 2019 at 09:54:12AM +0900, Mike Hommey wrote:

>> There are established corner cases, where in a repo where commit dates
>> are not monotonically increasing,
[...]
> All the above is without commit-graph, I presume?  If so, then you
> should give it a try, as it might bring immediate help in your
> pathological repo.  With 5k commit in the same second (enforced via
> 'export GIT_COMMITTER_DATE=$(date); for i in {1..5000} ...') I get:

Just to emphasize this point: one field in the commit-graph file is a
generation number (or more generally, a "reachability index" in the
standard jargon).  The reason I'm excited about having this field is
that it will allow us to stop playing games with slop.

So please join forces with Stolee and help us get to that future
sooner. :)

Thanks,
Jonathan
