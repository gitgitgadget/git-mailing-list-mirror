Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CDB71F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 22:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeKUIht (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 03:37:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38277 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbeKUIht (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 03:37:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so2285870plb.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 14:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9r3hZC0w99mHWVXIGNlOg6k5LoI2Rl2MAlGxlJOLr0U=;
        b=WF8V2nA8ZVLQSRBUz/106OQHdEFQ4JC6XXR+apPXe14RW8xeQFBcLTXzDYJY0kpsTH
         c4tnKPBheWRGDQVjfsbuFkvX1MJ3ohFb2cvIuuZNf68NyrsmO0PECiEIoYpfyuyd7aXp
         ery6hxWagsGm8IDUKzQlgCjedoeF6Zqo8XNMdjKC3hCP7aM/DQNwTmEEFNxlgGy0AgaK
         3c4J4JULid60AF/MVPYVt6egKxtGbmo0Qf9UvnLdSO4CTFo9o7jhRMFmb4Eluh8esYIv
         CLIvMz21biKhSDGc+BX6aUitOHUsKEYHC+p7omOgUGrt6HaFwwIIoQ8tE0O5FiC8bTGE
         QzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9r3hZC0w99mHWVXIGNlOg6k5LoI2Rl2MAlGxlJOLr0U=;
        b=fDol49GqbH1SgDYMfnDLd44yMeeOitGcNz4v6CXG51ilmcfuqOXMUYADFNnbOfAEwo
         cdj6uIm2kLk1oKjYQ8srhxPExzjtRzFsmW8PKaFbapO8Ut+XpEGztxpFy00PblUBpGij
         WU3vtjk76/hlKDMlMVIWH2dCDGZxZ+boVUMxJkEwvdd5qYYdIpwHhsE5M8oSL46dJcN2
         R0ay5S5xhxa6TMxWWBT8WP+3SORYdjsRbQqBfCOQPYTltBIwjoc2C2kmyYhxD9jH0eNd
         xHz0w0//UOY6HnFpkfjghqcPZ9tSBTTsXBkcrAMiuE4UotiGh1r44e4b37csKOP2UO91
         DIDQ==
X-Gm-Message-State: AGRZ1gKF8W0bE23FmPM4k2T4Y2xR6t/1WdRE6Bik0+6jH78ESljz2pkg
        wAJSi+jC6S8VSJxBfL9YzWk8rooo
X-Google-Smtp-Source: AJdET5fIfJpBJGQTsX9ozdbmRt6XgJDEagPfX4KwrUbc0GFMRYh0gzo3D1ClNYMq707d/Kj+qmn0nA==
X-Received: by 2002:aa7:8758:: with SMTP id g24mr3955278pfo.250.1542751589438;
        Tue, 20 Nov 2018 14:06:29 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k24sm40856376pfj.13.2018.11.20.14.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 14:06:28 -0800 (PST)
Date:   Tue, 20 Nov 2018 14:06:26 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
Message-ID: <20181120220626.GB149929@google.com>
References: <20181115005546.212538-1-sxenos@google.com>
 <87r2fm1hey.fsf@evledraar.gmail.com>
 <20181120011841.GB62243@google.com>
 <87r2fgyth8.fsf@evledraar.gmail.com>
 <CAPL8Zis6Jz3=Jb0JxuSyHczYQrrrqP3JGiov1ZuH2A_0x=dpVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPL8Zis6Jz3=Jb0JxuSyHczYQrrrqP3JGiov1ZuH2A_0x=dpVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos wrote:
> On Tue, Nov 20, 2018 at 1:43 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:

>> I think it sounds better to just make it, in the header:
>>
>>     x-evolve-pt content
>>     x-evolve-pt obsolete
>>     x-evolve-pt origin
>>
>> Where "pt = parent-type", we could of course spell that out too, but in
>> this case it's "x-evolve-pt" is the exact same number of bytes as
>> "parent-type", so nobody can object that it takes more space:)
>>
>> We'd then carry some documentation where we say everything except "x-*-"
>> is reserved, and that we'd like to know about new "*" there before it's
>> used, so it can be documented.
[...]
>                                                      that should
> probably be the subject of a separate proposal (who owns the content
> of a namespace, what is the process for adding a new namespace or a
> new attribute within a namespace, what order should the header
> attributes appear in, what problem is namespacing there to solve, when
> do we use a namespaced attribute versus a "reserved" attribute, etc.).

Agreed.  There are reasons that I prefer not to go in this direction,
but regardless, it would be the subject of a separate thread if you want
to pursue it.

>> Putting it in the commit message just sounds like a hack around not
>> having namespaced headers. If we'd like to keep this then tools would
>> need to parse both (potentially unpacking a lot of the commit message
>> object, it can be quite big in some cases...).

On the contrary: putting it in the commit message is a way to
experiment with the workflow without changing the object format at
all.

I don't think we should underestimate the value of that ability.

I don't understand what you're referring to by parsing both.  Are you
saying that if the experiment proves successful, we wouldn't be able
to migrate completely to a new format?  That sounds worrying to me ---
I want the ability to experiment and to act on what we learn from an
experiment, including when it touches on formats.

Thanks,
Jonathan
