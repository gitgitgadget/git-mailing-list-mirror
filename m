Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 573121F453
	for <e@80x24.org>; Tue, 23 Apr 2019 22:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfDWWcm (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 18:32:42 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35908 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 18:32:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id u57so14162647edm.3
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 15:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=F2K4NsxBNe9YU9Bbke5jmCj/PZBvCCFVrl04uqLeN5I=;
        b=Tc87/qYwuOeW/634di09lvhGFphDPcXq+tVorFsj2yE0b+/ny8sCxkGJLuwaiYtGGt
         dIf/dvS5kkAUld0ZMrN8V1A5Ke3ZMR4Zkg19q+tMssqiuULEuhPeo56ckSc/P1zbQKNd
         qevWw+AlRI94XHtZk2w9u3EfBCF0QlBMd+4B5KrkPuF8yu4wQL4GuO29aVBk6KIC3uYy
         SKC9DIH4U9qLCF4W2CR+RgoM775A6ZK+CLd4NIgFrpVO8ao4Yt3zsWTItb5OjPKbWY/p
         jZSi6QELf2e6FesWojG7aXOdumMu2gGq2EwV9WWACwtqAfYa5zzV4pgr8DdObtHXG086
         6bow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=F2K4NsxBNe9YU9Bbke5jmCj/PZBvCCFVrl04uqLeN5I=;
        b=nQSiBS4xQyaQdv0f59VLexNrhBqoV4w6T37RmjB/jgrZLz7oaWlviZyKgQi2uXugyf
         AL2jnOtYjgCH0Ttr75H15tvylIsF4JwTreTRjNq7OlRsL9dq/K3VIdMhtIU5sGWo1kyG
         eK05Kficl9rtJhEy7iYHb+kfHcfthIwxUSUN1dAKLLdOxWf4Hmi6SzmZa6Ctcl3bSJ5O
         bneOv8pDipixLxKv3bhakbCdn4B6lN3pBaXllKY6V0M38NyMNzyVCJWreRdvix2u5rS1
         2AYb7/I4p7ZK9iZRmklsJHXLrz1hXXkWMvn74HN6pP/TqLHdFJPFRGKzd+zIutd3hX1m
         /XcA==
X-Gm-Message-State: APjAAAXWHZc/FVmfNQ7veD+6U90ZKJVOsYmUuvVeJOTqFj0dSrQOANwJ
        /BtH+FBAoJfPwuZPeyJrriE=
X-Google-Smtp-Source: APXvYqzEcoUhUoCh+piiIL2xBzx0NpEEynKlhVR9crkfEPyXttmdWjTq1o/vpPoLlam5FWsSX23RyA==
X-Received: by 2002:a17:906:a48:: with SMTP id x8mr4463126ejf.247.1556058760245;
        Tue, 23 Apr 2019 15:32:40 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id f7sm5021429edj.10.2019.04.23.15.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 15:32:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 5/8] Documentation: add Packfile URIs design doc
References: <20190423053130.GA13162@sigill.intra.peff.net> <20190423203801.29156-1-jonathantanmy@google.com> <871s1stlf4.fsf@evledraar.gmail.com> <20190423222249.GB98980@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190423222249.GB98980@google.com>
Date:   Wed, 24 Apr 2019 00:30:46 +0200
Message-ID: <87y340s6ax.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, Jonathan Nieder wrote:

> Hi,
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> This is really orthagonal to this series, but wouldn't a better
>> resumption strategy here be to walk the pack we just downloaded, run the
>> equivalent of 'commit-graph write' on it to figure out likely "tip"
>> commits, and use those in "have" lines to negotiate with the server the
>> next time around?
>
> Do you mean this for when a pack is self-contained and contains all
> objects reachable from those "tip" commits?
>
> What would you do when a pack is not self-contained in that way?

Indeed, it had been a while since I read the first version of this. I
was assuming a "base pack" use-case, but it seems it's narrowly isolated
to just "N packs each containing one big blob", right?
