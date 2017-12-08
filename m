Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1877E1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 22:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753177AbdLHWaR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 17:30:17 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:42534 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbdLHWaO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 17:30:14 -0500
Received: by mail-io0-f179.google.com with SMTP id u42so3917058ioi.9
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 14:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0BhXWsUT3of7NgZMNQZQX+vvkqImv+j8vpEiztlAHS8=;
        b=XGO7m3IYd+jwxE8ZxBUc8QQ1mUaA8FVycHwt4lbXDlQ7vb8nJXb2kqdKxzSvT6Ybrr
         ojSMcQSkEL/QDw0i62IF34iTOKYZtGtHbyihTLvq3wHD1sHObNppA9ADDQ9tb0rrr8Dn
         DMD5OG9JItbD+c2CBe1aLocz/qwqoX3/5pvFbTSSkgMC5eQYxKXmN6j52d3fW+n2nNkl
         T4xqFRFaKbVqdAe8kwoVFYh5gl479oSkIggXQCDI6qZvghDo94lIUpibs1+8Y8fbSB2d
         5vXxrb7uQzoStnraKhIfh5EHka+9IscWRDXUQUue06/udRcbbDw5IaQHWJGG1OzXKWCH
         yc1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0BhXWsUT3of7NgZMNQZQX+vvkqImv+j8vpEiztlAHS8=;
        b=D4hA/2APYhpnivjQ5Md6s/OnCo1dfeYdPeqY94B8BxTZ9FcBb15oWDxmjQNvD1IrnB
         9/MJ0fC1wgumTJUrzLi9zeVW90B4Aq9eLHxUTHobdhAk2VcO70OAosaT/XnphaVqsfG3
         YK221FXsx73L3zLGLWuwKevq9USmsJbhD5iIDgI0SsqWh1ht54CtXII2VGns8fH9To5T
         zy6xDK4uVcQSi4HFZbWwU1d4bNDu4/a088TPF17ginDsnUhI8cgjbsRzPfYo9MlEEcnh
         1gDW5AgesvSGJya78qSPzROl8TVjCF7gl7L2x09U8kuTKD8+bbuQN/cvlw+tqWD40iOj
         eT6g==
X-Gm-Message-State: AKGB3mJQEFUzNkJltT+wAWxid03H3Y5RCgbJZGmWoQuD51J71O0jL+ZW
        aJpHaQ+AeOffVioUM3Wd0Dfadg==
X-Google-Smtp-Source: AGs4zMaS9HpCD1nS4/e3CQWsaaV3QwPRacC3F96tyAVBwIlvx32QsXQRX4qYz257ueOgffcnVkOqdg==
X-Received: by 10.107.114.19 with SMTP id n19mr4450181ioc.224.1512772212963;
        Fri, 08 Dec 2017 14:30:12 -0800 (PST)
Received: from google.com ([2620:0:100e:422:e4f1:b67a:70f2:4fbe])
        by smtp.gmail.com with ESMTPSA id x2sm1218663ite.24.2017.12.08.14.30.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 08 Dec 2017 14:30:12 -0800 (PST)
Date:   Fri, 8 Dec 2017 14:30:10 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jonathantanmy@google.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 00/16] Parial clone part 3: clone, fetch, fetch-pack,
 upload-pack, and tests
Message-ID: <20171208223010.GF140529@google.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171208155851.855-1-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08, Jeff Hostetler wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> This is V7 of part 3 of partial clone.  It builds upon V7 of part 2
> (which builds upon V6 of part 1).
> 
> This version adds additional tests, fixes test errors on the MAC version,
> and squashes some fixup commits.
> 
> It also restores functionality accidentally dropped from the V6 series
> for "git fetch" to automatically inherit the partial-clone filter-spec
> when appropriate.  This version extends the --no-filter argument to
> override this inheritance.
> 

I just finished reading through parts 1-3.  Overall I like the series.
There are a few point's that I'm not a big fan of but i wasn't able to
come up with a better alternative.  One of these being the need for a
global variable to tell the fetch-object logic to not go to the server
to try and fetch a missing object.

One other thing i noticed was it looks like when you discover that you
are missing a blob you you'll try to fault it in from the server without
first checking its an object the server would even have.  Shouldn't you
first do a check to verify that the object in question is a promised
object before you go out to contact the server to request it?  You may
have already ruled this out for some reason I'm not aware of (maybe its
too costly to compute?).


-- 
Brandon Williams
