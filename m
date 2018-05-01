Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A13B21847
	for <e@80x24.org>; Tue,  1 May 2018 23:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeEAX2N (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 19:28:13 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:36884 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeEAX2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 19:28:12 -0400
Received: by mail-wr0-f179.google.com with SMTP id c14-v6so12085989wrd.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 16:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=wLxuohWEkpFBg5/0tngMKS4rc3zps1rzh8YjU+YkB1Y=;
        b=o4psnDrJmkjduOyFzlRCMVRAoUCD52W+Y0ODZRRSKql6Qg+2dalicqDDxPGGBsn66q
         1VJSUX+cMyioDbuEX+3sxe61DquO+BmOhaqZER/pEpITiTf/KwTyCvRFfgvo78EH25Z9
         xZmX4yfwLCGk2aAw6MTP6s5haJyqVbSneUuAgXCYRJHlIKlyqYWATwDJweUmrwZVXyDu
         bC+zg92jvX63oIk5Anm9rNMo76Mf8OHUIjzz4PyrHInyB9i4Fb0zQPuM1Y+qXC14dk8v
         ETw/ElgyG0Ld1kQWgr0Oj6Vvw0udYW1TWHjzpYk9z1cxFKFuHzcsFvUFM1iV1J5vw7L8
         tIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=wLxuohWEkpFBg5/0tngMKS4rc3zps1rzh8YjU+YkB1Y=;
        b=SQscQpWcLSbhFpVxZTJjrhIjIEKAWFq0J6Ayio+QDaROIKAm1JoEpdqGuvwCyPFiPj
         HnGQghT978ZQKBf74JF6KzqDVR/0R+vM3YSuqxoeq8wyFl0IRlNQO1c6SlTZvQWiaeFG
         Bx1lcgG9ROLtNtLbJ7fKPOZAH0L9eBOyjHhgFJa71jwTMgIcXFAkJKu1z9qDngUcvJV6
         +nN9wDQXEMnA1fHjNnFWvbp5HR0gK+MstwwomyhyHrJeujC4gYJP1GeeIee9MieYWD7n
         PZ4IBlt6cRTrE7wrAXqk1MahP/SNLlj+azq0oZ6McZSaSWLcRH5ulrkk55+qy3Mse86D
         B2JQ==
X-Gm-Message-State: ALQs6tBa7hC0wrdq3ngq03tK85l6Rn9Mh96WQdkYdcYQRWuv4sunyrMx
        xk25jniPQLcBIZTANXAz+rQ=
X-Google-Smtp-Source: AB8JxZr4SNNgFYkyYVZBcY+LLZsNTjIVxF2yObqunpjJyV/dDjU+Xc5KR3IqYvHQo8ifdKe9fR6DnA==
X-Received: by 2002:adf:b004:: with SMTP id f4-v6mr13584124wra.75.1525217291096;
        Tue, 01 May 2018 16:28:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z11-v6sm10455052wre.15.2018.05.01.16.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 16:28:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Wink Saville <wink@saville.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH v4 0/3] Optional sub hierarchy for remote tags
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com>
        <20180501165931.25515-1-wink@saville.com>
        <87zi1jxjqn.fsf@evledraar.gmail.com>
Date:   Wed, 02 May 2018 08:28:10 +0900
In-Reply-To: <87zi1jxjqn.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 01 May 2018 21:24:00 +0200")
Message-ID: <xmqqd0yfx8fp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> As a workaround for that maybe we'll need something like:
>
>   [remote "gbenchmark"]
>     url = git@github.com:google/benchmark
>     fetch = +refs/heads/*:refs/remotes/gbenchmark/*
>     fetch = +refs/tags/*:refs/remote-tags/gbenchmark/*
> 	tagStyle = remote
>     tagopt = --no-tags

Good thinking.  In the longer term we would probably want to
deprecate tagopt that was invented in a very lazy way (it was
originally meant to hold any random string that we can insert on the
shell command that invokes "git fetch", which obviously is not a
good idea in the production code) and replace it with something more
"controlled", and the above looks like a good improvement to Wink's
proposed change.

> Or whatever, i.e. something where only the new version will fetch the
> tags and ignore the tagopt option (which I never liked anyway). It's a
> hack, but at least you don't end up with crap it your ref namespace by
> flip-flopping between versions.
