Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A15801FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 23:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753594AbdLHXbE (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 18:31:04 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:38212 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753341AbdLHXbD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 18:31:03 -0500
Received: by mail-wr0-f178.google.com with SMTP id o2so12199872wro.5
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 15:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xBpgkZY19w5u3XuJNq8XXZdLDomKgvzeRg7NOiOkcS4=;
        b=MgLXzJjNDfEyH+J4HFK2bCfEHF++O24XKOC/oiMa8YKBtZTeMrz6+LJhnKkYg6MBDJ
         zjk8sFK5sjU3NLzr6kY3Pt5ThIzyG7qjFcVozwDLazqJ+B1Zj2oBVTpJV6/ASpaUhDOD
         ro5nvokaTt8XkqkXFDtGLF3x7GKaCmwpsBrBBY9ce9FDMfebv5SAwU9MePFhAtFw6XS3
         dOgtn3kw/ChVvmujUtBMswObjC5c/M3esY2R+iuDSuNDu/ewuBuVaeRCSBPMhF4EQkJo
         5YCBLjKK732z65TPFG5ibJYdcsdVajJx4J7+uCdXEEgNLlzjzA4EBVp/rqqyHZnUNzo5
         JfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xBpgkZY19w5u3XuJNq8XXZdLDomKgvzeRg7NOiOkcS4=;
        b=ovoO23Ia2aPt5HtqYGau1yIO/fh2/ywSrS11DYRc0om2HWnkuO1IXz4YSFGrThTPOC
         ytU091zikIImGWPc9fRv4awHUG5QJ/OXr8uzFqW7ZJx+JQUwLM5pIdkbUjFuiti3Vk8f
         CShktpM6B96gPbi9W31Mtb7YiXW7ITVLBvhqFmSDOX15OhuFCJuVx+9fjPqju4gOLSip
         pcuMgciPIdQ+NkYqnGK75PGX7424Btf9uBwU5AuJPfVyuZ/K/KihPgWeEGJDCM4XhLkc
         mP6wNWpQOE06r55fCmOTozdL8DwOI5vaucqYXgyfF3I8XRqFhr2NpVzb3LwvgX5SP/4U
         y0IQ==
X-Gm-Message-State: AJaThX6qkXG6FnnxhUH1oB6yFgin8pwusjBBtkZ79ybmIwS4pDqVENi7
        c35Vez/PcsvW0iGTMZrG7BE=
X-Google-Smtp-Source: AGs4zMbcO0i7hs7lBjQEvYLeX1DBOSYrwtkFhzp1l/d0iA9M7jBpvty6VAv5xwZV11UlUeoH0qCJZA==
X-Received: by 10.223.172.226 with SMTP id o89mr28637294wrc.197.1512775862092;
        Fri, 08 Dec 2017 15:31:02 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id p128sm2750034wmb.23.2017.12.08.15.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 15:31:00 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eNS6d-0000Rq-TB; Sat, 09 Dec 2017 00:30:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 4/5] Makefile: use the sha1collisiondetection submodule by default
References: <20171208223001.556-1-avarab@gmail.com> <20171128213214.12477-1-avarab@gmail.com> <20171208223001.556-5-avarab@gmail.com> <xmqqo9n86dde.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqo9n86dde.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 09 Dec 2017 00:30:59 +0100
Message-ID: <87bmj8er0s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 08 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Instead the Makefile will emit an error if the contents of the
>> submodule aren't checked out (line-wrapped. GNU make emits this all on
>> one line):
>>
>>     Makefile:1031: *** The sha1collisiondetection submodule is not
>>     checked out. Please make it available, either by cloning with
>>     --recurse-submodules, or by running "git submodule update
>>     --init". If you can't use it for whatever reason you can define
>>     NO_DC_SHA1_SUBMODULE=NoThanks.  Stop.
>
> Sounds OK.
>
> But I actually do not mind to (and may even prefer to) have an
> endgame opposite of what this series tries to lead us to.  We've
> tried to have this as submodule, we've seen that the arrangement
> works, and now we declare victory and get rid of the submodule.

I don't think we can say we tried without having this 4/5 (5/5 not
needed) in a couple of releases. Without this series we always smoothly
fall back to the non-submodule, and only use it if you opt in.

So all we've really tested so far is:

 * CI systems that consume git.git and provide --recurse-submodules to
   git-clone by default.

 * People on this list that have gone out of their way to test by
   manually toggling the the flag.

> That endgame allows us not force people to grab an essential part of
> the codebase as an external dependency from another place, which
> feels quite bad, especially when their primary interest is not in
> dogfooding submodule but in building a working version of Git.

As noted previously my two motivations are:

 1) That we decide what we want to do with this, ultimately I don't
    really mind which way we go.

 2) That if we go with the submodule by default, it should be understood
    that one of the main benefits is us *actually* dogfooding it and
    subsequently improving it for all git users.

> Removing one and keeping the other between the two will make the
> distribution more streamlined by removing the build-time knob we
> need to tweak, but the one that gets removed does not have to be the
> in-tree one that allows people to "git clone" from just one place.

What you're describing here is a great example of #2, and also a way of
making my point above that we really haven't tried submodules in git.git
yet, since you're just worrying about this issue now that using it would
the default.

This is a UX issue with submodules that I agree sucks and there's no
reason for why it couldn't be solved. E.g. one solution is that
submodules could have something like:

    [submodule "sha1collisiondetection"]
            path = sha1collisiondetection
            url = https://github.com/cr-marcstevens/sha1collisiondetection.git
            branch = master
            localbranch = sha1collisiondetection/master

Where the localbranch would be git.git's own copy in a branch of the the
sha1collisiondetection/ commit. Then when you update the ref
sha1collisiondetection/ points to it would also update the
sha1collisiondetection/master branch (and warn/die when you push git.git
master but not that branch).

This would solve offer a solution to this submodule UX issue, but more
importantly I think the likelyhood of such a patch (and others) actually
being written is going to go up *significantly* if the git project
itself is dogfooding the feature, with exhibit A being that you're
already annoyed by it :)
