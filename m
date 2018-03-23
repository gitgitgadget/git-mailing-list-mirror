Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 195BE1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 18:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCWSYY (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 14:24:24 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35209 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeCWSYX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 14:24:23 -0400
Received: by mail-wr0-f172.google.com with SMTP id 80so11963493wrb.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CXooiXZgNc20OoFag6xc7R1NP5WeyPkToB79/Ei+hoo=;
        b=WwqyXxbRVzmSnSwMy38EezCVqpenXgS4QNgw7WqZ13XsOap+H26cAKJR9+uJQ0ql/D
         OFRLoLtLx7vQaNGAurqAIEo2g6HQrOiDCdo9o/7gd0HdObGy3UwttqtFlLof1w6XxDy0
         WZ7SM4sqiwv35eTY42hrvxyWtgHF9CJhZZoj/+KPVhFsv5Z/A9LndR704g9scjOW6VTx
         SIfGHysfsEPqB+qW2UG0DcsyLrw9c75DsaPqqLSfIX8mcxRLBsOu6qL0lZsa3beQvlr5
         7ftqQdqsAwUIEEIhopenBUUkPvZtOn29U9sM4qHtPx+kzOIuJ32cnD4UZuf82xu/sXFS
         8KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CXooiXZgNc20OoFag6xc7R1NP5WeyPkToB79/Ei+hoo=;
        b=V42fktpTQi6pCjnMIy3vz+m7liLJiCD53vJgTa2ciWizHgaa4YQgiRtnL/P2ozZ7H/
         mKfrMnPq56Sh6Jbnn9oHuU1kKaxH4INBRn9C2FYRV2qUfzcFjYYfowd3Ttp5k77qoVdj
         5NVxTS5Kjcz4PlyGx1DeNKmYYfuj21WZ7FEMyO9xpvcH+iNJ7f7Isn0sU1DxgEJtb86T
         jHE2o9+GNJzDFPT7A/qrvbo190c3zCbSJ82WqGbR5/fHJOrUPBOOl2OfvFGEt42bqmHA
         5CcxJa4egforwaFOISEWWrKiEQP9Yc73ISbF/bfTSXa5Rk6bNPKR6rXr0OfweLvwORuz
         AohA==
X-Gm-Message-State: AElRT7G+iQHbAdw3E/8uTnItY/uCbb+YJYhAC/o/W7tmZYAIJYYh/PuO
        OPyL63pn8C7wTBOwJMVe57cMu9UW
X-Google-Smtp-Source: AG47ELuDPSiUA8CrV0D96LgA8J4RoWWVIGsLlfzk6EzW38aEs0DrDB6AKNaO1haa3M9HxWhWQraRmg==
X-Received: by 10.223.195.58 with SMTP id n55mr22283264wrf.132.1521829462247;
        Fri, 23 Mar 2018 11:24:22 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f22sm19666682wmi.39.2018.03.23.11.24.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 11:24:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Wink Saville <wink@saville.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
Subject: Re: [RFC PATCH v3 5/9] Use new functions in git_rebase__interactive
References: <cover.1521690197.git.wink@saville.com>
        <387b3dc01562fd30f5894c91109d1a9d00d07720.1521690197.git.wink@saville.com>
        <nycvar.QRO.7.76.6.1803231838020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 23 Mar 2018 11:24:20 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803231838020.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Fri, 23 Mar 2018 18:42:13 +0100
        (STD)")
Message-ID: <xmqqzi2yiraj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> If you fold this into the previous patch, I am sure that after your 3/9
> indenting the function properly, the splitting into functions will look
> more or less like this:
>
> -git_rebase__interactive () {
> +initiate_action () {
> +	action="$1"
>  
>  	[... unchanged code ...]
> +}
> +
> +<next function> () {
> +	[... setting up variables ...]
>  
>  	[.. unchanged code ...]
> +}
> [... more of the same ...]
> +
> +git_rebase__interactive () {
> +	initiate_action "$action" &&
> + 	<next function> <arguments> &&
> +	...
> +}
>
> In other words, it would be easier to review and to verify that the
> previous code is left unchanged (although that would have to be verified
> manually by applying 3/9 and then looking at the diff with the -w option,
> anyway).

We are on the same page on this.  A series structured to have a step
that looks exactly like the above would be very pleasant to review.

Thanks for a great suggestion.
