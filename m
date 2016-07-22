Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6E59203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbcGVRPq (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 13:15:46 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34989 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbcGVRPp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 13:15:45 -0400
Received: by mail-io0-f177.google.com with SMTP id m101so110770945ioi.2
        for <git@vger.kernel.org>; Fri, 22 Jul 2016 10:15:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iugome-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KzY4pAV656V1hkqOWdVwP/A3nfAIRZLCzggWPoDa/Zo=;
        b=Da/jTQGu/ZNNYm/433QyjyEwjLxIaYrQCE6xlTq05eBDC9IxAw7yCANnc6b1RQvz1n
         on8KB7ryvQXuo+P37M0au9rR4RIdOLLv0TPQm8XDjd8Uhfw3bGO5S93P+ih5I3H/t6Yx
         AzE9eeSRCNM9i85kdTT8s4KaumSDXyVfmD5cxDb6FjMap6Ss33D0d88NZ2gp7XXnqjce
         LzIm49ip/9DjmszErmxeQcss9lXayKkqH+Ek0r4if3dvtcw79GAeI5V2ra71IwJx+Gaj
         lMw5/OQYlBI5uAlnCnGOe1PCKfqPMVCo3rpvTpPvB3N+yOLkhX3JowqSqBlbKQfHkzUk
         aH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KzY4pAV656V1hkqOWdVwP/A3nfAIRZLCzggWPoDa/Zo=;
        b=Yv1cA09GXVflhGtunMUm21Et0/f4XJnp4BPKdhrx8U2+U7u/IQTo3CorK9F0NprU6C
         jDHhf64FELYpxiFSW3HpsrZ9QWzqUUjjtFwGV61StVioq+Ajvn7PE3AxRRitPCukM9qS
         4ZjBKgfBaLm4pZsfUUeZ0H/O8RC3gm8SOnIJ4PkRDeO1wyaOkoLw58X0unH5PIEkdhOW
         gF8zKsO6fVTYE101EAhydG0ubil3svUWRApl2dCUMnEr87ntXcsykcEpjSRmh9iyhbny
         BJlH4qvCd5VjV96buCpjBvPjOH0IxRQqnNooJJHpqkpd2/8bGG3XqJt8ISlwQReG7EgW
         FUMA==
X-Gm-Message-State: AEkoousrMItp6qSK6KTAQxRuaZuXL18dgGEEL/fJjT6f3RiGHpUjZQPJzf90w3pyBMnSO7EzbqEFi7xRaBMa/A==
X-Received: by 10.107.197.1 with SMTP id v1mr3716400iof.178.1469207744398;
 Fri, 22 Jul 2016 10:15:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.152.141 with HTTP; Fri, 22 Jul 2016 10:15:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1607220954470.14111@virtualbox>
References: <010201560af48050-012ea887-a1e1-4d1b-82d3-4799ac7788bc-000000@eu-west-1.amazonses.com>
 <20160721052625.GA31423@gmail.com> <alpine.DEB.2.20.1607211724430.14111@virtualbox>
 <CAMaPC4JTerX7TSg5_M=DOztyaGUVd5_kK8cmTJuWrCekGgSodw@mail.gmail.com> <alpine.DEB.2.20.1607220954470.14111@virtualbox>
From:	Brett Cundal <brett.cundal@iugome.com>
Date:	Fri, 22 Jul 2016 10:15:43 -0700
Message-ID: <CAMaPC4+rjr3bSkKcUFipDwW6es4y9Rgq7Z-3SPz0A7qLMw77Pw@mail.gmail.com>
Subject: Re: [PATCH] git-subtree.sh: Use --allow-unrelated-histories when
 splitting with --rejoin
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Roberto Tyley <roberto.tyley@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 22 July 2016 at 01:11, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> I know it feels good to get frustration off of your chest by ranting. I am
> very sympathetic to that. Please note, however, that it puts the people
> who are ready to help you immediately into a defensive corner. Probably
> unintentional?

Shortest rant ever. :) Sorry if I caused any offense. It just seemed very odd to
block multi-part MIME that happened to contain a text/html part in addition to
text/plain, given that (AFAIK) the vast majority of email clients in
recent years
produce such a thing. Anyhow, off-topic... your list policy is your business.

> Back to the patch you wanted to submit: since this is an important bug
> fix, I spent the time to clean it up. The only missing bit that requires
> further effort from your side is that we need your Sign-off. See
> https://github.com/git/git/blob/v2.9.2/Documentation/SubmittingPatches#L239-L291
> for an explanation. Essentially, you are stating explicitly that you are
> not legally prohibited from contributing this patch. If you can say that,
> simply reply with a
>
>         Signed-off-by: Brett Cundal <brett.cundal@iugome.com>
>
> We can take it from there by inserting it into the following patch:

So, again I'll have to apologise... I should have submitted this as a bug
report rather than a patch, since the ownership is not legally clear. Didn't
even occur to me for such a trivial fix. If you can just treat this as
a bug report
at this point and 'reimplement' it, that would probably be the
simplest thing for
everyone... I guess this may be tricky since there are limited ways to possibly
implement this, but for the same reason it would be impossible IMO for me or
anyone else to legally claim authorship of it (but IANAL). If this is
going to cause
this fix to be jammed in limbo for all eternity, then let me know and
I'll see what
I can do to get the proper authorization.

-- Brett
