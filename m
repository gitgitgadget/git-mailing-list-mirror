Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B80B20954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbdKVRJr (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:09:47 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38616 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751585AbdKVRJq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:09:46 -0500
Received: by mail-pg0-f44.google.com with SMTP id s11so12835109pgc.5
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VKW+MXwwW7h4WUlb0JRYZYpKYK5zy12W73mXSNo+Ask=;
        b=PthMFNi9XYZBeuMHhjuPLoVJhsizv+mXqnSAuQ8NoULyNwP2jmb5x/9zX+3D1cpaGg
         +WbwJxXjRbVPPBF+YcR/LFHy7v9zaJLO9jBrY+ZI5hUGACefmtN1MgvfqFfShat90o/G
         WsrtV0rcAYFcZU/e42Knuq2c1g0vpcH7tct1VNQg0TQmx7I9aCcdQQhALaxvmaagkrLQ
         78W1X1ogB/jGbFsTxSJXFMp10Pb62985d+9yUd9UGlvKT36bW3PvdtEg8Ekl6nRR0Y5R
         hIBw6aRfQwJa5FRHdgVwcZXEQgXgRZunTMj8ehmxWlWuK97iVotc89hNF3Jjo4NTqISM
         3i7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VKW+MXwwW7h4WUlb0JRYZYpKYK5zy12W73mXSNo+Ask=;
        b=hbTZOKm8b4xNPgqxKzBTSmEQFgahIyfZLG5GqOncVKf/ii5m7WKCMgYXKldgiJz1vg
         Zw4jOjlg+PQsz+uipiVoXvmev5x2uTirNZkNTOjt6nWDO+j7Tcmmy0TiErwWuGdg9Xig
         RdbM4z+QePNTqIN/0XMdoHaoOOGDc90hFo29y+8G4+ms4O5B+dU6j3wwri+99IdDKzvK
         fbs5V0OSdbKCmbalGM1WmOe3YChsKOpiDpXuRMZbh8Of/BRfX7rLrUK5xHhGlkQ1zmjE
         5Q0wtqyx6khP36ixxexlG1HRihIj5CvsZiP/JrwEwHQsIrX7F+WgKzBNPoxLLwNB/omi
         yXDg==
X-Gm-Message-State: AJaThX5QBkh8tEh6zNIrUL04OKDwKJ+49m3Yd4+JMbaacVOZel5562ka
        VOg9HUa0bXAnlYlXDRI/Pe5GvlfK
X-Google-Smtp-Source: AGs4zMYmRMWV8oA+bBLWE/IdTm2PFk7BDBrcrQWR0BINIpKCFueEpYYQ6cfzexFBkS45rxO35YtouQ==
X-Received: by 10.98.222.197 with SMTP id h188mr20061932pfg.132.1511370585751;
        Wed, 22 Nov 2017 09:09:45 -0800 (PST)
Received: from ?IPv6:2405:204:73cd:cf11:6767:b6f6:4b9c:e3f? ([2405:204:73cd:cf11:6767:b6f6:4b9c:e3f])
        by smtp.gmail.com with ESMTPSA id k23sm31043970pfj.22.2017.11.22.09.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 09:09:44 -0800 (PST)
Subject: Re: [RFC PATCH] builtin/worktree: enhance worktree removal
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
References: <20171121150954.3227-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <fee60b19-bc8e-bbd8-9f5d-347b2f941b2e@gmail.com>
Date:   Wed, 22 Nov 2017 22:39:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQrC1MiPrwwPqtdX2tzj1ntFHxO28uqnMBcmVpPPrc_Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 22 November 2017 03:07 AM, Eric Sunshine wrote:
> On Tue, Nov 21, 2017 at 10:09 AM, Kaartic Sivaraam
> <kaartic.sivaraam@gmail.com> wrote:
>> The new feature to 'remove' worktree was handy to remove specific
>> worktrees. It didn't cover one particular case of removal. Specifically,
>> if there is an "entry" (a directory in <main_worktree>/.git/worktrees)
>> for a worktree but the worktree repository itself does not exist then
>> it means that the "entry" is stale and it could just be removed.
>>
>> So, in case there's a "worktree entry" but not "worktree direectory"
>> then just remove the 'stale' entry.
> 
> Let me see if I understand. Sometimes you know that you've deleted the
> worktree directory, in which case 'git worktree prune' is the obvious
> choice. However, there may be cases when you've forgotten that you
> deleted the worktree directory (or it got deleted some other way), yet
> it still shows up in "git worktree list" output with no indication
> that it has been deleted (though, ideally, it should tell you so[1]).
> In this case, you see a worktree that you know you no longer want, so
> you invoke "git worktree remove" but that errors out because the
> actual directory is already gone. This patch make the operation
> succeed, despite the missing directory. Is that correct?
> 

Yes. My primary motive for sending this is that, I thought it didn't 
make much sense for 'remove' to fail just because the directory didn't 
exist. Further, I thought it would be more flexible to allow for 
'selective' pruning of worktrees. The use case in which, I thought, this 
flexibility might prove helpful is that of 'scripts'.

Consider a hypothetical script that plays around with a git repository. 
Further, consider that spawns a new worktree for temporary use. It's 
quite natural for the script to consider cleaning up it's own mess and 
thus it might consider removing the worktree it created. With the 
'remove' command it is as easy is,

git worktree remove <worktree_id>

But what if it was the case that the directory might/might not exist 
when that part of the script is reached. In case the directory didn't 
exist the 'remove' command errors out that it didn't exist instead of 
just removing the worktree "entry" for that <worktree_id>. I thought it 
wasn't a good thing and thus this script.

After writing this, I feel I haven't justified it well (impostor 
syndrome, possibly). Anyways, at the end of the day this "ad-hoc" patch 
was just a result of my gut feeling that, "It didn't make sense for the 
'remove' command to fail when the directory didn't exist". The 
implementation is just a "sloppy" illustration of how it could be 
achieved and should "better" not be used as such.


> [1]: Excerpt from:
> https://public-inbox.org/git/CAPig+cTTrv2C7JLu1dr4+N8xo+7YQ+deiwLDA835wBGD6fhS1g@mail.gmail.com/
> 
> Other information which would be nice to display for each worktree
> [by the 'list' command] (possibly controlled by a --verbose flag):
> 
>     * the checked out branch or detached head
>     * whether it is locked
>          - the lock reason (if available)
>          - and whether the worktree is currently accessible
>      * whether it can be pruned
>          - and the prune reason if so
> 

It would nice to see this information. It would be very useful but 
'list' doesn't seem to be the right sub-sub-command to give such 
information. Maybe there should be a new sub-sub-command named 'info' or 
something to give such information?

