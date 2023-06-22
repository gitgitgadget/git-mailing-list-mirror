Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A7EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 10:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjFVKKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 06:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjFVKKI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 06:10:08 -0400
X-Greylist: delayed 519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Jun 2023 03:10:07 PDT
Received: from out-59.mta1.migadu.com (out-59.mta1.migadu.com [IPv6:2001:41d0:203:375::3b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D48D3
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 03:10:07 -0700 (PDT)
References: <20230509175347.1714141-1-christian.couder@gmail.com>
 <20230602102533.876905-1-christian.couder@gmail.com>
 <20230602102533.876905-11-christian.couder@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
        t=1687428087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORZvJquR6eOXbXWj1GYrIPCwwdL/K+SArSZnu4E/hIo=;
        b=L1H6ARmYw/lSEsCiojhK5cym2UCT9c0IGouR01UJp9zjHE9azlZmoAMp5TtEyiypMHHDml
        qnM/rduEQ6Yh9Ar53xvJIUZYPKqu/1nOpZ80Is27wsgmIaHsBrAzLHnlXo8w42cVr1JSc6
        GVAe9fIj2xeNOroy0YcyfUOxVqBAV9E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Toon Claes <toon@iotcl.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 10/15] replay: make it a minimal server side command
Date:   Thu, 22 Jun 2023 12:01:11 +0200
In-reply-to: <20230602102533.876905-11-christian.couder@gmail.com>
Message-ID: <87pm5nstli.fsf@iotcl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Christian Couder <christian.couder@gmail.com> writes:

> +			decoration = decoration->next;
> +		}
>  	}
>
> +	/* Cleanup */

Nit: I don't think this comment adds much value. I would argue it's more
confusing to have it, because there's a label cleanup: just a few lines
down.

>  	merge_finalize(&merge_opt, &result);
> +	ret = result.clean;
