Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD08D1F405
	for <e@80x24.org>; Fri, 21 Dec 2018 00:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbeLUAXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 19:23:42 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:35543 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeLUAXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 19:23:42 -0500
Received: by mail-qk1-f173.google.com with SMTP id w204so2138075qka.2
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 16:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iYL2V5PFkDgXqZeK189KGYMXr/w3tpL5Ra2l3C3v+ps=;
        b=chKF6lRrx4D9sYK4OTbKqGP2jLSSREAQx1TpEVlE79p7kOA0JIr6lx8uygMup3Zs9F
         yzens+XDrPphEBikTLgtaIGOOjYdoseEGCWK5pDtffr7TyGfaD8oEWlwBqBXYS2D/VE1
         SbqpHKxtu573YVW7AxBopjfHf2VIdlWVCFvop+h6kjpXB0lZUDO1cNAZL0IkGeGr+rBJ
         6fctC7AQ+VT5yq1j9hrmGCc0SK1KTDZ3+jKrbxUt5i5LR4Gf8sVzEAIVFIeJtAZKYKsZ
         0O938bZEsFAMbMSLb9ntaWWl3KnxOoWj47+SQqNFyb2CYw6ciafWAXmU5GNz1n/KLH2c
         fXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iYL2V5PFkDgXqZeK189KGYMXr/w3tpL5Ra2l3C3v+ps=;
        b=NFRiG20NBdx4r1Jd/g3MRl3bKFfv7DvsQYHmSm98IOnW64IUKZR6+JBD0Zg70NpNE2
         C4rdx5LEVli6tENTsB+z/YuJ9pzJzNLuOAINruQ5Z324PvK5kd/CyfiCghYYB/vcDQhF
         u/nrl8EtAKFVzCoDJmB1p9kMExylDXmg/6Zohfq0iefX7uZ3clkWw4gBhDcidoT5ipCz
         2oNw9jbukLJZIbKvEqs1HMTuyyJ+LX8ryLizOOwZwKxtXTr/8y7z1oF7kjHH+uCyPmjF
         MQtPAlmdYYLILOz/sW1sWn4oTYu77gTQc2fNumozosi9rrdkKxzT2LnOIr6JRHsztdBz
         em+A==
X-Gm-Message-State: AJcUukd1wqKI5D3bLgwllWRg34yGyRoUoDSmWsrALMG/6Br46w1v7TAo
        32Wb4kp8iJfzSIODLS52Xo1JKSSe
X-Google-Smtp-Source: ALg8bN7jVJELc/oQsZeqC8+yf8ZrjzYXTgZv2G/RDAiHWoPJerZZIqRP02V14vDYhPia27iS9chLoA==
X-Received: by 2002:a37:a06:: with SMTP id 6mr356945qkk.52.1545351822069;
        Thu, 20 Dec 2018 16:23:42 -0800 (PST)
Received: from localhost.localdomain ([187.183.221.211])
        by smtp.gmail.com with ESMTPSA id z207sm4077247qka.57.2018.12.20.16.23.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 16:23:41 -0800 (PST)
Date:   Thu, 20 Dec 2018 22:23:36 -0200
From:   Ricardo Biehl Pasquali <pasqualirb@gmail.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org
Subject: Re: rebase: Ask before doing anything not undoable
Message-ID: <20181221002336.GA10482@localhost.localdomain>
References: <20181220173348.GA5203@localhost.localdomain>
 <20181220182653.GB4823@alpha>
 <20181220211147.GA7426@localhost.localdomain>
 <53e97c08-1eaf-5f83-a699-5666376bb4c4@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e97c08-1eaf-5f83-a699-5666376bb4c4@virtuell-zuhause.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 20, 2018 at 10:37:00PM +0100, Thomas Braun wrote:
> The git rebase documentation has
>
> ORIG_HEAD is set to point at the tip of the branch before the reset.
>
> so doing
>
> git reset ORIG_HEAD
>
> does reset to the state before the rebase.

That's pretty easy :-)

> For avoiding the original problem of --co completing to
> --committer-date-is-author-date I'm using the alias rc for git rebase
> --continue.

It's definetly an alternative. Anyway, ORIG_HEAD reset is
sufficient for the cases when enter is hit before noticing
the completion string.

Thank you!

	pasquali
