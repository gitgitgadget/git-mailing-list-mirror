Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BF851F403
	for <e@80x24.org>; Sat,  9 Jun 2018 20:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeFIUbA (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 16:31:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40804 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933168AbeFIUa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 16:30:59 -0400
Received: by mail-wm0-f67.google.com with SMTP id n5-v6so9530335wmc.5
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 13:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2SN6xQORY4Sp5BpS7OCkUPgKx80+u3qsSzZxKFtqiZc=;
        b=ToSHvNkz21/6TNJrI0pAkJzXovUY6fyGUuCv6pS/0uN2vmPdq3x81esTQyr35OM4nu
         JPMQ0E0Tlf2FxNFA4qdrp7YgBWSNkCckaV0oEVm4kWd6BBd3XOt7r1H34Nzzq54l535t
         nlL7Byikwr3cWuxIFiHq+sCrQT5vLzJ0Z2I4Ti7fwKmuGwLHRdZA5IfCmS/l/ulbFaR3
         XZmzs0xVet0LLUwe5ToLOoCnEHx6jXMQFaxQL/Uyx6suynceTVvC3UjuWUWfvZeJg8UV
         elYkkTPYTWTXyCuXGnvjWyKQ2VI4hSJO0D9SiVBa4tGPgjv+HL9TKbd84h+SNbIO8T06
         7iPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=2SN6xQORY4Sp5BpS7OCkUPgKx80+u3qsSzZxKFtqiZc=;
        b=OrfigJZAO/qW1Hak7AjDks/15KMnYEBIBc/lFAmbg0u7/rCGv0Sr8aMh6w35OKP2T9
         IH3mh8HZMc/WaeMVSXRPtZcJz0INXGGm2fMQUgc990xC5a1Eq1WnBSTeztw4QQKVc99s
         BKySYaQsPJK/kvWoBz0mDVJwR4U3s3PKZzV4f7p1gZAb9oniUHGYAY5vn8aAmqbAiamh
         j7/hbmNEZAFjJC/39Vuxdj8v/i4GdGzfbZ0iF4QaD4v2QrBl9JbRVgMQY7CaRVcfoKGR
         AfK1P2B08WTSRyZWsy3pAX04yMhbwwewC3UKsNBWy5AGZWBVVP0XL91HZJbqObnThngQ
         OmTA==
X-Gm-Message-State: APt69E2HBjAHcL5SZvi1V3KS7eJXMDUFjzssYaURNT60KbjNnYX5tBsO
        GFC5+vrdHU7QKwi6fNzKC62mT9XX
X-Google-Smtp-Source: ADUXVKKuQJ0RkcljnLOhI8TbK9YvnPwcfbUPN8uXmS+5v+0+IiIz7y/z7605d4OGNfOurpbwYnjXeA==
X-Received: by 2002:a50:a722:: with SMTP id h31-v6mr12481709edc.251.1528576258340;
        Sat, 09 Jun 2018 13:30:58 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id y26-v6sm8587232edr.51.2018.06.09.13.30.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 13:30:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christoph =?utf-8?Q?B=C3=B6hmw?= =?utf-8?Q?alder?= 
        <christoph@boehmwalder.at>
Subject: Re: Why is there no force pull?
References: <20180609190154.yl4ig6dxfihgm5qi@christoph-lap> <CABPp-BG9HQ4O8h7-b4oL7KLu+boe6-QV1fvcfW_4O3Rax3W_Hw@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CABPp-BG9HQ4O8h7-b4oL7KLu+boe6-QV1fvcfW_4O3Rax3W_Hw@mail.gmail.com>
Date:   Sat, 09 Jun 2018 22:30:56 +0200
Message-ID: <87h8mbwvlr.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 09 2018, Elijah Newren wrote:

> On Sat, Jun 9, 2018 at 12:01 PM, Christoph Böhmwalder
> <christoph@boehmwalder.at> wrote:
>> Hi,
>>
>> Since this is a use case that actually comes up quite often in
>> day-to-day use, especially among git beginners, I was wondering: is
>> there a specific reason why a command like "fetch changes from remote,
>> overwriting everything in my current working directory including all
>> commits I've made" doesn't exist? Now, I'm quite aware that something
>> like
>>
>>     $ git fetch origin/branch
>>     $ git reset --hard origin/branch
>>
>> will do the trick just fine, but (like I mentioned, especially for
>> beginners) this kind of seems like a crook. Why not have a single
>> command for accomplishing this? Afterall we do have a `--force` flag on
>> `git push`, which practically does the same thing in reverse.
>>
>> Just reaching out to get some input on this, as it seems like a quite
>> curious inconsistency to me.
>
> Upon reading the subject and before reading the body, I assumed you
> were going to ask for a 'git pull --force' that would throw away
> *uncommitted* changes (i.e. do a 'git reset --hard HEAD' before the
> rest of the pull).  But then you asked for both uncommitted and
> committed changes to be thrown away.  That difference isn't something
> you have to consider with a push.
>
> That might be a reason such an option would be confusing, or it might
> just be a warning to document the option carefully.  Anyway, thought
> I'd mention it.

More generally, "git pull"'s params are passed to "git fetch", and then
we either "git merge" or "git rebase".

This proposed behavior doesn't fit into that at all.

But it would if we added a third mode, similar to how we added "rebase",
where we'd dispatch to "reset" instead, so:

    git pull --reset --hard

Meaning (in the general case):

    git fetch &&
    git reset --hard @{u}
