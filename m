Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BF311FF30
	for <e@80x24.org>; Mon, 22 May 2017 02:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932715AbdEVCqD (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 22:46:03 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34715 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932173AbdEVCqC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 22:46:02 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so16610377pfk.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 19:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Th6navNeGxxH7WFe3eRCYGuZ41xwx2Cpl1E/ZGeClF4=;
        b=EPAhDw01Dij4ITB0fmpg9Vr5QSNm/1wfc2tGLXK9pEAqXByJf3iGxSYTVroLj4Lg+f
         I834Z82Z9PzIsxQzejT2eeiPUwbloRNlexuJaN+ReWUyPaTyITm6VCqxj+7EalOpitYS
         AlpTPC3U1BfkJh/IuQEytZCDtaMsNBtPAwk4c4HHGp7G2PFI8nDVsnPfNQPfRzaN55Vg
         JKEIdXDtpBIWsroqa71HlTnhOEiyHfPmpNYGu+wK8v8S1e4rqRn+kr0NdpZ/BX6Exv81
         vvZLT3p3vqK58O1UoqVa1MLLdyBbc27Uu24yvutLvop7X2xRbdTITJc4aziLKIRRErF4
         Mthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Th6navNeGxxH7WFe3eRCYGuZ41xwx2Cpl1E/ZGeClF4=;
        b=sTlAHkwm2D7+07NhUPQRBDwdS/5u3TbiARk0R/e+9CzlKfEbgygWgzvyUZ4DGhOzik
         oQkSMXB8/iNX2LIByIxe1meAlobTmBbo0YrU5dEtWPkAEJS70Q2M0ni8QwjfwETh+9pO
         Ask7caaUWwKmgYM6dPjLkNWwSxHwDDXZAFeD0MNhjs4d+jEKnJnqAQS/vXymX587Cmpn
         0y5bzcQQxt/+ylk9DnAqGVeT/KADKXuhbJHhzN8zC3kDzPXT3x1fvSv4CYP5n01q/QUq
         cU3dDKxmYTYa74O4y6X5uav3x9rx6+nE2imAH2RlyueGEb8qg8VWKjs5FKr7stNskTdI
         7tAA==
X-Gm-Message-State: AODbwcDbHZXyjYts86FsS/doey+Favvk9lLQPxoYqWslVhlO8+Em1Xsm
        7CawjyUV9AWuIg==
X-Received: by 10.98.10.204 with SMTP id 73mr21430453pfk.191.1495421162035;
        Sun, 21 May 2017 19:46:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id u9sm26145292pgn.55.2017.05.21.19.46.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 19:46:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
        <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
        <11cae8d7-46a6-9ab5-5bee-a7e6897c0a88@ramsayjones.plus.com>
        <xmqqh90dpqja.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 22 May 2017 11:46:00 +0900
In-Reply-To: <xmqqh90dpqja.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 22 May 2017 11:35:21 +0900")
Message-ID: <xmqqd1b1pq1j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> So, I don't know. Wait let me try your specific version:
>>
>> $ ~/sparse/sparse --version
>> v0.5.0-207-g14964df
>> $ ~/sparse/sparse usage.c
>> usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type (originally declared at git-compat-util.h:1074) - different modifiers
>> $ 
>>
>> Er, dunno. (This is on Linux Mint 18.1).
>
> Oh, I don't question your expertise or competence.  There must be
> something I am doing wrong, and the version of sparse I happened to
> have run was the easiest thing to point a finger at, but that does
> not seem to be it.
>
> Thanks for helping.  I'll find time to dig deeper to find what's
> breaking it for me.

Hmph.  I do not know what went wrong.  The one I had in /usr/bin
that came from the distro was too old that it didn't give any useful
result and failed, and that was why I got v0.5.0-207-g14964df
installed in ~/gitstuff/bin/ which is early on my $PATH; I do not
think I did any other updates but now I am seeing happy results.

        $ git checkout jk/bug-to-abort^1
        $ make SP_OBJ=usage.sp sparse
        GIT_VERSION = 2.13.0.3.g25cd291963
            SP usage.c
        usage.c:220:6: error: symbol 'BUG_fl' redeclared with diff...

And then with your fix, of course,

        $ git checkout jk/bug-to-abort
        $ make SP_OBJ=usage.sp sparse
        GIT_VERSION = 2.13.0.4.g3d7dd2d3b6
            SP usage.c

I am still puzzled but anyway now the problem is clearly on my end
and no longer reproduces, there is no reason to waste your time.

Sorry for the noise, and thanks for a fix again.
