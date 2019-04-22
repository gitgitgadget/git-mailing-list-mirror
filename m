Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B241F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 15:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfDVPOi (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 11:14:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36233 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVPOi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 11:14:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so14848977wml.1
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 08:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o6Rw/SsaNDw1ZDZArmmQONRkCIKrlke/UBDeG/eEX4o=;
        b=TZkiaA224ugAeJK3oss5uXpmpAXSYtnduPIKSoetwJ9ytoK6Aga3qGY5C5XjHMyjM5
         +NAfEplCOavBkR/Wl0MBnZ0QUGcEGBT1LYcedZa7jPCey1XwSYYCyo31BFLGdH2UsYJT
         rOB/0b+wrrFV7tbvWB1YDj/lkFuF09nUTTUuShDhKKqjOSHcOpGYd9aK20XieH3Xcv2p
         qGcBGTrk9ty4CROVaLtzGNgrRXtFQeiLmOsqs2xDbxy5HA9c9lxeYRTsEyrbJbnMmuK4
         Fb5YbU7tADJ+rnEI3ejMq4i/VXQTVG4Keb9E9WoZrcgPMlB0Gm8Gu9W5Km4p6E845ccw
         U0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o6Rw/SsaNDw1ZDZArmmQONRkCIKrlke/UBDeG/eEX4o=;
        b=R3RJqpmnNZbgwlKZq+WoY5Lroi7ugqrAtBYrBTH4pBifIiblkiYvynWVNqu9FeRIXw
         dNacK9ryNtwuHXjM/cKQExXnrzWZ6jNumCajbjMJ35KBRoX75QAWpBt5g0gVIBQUvsxL
         vEKIBnSYb3GytmVzDMu62/SSGdkkkcGeTpuqg0mab+sTOOQ50Y6LvfQlKzlbBztUgznh
         4Zuwhgnh4Gjng7n7S5ubVYYKwX8XeSlslMGokFqr1CGNMbO0jPWXFda8hr0nAjqsvgq3
         lEgDiGnNQNBZt442PvO1Rlh21VzJchXiEzr/eWkNUKvKT+U6m8fr8b3SeysoZ66aqcln
         MZyQ==
X-Gm-Message-State: APjAAAWzE2O+K06BLLv9LiSMPMhp1YJjMVQ7cPZh4ZHLGMxlb8OyZ8eE
        ldxYjZt5/S77EQvZJ6Z4j28=
X-Google-Smtp-Source: APXvYqwEyC0haxpp976GmlZ754evOC/650hz/RRdb3zr/Lkg4bKarDSbWOZ3FzGrFjrDiLooB+QA3w==
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr13226176wmt.102.1555946076272;
        Mon, 22 Apr 2019 08:14:36 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-7-19.as13285.net. [92.22.7.19])
        by smtp.gmail.com with ESMTPSA id c16sm19475759wme.31.2019.04.22.08.14.35
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 08:14:35 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] Give git-pull a --reset option
To:     Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        sunshine@sunshineco.com
References: <20190421040823.24821-1-alexhenrie24@gmail.com>
 <xmqqftqbdijl.fsf@gitster-ct.c.googlers.com>
 <20190421211833.GC6316@genre.crustytoothpaste.net>
 <xmqqftqb9bf1.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <02595523-3b16-b434-1ea9-a9399d7f1783@gmail.com>
Date:   Mon, 22 Apr 2019 16:14:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqftqb9bf1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 22/04/2019 00:38, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> It may be helpful to point out that this is essentially the workflow I
>> had ...
>> I'm not sure if this email is an argument for or against this option,
>> but maybe it provides some helpful perspective.
> 
> I think you and Phillip misread me.
> 
> I did not question if the workflow is common the message you are
> responding to.  I've done my fair share of "I know what I have on my
> laptop is stale as I pushed it out to elsewhere to continue working
> on it, so let's get rid of it from the updated upstream and start
> afresh" myself.
> 
> What I questioned was if it is sensible to ensure that it stays
> common.
> 
> We'd be encouraging the dangerous workflow, instead of analysing the
> situation where people employ it and trying to give them a better
> alternative to deal with the situation. 

I agree that it would be better to support this workflow in a safer 
manner. I use a script that looks at the reflog of the local and remote 
branches to work out if it is safe to reset --hard when pulling. If 
there are local changes since the last push/pull (because I forget to 
sync before starting work) then it will run rebase --onto <new-remote> 
<last-sync>. If the remote branch and local branches have both been 
rewritten it tells me to run range-diff to figure out how to fix it.

The value of <last-sync> is the most recent push or pull that updated 
the local branch. i.e. when both the local and remote refs pointed to 
the same commit at the same time (rebase complicates this as the remote 
we rebased onto does not appear in directly the local reflog - you have 
to look for "rebase .*finish.* <local-ref> <remote-oid>". Also an ide 
might auto fetch and update the remote ref while we're rebasing the 
local work which stops the reflog coinciding exactly.) The <last-sync> 
is also useful for making forced pushes safer. The script pushes with 
--force-with-lease=<ref>:<last-sync> if the local branch has been 
rewritten since the last sync so that any remote changes since the last 
sync are not overwritten.

Using the reflog to figure out the last sync makes forced pushes and 
pulls much safer. If we want to support this workflow in core git (and 
it does seem to be fairly common) then I think it needs to be based on 
something that prevents people from accidentally throwing away local 
changes when pulling and remote changes when pushing. There was some 
discussion of this with respect to pushing last summer[1]

Best Wishes

Phillip

[1] 
https://public-inbox.org/git/CAEFop40OJ5MRwM8zxE44yB0f2Fxw9YsUdM1e-H=Nn9e=sAGJ=w@mail.gmail.com/T/#u

  That is what we'd be doing
> with "pull --reset", i.e. an easier to type short-hand that robs the
> chance to double check in the middle of "fetch && inspect && reset"
> sequence.
> 
> As to where the feature should go, if we decide that it is a good
> idea to promote this workflow element as a supported feature, I
> agree with Alex's design in the patch that it makes sense to have it
> as "pull --reset".  Existing "pull --merge" and "pull -rebase" are
> "fetch and then integrate by merging theirs into ours" and "fetch
> and then integrate by rebasing our stuff on top of theirs"; the new
> "pull --reset" would fit well sitting next to them with its "fetch
> and then treat our stuff as valueless and replace it with theirs"
> semantics.
> 
