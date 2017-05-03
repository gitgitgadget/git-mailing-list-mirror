Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4ED9207F8
	for <e@80x24.org>; Wed,  3 May 2017 21:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755033AbdECVIz (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 17:08:55 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36498 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753507AbdECVIx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 17:08:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id v1so210567pgv.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 14:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m0DFOH/EYSvlsN/i+oaGw+04cbJz6lCEuvCWSrP8I5U=;
        b=cz82Id4PMJwZZ3wCQD0RuNLONFYUgVMz6NuID7ipjeyUVBvH6pffUrYcU0CtiYFxy5
         SWnn9ZoA435deQTHFoqOwaxOU0BGbjaRgRJSYALfrKk3JXrt0jAXsnSFpYquG3xaYWBo
         SgU0hplXQzQKe/xl3NOa7rQR50X9/AyJE6T6RhOL3Oc2Vt9vxOyVJ0LCwDBVZZ/2ZQhv
         GcGMZCo2z29ws84Ja+dGPWKMvuGpsCTWzfIwzudylPYemILZptYyFkxoKP4ivVPN/9/c
         8hZJwKviDOQsbKrJdLhu1plY7KrFQzamBvN5ZKMyyqGsBRO1pnYWUi0RV2H2rWN4+pbG
         DG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m0DFOH/EYSvlsN/i+oaGw+04cbJz6lCEuvCWSrP8I5U=;
        b=NaqM6KHuzKwNKspvaApxPfbSGucEvdDtHyOz7GPeIb1Rks/4ecJqO8kNJP24JUX2Ai
         nY4Jm3BxZpp7Jq5eoynZuo4ThtJL+SbnJBKPIyJ0KPqpsZEPOjC1FBOrMVIfhhDYNVXv
         AtsX3aHqOCwLddnsN9bUNQGEnICsciNuKH/5Xx1HZl1nsD5jb1lSFIIgBvA0STf/UgX6
         K8ZoI6gmDlK1bukzPSv1E42enHQ2O/QAQmnmiTiu+EFtYeK6sS4VK5BnigTMj+FU4fUR
         Wa3nxE/5mS87fDCQjVJKMQXL5yxji339AM//fBdVkWwosuTo1sR1jyiNN6ExibS2n7W/
         wYQw==
X-Gm-Message-State: AN3rC/54MMftjX5Pt5hIssP2dJWXaEwq7Oz3w2ZmqIgWbfr+tLUFvh6a
        sZhTAt/gt/CN7Q==
X-Received: by 10.99.163.67 with SMTP id v3mr40665322pgn.206.1493845732973;
        Wed, 03 May 2017 14:08:52 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id b8sm111214pgn.51.2017.05.03.14.08.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 14:08:52 -0700 (PDT)
Date:   Wed, 3 May 2017 14:08:50 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
Message-ID: <20170503210850.GG28740@aiede.svl.corp.google.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
 <2b1b504a-07c9-81b3-fed2-e9c029a5b284@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1b504a-07c9-81b3-fed2-e9c029a5b284@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jonathan Tan wrote:

> The binary search to lookup a packfile offset from a .idx file
> (which involves disk reads) would take longer for all lookups (not
> just lookups for missing blobs) - I think I prefer keeping the lists
> separate, to avoid pessimizing the (likely) usual case where the
> relevant blobs are all already in local repo storage.

Another relevant operation is looking up objects by offset or
index_nr.  The current implementation involves building an in-memory
reverse index on demand by reading the idx file and sorting it by
offset --- see pack-revindex.c::create_pack_revindex.  This takes O(n
log n) time where n is the size of the idx file.

That said, it could be avoided by storing an on-disk reverse index
with the pack.  That's something we've been wanting to do anyway.

Thanks,
Jonathan
