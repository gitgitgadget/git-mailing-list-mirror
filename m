Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D0D202A7
	for <e@80x24.org>; Sat,  1 Jul 2017 11:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbdGALpI (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Jul 2017 07:45:08 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36168 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbdGALpH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jul 2017 07:45:07 -0400
Received: by mail-wm0-f50.google.com with SMTP id 62so130470656wmw.1
        for <git@vger.kernel.org>; Sat, 01 Jul 2017 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=wsmyYOgS9rXLurgIBj/6mYOx2rWZBVKQ765dHcfkXic=;
        b=B01jn6gMJsMZ7PiEC0PkV/u7D9wT6sNxaZ38wJf6Nzk5MxnRenOqnmMUS3+FGwhBn5
         GaG6bg4xORHbIZMVfXF3cBqo0LUtxyppNNt5lW4UNUGcJIyg3Tnmjq7K0kcYFe9dws7R
         vxz4xEiJ3JttKcgQrEm6cjoHyO5ry0L+HE1IFiKL14twb9kZd31X7flitffA8ujtHrHh
         ZEGPRC6HoHa5/6BtAFR1P1b5eRUQAjdsj8wLSZt4mYJj+MVBTvPM2BUSPN3LDPhToZpz
         QYWzyfvfxd/4SBNfzEMctchBmruN+yWZF9gMwJUlyIWdFLP0uCl6QWN54Luol4OQLh0s
         3WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=wsmyYOgS9rXLurgIBj/6mYOx2rWZBVKQ765dHcfkXic=;
        b=M+WH/1DjhvWJr+FH47nui6y2teIuCI0KbI3xYHAqtlXD/dyDWzzpatHLUBYpn1myW/
         kk71Y1JVlSB0faLazKMZKSUYcm/d7QnHMEZ/IEUw765pMNnPsCgHmyu7IhGgsawGz2Vu
         V54UUt+IvdIDv2LjMHTiPEDzl4hKloWNRAVnZ6tVlQydGW021gAd7G1pvX2z3Gl+xiYO
         bFS9ggv4W4V2EUtjutFK3sQcYy82XeE4osi9CeNWNKIjth4GfLh+4WiHaRu918bnJR4E
         XxC8X1NN3VUEArVMLgT953Cj9JnIP6VnP0u/lzT9lBuwBTZrXWaMwtNp2gik37qCRMdi
         kCnQ==
X-Gm-Message-State: AKS2vOyrbdgI6T1Cvekn6N0pnmL123SG23fV31a8sA3Sn2BPgLBfSinZ
        6wUepeTHiuV8Hw==
X-Received: by 10.28.91.213 with SMTP id p204mr17551886wmb.97.1498909506369;
        Sat, 01 Jul 2017 04:45:06 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id x21sm9584311wme.24.2017.07.01.04.45.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Jul 2017 04:45:03 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dRGpb-0004Oq-M4; Sat, 01 Jul 2017 13:44:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] commit-template: distinguish status information unconditionally
References: <1498792731.2063.5.camel@gmail.com> <20170630121221.3327-1-kaarticsivaraam91196@gmail.com> <20170630121221.3327-2-kaarticsivaraam91196@gmail.com> <xmqqa84pttmh.fsf@gitster.mtv.corp.google.com> <1498874344.2245.0.camel@gmail.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <1498874344.2245.0.camel@gmail.com>
Date:   Sat, 01 Jul 2017 13:44:55 +0200
Message-ID: <87mv8oe5zc.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jul 01 2017, Kaartic Sivaraam jotted:

> On Fri, 2017-06-30 at 07:52 -0700, Junio C Hamano wrote:
>> Thanks, both looks good.Will queue.
> You're welcome :)

Just as someone reading this from the sidelines, very nice to have
someone working this part of the UI, but it would be much easier to
review if you included before/after examples of changes, e.g. (for this
hypothetical change):

    
    Before we'd say:
    
        # Please enter the commit message for your changes. Lines starting
        # with '#' will be ignored, and an empty message aborts the commit.
        #
        # Date:      <date>
        #
        # On branch master
        # Your branch is up-to-date with 'origin/master'.
    
    Now:
    
        # Please enter the commit message for your changes. Lines starting
        # with '#' will be ignored, and an empty message aborts the commit.
        #
        # Date:      <date>
        #
        # On branch master
        # Your current branch is up-to-date with 'origin/master'.
    
    And as a word-diff:
    
        [...]
        # Your {+current+} branch is up-to-date with 'origin/master'.

Or something like that, much easier to read something like that than
read the code and mentally glue together what it's going to change.
