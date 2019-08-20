Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E536D1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 15:06:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbfHTPGh (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 11:06:37 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34734 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfHTPGg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 11:06:36 -0400
Received: by mail-wr1-f43.google.com with SMTP id s18so12788304wrn.1
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 08:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zXwu5BfSdUlo0CuacRJbFYqdoZFa76Tuko7KOCWNAOA=;
        b=K+rs5l/NWT2QTnhEwIo/VoJ9ov4PjIAGVSMexENwQvevMMR2/HD4gsqRo8IONL84rG
         xQcxnutfIls+0s6bWPyBaMsn2/IkjlkWvXrZLC8nziloHehrNWKQLSC+DDNQqaB3Z/QL
         1ZasO12F6B8/QwcEJha5ZKxNWOH+70PlsENiI9n7nC0/3XdNkKrnUHFuk5DvNU0RaSpv
         Tuz5IYBn6zKq3tvNAYMo9s4vn/rzDLr2gRnbQNpOBxcgjG7hJFhPHEWRCV4smNxeHdgf
         pz5wTDG9pjLwQG7XLZiJkBB2pZrxfB2DB/XvUKHzMBTkBF25LJN/DMY+PjkW1gBkwLo/
         9bNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXwu5BfSdUlo0CuacRJbFYqdoZFa76Tuko7KOCWNAOA=;
        b=lRhWScQanB+1OgTddXVJQOB9t8LrQao9xUudhgYLw7fmVxBflB8yRCnz388mv/9XNO
         e/JUvqL/vJeDipV8RAPUfNomp9KSGs1PWnN1BetwUwCpLOhuDtFrRzrrni7ytDSonl2e
         epjtYoPicnFHQyXBMLh4bJ0B4ZD1f1m8ePo4490Zbi9dwGzUaZqbaBOHTDPLOjAAJOOu
         rejYcf58fcQOzAuoD0AYW8pGdHiZLmHmeigXni+9RZzDf6G11oTU3Si8aUZO2uZpftkS
         Hy1uH79L+V/v4fYqKdm4/nFqqmtQGfVM+rzPKJSn06eQlb9D8pUZNBWAzVihixvWH/ES
         P2ZA==
X-Gm-Message-State: APjAAAUL9y+EDdB8cjXf5coNK3RnatkIox5HGVfjLM6WaFYiOcZ+O+WS
        DxfF3Kc4HmJQADUREaxxNIU=
X-Google-Smtp-Source: APXvYqwVRw5vqul2/cWrP4Oz0ENY1FaSZTrVk5fnia0TxYMMzxdeQgSdv3Y6y2JnK6B0KMhnKSxpfg==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr33567293wrr.194.1566313594548;
        Tue, 20 Aug 2019 08:06:34 -0700 (PDT)
Received: from szeder.dev (x4dbe6ded.dyn.telefonica.de. [77.190.109.237])
        by smtp.gmail.com with ESMTPSA id 16sm430870wmx.45.2019.08.20.08.06.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:06:33 -0700 (PDT)
Date:   Tue, 20 Aug 2019 17:06:31 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [problem with name-rev] (was: git log --graph with a sort of
 local revision number)
Message-ID: <20190820150631.GW20404@szeder.dev>
References: <87blwq7rn5.fsf@mat.ucm.es>
 <20190818190032.GA11185@rigel>
 <87pnkzkivn.fsf_-_@mat.ucm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnkzkivn.fsf_-_@mat.ucm.es>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 04:32:12PM +0200, Uwe Brauer wrote:
> Here's what I get when I start committing on master, then switch to a
> branch foo and finally merge foo into master:

> *   changeset: ae68dbe:master
> |\  user:      Uwe Brauer
> | | date:      Tue Aug 20 16:25:53 2019 +0200
> | | summary:   1.2.1/1.1
> | |
> | * changeset: c00bb5d:master^2
> | | user:      Uwe Brauer
> | | date:      Tue Aug 20 16:25:53 2019 +0200
> | | summary:   1.2.1
> | |
> | * changeset: 54c9230:master^2~1
> | | user:      Uwe Brauer
> | | date:      Tue Aug 20 16:25:53 2019 +0200
> | | summary:   1.2
> | |
> * | changeset: da0712f:master~1
> |/  user:      Uwe Brauer
> |   date:      Tue Aug 20 16:25:53 2019 +0200
> |   summary:   1.1
> |
> * changeset: 8eb999d:master~2
>   user:      Uwe Brauer
>   date:      Tue Aug 20 16:25:53 2019 +0200
>   summary:   1
> 
> That looks odd.

What exactly do you think looks odd?  That "master^2~1", perhaps?
That's how commits on different branches are named, see 'man
gitrevisions', and 'git name-rev' works as designed.

