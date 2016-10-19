Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05AF20986
	for <e@80x24.org>; Wed, 19 Oct 2016 22:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754811AbcJSWOM (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 18:14:12 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36340 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754765AbcJSWOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 18:14:11 -0400
Received: by mail-yw0-f194.google.com with SMTP id e5so1297960ywc.3
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 15:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WElXCGzVWvlS1gdFVCyyDHYK+JPf1ZUqMIKnvYXcrgY=;
        b=EnqtfOtNXt+0y/vLvmVAhWbBR5KjvqtVVQWq+5ymmEsNkf56xPgw8tGgXvV8Kb0oq+
         kcFl3tfoSzNcQFUD+0s27ZEw7OgnWM15NW7RpzdPmjjlwWaLp4uvn8KAdK6PHYfW1Ze3
         gfJOggXEpvfUWYLX6EIQZEeoVoUeR9RLuCwIIz+Pw1PFMG95ekAFvUEFoN2SFM329Uov
         QW4WoVLzMOuxUmnL7uMHy++0LoQKTtRGi/b6YuPynNGw9+kyEmAOitCgavfN6OHzSv9N
         6uqbS2HaqJzsY7xuLrdDTTO8dK0JQcVE2DFtkO5Wi+kVzHfmANAm9ITvuJ/rBVeE9GzI
         4/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WElXCGzVWvlS1gdFVCyyDHYK+JPf1ZUqMIKnvYXcrgY=;
        b=duIu7Symu7LFqNiS2vBtNxXAl9TEwlQe8GWpBl9kFqsg3efTBAGfuRv+FFNNp3K5CU
         nm5RQb+3WQUCu/PbUzasd8GT1Uhe47mwnSyz9nSGCa3ze6CNptEfHoBYphp5ZUt42B6U
         Xz05JbIaeJ6U3nSEDizryPUYIk6Gj07jcTyn3yPSrLphHeTR3M2zElx8zY/PiK4meXEa
         n4uvS46AFjc//b1wEgZz5CDypldv7/q4I1NTAXHVD3iAL/kPNACSxXcpvwbEkDacT/oD
         RBSQVRqBiWpWJLtFUOE0QK7bjxVRJ1dxbM0jQn+SvpRP1hj/oT9S3kBzRbJq/4pdYeKp
         eHwA==
X-Gm-Message-State: AA6/9RmC6MfnjCJqat7xpGzKsF+Bb5ORP/LS4qEBHiekLPlQhqDaXgHqFu5pIW33gYBRaA6kZt2e+knvLykPDQ==
X-Received: by 10.129.130.193 with SMTP id s184mr8405328ywf.276.1476915250269;
 Wed, 19 Oct 2016 15:14:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Wed, 19 Oct 2016 15:13:49 -0700 (PDT)
In-Reply-To: <1476908699.26043.9.camel@kaarsemaker.net>
References: <20160831232725.28205-1-jacob.e.keller@intel.com>
 <20160831232725.28205-4-jacob.e.keller@intel.com> <1476908699.26043.9.camel@kaarsemaker.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Oct 2016 15:13:49 -0700
Message-ID: <CA+P7+xo65Wg+jTkGTBW87Xv8O5-FO9EWqkpinfW48jBMG_oNrQ@mail.gmail.com>
Subject: Re: [PATCH v12 3/8] graph: add support for --line-prefix on all
 graph-aware output
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Oct 19, 2016 at 1:24 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> On Wed, 2016-08-31 at 16:27 -0700, Jacob Keller wrote:
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Add an extension to git-diff and git-log (and any other graph-aware
>> displayable output) such that "--line-prefix=<string>" will print the
>> additional line-prefix on every line of output.
>
> This patch breaks git rev-list --header, also breaking gitweb.
>

Oops! Is it possible you have a test case already?

> The NUL between commits has gone missing, causing gitweb to interpret
> the output of git rev-list as one commit.
>

That is obviously not what we want!

> Sorry for not catching this earlier, I actually encountered this early
> september but thought it was caused by us running an ancient gitweb
> with a modern git. Finally managed to upgrade gitweb today, and the bug
> didn't go away. git bisect says 660e113ce is the culprit. Checking out
> 'next' and reverting this single patch makes the problem disappear.
>

Ok.

> Haven't yet tried to fix the bug, but this hunk looks suspicious:



>
> -                       if (revs->commit_format != CMIT_FMT_USERFORMAT ||
> -                           buf.len) {
> -                               fwrite(buf.buf, 1, buf.len, stdout);
> -                               putchar(info->hdr_termination);
> -                       }
> +                       /*
> +                        * If the message buffer is empty, just show
> +                        * the rest of the graph output for this
> +                        * commit.
> +                        */
> +                       if (graph_show_remainder(revs->graph))
> +                               putchar('\n');

Most likely this should have been "putchar(info->hdr_termination);" I
think? Not entirely sure.

If we can get a test case in we can use that to help debug the issue.

Thanks,
Jake

> +                       if (revs->commit_format == CMIT_FMT_ONELINE)
> +
>
> D.
