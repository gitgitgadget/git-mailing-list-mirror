Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BD2F1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 18:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933976AbcHaSjm (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 14:39:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33193 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933952AbcHaSjk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 14:39:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id w207so4665719wmw.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbjM1n0u9zFHa3xlrYaauKdIUlxoIu4DMFthewoDhs8=;
        b=zmoUWjDAbxVOMl7MOVKO/SpxFbe068JKQJSPZWkCUUVf+TdpzVU5unO4umEoK/mGxJ
         5uhZ0ir9Q+vThn0DL1oyIr50TiX/7gdqWUqaKYMqlhhxcMCa9s7DppllPnWXIzNnjUii
         I0p1JxUPPScgvJpFh+NGMs3p0v4e9iFC/ZUoXCoGU1nO8sKEgYXtazEJaOMHW7UXxkhX
         +KLQgfLfkA9hz8d52W2A/ReOqOYm2gSMWURuCgC+dGA7wf4AXkygToW4Ko/rIj8cX+Vv
         r/vjIZ9YmCbuio/1cffEel4N1w/WjrPz6jsv4UvcpxfsXIAiV9N21ZwY9lE2UQO2r6DG
         B1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbjM1n0u9zFHa3xlrYaauKdIUlxoIu4DMFthewoDhs8=;
        b=UPCjUGn0uiq/WAYUatGL6hMmUEHIx2W8AdCDto5GWtm38lG+AR1r4zauBRVZmHwprT
         jIpXnQw1OXtoBDAzHF/E1Rmx72+U/Cl5WMQL0OKSbNKZUE/o23nqa6lOrl8gW/jU9mtJ
         eOMqzKQZBxT8mV9SfyjEqaagZjxqNH270s7j5oUWDBWjH/xl3FRm6xvB7GwxrIaFCIcm
         PhrB1omjZ2TujHHQUMxPIykk8G/N+X9gHccfvDvBPGsm31MpQ1IWryVckgLOnzjttutx
         knw+Tsd7Dox32fl5ozem5F/Gvn9pLHMkBxxipwu1O5BPe3MuJDw1xPzYpnngtzzgc6p+
         1OeA==
X-Gm-Message-State: AE9vXwMDYViH80ypgCS3HAbo1HlNM5BLUOJsRYr1eFQAV0VNzqRRGyKArBgr53fJCkpzPQ==
X-Received: by 10.28.23.210 with SMTP id 201mr10659134wmx.108.1472668779337;
        Wed, 31 Aug 2016 11:39:39 -0700 (PDT)
Received: from hurricane.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id r67sm10261863wmb.14.2016.08.31.11.39.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 11:39:38 -0700 (PDT)
Message-ID: <1472668778.4265.76.camel@kaarsemaker.net>
Subject: Re: [PATCH 15/34] sequencer (rebase -i): leave a patch upon error
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Wed, 31 Aug 2016 20:39:38 +0200
In-Reply-To: <cade51f893ed381ed03718439c7dba3f5dcebba3.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
         <cade51f893ed381ed03718439c7dba3f5dcebba3.1472633606.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On wo, 2016-08-31 at 10:55 +0200, Johannes Schindelin wrote:
> Just like the interactive rebase, we want to leave a 'patch' file for
> further inspection by the user (even if we never tried to actually apply
> that patch, since we're cherry-picking instead).
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

This commit message confuses me. Did you mean s/Just like the/When
doing an/? 

D.
