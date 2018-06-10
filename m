Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11931F403
	for <e@80x24.org>; Sun, 10 Jun 2018 08:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeFJIg6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 04:36:58 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50633 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeFJIg4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jun 2018 04:36:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so9633451wmd.0
        for <git@vger.kernel.org>; Sun, 10 Jun 2018 01:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Dzy2VXahRUbr9ieGt10Cs0VAdJwR0d/5v+GDrW6pCVU=;
        b=cNZG2bj1XFLqsaEtnFsupOG6pCMLIQNV5mownwhZjIvmRojoBX8HzGarfGMnJJjVq0
         DnRRasyxbOD28E4l9j5oOmRtuz8y5QwP1LJQ6jQAomuq4+Opy1fXxQm6bn/tBsCcikog
         qDS3yhxIo7/W/7/nTaYXJKfnmVwjDAdIm8EyWInTy6IQNYS8uffc5OzWhYwIVCUjq7Dx
         M9nDjWgmv02pXk+ZQjQKgDroAf3ADk++ORAeSzc3PtFy955XPjrdOXAAJkG46LChzRBQ
         ixK79SytefMD+7uFBx7349d8EuLXT+mzQvF/mS+2hluHGm/MtW+XgFPs2jgaRhuBQ+2V
         GMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Dzy2VXahRUbr9ieGt10Cs0VAdJwR0d/5v+GDrW6pCVU=;
        b=tjNQOxSmXPtvD0afI7/rXgjsTJ8lqXsJCcetcJWoCte/VRY/lXL7MxKrHr3X67mYyq
         F1FGQH43a4u8nQt2vXUdTQLFP2eWXWS4OspNPnVNCTq6GWMs+XtjlgyF15FFvSQrpp6t
         JN+bnAkxqZN33+EaX9D6o/nQJVrNGrSwEup4OAI2Od0uKhTpH1bJInGG4THhs/tq2R3z
         1AnSbLu89QqX1neivoDNc4aJzWV+NgMU4UjPpH8FGL1S6IjdFyuIOsVRf8775pqT8n7e
         vNdDFn25/wBQkSHzSwV36CiJ8orjaLa4E7HYGKcBVCgLuUNAYY1mema1jmv1CgfqGyQw
         d8cg==
X-Gm-Message-State: APt69E20crniqGj+eETCGt28AzSRuRO7fB+Q46jnQyfXNqfMc/ZrwyQT
        kRHrVPtkdPHL/9cs/yLkSbM=
X-Google-Smtp-Source: ADUXVKK1Pw+Ql/n3y9rlXd8174k5exfe3hvbJ/9AVaxrhMKLXXwRutOo3fp48cSkq8Lz8nuV68uKAQ==
X-Received: by 2002:a50:c986:: with SMTP id w6-v6mr13873128edh.222.1528619815658;
        Sun, 10 Jun 2018 01:36:55 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h11-v6sm324390edh.16.2018.06.10.01.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jun 2018 01:36:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Luis Marsano <luis.marsano@gmail.com>, git@vger.kernel.org,
        Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [RFC PATCH 0/2] contrib/credential/netrc Makefile & test improvements
References: <20180607051958.759-1-tmz@pobox.com> <CAHqJXRHGq9ofPcCzffUbTmuL6fuoB=33aZnwqNdqYy+nAVA_gw@mail.gmail.com> <20180610022802.GX3094@zaya.teonanacatl.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180610022802.GX3094@zaya.teonanacatl.net>
Date:   Sun, 10 Jun 2018 10:36:53 +0200
Message-ID: <87efhfvxzu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 10 2018, Todd Zullinger wrote:

>> I added 'use autodie;' without realizing it had external dependencies.
>> According to the documentation
>> http://perldoc.perl.org/autodie.html
>> it's a pragma since perl 5.10.1
>> Removing 'use autodie;' should be fine: it's not critical.
>
> I should clarify that part of why autodie isn't in my build
> environment is that the Fedora and RHEL7+ perl packages
> split out many modules which are shipped as part of the core
> perl tarball.  So while all the platforms I care about have
> perl >= 5.10.1, the Fedora and newer RHEL systems have the
> autodie module in a separate package.
>
> That said, the INSTALL docs still suggest that we only
> require perl >= 5.8, so if autodie is easily removed, that
> would probably be a good plan.

The intent of those docs was and still is to say "5.8 and the modules it
ships with".

This was discussed when 2.17.0 was released with my changes to make us
unconditionally use Digest::MD5:
https://public-inbox.org/git/87fu50e0ht.fsf@evledraar.gmail.com/

As noted there that's not some dogmatic "RedHat altered perl so we don't
care about them", but rather that in practice this doesn't impact users
negatively, so I think it's fine.

> Ævar brought up bumping the minimum supported perl to 5.10.0
> last December, in <20171223174400.26668-1-avarab@gmail.com>
> (https://public-inbox.org/git/20171223174400.26668-1-avarab@gmail.com/).
> The general consensus seemed positive, but I don't think
> it's happened.  Even so, that was 5.10.0, not the 5.10.1
> which added autodie.

Right, this doesn't apply to autodie. Looking at
https://www.cpan.org/ports/binaries.html there were a lot of releases
that had 5.10.0, not *.1.

Also git-credential-netrc is in contrib, I don't know if that warrants
treating it differently, I don't use it myself, and don't know how much
it's "not really contrib" in practice (e.g. like the bash completion
which is installed everywhere...)>

But yeah, skimming the code it would be easy to remove the dependency.
