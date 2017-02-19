Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897E9201B0
	for <e@80x24.org>; Sun, 19 Feb 2017 02:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751264AbdBSCId (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 21:08:33 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35486 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbdBSCI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 21:08:26 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so7020216pfx.2
        for <git@vger.kernel.org>; Sat, 18 Feb 2017 18:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zj5jyC2GPAwDpvMpNpSTDgFdc15L5vBP61tz8td2Yxo=;
        b=LpOaUpzOFS/MHfTPGdQkUi4Wkaol9NmaUCDMinbJcl5F1q1j23rCJxO7Kt08NJvuJU
         V9bUQC4aWg1TaxYPhdcYlGWJQvmZ7a2rRd5YqbPgUT72giTfvGjEnzxD5GHxOjeLdBeQ
         D5PUEAvS9lPp9bVRwHxHXSY2LjAcI8Cn1qSCA1gPUv9zri6+cck3Y0KMLii4r76h7xXX
         2Nxt3qU1P7edcWdgTwBePEDkpZK9SS1dp3Z0XpEJbHX3lHNyfWk7hIAtmVRM2K7oYecr
         TpFOS8FwAyc3wlBpHN/oOx/JCiTj5bSl/EwRvjVWRiXR39ybdadBLrZFcW6pZcprOHYt
         jWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zj5jyC2GPAwDpvMpNpSTDgFdc15L5vBP61tz8td2Yxo=;
        b=kFtYKZh74zIg/GLZUsZoG1SF/FQzgTPq/Omg3yn81IFAfr1EJDzjAfpAcQWedMii4l
         BA6mYMbS1qCpUCQ9aQVwWgdBgJ/7gaLusGDHQuQuUhthMoH+1yHxUpeNMS/BXted71bi
         pFZV0FAJnOJjg+mDyH2twvpGFUeBJligYsICfpAYo64Ce7xd34763a7DMm93B3MhZlcT
         Uw+THiwvUM74Kj38+ONEc2+7f0qrlRWiMmSWNLWVlaz+sWvrDIK7fBxY+fx+E9JyowMf
         qND+f8Vp8jAVmCGwH/HN8RugYkycFjuTiVcftxxy6cfPopmgB0x/mKAMpnZDCZhbHOap
         cD2w==
X-Gm-Message-State: AMke39m1kau/q7DbYC/k3ai3+Pb/RuDOh+XDhDm3Vsknb3x1166Mak82PU2JKo+H44mwwg==
X-Received: by 10.98.156.76 with SMTP id f73mr778104pfe.62.1487470020207;
        Sat, 18 Feb 2017 18:07:00 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:a885:1880:3813:e02])
        by smtp.gmail.com with ESMTPSA id l3sm27432022pgn.10.2017.02.18.18.06.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 18 Feb 2017 18:06:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] fixup! bisect--helper: `bisect_next_check` & bisect_voc shell function in C
References: <a1b9143bb29a8a5979dd733ed20161e6769b2b83.1486736391.git.johannes.schindelin@gmx.de>
        <128b4de6-7b8e-27b9-414d-c6c6529cb491@web.de>
        <alpine.DEB.2.20.1702131722350.3496@virtualbox>
        <74dfcffe-274c-7045-420a-95612394d66b@web.de>
        <xmqqinodewdr.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 18 Feb 2017 18:06:58 -0800
In-Reply-To: <xmqqinodewdr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Feb 2017 11:14:24 -0800")
Message-ID: <xmqqa89jlyrh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ...
> So, let's give Pranit a concrete "here is what we want to see
> squashed in", while you guys discuss peculiarity with various
> platforms and their system headers, which admittedly is a more
> interesting tangent ;-)
>
> There are early returns with "goto finish" even before _syn
> variables are first assigned to, so they would need to be
> initialized to NULL.  The other two get their initial values
> right at the beginning, so they are OK.
>
>  builtin/bisect--helper.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

While we are waiting for the topic to be fixed, I've tentatively
applied this on top to update 'pu', so Travis should now be happy
with 'pu' on Mac, too.

