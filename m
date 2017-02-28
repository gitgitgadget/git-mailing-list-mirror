Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054931F5FB
	for <e@80x24.org>; Tue, 28 Feb 2017 05:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdB1Fhc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 00:37:32 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33143 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdB1Fh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 00:37:29 -0500
Received: by mail-lf0-f66.google.com with SMTP id r36so151359lfi.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 21:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GliX6Ti3u0GulLJi6iGAh4W+iEGVG3yEOX1vUFn0nRY=;
        b=dE+a885yNHk9rbiIMD/y7PW8wXmhdcBTPCQKuvC0t7RHiI1Fp7fgG6F+nuESZtutRR
         ss+FWzVu93Y0v5AH8jw01ShCSSrHTjNHwZOSDWiEpDjVe9AySuLW3nE/phYRGTgim2er
         UAkg85E2R3GOLoMLJynm8SXrqCCb1dNEbDzGF/6UGRrjFkvwRGrQ9JU26GPklT29eIM+
         s3EYFJPiqFeGMsTBkXCXWAnrTmQeKXlAqAQMf2tTHtAvgDxsAeqUjwI+uelDlbKv540d
         5AJZtWlexIszU4csBZGgW/BKSNqZOK1uokDHHIMPzJ1NGRPTIP+zJtgoW88Wy/9iDvTR
         K1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GliX6Ti3u0GulLJi6iGAh4W+iEGVG3yEOX1vUFn0nRY=;
        b=W3QuPvM/9WX9uxvu5uMQd55CCze863eCl7SQDAYzDu2rXxH1vCBdMm1zKLKFLkTR2x
         8yJvFfmWpGGcHEsSVk73Tod4o68SXGKo5OmdUoXX8NzsHPkFhYBDVyOE7jY7xDQoX8oj
         Bu2BweLdL4cgQU+itL9vTU+kPCRoxHwXjMOghrExjIkWHGPH4hpwE4BB177dZbJeJS71
         3RaHzSnCTVpuBkhqWjiJqYoacST/PSB4slNSkkTNHfmXrrrrir3ySju3cSOSf8I8vULe
         Cxr6UPUYe6RzfR4xFYertfKPAlzHRpDxR1JH2mcDxUmNQv8r8eJDmT6TsqdUhl6NGHBN
         tNlw==
X-Gm-Message-State: AMke39mWPfKPyA50Q8ygCzVxJwz/9wOAt+fVkLSKOGX902YdCM6jDGWqTKiSNXfO6o9N2B5uXjdA3w5AlhbOAw==
X-Received: by 10.25.216.28 with SMTP id p28mr158610lfg.164.1488259735134;
 Mon, 27 Feb 2017 21:28:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.150.204 with HTTP; Mon, 27 Feb 2017 21:28:54 -0800 (PST)
In-Reply-To: <xmqq1sujwek2.fsf@gitster.mtv.corp.google.com>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
 <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net> <xmqqfuj47hfk.fsf@gitster.mtv.corp.google.com>
 <20170224010823.my4wmdyezjuqajfx@sigill.intra.peff.net> <xmqqlgsw5iu8.fsf@gitster.mtv.corp.google.com>
 <20170224041807.5g3yogfnsoqegqkl@sigill.intra.peff.net> <1488208102.10235.3.camel@kaarsemaker.net>
 <xmqq1sujwek2.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 28 Feb 2017 06:28:54 +0100
Message-ID: <CAP8UFD3zh26TdU7KUNK7v3qOd-eddwXii27cYu=bmbYO5di3Fw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ident: do not ignore empty config name/email
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jeff King <peff@peff.net>, bs.x.ttp@recursor.net,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 27, 2017 at 9:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
>
>> On Thu, 2017-02-23 at 23:18 -0500, Jeff King wrote:
>>> On Thu, Feb 23, 2017 at 08:11:11PM -0800, Junio C Hamano wrote:
>>>
>>> > > So I dunno. I could really go either way on it. Feel free to drop it, or
>>> > > even move it into a separate topic to be cooked longer.
>>> >
>>> > If it were 5 years ago, it would have been different, but I do not
>>> > think cooking it longer in 'next' would smoke out breakages in
>>> > obscure scripts any longer.  Git is used by too many people who have
>>> > never seen its source these days.
>>>
>>> Yeah, I have noticed that, too. I wonder if it would be interesting to
>>> cut "weeklies" or something of "master" or even "next" that people could
>>> install with a single click.
>>>
>>> Of course it's not like we have a binary installer in the first place,
>>> so I guess that's a prerequisite.
>>
>> I provide daily[*] snapshots of git's master and next tree as packages
>> for Ubuntu, Debian, Fedora and CentOS on launchpad and SuSE's
>> openbuildservice. If there's sufficient interest in this (I know of
>> only a few users), I can try to put more effort into this.
>
> That sounds handy for people who do not build from the source
> themselves.
>
> Christian, perhaps rev-news can help advertising Dennis's effort to
> recruit like-minded souls?

Yeah, I had already noticed this thread and now Jakub has mentioned it on:

https://github.com/git/git.github.io/issues/231

so yeah we will advertise it one way or another.
