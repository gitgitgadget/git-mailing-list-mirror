Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81CCE211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 19:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbeK3GgY (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 01:36:24 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33650 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3GgX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 01:36:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so2354597lfc.0
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SokH7FMwTMhIHSUx2X4z8I3fqKWLFDtTHvSb23iPIRY=;
        b=CIkCggWiovzeHMVmGeM7VnxwfBugTAenwR6jvEFPzUknoNCidi75zix6Su8TdcjB5/
         PCzc8RYN2hTt0BIOqUe0MWV8bwQOKtm6WciFWuIsRTdCfFETUCPIYzPslX2SFFMURSDS
         OX/bx3jv3QwH6TTkPLzcX38j7eNwXl+SFZ11ISMxBNQjPZfL08NEjjTjNzckfAgOEPSE
         Z5ilwu7we+lxsxWInAcsJA8I0aSYZEv9drjqtZt5BbenGSU0pSNjK/tIAN0/m/Dmj00T
         mCXLu+tQY1/RL1hTwNuokEB/R4UVNpJ1NDMxpnHti4G2284TuALiHnwzcMH42Se1T2D/
         P5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SokH7FMwTMhIHSUx2X4z8I3fqKWLFDtTHvSb23iPIRY=;
        b=HuQtTn3+d/IUAIB+JCnKOVGW7/RXyjdzo1G1PnW3eZ09EnSHSwNZgxjrz6Qq7IqSpW
         qBRZnd+E1EDkKpDTuOaxyjSxKr4BE7v/xQQk0SNbGXtC4eL1k/56GfyOXCdUjmjhDGda
         QMLcWMQ18UH6gA8b/I+3HaFmDI0HReNeA3kkUqZvcvQslh6EumKDiQEdTut/J9MU4jug
         xSjrLgGsXLb4WuCC140Q5aF60kNTRyCIn20S++p7umhp2HvBHccv1M+rFZUNdTK+Qsla
         ND9NYIHwa3i5KxZ/PwCATCF3zHD/csJNDfCdQ+XzcD5XwWb9SS2+rRGBmLGRv1WjOKDd
         QSDA==
X-Gm-Message-State: AA+aEWYtWs9GGPgBThjEywRQummNdM09vhhDVx3wwIJSQIwWOAlIumc8
        oywU8nH8puxacJUj7p7TJmCIx1/5fN28dFKhDnr4dg==
X-Google-Smtp-Source: AFSGD/URDsWf/Gs++W3UcySanNfgqSh9qdff/JhLzj7aD15Acz/cHEdriuMAGGVhX/xITcyAOWbD0bJ8gdAEVFdUh0o=
X-Received: by 2002:a19:7dc2:: with SMTP id y185mr1791233lfc.27.1543519792031;
 Thu, 29 Nov 2018 11:29:52 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
 <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com> <CACsJy8An2n5yah1UTCJZoC5ucSpCoM0vrXtEXnjg-di7jQZwLA@mail.gmail.com>
In-Reply-To: <CACsJy8An2n5yah1UTCJZoC5ucSpCoM0vrXtEXnjg-di7jQZwLA@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Thu, 29 Nov 2018 11:29:40 -0800
Message-ID: <CAPL8ZitNd+1zadorvrELSHqet5cFBU9UyigA6JGwHQOWmX_fWQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> Which brings us back to your "git checkout-files <tree-ish>" use case
> above. It should be treat the same way in my opinion, so we either do
>
>  git checkout-files --from=tree-ish :/
>
> or
>
>  git checkout-files --from=tree-ish .
>
> But "git checkout-files --from=tree-ish" alone is rejected.

Agreed. Those arguments are better. The gist of my comment was the
treatment of newly created local files rather than the form of the
arguments, but it sounds like you've got that under control, too.

> > Suggestion:
> > If git checkout-files overwrites or deletes any locally-modified files
> > from the workspace or index, those files could be auto-stashed. That
> > would make it easy to restore them in the event of a mistyped command.
> > Auto-stashing could be suppressed with a command-line argument (with
> > alternate behaviors being fail-if-modified or always-overwrite).
>
> Stashing I think is not the right tool for this. When you stash, you
> plan to retrieve it back later but here you should rarely ever need to
> unstash until the accident. For recovery from accidents like this, I
> have another thing in queue to achieve the same (I'm calling it
> "backup log" now). So we will have the same functionality, just with
> different means.

Yes, this makes sense too. You wouldn't want to pollute the stash list
with autogenerated things the user probably doesn't want.

> This one is tricky because we should deal with submodule autoupdate
> consistently across all porcelain commands (or at least common ones),
> not just checkout-files.

This is also a good point. I'd like it if submodules just behaved like
a single giant repository for most commands, but you're right that
this is something that should be done intentionally for all the
commands at one rather than just for a single command.

I also like your new names "switch-branch" and "restore-files".
