Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78D291F404
	for <e@80x24.org>; Thu, 25 Jan 2018 15:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeAYPqM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 10:46:12 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34841 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeAYPqK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 10:46:10 -0500
Received: by mail-wm0-f43.google.com with SMTP id r78so15791925wme.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 07:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Y6lpalo6ykGQSIpLT5RwM8u0pqW5DqJQKsW9gPZAJW8=;
        b=WydfycKqHKbU+Yi9XXbyvNT3kpgIn8camx8g3iMvv1BrkusNlR6su71ykmB8ZCxPav
         pI69rY5hLCKWC5wUWZj5FPWmUoUwdI9pVozV7tLSlMzXsN8J1UY03Yt9TlJxX1WuvmSj
         yIQDA4eemZ3/mcdTM+S5kN8IMAN4S2MlHYzjVds2PEnD8viQh2DcWcOKFFel2A0vGEpf
         N4GbDWRbmc7pB4MVqVQdLT+3f19m+IvX0II8hJFFGx+hypjgwgzs2kEf+vWFKh2Pfxpv
         kVQoCwFu1g0epTwmeKX1lPdQC+CqFafH01VkB7SLu5ToIr5Z1gSq4V5pyNSAUQY/Rm4A
         wn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Y6lpalo6ykGQSIpLT5RwM8u0pqW5DqJQKsW9gPZAJW8=;
        b=HcSKCTn+mtwQL5MiG5ZvvEFaPoZhCK2StjYRjGmph10tsT4La99GevnTkw6KNddmKh
         OyJ3U+l0l2xscrq+mV+XaMm+K2kmruFaCfegLBaBAPk9rpOiFkL9toRo4GCO/aqBrbCe
         tvi0ulDCv+MQw5rSbCDC7CVPFIONJNXeZRxh33LHkh0vqJQrLoI+XbO9ZzQOpK3FC1z5
         lGVHNWt9HwAsI3w38rjFIeMBG9EwBwlm05rhhy1mODXffmHYR3fo4IgRIhc4yNjEUW3T
         8LxSV9rKh5wDn9/IPXcCpfviLVXPyBgFCRhCxE0jIgH4SINEwcTzXCmgWJf5x6wrOZM6
         8c7A==
X-Gm-Message-State: AKwxytc67VA04VV6/txsCDs697uyNK7NTIvVjRdrKQG1MZKOqceWO2gd
        O+Ie6CKRqgZtwrEbiSF7C3E=
X-Google-Smtp-Source: AH8x227MNmal/YxJ8M6FiSA6NDE62ncOSGtqYtCSSeu8lmj3Qu89X/x8TrkKWtvkraWpBb4W6+wwnA==
X-Received: by 10.80.168.227 with SMTP id k90mr30364031edc.249.1516895169478;
        Thu, 25 Jan 2018 07:46:09 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id b46sm1519293edd.73.2018.01.25.07.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jan 2018 07:46:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH 00/14] Serialized Commit Graph
References: <20180125140231.65604-1-dstolee@microsoft.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <20180125140231.65604-1-dstolee@microsoft.com>
Date:   Thu, 25 Jan 2018 16:46:07 +0100
Message-ID: <871siex7pc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 25 2018, Derrick Stolee jotted:

> * 'git log --topo-order -1000' walks all reachable commits to avoid
>   incorrect topological orders, but only needs the commit message for
>   the top 1000 commits.
>
> * 'git merge-base <A> <B>' may walk many commits to find the correct
>   boundary between the commits reachable from A and those reachable
>   from B. No commit messages are needed.
>
> * 'git branch -vv' checks ahead/behind status for all local branches
>   compared to their upstream remote branches. This is essentially as
>   hard as computing merge bases for each.

This is great, spotted / questions so far:

* git graph --blah says you need to enable the config, should say
  "unknown option --blah <help>". I.e. overzelous config guard.

* On a big repo (git show-ref -s | ~/g/git/git-graph --write
  --update-head) is as of writing this still hanging for me, but strace
  shows it's brk()-ing. Presumably just still busy, a progress bar would
  be very nice.

* Shouldn't there be a pack.useGraph option so this gets auto-updated on
  repack? I understand this series is a WIP, so that's more a "is that
  the UI" than "it needs now".
