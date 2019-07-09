Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA0A01F461
	for <e@80x24.org>; Tue,  9 Jul 2019 16:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfGIQPl (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jul 2019 12:15:41 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:17858 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIQPk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jul 2019 12:15:40 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id DCC14500E4;
        Tue,  9 Jul 2019 18:15:38 +0200 (CEST)
Authentication-Results: spamfilter03.heinlein-hosting.de (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mailbox.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1562688938; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Pq6k0nwlyoSQAI7mIJCUh9Y5WEX3i8q6raIMLUb5aI=;
        b=hpYCOM4mwvBu47Dzd4bHZamZvKNYOf/w2Z9AWdZ2rtKjuXKBc3qkKkNUpQOhdz+GOUkfq+
        6svFTmoAZ99uYUCLhBLyU7W6pXBaMZjygTmbGFY6PDYk5aPrhZU9SFF7dgPyN+q3uxZvZd
        PqIvRQ6MUaCfYiwgGwV++XR/QU9OvNjZgPyM47uh7lHuvk5AmR40epq1WZCL4yfxHnALbM
        k2cYCCaZD12D0XtR+WD5qfNJ5d1Q1gTpcZcX+bdmZG87rfNfJwmqo7u8i8/px0fyznyTr0
        q+JANyqfhm18D82zK96RpLPRZucJVEVoB6WQLRHo2FD2oHYxqHjspgcB5gHydA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mailbox.org; h=
        content-transfer-encoding:content-type:content-type:mime-version
        :subject:subject:references:in-reply-to:message-id:from:from
        :date:date:received; s=mail20150812; t=1562688927; bh=gV5wQ50Kbh
        LaM12TzNSudX/KrEp+HcPWEIfSb2l8jeA=; b=IJPtqEFxFx3U2M+wF6PDhkuO6n
        etsJLaby3cOGSIuvlgOUDkvM9zcF0eIdfgENdgc201+0URAVrJD41CzPze6+oPPj
        VDEpPGH5kT8ZxSRqKEBhWoajAIfoBp/hMXRvgKsMGCWS3G8GkD3cTep8QH/VrpEu
        4u0+gFFUrYRTMHLDzmiPdMy4K8iDJK36ufqewUq+ZtH8tzADH6B3eNZT5vA5S0Fm
        qe/ZdQFrPmGdTEgJ78n6qk0x382ktfDuuTziyMFtmAuI+MSO7IEbWjPJu2z+fwaE
        Mu3PHxqd6pbywmU+eko1imovJjEUAHkX6buIrq4LOmpBvZAvFb43SReYknsA==
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id L3kOR_lINq8l; Tue,  9 Jul 2019 18:15:27 +0200 (CEST)
Date:   Tue, 9 Jul 2019 18:15:27 +0200 (CEST)
From:   =?UTF-8?Q?Roland_J=C3=A4ger?= <eyenseo@mailbox.org>
To:     Junio C Hamano <gitster@pobox.com>, usbuser@mailbox.org
Cc:     git@vger.kernel.org
Message-ID: <1152121968.7459.1562688927235@office.mailbox.org>
In-Reply-To: <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
References: <423596682.8516.1562665372094@office.mailbox.org>
 <xmqqa7dnw9b1.fsf@gitster-ct.c.googlers.com>
Subject: Re: Unexpected or wrong ff, no-ff and ff-only behaviour
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-K9mail-Identity: !l=434&o=25&fo=1595&pl=424&po=0&qs=PREFIX&f=HTML&m=!%3AOTc0NmU3MzItYzY4ZS00NzhmLTgwN2YtZGQ5ODkzZjEzZTIx%3ASU5CT1g%3D%3AMjQ5%3AANSWERED&p=419&q=SHOW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for answering Junio. 

I get what git does. But I believe that either the documentation ist wrong/ambiguous or --no-ff and --ff-only should be able to be combined and either should be fixed - preferably the later. What I want to say to git is "I never accept a real merge; please make a merge commit, even if it is redundant/empty". And I believe that github and gitlab allow to configure something like that.

My manpage tells me the following:

--ff When the merge resolves as a fast-forward, only update the branch pointer, without creating a merge commit. This is the default behavior.
=> Allow either

--no-ff Create a merge commit even when the merge resolves as a fast-forward. This is the default behaviour when merging an annotated (and possibly signed) tag that is not stored in its natural place in refs/tags/ hierarchy.
=> Always create a commit, even when FF

--ff-only Refuse to merge and exit with a non-zero status unless the current HEAD is already up to date or the merge can be resolved as a fast-forward.
=> Fail if FF is not possible

 

man page: 
On 9 July 2019 16:51:14 CEST, Junio C Hamano <gitster@pobox.com> wrote:> usbuser@mailbox.org writes:
> 
> > I'm rather confused about --ff, --no-ff and --ff-only. They seam
> >      
> > to be all mutual exclusive...
> A clean result left by "git merge" can be either a fast-forward, or
> a real merge (i.e. 2 possible outcomes).
> 
> The --ff option lets you say "If the other history I am attempting
> to merge is a descendant of the current commit, not creating a real
> merge and instead fast-forwarding is permitted".  As this is the
> default, case you actually type --ff on the command line is rather
> limited (e.g. to countermand an earlier --no-ff on the command
> line).
> 
> The --no-ff option lets you say "I never accept a fast-forward as
> the result; please make a real merge instead, even if it is
> redundant".
> 
> The --ff-only option lets you say "I never accept a real merge as 
> the result; please fail if this does not fast-forward".
> 
> So, the only "real" options are between --[no-]ff (which allows or
> disallows one of the two possible outcomes, which is "fast-forward")
> and [--ff-only] (which allows or disallows the other one of the two
> possible outcomes, which is "real merge").
