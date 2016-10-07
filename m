Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9127420986
	for <e@80x24.org>; Fri,  7 Oct 2016 13:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756488AbcJGNMF (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 09:12:05 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34621 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755437AbcJGNMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 09:12:03 -0400
Received: by mail-io0-f193.google.com with SMTP id i202so2701011ioi.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+jM0TnHphRrYh2PKIzDt6AIOelxKid+V5hLFPfu8n4w=;
        b=XSArt08TuIM4JYkSlWJs+XVhGJTlK51hL/4qgl9kHHhGo3SnCIv70MFdzdZrLZwEL2
         FwfbMHDUos11Q4iCyCtSIFdRYrjteUXiXMy3yvxGpO9ZwkAlvbNgJakKaoqiaBduVH/i
         c0x2DBJHRLcHMQZTQOZSe+ztZJk1JgrdvtsTUf3h+yysr1O3VKOoSgIPI1P61A5XhTF3
         BTnqXZLdsZgO9I47oDHdIOAFx59nh0pXntJRWfDky6LLtLB2rLNlxdN/hRcCGCi5v4C+
         DeI46+e6/0NOJUTO1LYCMhqHy1hMeM7OvM72cgyP7AQgKHB79h3JNGSC/1WzQe9dpmDm
         YfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+jM0TnHphRrYh2PKIzDt6AIOelxKid+V5hLFPfu8n4w=;
        b=SLdWlZ8iGoJ+TI4hPx3SiR/EYpGAvqAhDdKObej4Xkur9pB0b0/cUaD3TeUA43FxFt
         QnVI/y+VBxd7IuUVZnJCtCSqhNDcVFQPWE6c9+g+N+9/UOsoz2nKOlzG2uObR3D0nEI2
         Znv+/bi8Peem/Rcvf240Yv/BfYmouHQrj2Nd2kvvaKlLM0Muz9Jd3weXlY3fSu5zJEUQ
         AWsQ9rzimvrifEoqrRYp25RgfZgltFT0mZh8O9CTgyCYrTR4WoHhsXtoI6bjImlMa5ih
         RvZI3LUV0wQ/6yBbcuWC9Cv+/x2vuLPA16QPBXMoJq3RDF9oG7JZKzv94O3tOZjShLKX
         VqdA==
X-Gm-Message-State: AA6/9RknhfB5nBlAaUKbJe75BkY6weXkBKFb3G3yOeORz0OOfhB+iGW1Nqa3xJzsqHRiml28+GArjIEPDdmOBg==
X-Received: by 10.107.202.4 with SMTP id a4mr20733864iog.19.1475845037910;
 Fri, 07 Oct 2016 05:57:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Fri, 7 Oct 2016 05:56:47 -0700 (PDT)
In-Reply-To: <xmqqwphljnlj.fsf@gitster.mtv.corp.google.com>
References: <20160928114348.1470-1-pclouds@gmail.com> <20160928114348.1470-2-pclouds@gmail.com>
 <xmqqzimrj03j.fsf@gitster.mtv.corp.google.com> <CACsJy8D28iq3r3O_uzjyyJT--KQunAySRgUthF3FMrb1VM6XKw@mail.gmail.com>
 <xmqqd1jgw0nx.fsf@gitster.mtv.corp.google.com> <CACsJy8D7c8Z_ugasn_scf391+C6GxJp1CYwHY4ndvVtLiJzxnQ@mail.gmail.com>
 <xmqqwphljnlj.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 7 Oct 2016 19:56:47 +0700
Message-ID: <CACsJy8DiGoaKZZ1je=3L3y4odVHB7wLvvKs9pccjiN=-UeqeVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] Resurrect "diff-lib.c: adjust position of i-t-a
 entries in diff"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 2:15 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Tue, Oct 4, 2016 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> We don't use it internally _yet_. I need to go through all the
>>>> external diff code and see --shift-ita should be there. The end goal
>>>> is still changing the default behavior and getting rid of --shift-ita,
>>>
>>> I do not agree with that endgame, and quite honestly I do not want
>>> to waste time reviewing such a series.
>
> I definitely shouldn't have said that, especially "waste".  Many
> issues around i-t-a and diff make my head hurt when I think about
> them [*1*], but not wanting to spend time that gets my
> head hurt and not wanting to waste time are totally different
> things.  My apologies.

No problem. I do appreciate a straight shoot down though. Many of my
topics have been going on for months (ones not in 'pu') and seeing it
rejected near the end is worse than stopping working on them early.

> I missed something curious in your statement above, i.e. "external
> diff".  I thought we have pretty much got rid of all the invocation
> of "git diff" via the run_command() interface and we do not need the
> command line option (we only need the options->shift_ita so that
> callers like "git status" can seletively ask for it when making
> internal calls), and that is why I didn't want to see it.

I don't know if we have had any external diff calls in our shell-based
commands. I don't read them often. Regardless, people do use "git
diff" and it should show the "right thing" (I know it's subjective).
Or at least be consistent with both git-commit and git-status.

> [Footnote]
>
> Here is one of the things around i-t-a and diff.  If you make "git
> diff" (between the index and the working tree) report "new" file, it
> would imply that "git apply" run without "--index" should create an

Off topic. This reminds me of an old patch about apply and ita [1] but
that one is not the same here

> ita entry in the index for symmetry, wouldn't it?  That by itself
> can be seen as an improvement (we no longer would have to say that
> "git apply patchfile && git commit -a" that is run in a clean state
> will forget new files the patchfile creates), but it also means we
> now need a repository in order to run "git apply" (without "--index"),
> which is a problem, as "git apply" is often used as a better "patch".

We could detect "no repo available" and ignore the index, I guess.

> "git apply --cached" may also become "interesting".  A patch that
> would apply cleanly to HEAD should apply cleanly if you did this:
>
>     $ git read-tree HEAD
>     $ git apply --cached <patch
>
> no matter what the working tree state is.  Should a patch that
> creates a "new" file add contents to the index, or just an i-t-a
> entry?  I could argue it both ways, but either is quite satisfactory
> and makes my head hurt.

--cached tells you to put new contents in the index. I-ta entries,
being a reminder to add stuff, don't really fit in here because you
want to add contents _now_, i think. After a successful "git apply
--cached", a "git commit" should contain exactly what the applied
patch has. If new files are i-t-a entries instead, then the new commit
would not be the same as the patch.

[1] https://public-inbox.org/git/1451181092-26054-4-git-send-email-pclouds@gmail.com/
-- 
Duy
