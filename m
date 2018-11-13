Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592FB1F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 00:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbeKMKdz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 05:33:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40109 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbeKMKdz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 05:33:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so5110156pfm.7
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 16:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pDAFWJWOucu9Mch94kW0ngakW4kqKPvbej/FXlv/8hM=;
        b=ML+vqZ1umf3h26Uq6OWWSfJmQFL/Rc/67PMiBzc7/KcwJBB4PBPQDFyhuiqfbX35mT
         VG4tqdK9QGWZIAjYqeofd1c9Q86Z1+gx6jgmQLxIRFdeXT8NVv5vx/keX2SnwV7qpQ+D
         1h5yemaqpz+pIQOhKZhf4oCk8mDGCq5pmW94uv+Gm9vcTAcZl+rwagctSd1+aE80BCDO
         MreNlMxaeC5PJJkSLf2spA8D09+QqwaFAvNQlMOFI8dCHezK81f7kSdrZHouujyclH6j
         gyGjLfBV5EKUiXihlgrpGqA10PJgV/KWLlIvCy5c0/26I1K/rzaPW4n59lBJ0PFZml6M
         TOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pDAFWJWOucu9Mch94kW0ngakW4kqKPvbej/FXlv/8hM=;
        b=hLTgGrklS0hqRMeRHpmQ9ZOn5KCR0RIghuF1ySkYDr0kVmQklFXAcrnocg1BDvmh2o
         KGr7/MkRYtxRoHa+wyZrV47+Aog37/TH9fkWow7pKoxzlO8GG4NU5sLDnUcrVRAlgYNh
         8ZzLiQdRJYghgpgSat/OwAHvxTdEjojZb11h3K9JyTTwAjgVP+COezdJWG1O3u0nDbgw
         cWvqufp2r4xnrnNjlYNN1D4d3ry3/wvC1jZWPVPl6ELoNEy6oXBtsmJYGYrWsVpUzK0r
         pjpINP9x0hnnovxciT4nA9wRVSwcbA3Y/BNLpf7W1ghTJgQ/7Oshu0RywNH4M1EketXP
         OFfg==
X-Gm-Message-State: AGRZ1gLVJD9JCuYrskD49TscrXeheP/gbGt8j9HZ/kbu7rNqEIWwMqRq
        hS4mxwNGYK5nAwRRftCpPpY=
X-Google-Smtp-Source: AJdET5cInnPadEvl8ySWmydGoHdA4c5jC/vV2vE/DNsB/SSmavLsHO63tgEGZR9FUR+KstgV/yI90g==
X-Received: by 2002:a63:4a4d:: with SMTP id j13mr2063168pgl.127.1542069500619;
        Mon, 12 Nov 2018 16:38:20 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id j197sm21852423pgc.76.2018.11.12.16.38.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Nov 2018 16:38:19 -0800 (PST)
Date:   Mon, 12 Nov 2018 16:38:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
Subject: [PATCH 0/3] Avoid confusing messages from new index extensions (Re:
 [PATCH v8 0/7] speed up index load through parallelization)
Message-ID: <20181113003817.GA170017@google.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010155938.20996-1-peartben@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ben Peart wrote:

> Ben Peart (6):
>   read-cache: clean up casting and byte decoding
>   eoie: add End of Index Entry (EOIE) extension
>   config: add new index.threads config setting
>   read-cache: load cache extensions on a worker thread
>   ieot: add Index Entry Offset Table (IEOT) extension
>   read-cache: load cache entries on worker threads

I love this, but when deploying it I ran into a problem.

How about these patches?

Thanks,
Jonathan Nieder (3):
  eoie: default to not writing EOIE section
  ieot: default to not writing IEOT section
  index: do not warn about unrecognized extensions

 Documentation/config.txt | 14 ++++++++++++++
 read-cache.c             | 24 +++++++++++++++++++++---
 t/t1700-split-index.sh   | 11 +++++++----
 3 files changed, 42 insertions(+), 7 deletions(-)
