Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F34201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 15:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751356AbdBYPAJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 10:00:09 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34578 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdBYPAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 10:00:08 -0500
Received: by mail-wm0-f68.google.com with SMTP id m70so7049949wma.1
        for <git@vger.kernel.org>; Sat, 25 Feb 2017 07:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3ZVYmH8/W8iWPrQhWABb9u7PdmCLWk5K9n3Yjv8RS9Q=;
        b=C2HkVQ/ChDxH5Bo/Agnf2JkOsgf5MaBzTicDFE6oLNRpWFwE6Bjb2QHUT6UjCPhQlm
         tcFAI1ZWK2aTs09aMu5KnSjk0IM5m1PNmy10EwGIay3NFEx16DAVA9KvgLT4E62IIr5T
         fFxYS2Qvqeiz8tBZrUc0vB8Ldyzcv0UPuGEua81J6hE9tubu0gcgVUCCXg5F55+OmiHV
         3JunejPoHqebBGHUeWYE/CkFSJKE9faX41ayNhQkZ0HjWyERPmlKh6LGy1Zb/WmnVJRK
         20yjew8LuHajrzqO1zqfKDfVU58X+rMABRr8o++ZhPZPSolab6hbNkdJNT0TZ2gT6v1a
         8Fag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3ZVYmH8/W8iWPrQhWABb9u7PdmCLWk5K9n3Yjv8RS9Q=;
        b=jRrsSnMHj0Me+Q4SDR1VPqx9D8LLCRPuKPE+rjPDp87VrU4MDMFptNrgWvjAA2WHdR
         EM0faJVG9ZAnIowbyKiFPnyQ67RuJ2hac4WshwOXE7/4KAibCkgUgkM8E+odENxEk5Ll
         u7ma/dVKh0rDpjl03NuIQ0pH+WJ+My4uoLa4i///S7eWaLP9FnZDjJITHet3/hUWHdCn
         Pj1yVS+5K8UEct5BQ9SyiNCSyVYkXMstMFdPSfqJX5V5I63aSbfmQlsfJSXxF/1kLv7L
         AIPEnxoTmhk0C7BqXoP0tWxqMAo/RXvX7woemZ9QHay2N5nkh4NARIbiFn452eksra9l
         ogJA==
X-Gm-Message-State: AMke39nRaEWP/KC+0wPurUocmzGN6cZvmaNxqJf0OWZoxVU1nV12j0Kd5a67Mj0tgydoSg==
X-Received: by 10.28.6.210 with SMTP id 201mr7137998wmg.85.1488034291926;
        Sat, 25 Feb 2017 06:51:31 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id z10sm6618337wmg.31.2017.02.25.06.51.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Feb 2017 06:51:31 -0800 (PST)
Date:   Sat, 25 Feb 2017 15:57:19 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v6 0/6] stash: support pathspec argument
Message-ID: <20170225155719.GA6243@hank>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
 <xmqqd1eck5x5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqd1eck5x5.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > @@ -55,10 +53,13 @@ push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q
> >  
> >  	Save your local modifications to a new 'stash', and run `git reset
> >  	--hard` to revert them.  The <message> part is optional and gives
> 
> I didn't notice this during v5 review, but the above seems to be
> based on the codebase before your documentation update (which used
> to be part of the series in older iteration).  I had to tweak the
> series to apply on top of your 20a7e06172 ("Documentation/stash:
> remove mention of git reset --hard", 2017-02-12) while queuing, so
> please double check the result when it is pushed out to 'pu'.

Sorry about that.  What you queued looks good to me, I will however
send a re-roll based on your comments on 4/6.  (And I'll make sure to
base it on 20a7e06172)
