Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D461F453
	for <e@80x24.org>; Wed, 23 Jan 2019 17:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAWR6F (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 12:58:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36562 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbfAWR6E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 12:58:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so3580232wrp.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 09:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EwQABoN14ApmFQapWCZ6sKAew0ZRm3eFzZw8k8BOjXg=;
        b=my2znL2deYhPv8t+1BIKQ58kJPMHXtYQFTlObLI0koakmMxJNCbbelr/zRhwfNsGpD
         W7XA0wTdozxxeK5zG4sl2wxmdc4x89EakC9xa12oEEki/i3nyizEZDqRURdoTN3hqAhd
         +otaGhHVdSAl1we0SK73U5v3xNvM//y3RbIt1fDbiMwkwqSqNuuV4jmJosMqmt4ySNoZ
         0tQKB1HZMAGXw3+2S6SGbt00XxPVVpRriodjcky3ifSivSouzFXz8l+u24fyPcex/mMk
         55FlrNaBm6pQDifBNeibSraYAacuWDlJg0a64jVVbxzWbUvMrMb8nRL3fiILZxVya/SQ
         wjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EwQABoN14ApmFQapWCZ6sKAew0ZRm3eFzZw8k8BOjXg=;
        b=E5P4b2/F3riPZ3BTXm6ef7Ic0X5Rm/Lj4yDwoJggiUvuVKhXEaOPdVR98j6ci66v0E
         z3XRkqQ+2nMPpSF0y4iR96BtbBmaiaNPag2H+h/xb3p4atlCQc29S9PM5b5tGm9i2rbW
         uBm9j90xyS4bwWIoshqvQ8uuvKbXsUNrkSiNDxDaQ2YsVWv1O+IFHUybpNhMv0XuPbdq
         Ijuvwbvz+CGEB12G5mvO9PTG4QukmiwsxzNeLTqKFX0sRH4wDGXn7jyHN8dfTn7B0ErF
         NVkop9ERYL1ba/aj0hQWtCPKtCpWq0QJE5k/nWtDuoShX5Rzm2IL3h/wIeMSSwRKgPbd
         O97Q==
X-Gm-Message-State: AJcUukcaBRyHQ0XxOZpZDJ/3F6+OOUbFZxSNBXqnwOthMbNVnEl0wEvJ
        IUuTsRdIsaEvxxiWkCBtWtwTcsO8
X-Google-Smtp-Source: ALg8bN7I4bvClF6I//c8mTsiSXhQk3KJeEICGrxHYrMmJfA07NrTU1YeRJKt4u5MhcS64q7O37m9AQ==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr3656114wrn.104.1548266283172;
        Wed, 23 Jan 2019 09:58:03 -0800 (PST)
Received: from szeder.dev (x4db59613.dyn.telefonica.de. [77.181.150.19])
        by smtp.gmail.com with ESMTPSA id y138sm66562818wmc.16.2019.01.23.09.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 09:58:02 -0800 (PST)
Date:   Wed, 23 Jan 2019 18:57:56 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, asottile@umich.edu, benpeart@microsoft.com,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH v2 1/2] checkout: add test to demonstrate regression with
 checkout -b on initial commit
Message-ID: <20190123175756.GA6702@szeder.dev>
References: <20190118185558.17688-1-peartben@gmail.com>
 <20190121195008.8700-1-peartben@gmail.com>
 <20190121195008.8700-2-peartben@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190121195008.8700-2-peartben@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 02:50:07PM -0500, Ben Peart wrote:
> From: Ben Peart <benpeart@microsoft.com>
> 
> Commit fa655d8411 (checkout: optimize "git checkout -b <new_branch>", 2018-08-16)
> introduced an unintentional change in behavior for 'checkout -b' after doing
> 'clone --no-checkout'.  Add a test to demonstrate the changed behavior to be
> used in a later patch to verify the fix.

Please wrap the commit message at a width of around 70 or so
characters.  The commit messages of both patches contain lines that
are wider than a standard 80 char wide terminal.


