Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C8B1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 00:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbeLRACc (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 19:02:32 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40638 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeLRACb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 19:02:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so6886648pgp.7
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 16:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PD0rRdN+cAOZhCJql/DibklMBkA5LB+33DPEHvfA6Wo=;
        b=US8m2laFTGrD4DgTjRJPfskp3KaPBwcQjaVxFWP+XiU3Z1NBZfZUhfG4Ke6GQ1/VX8
         sN3MYd1sk/AUZN0xM04sL4V5rvGQQaWGiDfW/eqvghkqHBH9lL1wXYHTs+hzjyP2/3OS
         ePA3ifwmVVTebbddkNMlJy2bxU73DNXnSawqAbVCgn5UO6Ow1nCD9uySj2icu5cCVNrU
         yyErUbL1ZDRfye/Zy6Svf6l71RW9OghW0DDJpp0wANDrApqPWEqc86dA1BYCPWF2Gu6j
         vj5nkRQWPLZkBfmQ1QQRNQWmnuEQEU9zWMJ03vgEuRWOmjLZhdrzXNbASBkbY9CBF3Jb
         lxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PD0rRdN+cAOZhCJql/DibklMBkA5LB+33DPEHvfA6Wo=;
        b=rrjO8MeDRUL5a/DjxKe+hyPSwVnCzHzD250XYyJaXBJMhWGnAwoNz1VFqXXK0stWIP
         /jAhedAasFXCSzI/jsvFuW3g7kooJMygoFMtJzpHS/uVTuSj3RpoSRo4rAZq9/uFvRw8
         m4VIwqI3O8WO9fpSV/kgzY4SXASBQdczN3+zvPyxJ2smo9HSc5WIQtNI5a0SquspGqge
         o6tSULRcT3TY1fGRLdYyak1xuTDrqL+pOdMDq6cL+nG7FvKOwGaVa1R5eTNw71JuN21T
         jQHJr+wSVLH53uzT8tds7k2tVpU8H61q4fWcKyK1b8loPfsY7MOOMJO04lCM3IQgwoAC
         udNw==
X-Gm-Message-State: AA+aEWaj8BiV5gyzRf8PwvAyNtsq1/r1BmOkS7ySsF5vCE2f0f1/UaHc
        IZEpypw020wMRlErkyKM6XA=
X-Google-Smtp-Source: AFSGD/W19fo/cUX/pVymRKaA11yQblf4Sd9o34T39bRz2UBAwNEpjeqHXPqXrG8Pd0XLpaDPNgyWYg==
X-Received: by 2002:a62:1f53:: with SMTP id f80mr14615173pff.92.1545091349648;
        Mon, 17 Dec 2018 16:02:29 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id h8sm14470414pgv.27.2018.12.17.16.02.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 16:02:28 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:02:27 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181218000227.GB13835@google.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
 <20181214101232.GC13465@sigill.intra.peff.net>
 <87o99o1iot.fsf@evledraar.gmail.com>
 <20181217195713.GA10673@sigill.intra.peff.net>
 <20181217231452.GA13835@google.com>
 <874lbb209x.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lbb209x.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Mon, Dec 17 2018, Jonathan Nieder wrote:

>> This would make per-branch ACLs (as implemented both by Gerrit and
>> gitolite) an essentially useless feature, so please no.
>
> Doesn't Gerrit always use JGit?
>
> The discussion upthread is about what we should do about git.git's
> version of this feature since we document it doesn't do its job from a
> security / ACL standpoint, but that doesn't preclude other server
> implementations from having a working version of this.
>
> But if gitolite is relying on this to hide refs, and if our security
> docs are to be believed, then it's just providing security through
> obscurity.

Yes, Gerrit uses JGit.  JGit shares configuration with Git, so if we
make that configuration in Git warn "This is just a placebo", then
people will naturally assume that it's just a placebo in JGit, too.

More importantly, if Git upstream stops caring about this use case,
then the protocol and other features can evolve in directions that
make it even harder to support.  I am willing to take on some of the
burden of keeping it working, even when I do not run any servers that
use plain Git (I do interact with many).

> Like you I'm curious about a POC. The patch I submitted in
> <20181217221625.1523-1-avarab@gmail.com> takes the "SECURITY" docs at
> face value.

One of the difficulties that security engineers have to deal with is
living without absolutes.  In other words, their experience is
constant risk/benefit tradeoffs: if you want 0% risk, then don't use a
computer. ;-)

If someone has thoughts on what would lead people to be comfortable
with removing the SECURITY notice, then I'm happy to listen.  As
already mentioned, I am strongly against abandoning this use case.

Jonathan
