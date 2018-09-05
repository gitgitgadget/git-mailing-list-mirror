Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13F01F404
	for <e@80x24.org>; Wed,  5 Sep 2018 16:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeIEVQE (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 17:16:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51403 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEVQE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 17:16:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so8682133wma.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=vDPVg/2Hp2FxbUY7TLHNcSCWkRXl4eVhS2GNe/L5Vdk=;
        b=IT6IuJVBUrGE7Q2QdPhru7heFS9juEun+Asrl4McVmDmnHZDkJw255H5yawJ1YbOhr
         Z3g4dBvw4g622j0bHoNEEyXCMZXfZBZMxSm1KUq/pWYcGYweaor2nMnkgtDmguIYP/2r
         iXdy7AGRYzBX2pLtlYjYS7TkOjzDIEuOymMe888csbvGrKbbTtXkmm7u9XJfWjB2OeK/
         RNM081HeJmEe/zQxf5QzOyjlGxIe7TQApjPQmJjXx6dDcAnHlDAcspW8tO26xn9E52wa
         kX3WhXW3EFpJ1lkg/lWoa8OvOBnBqCnxEBStq7u6S2Bu+DGCIN0yAXKZWVdbYkZxOLE3
         4zHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=vDPVg/2Hp2FxbUY7TLHNcSCWkRXl4eVhS2GNe/L5Vdk=;
        b=YkhlKUTT2szVnzfRLL6N/WNSSbYzNqxItu19HXWQWBC2kHL3RewX/BdZxOsbrhkOuW
         HgSAzaRgdmlR3UhYPCX4ytnp72CnpzaGZOVoXqpphOwl2QAf0EGHxhThVexv1dBZKOdT
         8zW1Y8JhA8dkAisEGT93qnus4adwGmFS4Y4tOEQKyp18aiTkeFCzeqaY55ERedNRkQnz
         hUZBgqku0IMQntWdr5QEzd7aHAIPyXvdmqixRWI38ScogHs0JONYoqoIB2IO5LpapxDK
         U6rDfJGYIVm8es9tN5/W0TGexwfGRxuBKsmbeyTe1FgX53tQ6cBr8drZOppd/8bMagDF
         IV7A==
X-Gm-Message-State: APzg51DysiWw9nvq5i3HC7++bmyhbm/0JCfLk9a9H5GbykYj6+WTMFO5
        sS6yUp6l/1MW3rGxNWISlE4=
X-Google-Smtp-Source: ANB0Vda7yggPYiX+1AM8ZbyX3qUMKGAFnCWpWQ6KqOFWcVSmrUDgdFpiIxZFeyU0G8Mkzlf7/6I8Ig==
X-Received: by 2002:a1c:5411:: with SMTP id i17-v6mr781547wmb.53.1536165902691;
        Wed, 05 Sep 2018 09:45:02 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c19-v6sm2552342wre.86.2018.09.05.09.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 09:45:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Brandon Casey <drafnel@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <20180824152016.20286-5-avarab@gmail.com>
        <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
        <87bm9cs5y6.fsf@evledraar.gmail.com>
        <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com>
Date:   Wed, 05 Sep 2018 09:45:01 -0700
In-Reply-To: <CAPig+cRrwW662Hzp8V1sH51x8qYxPyqG=VHpOkfd-=RwUSSZbw@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 5 Sep 2018 04:59:27 -0400")
Message-ID: <xmqqzhwv51wy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Sep 5, 2018 at 4:29 AM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
>> I recently gained access to a Solaris 10 SPARC (5.10) box and discovered
>> that the chainlint.sed implementation in 2.19.0 has more sed portability
>> issues.
>>
>> First, whoever implemented the /bin/sed on Solaris apparently read the
>> POSIX requirements for a max length label of 8 to mean that 8 characters
>> should include the colon, so a bunch of things fail because of that, but
>> are fixed with a shorter 7 character label.
>
> I'm pretty sure that Solaris 'sed' predates POSIX by a good bit, but
> that's neither here nor there.

I thought that we long time ago declared that it is a lost cause to
use Solaris with only tools in /bin and /usr/bin and instead depend
on /usr/xpg[46]/bin; did something happen recently to make us
reconsider the position?  If not, let's not waste time worrying
about /bin/sed over there.
