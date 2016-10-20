Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28141F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 19:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756193AbcJTTeS (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 15:34:18 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34153 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756079AbcJTTeP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 15:34:15 -0400
Received: by mail-qk0-f176.google.com with SMTP id f128so109305111qkb.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g6PPmumvRwtm2Uhj9CEMDe/ZIynq0EbX/icejZtAL6w=;
        b=pjtT3TNtocqfVP61yuiT3z0QJzLuZFL3l2c7t3yQa9qA0pAlUOPN1zSzrn1hJ8AI2v
         GM5z8BhQoUcAxfNXLmj4LzKEFjJBg+10qushS38Key4P8LXQuQcbP8aIiwgp2zQyK81r
         dd5TVzM4r3JfJzxcBPtHRoSv7vL2uD8P/QMcwBdVf5sa/xSc25ktLmozVmVIF8erkluv
         eMwhs5BH0BtKhIGyCqqQVRHFNqgSsE7uCilOJ0W9nlac0gpNshvHHmUlhiQNfgW3Ts1f
         w+DoVmHYhJtQnqIpLCW0s9C81A/Eb/57I/qY2H54iSuTBsHdlmLw/WPv4fXl0m7HNhZ4
         RcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g6PPmumvRwtm2Uhj9CEMDe/ZIynq0EbX/icejZtAL6w=;
        b=k42AcRQT18MmPdtuPCeQLfvYGRN2DDl0slDXdx8WIbzW8HusxuDUjDBn2qwFqU1LfU
         2Xb3sPJMCwhdMJDgXIoPmA4D6WsVeliOgjObUSZ25pmmBZjvLzVJ/RJgWB9xcbRL9zgX
         QoiMLYjyskp+b4XM5nkvgKEAGYLFPtQOVUYpLic/M9Gpb/JwIBCdHx1jHU/zvi7MezSP
         zvX7Ffj3//5ApzXtzn261/gsQAaY15mE3fy3wWDw+n5iwCkD48o8KK4//s6eS7f1QoJF
         pLulm/mkWBv5nEPMYVK9EI1FOkoLt9f0hBVdZ4S2z1Qgm7sxokxuZ0JcNXYRb9dMwkyX
         7vZA==
X-Gm-Message-State: ABUngveOsr05e2ehPqfC/LB1O0eKEPfkA/h9CEMkvNY39syGZbAv0RVd6EJkfPDGzhRKwa4t2otsvv/KoKSoZVx6
X-Received: by 10.55.129.1 with SMTP id c1mr1900189qkd.53.1476992054183; Thu,
 20 Oct 2016 12:34:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Thu, 20 Oct 2016 12:34:13 -0700 (PDT)
In-Reply-To: <xmqqzilyg6tk.fsf@gitster.mtv.corp.google.com>
References: <20161018210623.32696-1-sbeller@google.com> <xmqqzim1nyz0.fsf@gitster.mtv.corp.google.com>
 <xmqqshrtnynj.fsf@gitster.mtv.corp.google.com> <CAGZ79kZHLVpxbJ_C-dM2LDA64-_TJNyY+52fTWkOvLvvAq2XDg@mail.gmail.com>
 <xmqq60opnolz.fsf@gitster.mtv.corp.google.com> <CAGZ79kYrKGLEOO72aWuX5OOM-AecdFZFXRqBkRzhdAM-VbPFxA@mail.gmail.com>
 <xmqqwph5m6th.fsf@gitster.mtv.corp.google.com> <CAGZ79kY4u-k8v3g5Jmod4acwJ81AnJYeYMQZ2tarx6UMGj8Xew@mail.gmail.com>
 <xmqqzilyg6tk.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 20 Oct 2016 12:34:13 -0700
Message-ID: <CAGZ79kZyCXKnt9kTbnD8KrnsjJVb_7juW2epmdP9XqcRGfg=GA@mail.gmail.com>
Subject: Re: [PATCHv3] submodule--helper: normalize funny urls
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Karl A." <venv21@gmail.com>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 12:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Do we actually want to fix git-clone as well?
>
> If I understand correctly, the point of this fix is to make it not
> to matter whether the original URL the end user gives or recorded as
> the remote by "git clone" in the repository is any one of:
>
>         $any_leading_part/path/to/dir
>         $any_leading_part/path/to/dir/
>         $any_leading_part/path/to/dir/.
>
> So I do not think there is anything to "fix", as long as "git clone"

Yes "git clone" works with any of the three above.

My thought was to fix it nevertheless, such that the url recorded as
remote.origin.url is always the first case (no l or /. at the end).

If we were to add this fix to clone, then it may be easier to debug
submodule url schemes for users as the submodule url would then
be a concatenation of remote.origin.url and the relative part.

That seems easier to understand than ${remote.origin.url%%/.} +
relative path, maybe? (Because then the user doesn't need to guess
or remember historical behavior that is wrong on how this)

> that is given any one of the above three records any one of the
> above three as the result.  It _may_ be desirable if the result is
> identical what was given as input, but I do not offhand think that
> is required.
>
>> I tried and then I see breakage in 5603-clone-dirname
>> as ssh://host seems to be an invalid url; it has to end with a slash?
>
> That is a separate issue, isn't it?  We shouldn't be touching the
> leading "<scheme>://<host>/" part, I would think.

I agree, So I'll first fix the submodule parts only.

>
> For example, a URL "../another" relative to "ssh://host/path" may be
> "ssh://host/another", but shouldn't it be an error to take
> "../../outside" relative to "ssh://host/path"?

That is correct. I'll stop looking at clone code.
