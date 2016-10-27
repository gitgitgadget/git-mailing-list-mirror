Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35060203BD
	for <e@80x24.org>; Thu, 27 Oct 2016 14:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034051AbcJ0OZg (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 10:25:36 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:35124 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034067AbcJ0OZc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 10:25:32 -0400
Received: by mail-qk0-f179.google.com with SMTP id z190so46852606qkc.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YCeMOvzPJSLp0J37kjnJZswlg0P1Csu8DB95ms11wVc=;
        b=XJesvmQhCtLQ8NvuYWnV9YsyH4V4D9OvVK5fm9FTirPGqKs0nI+2vEszkc36+cHOcU
         Y+TTgbKi0klgfIaQfBxYEoHgqXQG+huyQmMsIz8FqteH47fjptCm2bUYwBzFydApk5xO
         LzjAHv7bwOfayRYkiN357NnSMglL2mn9yN9TK+RWpJAUuRTGn4cH5MiUkxmxUcmUHwDl
         mrRgJPCicU6CwWoOERlz56rUOdcVlgI7rNKaiwjBN9ooLp/rtx28wATHNZ4DXkmCrCP0
         VIt6OlR+1tjiJ1kPK4vTwfBZiYygb8ONyLlgi7TNbhBOj/027E5R7gQ19RgH2svrp/np
         uocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YCeMOvzPJSLp0J37kjnJZswlg0P1Csu8DB95ms11wVc=;
        b=c4Cy59BAZntH5YvKzbAYS7ePqo0VEKUWnGs0mLbUcB85i5cOR8D2BEBSf2CxWQtQeM
         pQ45PnA+a61mkyBs5l+/w+rgQ1SPzn6F+9iIGEDYhf+n1i9CR6Jfq7UFjs574t/BZLBg
         /tm6gdU1idclrAhagdiBzuTx1k+FQuBZ2Jdqqyn44K4D8pIkZmhUOe9FpFfhIYRh9/N6
         ZoRJZex6mkaWcRgAztMTLbqFHxl/oZ+La8ZyxtXhMkhDRBbwwP5jatelotRHVa3UdP5I
         gbALZ9p+q+rrMD8zIezJlI1SFvRXoXP+lL2ImIoCB8cDJs3R4IlY8gT+jLX9DMIY6Iyo
         X5Hw==
X-Gm-Message-State: ABUngvcYY4nTfpWNWCey6crrKCJ6CPGiq2taeTIRszDTH/8sB3tMMk2xW/q4l3sTBrzX0FsKvnqDfDtT6x2nPA==
X-Received: by 10.107.59.6 with SMTP id i6mr6289468ioa.176.1477564874298; Thu,
 27 Oct 2016 03:41:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Thu, 27 Oct 2016 03:40:43 -0700 (PDT)
In-Reply-To: <xmqq60ofcavd.fsf@gitster.mtv.corp.google.com>
References: <20161026094658.20704-1-pclouds@gmail.com> <xmqq60ofcavd.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Oct 2016 17:40:43 +0700
Message-ID: <CACsJy8CSz-2A56okV6kWBjGqUgiL7DrmmVJ=2jEQhKmqe41cRg@mail.gmail.com>
Subject: Re: [PATCH] rebase: add --forget to cleanup rebase, leave HEAD untouched
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 11:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> There are occasions when you decide to abort an in-progress rebase and
>> move on to do something else but you forget to do "git rebase --abort"
>> first. Or the rebase has been in progress for so long you forgot about
>> it. By the time you realize that (e.g. by starting another rebase)
>> it's already too late to retrace your steps. The solution is normally
>>
>>     rm -r .git/<some rebase dir>
>>
>> and continue with your life. But there could be two different
>> directories for <some rebase dir> (and it obviously requires some
>> knowledge of how rebase works), and the ".git" part could be much
>> longer if you are not at top-dir, or in a linked worktree. And
>> "rm -r" is very dangerous to do in .git, a mistake in there could
>> destroy object database or other important data.
>>
>> Provide "git rebase --forget" for this exact use case.
>
> Two and a half comments.
>
>  - The title says "leave HEAD untouched".  Are my working tree files
>    and my index also safe from this operation, or is HEAD the only
>    thing that is protected?

Everything is protected. I will rephrase the title a bit. The option
is basically a safe form of "rm -r .git/rebase-{apply,merge}".

>  - I think I saw a variant of this gotcha for an unconcluded
>    cherry-pick that was left behind, which the bash-prompt script
>    did not notice but the next "git cherry-pick" did by complaining
>    "you are in the middle" or something like that.  Perhaps we would
>    want to have a similarly sounding option to help that case, too,
>    not in this patch but as another patch on the same theme?

That would be nice. I don't put lots of git info on my shell prompt
though, so it does not help me. And it's probably difficult to report
the right thing too. Sometimes in the middle of rebase I would switch
to another branch, look or do stuff, then "git checkout -" back. I
don't think we can make the prompt script clever enough to see my
intention.

>  - Would it have helped if bash-prompt were in use?  I am not saying
>    that this patch becomes unnecessary if you use it; I am trying to
>    see if it helps its users by reminding them what state they are
>    in.

Since I don't use it because I want to keep shell prompt short and
light, it doe not help me. But it looks like git-prompt.sh does print
rebase in progress and others (only checked the code, didn't test it).
--=20
Duy
