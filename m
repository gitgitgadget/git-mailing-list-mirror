Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27FC1215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 18:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754374AbeD3SMQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 14:12:16 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:43850 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeD3SMP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 14:12:15 -0400
Received: by mail-yb0-f169.google.com with SMTP id x145-v6so2525988ybg.10
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OnBL8fDOA/s1uhZSKZq9C6SBrJFGwUYH05dsgEkjvcA=;
        b=EoZL0Jcnxd5uE61WyggQA2S82UMbohFviWpc9f0jmpcDKmgxXppAFe0dEnM3NgfTt7
         MUSWJB6ivw62he8tF/U0IRkk9BAAHPmIfDzGMliZg70jzxbB5yblOIppeE3prRMrPpD+
         9bqhZo7sfF6pm8NTd760GKU+/VRH1NZwMTrCEAo+MaH5lpPgKaHBAtPLg1ZD+zpwlu5I
         cEYx0bQLrA8oX7U3dP9gG359N58V7TDaOF6OfLBh1+ETm0dl+1Gl4gDDyfLSBrYXElXP
         yzjaKiXjI+zq8dm4e9fYKO+ZSle6My92sP6c3bzr+uFrZye7gsDrxlISIylwIYt/jmQK
         xdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OnBL8fDOA/s1uhZSKZq9C6SBrJFGwUYH05dsgEkjvcA=;
        b=Sjlxw+uQfMT9eLB5psfIiH2zJUTe3j3ngBQ4ZLiQOhTdq+8epWaBKYHgQtO3QABVQq
         XkNaKlPzgGaM2MDkAu88Lp8ojPrHqSxdYxgmjHRZVu45zzB7SN3e/aBVi1aGzAwjXx2v
         7cYbbfuLdWsXbEG+nBeqvnuItLUzHoV9/vBlpkBz72sEplsLxuyfp3HNrGGTqaeDPyV8
         ETk1yxZMTZb5ks+0Na7z8rIdUCz9+GHH8e10XN9J9EzqCz8k2GGFIioiCkJDlX81onfG
         BKRG8TTOdmO3p5//2arEM0UP3qmU6yCNkxt9P3Intd/5mBX53lCy/Q4Yf4gM6PrhzOJA
         4fxQ==
X-Gm-Message-State: ALQs6tCwWfrnPCIYqcW3EfFiqs7cnGeM8fkmGSdq3de8c/hpQWR+Hyv0
        4882FxlDj0a/qquZcWze75iqURi/kAXSRUfFCgFyWw==
X-Google-Smtp-Source: AB8JxZognDiLfxpTuPfXgZt5tywt+ZOsd7BBG7EyjiFybTi5g8QLmvRH7bxzOQxxq4bkgVNGKarO71JIS4B4ysAEphQ=
X-Received: by 2002:a25:69cf:: with SMTP id e198-v6mr7928320ybc.247.1525111933958;
 Mon, 30 Apr 2018 11:12:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 11:12:13
 -0700 (PDT)
In-Reply-To: <20180430142555.23260-1-benpeart@microsoft.com>
References: <20180430142555.23260-1-benpeart@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Apr 2018 11:12:13 -0700
Message-ID: <CAGZ79kZvyFTKadjY11Xu+KcV9OUe-4hbjgPzBDcD52X2nZKCzg@mail.gmail.com>
Subject: Re: [PATCH v1] test-drop-caches: simplify delay loading of NtSetSystemInformation
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 7:26 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> Take advantage of the recent addition of support for lazy loading functions

Care to specify "recent additions"? Are these in Git code or somewhere else?

I find this alias handy, as then I can describe commits
in commit messages via "git gcs <commitish>

  alias.gcs=show --date=short -s --pretty='format:%h (%s, %ad)'

Thanks,
Stefan
