Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A48181F404
	for <e@80x24.org>; Fri, 10 Aug 2018 19:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeHJWIG (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:08:06 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:33715 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeHJWIF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:08:05 -0400
Received: by mail-wm0-f46.google.com with SMTP id r24-v6so2277196wmh.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b/3NdrJAU5x9R0DEKiTEUtWlb1P2yP8Rfu5nvnTvanM=;
        b=t7w0j43mZ0Gm5tuEKRbEiIIKSz3H9UsUEDDvgMyxv0w25vnLOpdeJU50uORFnV+4Qk
         dk2wrgTxtOeS7xlChbkRjYcikaVaVw3tEikDcXcQ0oVXnOctcHTo50WOefD+i+2GeTju
         n+EafpejnCvKDRgzUTKLduesRgygOzjZ00QgdCfnZIIO1cdxmRt3BHAuvmE+6vekvls2
         8o/tEwNfF1hH4lwhGyBkhDZfvagSXkyjdAh38BWhfzH2WqYrSoUyLH1oqeeT/TfrRO1j
         BG8qMMD1QDyQxHt6++AAajygtUeU2Hq6oX4Vf5X2UeQxXinHBis2J0QxiHHer85u918A
         KMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b/3NdrJAU5x9R0DEKiTEUtWlb1P2yP8Rfu5nvnTvanM=;
        b=NjoKiAqcicg2mTKEBk1uuChfSN/z2kXoHPQbxirpBGSGBlvIdxUdujSibbDQ6ekeiM
         Wk6hYA8pPEmCRu9Ngzq4q8Q66MVNiF1MmUi2k2Mw4nNv2p1i7gssT3qxNydSic9wnv+Q
         oZfOzsBy9BEmlTkKzFwsAoBpzZo34QiYENFvkaYf0DEctxqc/THhYCTHws8zbIxWGkzg
         0j19m3vOYnq5MoG4Rfjw650ShoBOd0cMEvdKclZ8Gi2V0MRcixvW/wCvHxK0tp6/aM0Q
         t3rg2vp+DbC84rKgCJnqYgvi8Q+HGQjvdAOFTvV8wBUvI9ieCmv1x4nsoRBjtSJh8Oc2
         AEiA==
X-Gm-Message-State: AOUpUlHEshFythFp0TJpHUb4dS1DbK7qnh8gMBpeHaYBJ+nHsmlyKfTG
        x8ap1c/rblC1Q75wLxGv9u8=
X-Google-Smtp-Source: AA+uWPw8gQnwspGwkwMMaqtfgErURqDm6HKpvZ/skTW19NbB5l8OLekksnNWyTdc41EnErMiganahg==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr2494480wmg.50.1533929810649;
        Fri, 10 Aug 2018 12:36:50 -0700 (PDT)
Received: from [192.168.0.104] (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.gmail.com with ESMTPSA id u7-v6sm9129427wrq.13.2018.08.10.12.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 12:36:49 -0700 (PDT)
Subject: Re: [GSoC][PATCH v6 11/20] rebase -i: rewrite complete_action() in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180810165147.4779-12-alban.gruin@gmail.com>
 <xmqq4lg281ms.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <453e3f0c-6c68-71e1-0338-185f129bb778@gmail.com>
Date:   Fri, 10 Aug 2018 21:36:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lg281ms.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 10/08/2018 à 21:25, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> This rewrites complete_action() from shell to C.
>>
>> A new mode is added to rebase--helper (`--complete-action`), as well as
>> a new flag (`--autosquash`).
>>
>> Finally, complete_action() is stripped from git-rebase--interactive.sh.
>>
>> The original complete_action() would return the code 2 when the todo
>> list contained no actions.  This was a special case for rebase -i and
>> -p; git-rebase.sh would then apply the autostash, delete the state
>> directory, and die with the message "Nothing to do".  This cleanup is
>> rewritten in C instead of returning 2.  As rebase -i no longer returns
>> 2, the comment describing this behaviour in git-rebase.sh is updated to
>> reflect this change.
> 
> Hmph.  It is easy enough to do the clean-up ourselves in this code,
> instead of asking the caller to do so.  On the other hand, stashing
> of local changes is done by the caller, so it feels a bit strange
> way to divide the labor between the two parts.
> 
> Other than that design choice, the patch itself looks reasonable and
> a fairly faithful reimplementation of what the scripted one did.
> 

This was the behaviour of the old complete_action().  The new one cleans
up by itself; this is the
apply_autostash()/sequencer_remove_state()/todo_list_release() dance
done at three places inside complete_action(), and has not changed since
v3[0].

Maybe I misunderstood what you said?

[0]
https://public-inbox.org/git/20180710121557.6698-11-alban.gruin@gmail.com/

Cheers,
Alban

