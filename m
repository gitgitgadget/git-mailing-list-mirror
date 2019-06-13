Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B2461F462
	for <e@80x24.org>; Thu, 13 Jun 2019 17:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfFMRne (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 13:43:34 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:46882 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfFMRnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 13:43:33 -0400
Received: by mail-wr1-f47.google.com with SMTP id n4so21656212wrw.13
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 10:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a8KMQgYk2wGSgKSEOEt+ueHIk0Uy6dipb74jfl7jHgw=;
        b=eYiu9dbHirD2Bv29KiYpORabF4zYtcLo6TuD4MpMREFLw/7LBVAa8Arq78jI6zWegz
         GwC3qNP1F8BwSMUV0CHFeO58eLOgF3NjVQZwTCeYbc4lVJJwIofVl35pkpaTKYP3YvqB
         8T2wZeunUhjJmatPhfP/826b2Mos0uWVc4VBO7e7HXe99y1NPmG7dQtb+izik+2hxiFZ
         5E4lt97HkQDaoYyXw9qt66f/CN94mrjumkzPqhU9JlT+5Pp/bKJVn75kYvDkwGKTgcxd
         Bn6hN2hDmWSm5Aa2u1Pa6YurDzbY0Rz75MhWLiAS0EsmuVg53enWx5VzFiZdY4/GHoO9
         ua+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8KMQgYk2wGSgKSEOEt+ueHIk0Uy6dipb74jfl7jHgw=;
        b=Cx5EAGT6g7NlpccynysreTnPB1pwmFVwoF4SW4t0R6QS6gza0nNKMSYqm4hXVsmNNs
         F/8hPov0Zs686QgVwjYRriD0QEc7F03cgc2pXibrSbdIajfZug2Mex0oGoHEZEsK4yGy
         QWFjW9craEYjCWFvYqy9J8cOgqFiCqmD7QI89HF0pdHL4PAkZTCuodLens3wu1+t44CP
         MvDv6PNPDNLYlenbYnCN0BW4qA+QKdI2cq3ppt2eAa7IY/6mLt55AC0RRBD/bGM9pI2m
         GJ6zBprxNcQSElU8VmmgAR8q6BWH/uUQ+h9SU4mLPWwjTOXaHvXphMwF64MzBt/awmWP
         FYwQ==
X-Gm-Message-State: APjAAAWH1KpcF7MIsY0L9pObVaBadUXK4O/j1Qe/FPBZL5MEcMLzb7bI
        KyxgrZD7+7clguiHbQDfPnC8cuSAMPs=
X-Google-Smtp-Source: APXvYqzfPjLwj+ESHUyHZnkT/zC/BZbLHdq76/uglJ1grd3pd2pSDG/wqf+zd98OOMsneoagntsjMg==
X-Received: by 2002:adf:a443:: with SMTP id e3mr8051551wra.221.1560447811847;
        Thu, 13 Jun 2019 10:43:31 -0700 (PDT)
Received: from [192.168.2.201] (host-89-242-178-164.as13285.net. [89.242.178.164])
        by smtp.googlemail.com with ESMTPSA id o8sm484562wrj.71.2019.06.13.10.43.30
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 10:43:31 -0700 (PDT)
Subject: Re: Git status parse error after v.2.22.0 upgrade
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     aleksandrs@ledovskis.lv,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Espen Antonsen <espen@inspired.no>, git@vger.kernel.org
References: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906112127420.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <38b0f33a-1da1-4231-802e-ae14d9843ad2@www.fastmail.com>
 <nycvar.QRO.7.76.6.1906122046400.789@QRFXGBC-DHN364S.ybpnyqbznva>
 <20190613093023.GA3919@ariake.ledovskis.lv>
 <xmqqr27xwjwj.fsf@gitster-ct.c.googlers.com>
 <20190613162432.GA12128@sigill.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <8981e6c8-eb20-fde7-2b4c-1fbf2057caef@gmail.com>
Date:   Thu, 13 Jun 2019 18:43:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613162432.GA12128@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/06/2019 17:24, Jeff King wrote:
> On Thu, Jun 13, 2019 at 09:05:16AM -0700, Junio C Hamano wrote:
> 
>> aleksandrs@ledovskis.lv writes:
>>
>>> My repo indeed contains a ".git/sequencer/todo" file which
>>> contains references to commits long-gone (i.e., rebased).
>>> Renaming or deleting this file stops whines about "error: could
>>> not parse".

I think this bug report is a result of
4a72486de9 ("fix cherry-pick/revert status after commit", 2019-04-16)
which tries to read the sequencer todo file if it is present and there
is no CHERRY_PICK_HEAD/REVERT_HEAD. Before that if the user committed a
conflict resolution in the middle of a sequence of picks then status
would forget that there was a cherry-pick in progress. It just reuses
the code that cherry-pick uses to parse the first todo list item which
expects the commits to exist.

>> Interesting.  So in short, when the repository has leftover
>> sequencer state file that is not in use, "git status parse" thing
>> (whatever it is---are you getting it when you run "git status"
>> command???)---is not careful enough to notice that it does not
>> matter even if that leftover file is unusable.
>>
>> Two issues "the sequencer" folks may want to address are
>>
>>  (1) make the one that reads an irrelevant/stale 'todo' file more
>>      careful to ignore errors in such a file;
>>
>>  (2) make the sequencer machinery more careful to clean up after it
>>      is done or it is aborted  (for example, "git reset --hard"
>>      could remove these state files preemptively even when a rebase
>>      is not in progress, I would think).
>>
>> I think we already had some patches toward the latter recently.
> 
> Maybe I am not understanding it correctly, but do you mean in (2) that
> "git reset --hard" would always clear sequencer state?

I think the commit Junio is referring to is
b07d9bfd17 ("commit/reset: try to clean up sequencer state", 2019-04-16)
which will only remove the sequencer directory if it stops after the
pick was the last one in the series. The idea is that if cherry-pick
stops for a conflict resolution on the last pick user commits the result
directly or run reset without running `cherry-pick --continue`
afterwards the sequencer state gets cleaned up properly.

> That seems
> undesirable to me, as I often use "git reset" to move the head around
> during a rebase. (e.g., when using "rebase -i" to split apart I commit,
> I stop on that commit, "git reset" back to the parent, and then
> selectively "add -p" the various parts).
> 
> Direction (1) seems quite sensible to me, though.

Now that we try harder to clean up the sequencer state I wonder if that
would just cover up bugs where the state has not been removed when it
should have been. That can lead to unpleasant problems if the user
aborts a single revert/cherry-pick when there is stale sequencer state
around as it rewinds HEAD to the commit when the stale
cherry-pick/revert was started as explained in the message to b07d9bfd17
("commit/reset: try to clean up sequencer state", 2019-04-16)

If we do want to do something then maybe teaching gc not to collect
commits listed in .git/sequencer/todo and
.git/rebase-merge/git-rebase-todo would be useful.

Best Wishes

Phillip

> -Peff
> 

