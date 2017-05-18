Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16CA3201CF
	for <e@80x24.org>; Thu, 18 May 2017 17:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934500AbdERRMX (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 13:12:23 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33672 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934303AbdERRMV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 13:12:21 -0400
Received: by mail-pg0-f54.google.com with SMTP id u187so25733041pgb.0
        for <git@vger.kernel.org>; Thu, 18 May 2017 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nZNY6h7s0qR6JH9zsfxcQZqLusiJ/UUZmsLmiaxowSk=;
        b=ZCpWH/zI1BMlFbD09MfBs/5Nh7ZwTeNnL/UWJnEG1MCwYb7/pJgeR9jrQkuAxmXB6m
         R9P5S0BHbfCpoIHLzo3RGC28h/5eiTDY5Byz1pYnvMS+N7gx+m5+PCuo7MEVDsVYQRlo
         NTJYlemXcI6w3oZHpBE9ue3dUBjCPs3XTHNj2s1kNXE0+sK54FggCko9SrRaxUxqgki+
         W9yOMbXMgtx4oHsAjDSV3i9n/Nxb1OQkunTRg/zFLpZ2fXyOA/9ZNwmfC8dWm0X8DTfP
         qBsGJ9tOcuIWPyZqe2NSSq871J24bBOkAGF1fs9RZNpf7cWv6gAtMCyZr3FjvupcHsG0
         hBZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nZNY6h7s0qR6JH9zsfxcQZqLusiJ/UUZmsLmiaxowSk=;
        b=Hg+CrvIAW9jPsQ5AXK/RftBJabRdoxfedzXI4w3tRy179oN96QxrMdZ0ZpAm1uLtG5
         wwXYFq6QQzbAVQw9kDpLYJmTxmRgspAYyIb6FW2rhoNPP3y2jb1CpHQyF4L+g96ChYLW
         o+JoMdDYUXTkaaSunQ4WK3l/jjU9ZlUvGsJLKpu+8doVrgV+dA4KgXN2c/1Wir/vweJc
         bpiRwSnXojWrUmwGKEP6n0MhNcJrZPYx06/ZF1qgoAOxoomvaxESTpRX//QCakpMK+DR
         EyOdpicx8DUZkhusJFjq/1bufnxW77Kv3fXZUFs6PGCuF1rBFsazkeZLos05Aw3Hy8/r
         LX1A==
X-Gm-Message-State: AODbwcCdUnncjGzOHDUVcScqDDnqq/klO/VPRn3O1WYTj3K7PS8qxAWI
        mhJlgkXMfnFdzTvXBicKKt7yZJ+KpWKO0CkgLA==
X-Received: by 10.98.104.4 with SMTP id d4mr5494052pfc.94.1495127540813; Thu,
 18 May 2017 10:12:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 18 May 2017 10:12:20 -0700 (PDT)
In-Reply-To: <xmqqinkyvobp.fsf@gitster.mtv.corp.google.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170517025857.32320-1-sbeller@google.com>
 <20170517025857.32320-13-sbeller@google.com> <xmqq8tlwxdp3.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbCYiDRbf2+uXANqBiR9sG4ir4m6VK5+t1LS-kE7T1aQg@mail.gmail.com> <xmqqinkyvobp.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 May 2017 10:12:20 -0700
Message-ID: <CAGZ79kbXyjTaE=F7YU8yu8=eNzLS96sA5r5N4xrhmOfw+T4Lwg@mail.gmail.com>
Subject: Re: [PATCHv2 12/20] submodule.c: convert show_submodule_summary to
 use emit_line_fmt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 8:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>>> +static void show_submodule_header(struct diff_options *o, const char *path,
>>>>               struct object_id *one, struct object_id *two,
>>>>               unsigned dirty_submodule, const char *meta,
>>>>               const char *reset,
>>> ...
>>> How does capturing these lines help moved line detection, by the
>>> way?  These must never be matched with any other added or removed
>>> line in the real patch output.
>>
>> Why?
>
> What are buffered are not patch text, but informational text like
> "Submodule X contains untracked content", etc.  When a text file is
> modified elsewhere and lost a line that happened to say the same
> contents, we do not want to consider that such a line was moved to
> where a submodule had an untracked file.
>
> I have a suspicion that the two-pass buffering is done at too high a
> level in this series.  Doesn't the code (I haven't reached the end
> of the series) update emit_line() to buffer the patch text and these
> non-patch text with all the coloring and resetting sequences?
> Because the "ah, this old line removed corresponds to that new line
> that appears elsewhere?" logic do not want to see these color/reset
> sequence, the buffering code needs to become quite specific to how
> the current diff code is colored (e.g. a line must be painted in a
> single color and have reset at the end) and makes future change to
> color things differently almost impossible (e.g. imagine how you
> would add a "feature" that paints certain words on added lines
> differently?).

That could be added in ws.c:ws_check_emit, as these certain words
are similar to coloring whitespace.

It depends on the precedence of such a future feature, is the move
detection or the word highlighting more important to keep its color?

> Ahh, yes, I see NEEDSWORK comment in patch 19/20.
>
> Yes, I agree that this code really should be working in terms of
> offsets into pre/post images when finding matching changes, which
> probably should happen without letting fn_out_consume produce fully
> colored textual diff output in the first pass.  For the purpose of
> "moved lines detection", the logic to match a stretch of preimage
> lines with postimage lines do not want to bother with "--- a/$path"
> headers, and it does not want to care if a line that begins with '+'
> needs to be added by calling emit_add_line() that knows how to check
> ws errors or the payload needs to be painted in green.  After the
> first pass determines which added lines are not true addition but
> merely moved, the second pass would know how that '+' line needs to
> be painted a lot better (e.g. it may not be painted in green).
> Letting fn_out_consume() call emit_add_line() only to compute
> information (e.g. "'+'? ok, green") that the first pass does not
> want to see and the second pass will compute better is probably not
> a good longer term direction to go in.
>
> Having said that, we need to start somewhere, and I think it is a
> reasonable first-cut attempt to work on top of the textual output
> like this series does (IOW, while I do agree with the NEEDSWORK and
> the way this series currently does things must be revamped in the
> longer term, I do not think we should wait until that happens to
> start playing with this topic).

Ok. I share a similar reaction to submodule diffs that we discuss above
and word coloring, that Jonathan Tan brought up off list.

Both of them are broken in this implementation, but the NEEDSWORK
would hint at how to fix them.

For word coloring, we'd invent a new state BPL_EMIT_WITH_BRACES,
that would only store the word and at output time we'd have to add
sign, braces, colors. Then a block movement detection is possible.
(and this would also work with offset/len into the files longer term)

For the submodule diffs, I am really looking forward how Brandons
current work is coming along to have a repository struct such that we
can process submodules in the same process. For this diffing the
repo object would need to learn about the attribute system of
the submodules, such that we can obtain the whitespace coloring
rules, as well as the config (submodule may be configured to use
different colors for diffs).
