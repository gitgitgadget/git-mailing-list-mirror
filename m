Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-10.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 696CF1F45F
	for <e@80x24.org>; Mon,  6 May 2019 20:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEFUaK (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 16:30:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40539 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEFUaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 16:30:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id d31so7027714pgl.7
        for <git@vger.kernel.org>; Mon, 06 May 2019 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Szpe+ULFBBPxZ5uT3taPY4V3ppuuRqvecTnPGmxohdY=;
        b=Kcvm6/YYnHA25YrZSxDSeCFN5wRahQT7anzqOfbkdXIaFcFKxsJ2anyU2N8uGlvaLu
         M8cpANqsEGZTzqolcvLxbhQEBhQQOdAa/jwPYybxDBKYUvYyPmie3oXxqMBKBuRhr54N
         KU5Iuy6YFUW1KrcNEox/Kd2vjDdxiiEpcIq7bekeEQL9VpZpTUh/SBvJQbCMJAQtY7I8
         7DZGA5xn9Gbk0/ZKEWxwUHja3AhGea1FTW0OX9XdztUlVKcpA7aqP8ddM02r/2RvHzWw
         xook+aQRq3H22XaS8XdK6mZRgra2v+zIESmPfiwTPVut3TRNkyjxynzGXLDwACdG+t51
         hv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Szpe+ULFBBPxZ5uT3taPY4V3ppuuRqvecTnPGmxohdY=;
        b=hkFf3sTsJ/FRAvCQECO5HzLeKxl8jdrgnN9Zh7hQXyrFwi9gjkI8qm+yb91QdrhuRa
         i9nv1jgdRTUZv9BJljAOYDp3pC3RhdUQ0cL1o1I7+NPSl6M9Odaf6T2pO+0AXUJgBLvK
         g9kYffnxQhl5aeQTHcKktp/+gWRDz7RZW6YPZ/u+rVyBu2cRGMjvCYvU59LXPAXa6z3D
         Hklfqry3lyo+vpfVtyD0m411fiCHx6++gvWrPRiDOB70RK1kERDkhuY2eTZpgkaKsYAi
         EBQfGqGQ5XY43R30c4Z+9UCYKQ3yikpOZL1RaO6HO1EeRAcj3PnLZEBoZCV/39LU9Ajk
         ef8w==
X-Gm-Message-State: APjAAAXA5b5vG3+ytreL07yxKujeu/DtuuZNcNk/F5JQdeZu0QXhwnFy
        XQkZWxhSaRobO+Nb2I1uj+m+jg==
X-Google-Smtp-Source: APXvYqzeM6WYLBeGV4+eBC7zyc8kdsslo1XHL8gdvNl0uhsm7jYDM4S0FVb0kZJBBwD+msT3w7G9Lg==
X-Received: by 2002:a62:5fc7:: with SMTP id t190mr35899097pfb.191.1557174608528;
        Mon, 06 May 2019 13:30:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:903:92a9:af1c:1897:8241])
        by smtp.gmail.com with ESMTPSA id h74sm20925659pfj.5.2019.05.06.13.30.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 13:30:07 -0700 (PDT)
Date:   Mon, 6 May 2019 13:30:03 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Konstantin Kharlamov <hi-angel@yandex.ru>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFE] Allow for "interactive"-like actions in non-interactive
 rebase
Message-ID: <20190506203003.GA85211@google.com>
References: <1556895855.30374.0@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556895855.30374.0@yandex.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, May 03, 2019 at 06:04:15PM +0300, Konstantin Kharlamov wrote:
> Interactive rebase (i.e. for example "git rebase -i HEAD~10") is used most
> often to apply an action to a single commit, e.g. "rename", "edit", "fixup",
> etc…
> 
> As result, people keep coming up with custom scripts and aliases for every
> distinct action.
> 
> Instead, it would be nice to have native support in git to start "rebase"
> for a given commit, and pass the "interactive action" to use on that commit.

I would totally use this. The equivalent workflow right now is a pretty
large number of steps for, say, fixing a typo.

> Examples:
> 
> $ git rebase -i HEAD~10 --action edit
> $ git rebase -i HEAD~10 --action rename
> $ git rebase -i HEAD~10 --action fixup

Is there an alternative to any of these actions that can already be
taken individually? Or, another way of asking, were the interactive
rebase commands based on some other Git command which could be pain to
do on many commits individually?

Emily
