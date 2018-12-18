Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB741F405
	for <e@80x24.org>; Tue, 18 Dec 2018 16:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeLRQvF (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 11:51:05 -0500
Received: from mail-yb1-f182.google.com ([209.85.219.182]:37299 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeLRQvF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 11:51:05 -0500
Received: by mail-yb1-f182.google.com with SMTP id s66so853185ybc.4
        for <git@vger.kernel.org>; Tue, 18 Dec 2018 08:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yg7yAVMN6ergp2Xi3/NN6kUyEiHXTGZCGhxH0m/Mkxs=;
        b=hCGsAfKXs4YSxxTwo0eY69lJcdBHWUlbL7ezys8k8ZMEWJfwwDefMxqGHRfjawxLaL
         NBfHod0+e2FNQ3d86bwJ+VbpwE2Dtf4aPyVSIwGNY/rHaBYIEPvDzov5VuDW3NeFPiGa
         FknOntjCJE0i40XBunN/G8bzD4GMGmTERZUq4TQhRsfT19SIbdR6ylJv2c6iueYMQ33q
         yNqqGzRZowmsFH9iXlgwRRsdgGgocOTg138rEdyydEDH3sRNXXNE8P2zFRpAwSZFnz3H
         JGecGyQdrtYT+tP/CCOc5zffLcFIX7sCISJwakgURRLvgdC/wHldnYVWRVKzBfFwOj3Z
         e3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yg7yAVMN6ergp2Xi3/NN6kUyEiHXTGZCGhxH0m/Mkxs=;
        b=SFj9jVqnJM85CXTDtnA8Bee65sCHOaCI7SNu2C/v0IiYgYD37u5lK9GV/FVRt3zjUq
         Dja3EapZRJRimj7AnGTc+A9IOG+C+cCdBmBQzCUfSm/b85i6JucyrvFFhlwdeaZJ4cuT
         vd3d5Adl343RTyIOF2kevrhB4CLWAF+cz4KJKVkt2RYg6IhgycHQoZEisuEyf+C3jyFc
         paB461CLjZeBVr6FaINTLYQnpdM3j38LHLhGWHs0C+7ytwTHlt/I4dM3lLn4pafjnWf+
         1NPnWrMeJX0Imjla65MRGIVnSCn/HAEkGcQTlkBkotllzkVaBWTIy/S3j0IQiBYPKAsU
         ON3g==
X-Gm-Message-State: AA+aEWZcRBqAomqJ3j37Uoc2lOc1E96EuDKScP4r46ArPfzrP7yRcwKI
        RoNjXyY8nvr832YPJe+UBtU=
X-Google-Smtp-Source: AFSGD/WSGq6W0vfm6ovL6izzkF34Gp3Qgvkw+wum+qHZAVVc/X2qB4jCjoF7zprT1xqvMf/94dCSdw==
X-Received: by 2002:a25:3a04:: with SMTP id h4-v6mr17214610yba.32.1545151863416;
        Tue, 18 Dec 2018 08:51:03 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:e01b])
        by smtp.gmail.com with ESMTPSA id x203sm5597818ywd.41.2018.12.18.08.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 08:51:02 -0800 (PST)
Date:   Tue, 18 Dec 2018 08:51:01 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Stefan Xenos <sxenos@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, kernel-team@fb.com
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks
 and other cross-references
Message-ID: <20181218165101.GY2509588@devbig004.ftw2.facebook.com>
References: <20181211234909.2855638-1-tj@kernel.org>
 <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
 <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
 <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
 <xmqqa7lagm18.fsf@gitster-ct.c.googlers.com>
 <20181213034606.GS2509588@devbig004.ftw2.facebook.com>
 <CAPL8ZiuNgv4s1w-FKAznV5A9MKxSxW40fTPrF0Xt8Ywy6UOsVQ@mail.gmail.com>
 <CAPL8ZiuxzdUtkRxALBZ=LjTaKQ6d85BmB9nTQ0JPLnVRo91j8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL8ZiuxzdUtkRxALBZ=LjTaKQ6d85BmB9nTQ0JPLnVRo91j8Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, guys.

On Tue, Dec 18, 2018 at 08:48:35AM -0800, Stefan Xenos wrote:
> I've just uploaded a new evolve proposal that includes a spec for the
> "hiddenmetas" namespace, where we can store historical cherry-pick
> information.

Total noob question - where can I read that?  Also, as long as I can
have the back references and follow to the existing cherry-picks, I
don't have any further requirements, so any working mechanism is great
by me.

Thanks.

-- 
tejun
