Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274651FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 16:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933313AbdCaQXp (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 12:23:45 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35510 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933256AbdCaQXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 12:23:44 -0400
Received: by mail-vk0-f53.google.com with SMTP id r69so96875874vke.2
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=40jWik/G7fqn3VigJH/EDrJlYgePhoVJcDeN98eraHk=;
        b=r0nqcIyf6har391AJSKarKnZrL+gy/kkAHjL0QxguQ+098SA7iR5DqRHoUqL5t22bQ
         rOiZQPiYydymImZRU3bMwhGfi907e8OjMaB3enH6UwZO1Qe0Qavimw6lnnaoDDVFG8Qi
         +zT2QQ2KJ9sv6Ey3wBD4BhzMBeUpHJnyO3Px7nBAUEyVQbI/fNxK5VZOVshYmcxZk2gk
         Yuc4bYmVxY/Cx+nBBVXquxP32FukkJw/ePePGe+HSdegz+qDGMQfrqiPHtHuJ9kTB7s5
         GRwKQ4SJynU1t6BrCiqZDD4RNofA3BG5LRYN7w2NIbUqKee2+31sFemqZmagu50J9cQe
         U/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=40jWik/G7fqn3VigJH/EDrJlYgePhoVJcDeN98eraHk=;
        b=G98+v4i5kUiBTGExySCvoZlUvNEGAAG4Kt6pPtQ0gTNFFLfnOoc6uarNi7wNF72ie4
         HiDbklDHrvRt0J0+5JyFCYxSLOWxNQNNcMs5EtzPdS8d8SNum0FZ6UA9PmeSb7dsQ66e
         ba0qCjyoi/9jN/hm0zE56AntUyS7IMBk2uvz+Lt7jLeHN1d2acrTmK91cxb0NNg4Dqhx
         GKlv+yomkYSJUrciiZrJ7YQvqd7uUDr6UKvMoNKKDthmN7WXUk38+kaaWZhDROLeApkU
         o6tujsbsj1b5PfZZEJWhJzLNkMI20L5yQR1zaeZuNQs/SBoEMz/BzLLyDgvp8y8/P1IK
         l9Ew==
X-Gm-Message-State: AFeK/H0jjKM6Cy9kNNTRMUnCkRfoc6TJi0aZcM4NJ+ZH7rNdCA9IdWFTRwp3vgEa1S7hgFyG2D43Nbq5XEylFw==
X-Received: by 10.31.224.67 with SMTP id x64mr1444876vkg.21.1490977423272;
 Fri, 31 Mar 2017 09:23:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.4.54 with HTTP; Fri, 31 Mar 2017 09:23:02 -0700 (PDT)
In-Reply-To: <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de> <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Fri, 31 Mar 2017 11:23:02 -0500
Message-ID: <CAJZjrdXyRqs=oscynWghB13OiR8qjP10O2EV-wiP-acb7wqY-A@mail.gmail.com>
Subject: Re: Terrible bad performance for it blame --date=iso -C -C master -- <file>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Harrison Stall <harrison.r.stall@vanderbilt.edu>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich,

Is there any chance you could share the repo where this is coming from?

This is actually something a colleague and I are looking into seeing
if we can crunch out some performance gains since -C -C isn't
threaded.

Sam

On Fri, Mar 31, 2017 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:
>
>> I was running "vc-annotate" in Emacs for a file from a large
>> repository (>40000 files, a big percentage being binary, about 10
>> commits). For the first file the result was presented rather soon, but
>> for a second file the command did not finish even after about 10
>> minutes!
>>
>> The file in question is a rather short text file (124 kB), and
>> according to git log it has one commit.
>>
>> While being bored, I did an strace of the command to find out that a
>> huge number of files is inspected.
>
> With -C -C the user (vc-annotate?) is asking to inspect huge number
> of files, to find if the contents of the file (except for the part
> that came from its own previous version) came from other existing
> files.  So this is very much expected.
>
> It might not be a bad idea to teach "blame" not to pay attention to
> any path that is marked as "-diff" (e.g. binary files) when trying
> to see if remaining contents appeared by borrowing from them.  We do
> not have that heuristics (yet).
