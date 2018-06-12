Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210481F403
	for <e@80x24.org>; Tue, 12 Jun 2018 16:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933744AbeFLQLt (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 12:11:49 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43140 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933137AbeFLQLs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 12:11:48 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so24682269wrm.10
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I/jYFW1XTXoKhcgvdqlk3PjE1qJ7wieyLSgcaZRjT6Q=;
        b=mZ+3IAF8WpCECvzgl/WiAxM9lUmFNHdnNMqzgz1gmkM8nVabEYfhumexmznJL3ZjZJ
         W12Ua8p2yXfTVXjFsy95wrDS7t/wr5+p1BWqIEOaZyIA5Mqku1C/u0ntt+X+bKljw/o2
         XNavItO+ejRKAT0JoYqQsNvIotcj3Bn81ZsC1cQHycHKLxSnLtI2cUTB8ln2z2CdwuK5
         n13GztJtd8Mx+8wGX+q8LwkNhT5U9zL+6ZclT7ywRgwT9Fc5Wv3EE5rJdtk2wwNea1pv
         1nT2jDiZSz1aGNaYYA3blDNjic/GZlhOEcQbnVzDYy5sMWef9IsWIq73K9Ezqd20ZiHZ
         d5xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I/jYFW1XTXoKhcgvdqlk3PjE1qJ7wieyLSgcaZRjT6Q=;
        b=OBb5DQRZHzJZC5UAzalGqe5EDiWEPffoqfOt1yvfrehd3eGJEw42oMenzAxnTzTfzq
         vCfRYn9UYna1mCQUvkePE2hD2aWsLZR1KhUmleSL9HUPuUxk6h60SVcsholoboZ2yZkp
         No1mFL/bX+MYRvQd009OMZVQpX6BXLmrijaYgbuxf3B0t+kOKjkseNwbkXWuFB4exlzZ
         /Woq5ClJJZxvHBSzCj2StBqOfP5rs06UISko/4sk5aVAbXJ5+Zx3N2OG4v4sZ42k3Z/5
         AeXCMvTM1CMZD+/YW/iXpE1UqjeW357RoU/zCfHQWoTw0auHNl0/0szfonogpqlq0iEC
         ktdQ==
X-Gm-Message-State: APt69E26dWhpSElxPfhtTJXQ5NqPiOs6W+/cyrbz+b0rO0+HMADW3rPM
        ZJoPQinOMLS6NKMo8NZrYFw=
X-Google-Smtp-Source: ADUXVKICWpy1VvYGKjT4PCZDylWHUMy4FdoNJmkpPyzHiK41/9+ZQyMn0RWwM3aCbY0UUmTzezSBZA==
X-Received: by 2002:a5d:45cb:: with SMTP id b11-v6mr841113wrs.106.1528819907488;
        Tue, 12 Jun 2018 09:11:47 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-25-147.w86-222.abo.wanadoo.fr. [86.222.24.147])
        by smtp.gmail.com with ESMTPSA id t17-v6sm494764wrr.82.2018.06.12.09.11.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 09:11:45 -0700 (PDT)
Subject: Re: [GSoC][PATCH 1/1] rebase--interactive: rewrite the edit-todo
 functionality in C
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20180611135714.29378-1-alban.gruin@gmail.com>
 <20180611135714.29378-2-alban.gruin@gmail.com>
 <CABPp-BHG41ePN1jRxADfb47FnXfKgJ++Jv=DUiTPwpUJUi=C=w@mail.gmail.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <599bb1fd-3a09-8c2d-d319-dbed95012895@gmail.com>
Date:   Tue, 12 Jun 2018 18:11:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BHG41ePN1jRxADfb47FnXfKgJ++Jv=DUiTPwpUJUi=C=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Le 12/06/2018 à 17:46, Elijah Newren a écrit :
> Hi Alban,
> 
> On Mon, Jun 11, 2018 at 6:57 AM, Alban Gruin <alban.gruin@gmail.com> wrote:
>> This rewrites the edit-todo functionality from shell to C.
>>
>> To achieve that, a new command mode, `edit-todo`, is added, and the
>> `write-edit-todo` flag is removed, as the shell script does not need to
>> write the edit todo help message to the todo list anymore.
>>
>> The shell version is then stripped in favour of a call to the helper.
> 
> I looked over the patch and didn't see any problems (though I haven't
> worked with rebase--helper before, or the code for todo list editing),
> but when I went to apply the patch it failed telling me:
> 
> Applying: rebase--interactive: rewrite the edit-todo functionality in C
> error: sha1 information is lacking or useless (builtin/rebase--helper.c).
> error: could not build fake ancestor
> Patch failed at 0001 rebase--interactive: rewrite the edit-todo
> functionality in C
> Use 'git am --show-current-patch' to see the failed patch
> 
> I tried each of master, next, and pu (as of today) to see if it might
> apply there.  On which commit is this patch based?  (Do you have other
> local commits that this was based on top of?)
> 
> 
> Elijah
> 

It can be applied on top of pu with my patch that rewrites
append_todo_help() in C
(https://public-inbox.org/git/20180607103012.22981-1-alban.gruin@gmail.com/)

Cheers,
Alban

