Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799ED20D11
	for <e@80x24.org>; Tue, 30 May 2017 05:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbdE3FaG (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 01:30:06 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35355 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdE3FaE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 01:30:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so15402262pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=SB93YDd5dp98E9ej1ldiCElUBsGHZHsoUQZseOnyGig=;
        b=dIgA0+BqL2pLhI7aeG/KTTUh3Faav7RfYS3dnC8+9gQK1pPlTdZKnD0c9k75nZkPUr
         zOaZHCWgHuk4HxOXQ7Shcs8JC12LPY+nZaZDMOSzTo3FSUxagp4xRPqdeNBLrBjZS0pV
         kZ6MPKYJtbojcqKPV6d9W39e/cdxzTCY+/AzE+GIr0Cqg5Mdcx2R939ct00ZTNjmKmf7
         sJ4MDTFJjRSlXk1DmnsQgP8JcaB+3Xq8gmEDyIVn1LMmk1VLLvEYBgQQz602Kwtyo4tR
         tZiRh14ZFbkysAb/97nAie2kQMWTMrKCre2QK6oOqZM1l6Q1ud27em20lXGyaoOTxlbF
         xCJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=SB93YDd5dp98E9ej1ldiCElUBsGHZHsoUQZseOnyGig=;
        b=n7LcYDeRLFuz3F1JAcjD8EPtiDdjAtEfaRMa9CQpe/L3C7khplfkstorw/b6ZLX34p
         cxSHHsN7vvgG7o2MEgoEDar3iqxScz2Lew6S5fav++gHlpELN05Rj/dAybuOJWatKtbP
         5NE8PXlHtM+0OVj5BIamEGih671iAwucCwa4YvkZ7JIAA1z3j980jAmL0MCR9r5VmA2J
         vigeGCcR0Rcpsmlzx3cGVLCHHi3PJtTRuKv1DSXzbFQbdyFpFY2SzlEN4o/37vSC4ko+
         C0Suxv/aB63ea1/fK8nFoT0LLkJ6o3Gjxn/251mQXjpPx/X6J8YfQDMPhFSMJlMW8ViR
         kXFw==
X-Gm-Message-State: AODbwcD8Zz8RvaCqOMAfHfRNz/vvIQchULI9QGseZNAoHvSnuj9y3GtB
        JoBuDTw7Nv+v+DNbyt0=
X-Received: by 10.84.171.193 with SMTP id l59mr78684028plb.139.1496122203337;
        Mon, 29 May 2017 22:30:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id m80sm20724575pfg.107.2017.05.29.22.30.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 22:30:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org
Subject: Re: [PATCHv2 0/8] A reroll of sb/submodule-blanket-recursive
References: <20170526191017.19155-1-sbeller@google.com>
Date:   Tue, 30 May 2017 14:30:01 +0900
In-Reply-To: <20170526191017.19155-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 26 May 2017 12:10:09 -0700")
Message-ID: <xmqqa85udi92.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> v2:
> * A reroll of sb/submodule-blanket-recursive.
> * This requires ab/grep-preparatory-cleanup 

2/8 seems to be more stale than sb/checkout-recurse-submodules that
was merged at f1101cef to 'master'.  I'll try to merge Ævar's series
to 'master' before that merge, queue these patches and see if the
resulting history is too messy.

Thanks.
