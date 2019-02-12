Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B477F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 00:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfBLAH4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 19:07:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46930 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbfBLAH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 19:07:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so318058pgp.13
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 16:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DBHp2G4SA3QNFt/UvBlCJ4JLu5+jA4ZJwevHl3CRNCM=;
        b=pzNVpfHW0qV85TuJ5JEPPhUw6aP0v92jI06uh+UY+5zU1DpjQySKKoU/OJQJH7WWW2
         2s6i/gvaUTjPEnRIU6BiBDhDfKS9Unt8hEhwRCl9RlUaQ52M3msN5xem6WVzY4PC1Wku
         ekKXnSFcebHIS5XfacpCBcXc3MufL4VRnMV+4PS3zsuDrzmLy0BmcXYJsiBnREOvIRLc
         hhpgJsFn9cK91y8VEN5shVGgq5zp8IkoWs1OEKDun2WoH39MxiZXiAPzucd7eFgDPpBY
         SdY3fWtVtr37GEQxov2azGPphj8yQ5hLzn8yxCzotvAkxlIdAC2YieWhOwIsUbAjRS7z
         Z0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=DBHp2G4SA3QNFt/UvBlCJ4JLu5+jA4ZJwevHl3CRNCM=;
        b=JNhdNDr/pQ2K1leBFbazCBxISdlgQYc8LBJfho8OuG/g+hQpMFdzvtU1ZEGjkQiY/m
         Jx1DDIweuVDDNzOygxqjGFhKlPn/o9VrAuAl0qAZHyqCog8N/yrHxYCq4qa3pR93B/R0
         VqByPmDee1ExVqaTQPU3Vl2gjLA2BoPSWmYSajnhzj77ZBSNwsHpqR3te/8/OOXaXCLO
         nL/2IMWo6Jn6eUbxqxOSYci61yTQC2adt1sXUeG5dSM0uwf8rH4NPezc7ccLn3dxWKT2
         6U4ELfOXfdrUomNAhZOn1DtgMJ8P6bl/Hdiu3o/N70w1U/ZzLDkqkF0rcrBOi+Rio6My
         EqmA==
X-Gm-Message-State: AHQUAuaCgi0YO0fJr7M8rL6zJgKomf6JmZm3gyVuAdkMNoGXSf6lL2SS
        4c7ErT2hh/s04MdbYdOoFUweocyD/1Bv7w==
X-Google-Smtp-Source: AHgI3IYoJgxmsc6AdBsESTCyRvFqDaiSKH22o1d7bDutBh31ZEH40Er9rsIMu/yoS6TF13d02AmC7A==
X-Received: by 2002:a63:94:: with SMTP id 142mr912966pga.74.1549930075085;
        Mon, 11 Feb 2019 16:07:55 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id i74sm21015429pfi.33.2019.02.11.16.07.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 16:07:54 -0800 (PST)
Date:   Mon, 11 Feb 2019 16:07:49 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] protocol-capabilities.txt: document symref
Message-ID: <20190212000749.GF72177@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <4ffb11ff776166944673ba3bdb96a9d20eb14df7.1549929088.git.steadmon@google.com>
 <20190212000530.GC13301@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212000530.GC13301@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.02.11 19:05, Jeff King wrote:
> On Mon, Feb 11, 2019 at 03:52:24PM -0800, Josh Steadmon wrote:
> 
> > In 7171d8c15f ("upload-pack: send symbolic ref information as
> > capability"), we added a symref capability to the pack protocol, but it
> > was never documented. Adapt the patch notes from that commit and add
> > them to the capabilities documentation.
> 
> Good catch, and your explanation (especially the SHOULD/MAY bits) looks
> good.
> 
> I think this is obsoleted by v2, which will send symref info along with
> each ref. I don't know if it's worth mentioning that here (the v2 docs
> discuss it, but I don't know if this capabilities document is clear
> about which ones apply only to v0).
> 
> -Peff

I believe this doc is only for v0/v1. I'll add a note.
