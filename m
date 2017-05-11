Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 942891FF34
	for <e@80x24.org>; Thu, 11 May 2017 06:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754784AbdEKGmt (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 02:42:49 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36786 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdEKGms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 02:42:48 -0400
Received: by mail-pg0-f54.google.com with SMTP id 64so9705534pgb.3
        for <git@vger.kernel.org>; Wed, 10 May 2017 23:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Zbr2dz7AshgPKg5TpA165UmJwuq9CK4RRWbDSiZTQXs=;
        b=HwR8/qVm1LsI3897F/47ogdx6GKB9mqq911S6/3XMxwE5YgF0lO9oQsp6Kkt6qhRex
         7/cS5S7M5F+QsB8t4S+UjQdCH3W4I67dsgdk+sTEoEi1D5dkvqN9xALSe34U4b6x/xzQ
         bh9atFQsoL/11/nlI0UrTIN7nNoLANToCYfgikwXYfKP6Y0Qv/ZyeW35Xv33gpkI8cDd
         4dIj4vx+n/1w9hAUUzj9Hur0ua7X0QnuAnY6GzMumn8j5Wdha1mN7DVcfNJmHh7FeAeB
         x362bTRw7xrsnIR7D1W86GFESXp9gISS8wAARaReWB/zXvdzfenlmdRGiFh6E6oSDuty
         yEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Zbr2dz7AshgPKg5TpA165UmJwuq9CK4RRWbDSiZTQXs=;
        b=rBZAb5rXyFtbjw+7kgjA/oiQTMaPSP5j8H/Gc77t6ZQy6nFX8ngZG3flUKRwDdmoWk
         BRmKIR0q6QYTylIDDAXoe1h31gZ9inDMBCS/atdeOTwF9wCE7PyeI9bHa6Y7KH55WQLs
         Azwg4kE6h7UFEBOiEkiRCYT1wBePeV42DnJHuscW3Hvp+Yml2xEy2jQvF1je8gGKUqHR
         jkQtA5BymKpafBGrISxd+17fVL4FjgNs/W2I9X4oaLXXm8A+sFeJ1X7sx2ytFoWFpXQH
         YPFA6eYOXR1dkFCgg6Xr/ujfMb6Lpkzn1sktJt4TaoUbH/KRC8r8WMmzWJknnb+QeaOX
         Z4dw==
X-Gm-Message-State: AODbwcARZWVLgWkdDqAFwMdluFwBKssRkzEuqUZ4hJPFEXZSJJVXzhe4
        FqdNQ6Kpw/lihfg40HQ=
X-Received: by 10.84.233.131 with SMTP id l3mr13645829plk.18.1494484967598;
        Wed, 10 May 2017 23:42:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id r21sm1860942pfg.95.2017.05.10.23.42.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 23:42:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nazri Ramliy <ayiehere@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Should "git submodule update" accepts --init?
References: <CAEY4ZpMJbS+-xDKcwbOHCWxAdjOVuTN9DFJNHVqHw0r06CwKJg@mail.gmail.com>
Date:   Wed, 10 May 2017 23:42:46 -0700
In-Reply-To: <CAEY4ZpMJbS+-xDKcwbOHCWxAdjOVuTN9DFJNHVqHw0r06CwKJg@mail.gmail.com>
        (Nazri Ramliy's message of "Thu, 11 May 2017 14:11:02 +0800")
Message-ID: <xmqqk25nc2s9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nazri Ramliy <ayiehere@gmail.com> writes:

> Otherwise it seems like I'll have to do "git submodule update" twice
> in order to update an already initialized submodule whose upstream
> repo url has been updated in .gitmodules to point to somewhere new,

I am not a heavy submodule user so what I think may not count, but I
think the "upstream" changing the URL of the submodule should be a
rare and notable event.  Making it easy to automatically run "sync"
without thinking would be a huge mistake---it will make it likely
for users to blindly follow what the upstream has in .gitmodules
without checking if the new URL is sensible.

Also doesn't "submodule sync" blindly overwrite URL, even the ones
that you tweaked in your configuration to override to point at a
mirror that is closer to you than the one suggested in .gitmodules?
If that is the case, sucn a change to make it easier to run "sync"
without thinking is doubly bad, I would think.
