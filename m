Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5EBDC20209
	for <e@80x24.org>; Thu, 25 May 2017 05:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941936AbdEYFZx (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:25:53 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35964 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941903AbdEYFZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:25:53 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so36793168pfb.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F2Ld+ObMcQHZpSVZQwaSWY9WQXkhGNxrhUaT8PpN7Qk=;
        b=RG7KPHG+l8mEwbx2RPsy2PkV7L/VMGnvWupSER18R/8+oo3XUgr8nOfFrzQfW28h0X
         yR+awJP6M9DtEqCAP3vOEE9asp+z87SGprPzsMjjYH3gCPx3uZCHmRvAs+4+0jaSsVfq
         P/6T0qREoXtKqsF1aJyVY7HwuIFrkVikCpVphviMVUkU1qzk3GOCeAoBZcnIjSZ30DwZ
         YpfR+T86hyOpRWwfhxqsgVY7RAimxiqbzfQ4MppBgkAvx3g5cIxCRZOHVHzIwjClP9jw
         ZDcXAwebXIl6d45EOvkHRfHxTG5Er3XDya26qbyqHq+rrl2JB6fEZ7lMUUr5YvgCK+rE
         dMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F2Ld+ObMcQHZpSVZQwaSWY9WQXkhGNxrhUaT8PpN7Qk=;
        b=TYwPEVIACHwAxXnCu2RkabtnCQK57jDEzWyMB/7Iz8DWQjxiaM7TPnWvQ9MeWhAa/f
         AoOaQh75a5gJG0aXOfhuzHkB3HhAzsECmtSOzhFiAPH671yQ6pDy3ctoVtuomuK6m7FZ
         0xqgJbJCGZE65bci3e779iSYMyk5QktDzl/tG8zctEib4qfBQqKmLnQpYy8w9JC/WqMb
         TUyhkWPF6sNj7h1qESbGxZsk7sy9jlwBrN56sd92LHa1CPRw8aaxn8ci31OpcAl75Tt8
         bjMk1I4lCAp9VAE7P1qqk/8+9Q7RiVppQIpEkh4fdYETvaIH0CJs1o1r/AagFbwaJGOm
         513w==
X-Gm-Message-State: AODbwcAzxtjDk17sF2OcKVlwR8aQ200oshsgD3FPS3Q3z6Fjknw+t0uY
        5p2p/yKPXQi/PkFL3v8=
X-Received: by 10.99.65.7 with SMTP id o7mr42377095pga.90.1495689952346;
        Wed, 24 May 2017 22:25:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id t79sm9971858pfk.106.2017.05.24.22.25.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 22:25:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Smith <whydoubt@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 24/29] blame: move core structures to header
References: <20170524051537.29978-1-whydoubt@gmail.com>
        <20170524051537.29978-25-whydoubt@gmail.com>
Date:   Thu, 25 May 2017 14:25:50 +0900
In-Reply-To: <20170524051537.29978-25-whydoubt@gmail.com> (Jeff Smith's
        message of "Wed, 24 May 2017 00:15:32 -0500")
Message-ID: <xmqqk255ecdd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Smith <whydoubt@gmail.com> writes:

> The origin, entry, and scoreboard structures are core to the blame
> interface and need to be exposed for blame functionality.
>
> Signed-off-by: Jeff Smith <whydoubt@gmail.com>
> ---

Looks good.  

Thanks to "prepare everything in place before bulk movement"
approach this round takes, unlike the previous one, reviewing this
is just the matter of running

	$ git blame -C -b HEAD^..HEAD -- blame.h

after applying this patch.  Anything that is shown as "introduced"
by HEAD needs careful examination; everything else we already know
are good because we know it came from existing parts.

Thanks.
