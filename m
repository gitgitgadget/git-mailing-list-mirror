Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71C21F424
	for <e@80x24.org>; Wed, 28 Mar 2018 00:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752596AbeC1AYy (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 20:24:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45290 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeC1AYx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 20:24:53 -0400
Received: by mail-pl0-f66.google.com with SMTP id n15-v6so476979plp.12
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZE6BPQ2qFeTWRMQhTmpUDabsV3+FXermdyI8AreR9+Q=;
        b=B8iU3q3Xj92xAraAXndj6X6neB/8nkPhsbRL9bfbW5IZaQTpch00+6TWco3UUMOw+O
         GyyfgaNPPJNJY4XPfQEAyN5Hr1GshTXbO1CnWQWB+1946gT94UvXEEUx0DbtyW+grN7N
         x55bD5bc47PBW+2VUqTAbJ3pJIeoOZAHJoiGjVCw/tFyQE1W7O/SSrGBTpoDkP6wpVVV
         he4xiMdfd7Bgi/62TQjbYj1QTxGaYlaK4RSVis4+326VKmPQ3tMddgsApIkBLp0ekBoh
         JH1eccOximFviBkpDXpEsmzEY4+WFZPMNa4wyC64r7k1E2g7D1vnTNkOU6Fe7ETPzU48
         Drcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZE6BPQ2qFeTWRMQhTmpUDabsV3+FXermdyI8AreR9+Q=;
        b=W4nRCmWAzhbwwXiVpF21IOJqewqzjUoAnpVJmIATPW0CS31b0DtLXFSFnVK0IiWqRg
         yECrHoO+NvGEAQac2YRax7u/9d/LVyQAioJO8pk+/9gh9qDd5fA6vbE9vGoUZL6j8bKW
         vn3UnTZ5W148IMJAQaq5+ax/jXQVE1mYbDMRMw6h8XJuP4bQi33Fq06HK/HmYHPnzxdj
         IdGHHJjvX66MuPnYUcEE398gaHyO52DoWs+YF3A5dOaYeVBnMtIpab3A7TCHaRJ3XUdE
         +yEGCgX1UMexKw1NrGDiDQGb1I3xBk3IIbp8gkpceVJV/DECwXr8OLViEoCpFSZ3aOb5
         VWPA==
X-Gm-Message-State: AElRT7FWW+EDmqk3Go3iHeAbqgCSse+hFiV67wAJWixQ/PnIlg2XqJ7m
        3vqIxWTwKNUCQz2An9juVxSZkw==
X-Google-Smtp-Source: AIpwx4+g6Cp3BNYiqEHaFRlB/r1YD2IHZUuKdouuVWbqUM58qdYvKUKDRHI1FzSSfDN2T9vINGfZlQ==
X-Received: by 2002:a17:902:d885:: with SMTP id b5-v6mr1424280plz.234.1522196693247;
        Tue, 27 Mar 2018 17:24:53 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id a28sm4070737pgd.38.2018.03.27.17.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 17:24:52 -0700 (PDT)
Date:   Tue, 27 Mar 2018 17:24:51 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>, seanwbehan@riseup.net
Subject: Re: [PATCH] grep: remove "repo" arg from non-supporting funcs
Message-Id: <20180327172451.34f60c483133df629b1e8ec6@google.com>
In-Reply-To: <CAGZ79kY-E5FZRJAg6QG0DX1TzWXgo9LqJ-b7JojpkD6_BdF-wQ@mail.gmail.com>
References: <20180327213918.77851-3-sbeller@google.com>
        <20180327225850.166523-1-jonathantanmy@google.com>
        <CAGZ79kY-E5FZRJAg6QG0DX1TzWXgo9LqJ-b7JojpkD6_BdF-wQ@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 27 Mar 2018 16:20:25 -0700
Stefan Beller <sbeller@google.com> wrote:

> On Tue, Mar 27, 2018 at 3:58 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> > As part of commit f9ee2fcdfa ("grep: recurse in-process using 'struct
> > repository'", 2017-08-02), many functions in builtin/grep.c were
> > converted to also take "struct repository *" arguments. Among them were
> > grep_object() and grep_objects().
> >
> > However, at least grep_objects() was converted incompletely - it calls
> > gitmodules_config_oid(), which references the_repository.
> >
> > But it turns out that the conversion was extraneous anyway - there has
> > been no user-visible effect - because grep_objects() is never invoked
> > except with the_repository.
> >
> > Revert the changes to grep_objects() and grep_object() (which conversion
> > is also extraneous) to show that both these functions do not support
> > repositories other than the_repository.
> 
> I'd rather convert gitmodules_config_oid instead of reverting the other
> functions into a world without an arbitrary repository object.

I don't really think of it as a reversion, since grep_objects() didn't
fully support repos other than the_repository anyway.

Besides that, that's fine, but then:

 (1) You would have to explain both in the gitmodules_config_oid() and
     in this patch why "gitmodules_config_oid(...)" ->
     "gitmodules_config_oid(repo, ...)" and "submodule_free()" ->
     "submodule_free(repo)" are safe, since they have different behavior
     upon first glance. (They have the same behavior only because
     grep_objects() is always called with the_repository.) I was trying
     to explain this in as clear a way as possible, by showing (with
     code) that grep_objects() only works with, and is only called with,
     the_repository.
 (2) The code path where repo != the_repository would still never be
     exercised, and I prefer to not have such code paths.

I don't feel too strongly about (1), since they just concern commit
messages, of which there are many valid opinions on how to write them. I
feel a bit more strongly about (2), but can concede my point if the
project is OK with a code path not being exercised.

> Thanks for looking at the patches!
> I'd think this patch is orthogonal to the series, as this is about the effort
> of converting parts of git-grep whereas this series is fixing a bug (by
> converting parts of the submodule config machinery))?

It is orthogonal in the same way as your patch 1/5, I think - a
preparatory patch to make your "real" patches easier to understand.
