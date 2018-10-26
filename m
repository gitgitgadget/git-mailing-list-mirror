Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4311F453
	for <e@80x24.org>; Fri, 26 Oct 2018 01:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeJZK21 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 06:28:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36114 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbeJZK21 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 06:28:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id y16so11207573wrw.3
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 18:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iKZhiL4WhZ4Q8k6FuPdzm6Gz6vhG71PD1Lx/NQSgEIo=;
        b=jffIcdp5uKl2N7lIxWxQSUvOiJgtbEfmRz9Lkks04IYNNsWTN06yzdRW+0RBNck31Z
         aFoW03ei3sJVXoyCIWijdxxGhx2pqpOnYXNmizAS+g+OaKUToC0NW6PgENa4dIA22CVK
         i/GlZ94mplaWVsZgGe2jiXpWfDGs2zA04P+bZXY7oBTEbU5X24RjRI3gsrjtVXCk7hev
         VOO+ryCFMVyZUDg5TDXNyEgjgyPCOqJ1OiPOXMsSkRKCltb8y8clc/97t9fS175eKWHj
         qCtGYHZHg3A2KzXkwhe7tSkvA+vs3m1jv+8JvwqUmNnLEsEGqMZMA/v19mYbAxcm+dLP
         sxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iKZhiL4WhZ4Q8k6FuPdzm6Gz6vhG71PD1Lx/NQSgEIo=;
        b=DXIZa+Noto/SaIQbEdXSU4HcrzsvUqFLy9KxfsV3cXyUjcbaOCsq6A/QozbJIp+omk
         wbOYQFk0UNDI40MESRbnFg1GAfgTUAPVKz3jPBb3l8PRxVOgUrpRC371MAVa48y9sY97
         0WUqA5m5MbpVxpqM8arGjlhKP6GTQ9N9sFi/YIn0WacppYr+QUZTk1dmHMUrQ8Yyn0xg
         vjKUEy6BAh1PhYjk2cP2DF3SYTeKDYPa+tqH4BlYpCxLDz/vEqxDbvUGjFNmZt5iOH/d
         A7K6yryObjmcowztR+AqfoYMwCpux9oxRFQ6EFEmFc++myKIMWlQ7EnS4NQ0JTkhFceA
         Ff5g==
X-Gm-Message-State: AGRZ1gJQ3VpAALe0e1VMZV7Li6KTXoH99ATqc/h8Kj2EjwddAZFBDFxv
        861h+ygv3X5DvEwiVD9Qf5cUW32J2k0=
X-Google-Smtp-Source: AJdET5fLx8upBTZkmL6zta5Ub+v38iHu8C9jLu8PBJRjDJR77nzP6vnrlAuSFluMJi0Yz9AJNbXq3g==
X-Received: by 2002:adf:f111:: with SMTP id r17-v6mr4030150wro.303.1540518803912;
        Thu, 25 Oct 2018 18:53:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e196-v6sm5759498wmf.43.2018.10.25.18.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 18:53:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Daniels Umanovskis <daniels@umanovskis.se>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v5] branch: introduce --show-current display option
References: <20181025190421.15022-1-daniels@umanovskis.se>
        <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>
Date:   Fri, 26 Oct 2018 10:53:22 +0900
In-Reply-To: <CAPig+cRVdogY8VLXcftbY=n9tQ9wDo4YrnrdU6+pZ3ch6uhZGA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 25 Oct 2018 15:30:23 -0400")
Message-ID: <xmqqr2gdeanh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +       test_when_finished "
>> +               git checkout branch-one
>> +               git branch -D branch-and-tag-name
>> +       " &&
>> +       git checkout -b branch-and-tag-name &&
>> +       test_when_finished "git tag -d branch-and-tag-name" &&
>> +       git tag branch-and-tag-name &&

We've discussed about the exit status from clean-up code already,
but another thing worth noticing is that it probably is easier to
see what is going on if we use a single when-finished to clear both
branch and the tag with the same name.  Something like

	test_when_finished "
		git checkout branch-one
		git branch -D branch-and-tag-name
		git tag -d branch-and-tag-name
		:
	" &&

upfront before doing anything else.  "checkout" may break if the
test that follows when-finished accidentally removes branch-one
and that would cascade to a failure to remove branch-and-tag-name
branch (because we fail to move away from it), but because there is
no && in between, we'd clean as much as we could in such a case,
which may or may not be a good thing.  And then we hide the exit
code by having a ":" at the end.


