Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A804720C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 19:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752822AbdFLTLZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 15:11:25 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33711 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbdFLTLY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 15:11:24 -0400
Received: by mail-pf0-f176.google.com with SMTP id 83so55282483pfr.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 12:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VG7aGgFunb7I8aeLLEq8LkEcqFTvMNh4u8msziWcMBI=;
        b=XnhFkmNt797M4JzxfJCigHuBftmqS3OLFv5mS7YYz4OkAq6nMaqIzB3hokJCh9nkj9
         ElQ6Xez2JsQij0tJ1Jf1o/pgX59tB8P0nAqfeKKZy6q1Vh2M6rA1zUXMJoGqtLEPGsHa
         EsTmDnDXJcW+blrtabDjro2ngUoVoVZXheQUX9Sj+YC7eaksEd34qa0T8FWsS/m4u/uq
         An3W2059+BzWZK57r5/+6SyDDPkEMJrPYth3sRx4g/Z6/YwhEmun5ig4dgpcP75+Og0d
         7QpEXhEVtw+vLmwHmpUcMf4UkCr34v9SYffGk2XRzYFHQlh90V/bBUq19uHWFHtiMp8b
         xS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VG7aGgFunb7I8aeLLEq8LkEcqFTvMNh4u8msziWcMBI=;
        b=cY1dK1CXf0T7KG/DQh15NtLkSMT31CIvbwroKVdyfUATALYHMY+KEaASGtm3eM7ot4
         KmC79YKL/DxagigkVv0dUKaHiX9rVRm6+41Dgl5XW0pXhczchoHHVb+FsBw4vZJWuMJM
         ODMK5q9/6rP1tuzcyEToutuKtgztCVpib4E4GoJuzWzn+69gfIZjyrvi3V84SiIfCO+S
         /fsS+SUHfJFl4i8LHl1A0S609J0jeEzu0IGvyoNF6W4zwdL2LrP6+IzCq8t3JkW+geBG
         m9Si2p2P7uX3vxGLGNdysKe46VOR3d/uZ/dij4L4nhWaWs8Gqu8cJa7wEtUfY2szXX9f
         mmhA==
X-Gm-Message-State: AKS2vOwpjzNmILPglHSG0v9TeFfKazVqBgKpN7NchKKkbTVcCVp5YuCE
        iVdojpeV9bOXmTK8
X-Received: by 10.98.0.77 with SMTP id 74mr4146419pfa.127.1497294683741;
        Mon, 12 Jun 2017 12:11:23 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id d66sm687856pfb.38.2017.06.12.12.11.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 12:11:22 -0700 (PDT)
Date:   Mon, 12 Jun 2017 12:11:21 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org, sbeller@google.com,
        jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/32] repository object
Message-ID: <20170612191121.GB154599@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170609174034.61889ae8@twelve2.svl.corp.google.com>
 <20170610060712.foqre5fscaxu3tnx@sigill.intra.peff.net>
 <20170612120140.3da90194@twelve2.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612120140.3da90194@twelve2.svl.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12, Jonathan Tan wrote:
> On Sat, 10 Jun 2017 02:07:12 -0400
> Jeff King <peff@peff.net> wrote:
> 
> > I do agree that "pass just what the sub-function needs" is a good rule
> > of thumb. But the reason that these are globals in the first place is
> > that there are a ton of them, and they are used at the lowest levels of
> > call chains. So I have a feeling that we're always going to need some
> > big object to hold all that context when doing multi-repo operations in
> > a single process.
> 
> From my experience with the codebase, it seems that most of these config
> variables are static (file-local). This means that the lowest levels of
> call chains could probably get away with storing per-repo configs in a
> static hashmap or associative array keyed by repo (if they cannot just
> pass the config around).
> 
> Having said that, if it did come to the hashmap, I probably would prefer
> just putting the config in the repo object too. So maybe that is the way
> to go.

This is how the config is already handled.  A config_set is just a
wrapper around a fancy hashmap.  Callers query using a string as a key
and are returned the value for that config option.  I say fancy because
it does stuff to handle multiple values, etc.

I'm not sure I know what you mean by config variables which are static,
are you referring to the in-memory options which are populated by
querying the config?  Those I wouldn't want to see placed in a
'repository object'.

-- 
Brandon Williams
