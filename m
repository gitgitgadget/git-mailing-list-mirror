Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D1220954
	for <e@80x24.org>; Tue, 28 Nov 2017 16:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753434AbdK1Qqw (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 11:46:52 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:37925 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbdK1Qqv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 11:46:51 -0500
Received: by mail-pl0-f47.google.com with SMTP id s10so247242plj.5
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 08:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GodPJ9ILQJq5x9gD1zZMeaojkRxvGONp6/uvP4BmlKs=;
        b=rxEy6vcl3VCIh5mDejEF0mLvIFlpVAcD3UxVaBH0SNZM2gXXkZJ8K56uqOAu7smZm6
         RPeKnZqGb+eZbHAlrRld4UhoJNL+gRzYgdTTPB2mnejuaI/vcT9Dh/j5dzpEpbnBJ+Gj
         lusxa2eSzfDmAB3tYBbWdZvtzlf39UbJxedoNhIIbI/f0oN/8rVS2KtYfHumvr7q5Uyy
         Wl5+kE085TZ1GtyS7fiVQYMdPVhdlqnq8Ul2VrBwwOJKIoDr6YU+EEV2jN0Qf6ODoL4W
         VP3m7r7ckPQTlmGtUs+QhPV8B1w+gnatzqRr+YgyCaqUX6N8fo1Hhs1A82sE7SK0QGdg
         PSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GodPJ9ILQJq5x9gD1zZMeaojkRxvGONp6/uvP4BmlKs=;
        b=JhxiW1OCXlZDe8fPQLPGMw0JTDTMjtWkMXdajXXO+JuVw81aRqppCEmX9g4ra3TAUK
         RfBuiZVHCuSod/fnKbpM3P4R5zAOlAi1tRXE/E62kZ4c47oKiF71gwFLo5A2ecthEWS2
         NW4vKRLB6jTGjwhx1aOpZUCbSvj3/lIZMVWjTH0eGOskNLSEoybibvnj8e8BQbec0Zk0
         RN6ac86YsThC9RAp0ygR2EVOW9ybWNG4bYQ3WO1TlsMXASZvB+nrrqOHTvhAU6ToINd1
         wCHRP7n0Z3rohoWGejGNuEUNcCj9dsDsFBuOpDYoU47PdxmyO/JfTv5btoUXor3cz5EQ
         +tJQ==
X-Gm-Message-State: AJaThX4cLROgQrYYN6oEqCaV85zKVVaVJlrPyi4Gl1sfz+uU4Q1yKP5J
        aiHQnDLpnNQQwO3Bfjaih6SEzgWfC0o=
X-Google-Smtp-Source: AGs4zMar+4q2B7vY3mARhGs9OXDkSwXeaq3W9gjTGvwSoHQEASRzvOCn/2I6PHsNJtUGOR2j0ESgOA==
X-Received: by 10.84.128.229 with SMTP id a92mr28070047pla.108.1511887610456;
        Tue, 28 Nov 2017 08:46:50 -0800 (PST)
Received: from ?IPv6:2405:204:7344:993e:9a3:d467:14f5:495b? ([2405:204:7344:993e:9a3:d467:14f5:495b])
        by smtp.gmail.com with ESMTPSA id a87sm57987293pfg.159.2017.11.28.08.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 08:46:49 -0800 (PST)
Subject: Re: [RFC PATCH v2] builtin/worktree: enhance worktree removal
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
References: <20883815-0d9b-a4d8-cc93-0eb8b918551f@gmail.com>
 <20171127173621.6707-1-kaartic.sivaraam@gmail.com>
 <xmqq7eub85rz.fsf@gitster.mtv.corp.google.com>
 <CAPig+cT3jbZ=VRWpggw_tvegAGnjGQ0Mxp8m2DdKKPhfKTVEWA@mail.gmail.com>
 <xmqqy3mr6ocp.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <c2e041ab-4c29-99a8-2de9-a68e986c225c@gmail.com>
Date:   Tue, 28 Nov 2017 22:16:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqy3mr6ocp.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 28 November 2017 09:34 AM, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> With this approach, validate_worktree() will print an error message
>> saying that the worktree directory is missing before the control info
>> is actually removed. Kaartic's original patch silenced the message
>> (and _all_ error messages from validate_worktree()) by passing 1 as
>> the second argument. That seemed heavy-handed, so I suggested keeping
>> the validate_worktree() call as-is but doing the directory-missing
>> check first as a special case.
>>
>> But perhaps that special case isn't necessary.
> 
> I do not think the user minds to see "there is no such directory
> there"; actually that would be beneficial, even.
> 
> But you are right; validate_worktree() would need to become aware of
> the possibility that it can be passed such a "corrupt" worktree to
> handle if that approach is followed.
> 
> The case we are discussing, i.e. the user removed the directory
> without telling Git to give it a chance to remove control
> information, may be common enough that it becomes a worthwhile
> addition to make the "quiet" boolean that occupies a whole int to an
> unsigned that is a collection of bits, and pass "missing_ok" bit in
> that flag word to the validate_worktree() to tell that the caller
> can tolerate the "user removed it while we were looking the other
> way" case and can handle it gracefully.  But that would be a lot
> larger change, and "the caller checks before calling validate" as
> done with this [RFC v2] may be a good way to add the feature with
> the least impact to the codebase.
> 
>> I had envisioned a simple 'goto remove_control_info' rather than extra
>> nesting or refactoring, but that's a minor point.
> 
> Yes, use of goto is also a good way to avoid having to worry about
> the future evolution of the codeflow in this function.
> 
> So perhaps
> 
> 	if (the directory is no longer there)
> 		goto cleanup;
> 	if (the worktree does not validate)
> 		return -1;
> 	... the original code to (carefully) remove the
> 	... worktree itself
> 
> 	cleanup:
> 
> 	... remove control info
> 	... free resources held in variables
> 	... return from the function
> 
> is what we want?
>

Probably but I'm not interested in going for a v3 that does that as I 
just wanted to show that worktree remove could be enhanced in this 
aspect and show how it could be done. So, I'll leave this in the 
#leftoverbits for the person who would be re-rolling nd/worktree-move.

---
Kaartic
