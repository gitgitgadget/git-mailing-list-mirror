Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4261FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 22:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbcHJW51 (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 18:57:27 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:35839 "EHLO
	mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbcHJW50 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 18:57:26 -0400
Received: by mail-yb0-f193.google.com with SMTP id g133so1442198ybf.2
        for <git@vger.kernel.org>; Wed, 10 Aug 2016 15:57:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N/hrsumAwRTwPYQswL/+sjwpdGya0W9U9ohSPMt5WUs=;
        b=fLXE5p1TgE5/8suCJJWd8J+GoCMkagYXl+/BZURcr2N0Lzzp5Gbth7j7JZ55sweuZr
         1xFIrcqjZDrA9d9dxPcuAcL7RtHuxJiS4dY16YgYJOKZVkERj254eq8e39joE4ewAbrj
         QwNkkSFGDqMgPRH42vxXx490x2EhDRsH4V/yPA5dGx2MEoiWYzF2QOFYfA1rOdM/WH+w
         G+Eh+UOJiLjJ8Un/3p0BGOof/Ndu2clQBGzijiinLCUw9mINqpSYIUzOZsgQzuEPCAAq
         oZyatZmhLXC15t0cQAE5ekOkV2nTsoErj8knjWcl6B8UVTpN94F8lOnxCnLR61HkloLd
         bTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N/hrsumAwRTwPYQswL/+sjwpdGya0W9U9ohSPMt5WUs=;
        b=ABDiMqlBfITmZ9O6rOvpTGiIWZ7EnftZe+LbxBXQv4UnKTLge2J1R9SVCk5mwZTww9
         A4ljPisFU7fbj3obotrf/j39QD9LD0mYfM5OvCxwYUNSqEJAHYR9a5yuthl1XqgoRgbu
         m/UNeQDmyFIPY76hsJOG0Y7soZuk4Xa0tnD7zz0MbVHBYI1XSdncKQCmz5NXO1nihv3G
         fpJOt+M9PBulxLdby+LIiVsIc18s6yjd4wU+7hxeanMIAiGIW4qqz+pUAk4ZSM4ZgkIE
         ffKrhIDlSOSaPr+RiOOi7WgWUrtGfm2OFj/oh5iXrQlJth+0/39FQsDLVubAzLsJIOrB
         qTuw==
X-Gm-Message-State: AEkoout61MDFc4/UgJNoX/bXC/DoNFvIzP91dDNe7He5+ydD8tWRmTrOZ53mXkE0ySOoOQEld0DEyGcYgpECRg==
X-Received: by 10.37.60.67 with SMTP id j64mr4202461yba.111.1470868998155;
 Wed, 10 Aug 2016 15:43:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Wed, 10 Aug 2016 15:42:57 -0700 (PDT)
In-Reply-To: <xmqq4m6s476t.fsf@gitster.mtv.corp.google.com>
References: <20160810211710.23173-1-jacob.e.keller@intel.com> <xmqq4m6s476t.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Wed, 10 Aug 2016 15:42:57 -0700
Message-ID: <CA+P7+xr1RWsOREue_D75z_Qd8pC1aNcPAejTXAjo=S6nP3_fNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] diff: add --line-prefix option for passing in a prefix
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 2:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> As suggested by Junio, I implemented --line-prefix to enable the graph
>> display correctly. This works by a neat trick of adding to the msgbuf,
>> so no code needs to be altered. I presumed that the line prefix should
>> go *after* the graphs own prefix.
>
> I do not understand the last sentence.
>
> The motivation I suggested the --line-prefix for is for a scenario
> in which "git log -p --graph" that recurses into a submodule causes
> "git diff A B" between the two commits in a submodule to run; the
> internal diff machinery driven by "log -p --graph" for the
> superproject knows what the graph lines that depict the lineages of
> history in the superproject should look like, but the "git diff A B"
> in the submodule of course does not, so while showing e.g. "| | |"
> (three lineages) for the history in the superproject, you would run
> "git diff --line-prefix='| | | ' A B" and by showing them before
> anything that "git diff A B" without the new option would have
> produced, you could mimick and match the graph output in the
> superproject.
>
> In that scenario, the line prefix _is_ the graph's prefix in the
> superproject.
>
> You might be envisioning a future enhancement where the recursive
> one uses not "-Submodule commit A"/"-Submodule commit B", and not
> "diff A B", but "log -p A...B" in the submodule, and in such a case,
> it might make sense to run "log -p --graph A...B" instead when the
> command the end user run in the superproject asked for "--graph".
> You would use the same "--line-prefix='| | | '" when running the
> "log -p --graph A...B" command in the submodule, so that the output
> for the submodule will go _after_ the graph of the superproject, but
> in that case, the output for the submodule would also include its
> own graph to show the relationship between A and B.  The line-prefix
> must come before that graph part (and also if it is "git log" run in
> the submodule, the same line-prefix must come before each line of
> the log message output).
>
> With that understanding/assumption, "line prefix should go after the
> graph's own prefix" sounds like a wrong choice to me.  Shouldn't the
> prefix go before everything else?
>

I don't think it matters, but if it did, I assumed that a users use of
"line-prefix" goes "closest to the edge with the diff content" and
then any additional prefix from log --graph would go to the left of
that.

Thanks,
Jake
