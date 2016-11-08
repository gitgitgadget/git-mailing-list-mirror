Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC4F2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 22:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753589AbcKHWFq (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 17:05:46 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33958 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753485AbcKHWFp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 17:05:45 -0500
Received: by mail-pf0-f170.google.com with SMTP id n85so114293956pfi.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 14:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2QMOO6guZmdxs00h/PynRe1kbeVkbrwtmVFM7b/EA4g=;
        b=op6G/DPW8GB6yyTy+sAQ3txlIhMRmQyeb1Zt5Wxhsb77+uYI9Pu8rQKj8OSl4AKncS
         /oG0RuP8yRTV+AHNIwlrj9kFUT+cVW2MgXD5+/+StLpm7K9i2gxygTPy75GryrOx/IzW
         n0Hr1xmsLaGcCp1yMwbZPqtK7N1JN7BwZOfPeleaUZs0wKuxUt3OTo3par+JZRSNRUBR
         i5AaAXA6h64jtsgHJjreEb7D5Grwk5X47VRwNOw4fY0MMsd/JyhfJnGtdVB4q9+/Qs4+
         20ZNlrKnpp0rAjFZ3iMhS86Bm5/HCR+o5jAqZiaBVyVlB574PFv8Dwd4dG+ctfhd1mmx
         qCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2QMOO6guZmdxs00h/PynRe1kbeVkbrwtmVFM7b/EA4g=;
        b=B5P4aNukaLqEDMm0266tTevR+ifav4vk0IkK4cNOd1Hh78jRZ7cR5MeAZa4j2pPXxA
         un32cqkASlCD7U+AaBMlPTy2js2fcQdR5kyTqkZ71VP7eOlJs/vE8HIIvCvDL6P2+n0F
         hXt5GGtKj8ExpRl7+swczXLgK5i7zDDhnwTKKfPRfMaM9UU8OUMq+jKibtlvEvoonLTi
         9vpMYB/bNtnYZdFUV5c6EIoxJuRLLRXPvJNfO3TmRt711Rx/Yb6nXbWIXYQlxPBn1FlU
         SwIQDYkN+/mrpSmF9L4SkCLJvTsv3VwE1EHK343BCIIEIErqbmqZfPNI6kJv8RoeR8g7
         JS6w==
X-Gm-Message-State: ABUngvffE60aBZIQDzuQIl0bfYTMAhjfHT4CW2BmJVmELlk+Z314BiOH5H7gh4937GILm6iB
X-Received: by 10.99.116.76 with SMTP id e12mr9901404pgn.20.1478642744769;
        Tue, 08 Nov 2016 14:05:44 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b1a1:9a4c:f024:dba4])
        by smtp.gmail.com with ESMTPSA id y20sm50379936pfj.26.2016.11.08.14.05.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 08 Nov 2016 14:05:43 -0800 (PST)
Date:   Tue, 8 Nov 2016 14:05:42 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 2/2] transport: add protocol policy config option
Message-ID: <20161108220542.GA86649@google.com>
References: <1478547323-47332-1-git-send-email-bmwill@google.com>
 <1478555462-132573-1-git-send-email-bmwill@google.com>
 <1478555462-132573-2-git-send-email-bmwill@google.com>
 <20161108220426.bqvmmjr54w7btgih@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161108220426.bqvmmjr54w7btgih@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/08, Jeff King wrote:
> On Mon, Nov 07, 2016 at 01:51:02PM -0800, Brandon Williams wrote:
> 
> > Previously the `GIT_ALLOW_PROTOCOL` environment variable was used to
> > specify a whitelist of protocols to be used in clone/fetch/push
> > commands.  This patch introduces new configuration options for more
> > fine-grained control for allowing/disallowing protocols.  This also has
> > the added benefit of allowing easier construction of a protocol
> > whitelist on systems where setting an environment variable is
> > non-trivial.
> 
> This v5 looks good to me (both patches 1 and 2).

Thanks again for the help with this series!

-- 
Brandon Williams
