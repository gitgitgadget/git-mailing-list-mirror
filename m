Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B1A207E4
	for <e@80x24.org>; Wed, 26 Apr 2017 02:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1949693AbdDZCJa (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 22:09:30 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33349 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949686AbdDZCJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 22:09:29 -0400
Received: by mail-pg0-f66.google.com with SMTP id 63so14585130pgh.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 19:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=pn1xO/ljIEQK08OVH7D3HzNPqZe8ybF/Fejzu7lEEmY=;
        b=VX2g9cQO+zevWUIeaDYLPA6WgNkFfCQeyxOsyMmBIWLCVfR1ixCRJ7FUyooOfMe3wZ
         li6NqlEo2SHpQcf8xlRcPSL80GDu3bCsCt8qIVU+to1fajQ8qBNL0ZJtazcWu0EuMIdZ
         qG0SX84LAqKTaN/v0BS/6DpORYHCOkAwsiqSazRs+vCRnD1L/+qYG5hj0nLrQzaN5+2r
         /IHFoL4MOaq9eMQLDCoGMYys+IMvvWZto20rinomlnJ994iZ/rS+uN8QsU2QVtPhoo7l
         cFGnv9F3Kva6QnKHSvWDlOwavrTT7tcFpkCKz6pE0y4De079Na9O5YUUkyr6JnvUQTz9
         5IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=pn1xO/ljIEQK08OVH7D3HzNPqZe8ybF/Fejzu7lEEmY=;
        b=Q/Jpzf/NYoskS/k+gRTV+4mVAhxNqk9h4MfkssTyLR/7VYzLUqDi3EeYppoUpGFlUN
         bu2CALHStkw35JKFKUzOb85N4jWS+kJYolOwSaJhhWM+bL6e9ixInUGAyHqfAYnqoGQh
         bhfZG4f2VxRxTcKIK5CIekdxE+GC5Ja+bZyL9/IZeelEptViuVZ6pRCzUyYBUv3+tXSV
         /Zc1GA3OPo28BUw/eB3jKCz5FM3zebeQDUv2CnPqLfp9A1CD2ZLFbPZ3YwIte1uOy/BE
         AjiqNiurAg2Rht3NQ64tWr0f9Sly/g0b6ArOlLLtweD3vUQNYYhrzDyG0Dx6/Sfb9xNb
         nxZQ==
X-Gm-Message-State: AN3rC/7pucry96tsSfkur70AeUrYVyfue27NNibF/o3t0C6XtgC+LyFw
        /EAscRGMiJWbtg==
X-Received: by 10.98.72.144 with SMTP id q16mr30734944pfi.152.1493172568684;
        Tue, 25 Apr 2017 19:09:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3179:d004:20b:b383])
        by smtp.gmail.com with ESMTPSA id y202sm23476053pfb.15.2017.04.25.19.09.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 19:09:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jhannes.Schindelin@gmx.de, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
References: <20170424032347.10878-1-liambeguin@gmail.com>
        <20170425043742.15529-1-liambeguin@gmail.com>
        <xmqqinltuhiv.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xrXyguugTETd_C-JXDSZ5zHUC3d_1cU4CuiaJjAqWQ=RA@mail.gmail.com>
Date:   Tue, 25 Apr 2017 19:09:27 -0700
In-Reply-To: <CA+P7+xrXyguugTETd_C-JXDSZ5zHUC3d_1cU4CuiaJjAqWQ=RA@mail.gmail.com>
        (Jacob Keller's message of "Tue, 25 Apr 2017 01:29:10 -0700")
Message-ID: <xmqqefwfudgo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Mon, Apr 24, 2017 at 11:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Personally I am happy with the beginning of each instruction line
>> aligned, so from that point of view, this patch is a mild Meh to me,
>> even though I do a fair amount of "rebase -i" myself.  But obviously
>> I am not the only user of Git you need to please, so...
>
> I would instead justify this as making it easier to change the action,
> since you only need to rewrite a single letter, which at least in vim
> takes "r<letter>" to change the action, vs slightly more keystrokes
> such as "ct <letter" or otherwise.

That makes sense to me too.
