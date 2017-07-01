Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25B5220209
	for <e@80x24.org>; Sat,  1 Jul 2017 20:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbdGAU2h (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 16:28:37 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33777 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdGAU2g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 16:28:36 -0400
Received: by mail-pg0-f67.google.com with SMTP id u62so18937576pgb.0
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bWQaI4VO74OfkFZEcBWrFf+ign7iVQFftcGkICzJPTc=;
        b=B2qmKqKpz97ToOyY3PmkAeRVsmNzDckS6xrOOd48vk8GsrB56qZxoLx9g64MfgzWhz
         hzbqFSCNaSSMI7/xgrdDySQT2ye4cfxq4epnU9sy2pIzEER2RPIq0rBi06Vl2tNHUMjG
         RA4jVDsNC3Zyp2GNnt7doWxEyVem7/vt9bFtK8SU8C/CAlGQ2tvkJNbYTxZ49A+9R6UT
         AyLOltKeKMNiorsuz2vhHKMxVBY6pExYXZLjIf1hy8hcNnkI24TqY9IbYMVB4K+kvWIw
         G6E2QOOZKHx6d3FaJ4426UWRaxChfnSlpbvlFnvbVeXNK8hhkitTrWVnl2fg3vEqkMgZ
         hLWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bWQaI4VO74OfkFZEcBWrFf+ign7iVQFftcGkICzJPTc=;
        b=FxWPoO8fugFOxJPXylxckE8QS9Q4zfdde1+2DzBFsYEQB02Ag1rIFDOk56Ys4w7ao/
         r3q0MRWqwKH0nBy6B812/4CdyXoq7NES+2BqEUFqkcNXfPg34ebzqyVYGLWIWERjWb7F
         a9e+L38vZQ7u3TVT/6jYbp6YpeDjx7xPt+i8FaI1uD3sEM3/Y5hiAADUHXhxqElugAog
         SCTG0hVMzEHxeWhEQ8QoUmsbz3Vv5MUrAaB2iRsdn/79ulM8Z7IeyMMu2MixLIymtacu
         WqayeYx4MMbslG9oFqPPhpZ3PpEZ1bVqzhKnAhoa75qoZ/i97B2nmHx6AyUfzrjicMZf
         WjUg==
X-Gm-Message-State: AIVw110gingU3E2cImkhpEiz8NPqItqQQHJAVJRVR9JdofaAvEIXiWhb
        8Sj4UrRZWcNTWw==
X-Received: by 10.84.229.7 with SMTP id b7mr2256747plk.216.1498940915498;
        Sat, 01 Jul 2017 13:28:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:fd45:ceab:278e:5d13])
        by smtp.gmail.com with ESMTPSA id x64sm26660606pfk.20.2017.07.01.13.28.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jul 2017 13:28:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Kaartic Sivaraam" <kaarticsivaraam91196@gmail.com>,
        <git@vger.kernel.org>,
        "Christian Couder" <christian.couder@gmail.com>
Subject: Re: [PATCH] hooks: add signature to the top of the commit message
References: <20170630154306.26993-1-kaarticsivaraam91196@gmail.com>
        <xmqq1sq1togq.fsf@gitster.mtv.corp.google.com>
        <1498918546.4321.1.camel@gmail.com>
        <xmqqfuegnjnt.fsf@gitster.mtv.corp.google.com>
        <54E752528FED4662912D8CC94B19513D@PhilipOakley>
Date:   Sat, 01 Jul 2017 13:28:34 -0700
In-Reply-To: <54E752528FED4662912D8CC94B19513D@PhilipOakley> (Philip Oakley's
        message of "Sat, 1 Jul 2017 19:40:52 +0100")
Message-ID: <xmqq37afoqa5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Junio C Hamano" <gitster@pobox.com>
>> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>>
>>>> By the way, the one that is still actually enabled is no longer
>>>> needed.  The commit template generated internally was corrected some
>>>> time ago not to add the "Conflicts:" section without commenting it
>>>> out.
>>>>
>>> I'll send in another patch that removes it but it seems removing it
>>> would leave sample hook without anything turned on by default. That
>>> doesn't sound fine, does it?
>>
>> Actually I was wondering if it is a good idea to remove it, as it
>> seems to have outlived its usefulness.
>
> Personally, I like the comfort of seeing the Conflicts: list, but if
> others have indicated otherwise...

Oh, I think you misread the discussion while arriving from the
sideways.  My "it" in the "remove it" refers to the sample
prepare-commit-msg hook; among the three examples in that hook, only
one of them is enabled but that one was to comment out the "Conflicts"
section in the log message editor.  These days, that section already
appears in a commented-out form without the help of that hook, so
there is nothing useful in there---hence a suggestion for removal of
the sample.

