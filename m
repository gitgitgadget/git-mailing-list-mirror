Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C223208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 14:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389608AbeHGQvH (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 12:51:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55569 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbeHGQvH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 12:51:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so17675658wmc.5
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Q3vQIJLwTcewifUnOJAznYKUm7eyOAsduHlIsTgN1GE=;
        b=VAj5hTguB9qBXlQnyKvhnvwr4xlBnHsGTtctb1PUZgxABUGeD8MrI7UK4m5/VhQbhc
         L3SMk2p7UoK9ZBhwbLHkQBvhsTBE76I2dB/wfAzCFBTVjsa+X46bJYtQeG6xXUCic5/Q
         eI9pFyCuAQfy9lXHH6bJFqF+iM1XZWGm5y0VG1FpnCYUZnsme78sHZjX6OtrRwhLqup2
         dXor40A+Ulz5sDXABSSoZOtPscN25wq6DmbcgIZGC5BwcZnij3hkP5g72R1stsKtGP9Q
         vqsoGLwJ0Y/njU+c3r/p+7ncpzITAKvjK1UTPFXdmvbDmcoZktP/ollFdpCpBQPE5NLc
         CTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Q3vQIJLwTcewifUnOJAznYKUm7eyOAsduHlIsTgN1GE=;
        b=uDephlde4kRBW2ByPmAxh7QfZNELwLImjck0gV5rVRKpwbtjXAYlsneDE4TMATMUFs
         WPWUts9A7IwvHjP07Gzjc1TUdjIBSJQzf2puSURJBC/bjDQHm0MlkovS3tsFxoKKCjoF
         IbEZyRZGHk3BgUr7AwUT3Hrk25c2DvaO0/SL/QFP1v9LVlKA3kNHpSf94GZxKEt5V9LK
         tfRJED7swQafi+NeybnWPX5p8XjL1FA2bR0JEu12O/S++ZUhHjcNu/gSL3GUREGWAorR
         mAGcuMMEOHyc9AYWWzbenxv7QgLukWL/5nxwrxprVPhBZChT9viGGPCFDt/njnqxxftn
         SNvg==
X-Gm-Message-State: AOUpUlGYQ/EZzbFD4/pwI4Yt69xdlcWEnkjUbzjZ+bS6HysIUk43Clfv
        5cQc0BBaNXIe3xDnj821aTY=
X-Google-Smtp-Source: AA+uWPwiHO/QioxNwgrirBtB5oebIl2cMg6/JHPUwBWRq3XDjcM9gNOM97i9U3zn1gcLN8C1DXO3wA==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr1790538wmf.141.1533652588015;
        Tue, 07 Aug 2018 07:36:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 8-v6sm3585740wmw.34.2018.08.07.07.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 07:36:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
        <86effapi1t.fsf@gmail.com>
Date:   Tue, 07 Aug 2018 07:36:26 -0700
In-Reply-To: <86effapi1t.fsf@gmail.com> (Jakub Narebski's message of "Tue, 07
        Aug 2018 12:50:06 +0200")
Message-ID: <xmqqk1p2mefp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * ds/commit-graph-with-grafts (2018-07-19) 8 commits
>>   (merged to 'next' on 2018-08-02 at 0ee624e329)
>> ...
>>  Will merge to 'master'.
>
> Derrick wrote that he will be sending v2 of this patch series in a few
> weeks, among others to make it use commit-graph feature if replace
> objects are present but not used (as some git hosting services do, see
> core.useReplaceRefs below).

Ah, thanks for stopping me (albeit a bit too late-ish, but reverting
that merge is easy enough).  Do you have a handy reference to stop
me from making the same mistake on this topic later?

>
> Also, the test for interaction of commit-graph with the grafts file
> feature does not actually test grafts, but replace objects.
>
>> * jk/core-use-replace-refs (2018-07-18) 3 commits
>>   (merged to 'next' on 2018-08-02 at 90fb6b1056)
>>  + add core.usereplacerefs config option
>>  + check_replace_refs: rename to read_replace_refs
>>  + check_replace_refs: fix outdated comment
>>
>>  A new configuration variable core.usereplacerefs has been added,
>>  primarily to help server installations that want to ignore the
>>  replace mechanism altogether.
>>
>>  Will merge to 'master'.
>
> Nice to have features used in the wild merged into core git.

Yes, indeed.
