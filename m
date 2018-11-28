Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23DFD1F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 00:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeK1LLN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 06:11:13 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:46664 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbeK1LLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 06:11:13 -0500
Received: by mail-ed1-f47.google.com with SMTP id o10so20537460edt.13
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 16:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KPZC0J/0+YyICzjv79qmpxU9/OBrHdTzE50bANoSw60=;
        b=gyKMrCtnx3YbPpo3u9eILZZVGJNs/mTc5uAlRXITUeQ/aVdk7iX78c+5vsM/JZgLGB
         ZERMxcyMpafmLA1IWSv7SdLtLuraQ5lx10LimoVicxpeW5fTVIurdf/A15srFRljW+dp
         Pkr99kUQ3SkQbC2lpE8GjyY4wrWZ2T5QIN/ZCFCtpo5pqG4tzO7AR0LsbwM66tzSOutr
         4qr8xTAlw3gpN6iV4HqZOp4uOUByMrlwO2fQrQyT1VpO4C+zd5tD5PQENbDBFt3F6Heb
         tnogRcGygZiTo92ea5U03VSfSspO0o8nMIzkxXKxBgZ4IajufUBxPa0CJBmLhJHCewMp
         iI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KPZC0J/0+YyICzjv79qmpxU9/OBrHdTzE50bANoSw60=;
        b=mu+wv1NlsMsS2YwTBzfVsY4k5eT9Eh+NMgqWKglyMSctAcSAvJa5dJpfURGqqb6+Bp
         HXSkbckIEHZKccVGft10QcQ6+Pmv7MzPYDk8a1eKot21pRnWXx8m9lPpqFiGUsgLCfyq
         iasseQNKqvFdRKLZiQdaMUqyAKOkNeZxtArz+l2M8TzM/knKwLtWEk9kVhdemSwO+Tr5
         ljeL1oAe4moA2UfzChAd4adZU383VsXI3ciwuu32mY7xWoOyldLGE+wsqtcp9mlldqLH
         l4zO92kyq6ldlu7VOLRV7sbOK/YaS5b7go7aklYiSexxNWAjut1H1MCBaryqmLeo9DOm
         Ynkg==
X-Gm-Message-State: AA+aEWYbQ+//s+6psT9XbLIEnUtdn0JVg+a4PKBa+j3TAaPSK/T3+KS0
        Wu4DC2sdyHKF+uEsK8mxglE=
X-Google-Smtp-Source: AFSGD/XNNGTWwJKBN7OMmCAYNw/I9YS1YdVIqoclXZ/3AtnqCkom4Aq4NP5TPIWuLr36hUFQJf1Wpg==
X-Received: by 2002:a50:9b1d:: with SMTP id o29mr26896596edi.246.1543363895613;
        Tue, 27 Nov 2018 16:11:35 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v1-v6sm791099ejq.47.2018.11.27.16.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 16:11:34 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Subject: Re: Forcing GC to always fail
References: <CAGyf7-F6BiqSa7LOWxvHZPfO+UaohQR78rCgvN9En+1P4du2Nw@mail.gmail.com> <87efb6ytfj.fsf@evledraar.gmail.com> <CAGyf7-F-zs9Xyx623HizpOrv80y3PydReFYw-64w3T7Xfr3CNg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CAGyf7-F-zs9Xyx623HizpOrv80y3PydReFYw-64w3T7Xfr3CNg@mail.gmail.com>
Date:   Wed, 28 Nov 2018 01:11:33 +0100
Message-ID: <87d0qqysay.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 28 2018, Bryan Turner wrote:

> On Tue, Nov 27, 2018 at 3:47 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Tue, Nov 27 2018, Bryan Turner wrote:
>>
>> >
>> > Is there anything I can set, perhaps some invalid configuration
>> > option/value, that will make "git gc" (most important) and "git
>> > reflog" (ideal, but less important) fail when they're run in our
>> > repositories? Hopefully at that point customers will reach out to us
>> > for help _before_ they corrupt their repositories.
>>
>> You could fix this and so many other issues by just hanging up a "Is
>> This Good For The Company?" banner up in Atlassian offices .
>
> Not sure I understand what this means, or what your goal was in saying
> it. No one inside Atlassian is running these commands. I'm trying to
> help save administrators from themselves, which reduces real world
> end-user pain that comes from decisions made without fully
> understanding the consequences. It feels like this comment is mocking
> my earnest desire to help, and my genuine question looking for any
> insight people more familiar with the code might be able to offer.
> Perhaps I'm just missing the joke, but if it's an Office Space
> reference it feels like it's in pretty poor taste.

I (mis)read 'administrators' as being other people at Atlassian. Yeah
it's a reference to Office Space. I meaning to poke some fun at the
situation of having to defensively configure tools least co-workers run
them the wrong way, which I'm sure we've all had to do at some point. I
didn't mean any offense by it.

>>
>> But more seriously:
>>
>>     $ stahp='Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' && git -c gc.pruneExpire=$stahp gc; git -c gc.reflogExpire=$stahp reflog expire
>>     error: Invalid gc.pruneexpire: 'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc'
>>     fatal: unable to parse 'gc.pruneexpire' from command-line config
>>     error: 'Bryan.Turner.will.hunt.you.down.if.you.manually.run.gc' for 'gc.reflogexpire' is not a valid timestamp
>>     fatal: unable to parse 'gc.reflogexpire' from command-line config
>
> Thanks for that! It looks like that does block both "git gc" and "git
> reflog expire" without blocking "git pack-refs", "git repack" or "git
> prune". Fantastic! The fact that it shows the invalid value means it
> might also be possible to at least provide a useful hint that manual
> GC is not safe.
>
> I appreciate your help, Ævar.

No problem. I was going to add that you can set
e.g. pack.windowMemory='some.message' to make this go for git-repack
too, but it sounds like you don't want that.

Is there a reason for why BitBucket isn't using 'git-gc'? Some other
hosting providers use it, and if you don't run it with "expire now" or
similarly aggressive non-default values on an active repository it won't
corrupt anything.
