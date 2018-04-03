Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49F2F1F424
	for <e@80x24.org>; Tue,  3 Apr 2018 10:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754927AbeDCKSj (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 06:18:39 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34523 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754813AbeDCKSi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 06:18:38 -0400
Received: by mail-wm0-f41.google.com with SMTP id w2so10873966wmw.1
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 03:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=MkQ4gH+hc36J1Far8SYhIkpVjVhWVq2QDsSRAGnHR1o=;
        b=KiPbVgVQWpES573vaqwqHLBD21YyPVPZS+6VrGEiwi1KGat4yAJo0Iw6aND/f3OTry
         BnZkgLcjPgVdRL9M3LRgXYxEY4K79eyjQKmfvkfStgkkbO3vYYWOmedi/IKqcHPj9bia
         ODSPsIXbEvL/94V/5YFtIldC/fYvtGLN8yWUmxG1U2Lv2IJEdXl0zveBU5BUggsrAyij
         JmagsW5Jv64zeOERyLG4hK4ku26GfV4kOQda1c2LdkOvlXykWQwrX3wiSTqNyw8kR7Ir
         KwzrFo7aEHcOLoDchbVzb5T8gsYbvBx500rcIGspK7CUfK2/GpCFQx1rWOkoadAAEmb4
         nUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=MkQ4gH+hc36J1Far8SYhIkpVjVhWVq2QDsSRAGnHR1o=;
        b=ajlILmgDf6pwMIdWqnbkDVwXG1tlhKJgxejcq70uRiBT7azY/a/MgAHrE3QlbDft4H
         Pa9XfKEaaIkgxvagsh7sbBUAMGGfhobagcg3MedQDDZwePBs/LTpSK8qUm+RZINX/t0G
         yI0hXk5Yhi8H2TPriYz7JDgXiZwhHJ4aqrpWZT66DlbTVnYeTAUqBqUsIy1e/6QYT9Nu
         kwtFtuVRU8ZsZ1/vVmoYk152z8+nyspIoMLFkc7Cb+W+YfQT85hCoUxPq7O38PLBgm+C
         gAct5pbtyJTOP/0aKDCqsvMQjE26tqY4278tAW67sVOgZJHerNP6z7M/PFu7jJDQtGx0
         /y/g==
X-Gm-Message-State: AElRT7EMXUqwb4VqkcYvDqTLtnk1gexhGeWI0SCWp4zolX8ZLjbrpuZz
        cfsrInYb/6kMu+DGwUMg8ao=
X-Google-Smtp-Source: AIpwx48yBV/kQfa8Y38rOMNktc8QxSV/mF/tlNVxTDhxsRKbETgQpr48+Mty4LngBQizJ5J5BJnvAg==
X-Received: by 10.80.189.197 with SMTP id z5mr16068710edh.198.1522750716942;
        Tue, 03 Apr 2018 03:18:36 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id i48sm1537617ede.39.2018.04.03.03.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 03:18:35 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] core.aheadbehind: add new config setting
References: <20171221190909.62995-1-git@jeffhostetler.com>
        <20171221190909.62995-2-git@jeffhostetler.com>
        <20171221204356.GA58971@aiede.mtv.corp.google.com>
        <xmqq3742tyho.fsf@gitster.mtv.corp.google.com>
        <20171224143318.GC23648@sigill.intra.peff.net>
        <xmqq1sjgoyph.fsf@gitster.mtv.corp.google.com>
        <20180104192604.GA27528@sigill.intra.peff.net>
        <091D90DC-DAA2-4338-AAFA-01CB75807992@gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <091D90DC-DAA2-4338-AAFA-01CB75807992@gmail.com>
Date:   Tue, 03 Apr 2018 12:18:34 +0200
Message-ID: <87vad8vbid.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 03 2018, Lars Schneider wrote:

>> On 04 Jan 2018, at 20:26, Jeff King <peff@peff.net> wrote:
>>
>> On Wed, Dec 27, 2017 at 09:41:30AM -0800, Junio C Hamano wrote:
>>
>>> Jeff King <peff@peff.net> writes:
>>>
>>>> I, too, had a funny feeling about calling this "core". But I didn't have
>>>> a better name, as I'm not sure what other place we have for config
>>>> options that cross many command boundaries. "diff" and "status" don't
>>>> seem quite right to me. While you can argue they are subsystems, it
>>>> seems too easy for users to confuse them with the commands of the same
>>>> names.
>>>>
>>>> Maybe there should be a "ui.*" config hierarchy for these kinds of
>>>> cross-command interface options?
>>>
>>> I had an impression that ui.* was primarily pretty-printing,
>>> colouring and things of such nature.
>>
>> I didn't think we had a "ui.*" so far. We have "color.ui" and
>> "column.ui", but I think that's it.
>>
>> At any rate, my intent was to consider this a "ui" issue, in that we are
>> deciding how the ahead/behind hints should be shown to the user.
>>
>>> I do not think it is such a
>>> bad idea to honor a status.frotz variable that affects how (e.g. to
>>> what degree of detailedness) status on frotz are reported in Git
>>> subcommands other than 'git status' if they report the same sort of
>>> information on 'frotz' that 'git status' makes.
>>
>> Is ahead/behind uniquely attached to git-status? IOW, could this be called
>> "branch.aheadbehind" and git-status respects it? It seems like putting
>> it in status introduces a weird asymmetry.
>>
>> I buy the argument more that "status" here is not "this is a git-status
>> config option", but "this config section encompasses various things
>> about the status of a repository reported by many commands". But then
>> it's kind of funny to have many of the existing options there that
>> really are specific to git-status.
>>
>> In can be both of those things, of course, but then it becomes less
>> clear to the user which config options affect which command.
>>
>> I dunno. It is probably not _that_ big a deal, and I can live with it
>> wherever. But Git has a reputation for having inconsistencies and weird
>> asymmetries in its UI, so I like to give some thought to squashing them
>> preemptively.
>
> What is the state of this series? I can't find it in git/git nor in
> git-for-windows/git. I think Stolee mentioned the config in
> his Git Merge talk [1] and I was about to test it/roll it out :-)

It's in the gvfs branch of git@github.com:Microsoft/git.git, i.e. it's
not in Git for Windows, but used in Microsoft's own in-house version
used for Windows.git.

I may be misunderstanding this feature, but my impression was that it
was a kludge as a workaround until the commit graph code landed, because
once we have that then surely we can just cheaply report the actual (or
approximate?) number in the common case, but of course it may still be
slow if your commit graph file is out of date.
