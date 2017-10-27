Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301442055E
	for <e@80x24.org>; Fri, 27 Oct 2017 06:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbdJ0G4l (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Oct 2017 02:56:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:54968 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751070AbdJ0G4k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Oct 2017 02:56:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id z19so7240738qtg.11
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Rv2NO+yFqJWMVOjFHc3RS6H3RyCc+mco4V0qwHfjbmw=;
        b=lzZhPKhhwmqdVxdPEs2lDxzTW27hY2NOFlcSLbqF7u/0ljwDyfk9pnPWFsQPMCfpic
         8hiWvEi4sUhUzFXa0wLdZBJFVXzTSDqlv3P8sjQlpzm+qE4/mLzKzhZotIDYRdukQpuN
         Kpgfl/69brigV9ZXNpOlZsQjQE9B08shnQQYbatz0sA2CYVu3GT2HIaQy3Q0D8i0yeN4
         bEd6DEuSF/o0SOAMAlyuJuxBmuw8xYzE31ohG9u+ICErtsAqbBfTgmNqkhfHCmTcFeE9
         9aTVpTCMsXzy1Jnfm85fC7bLjTvBNEPu2XTotgme9Qp2PTpwA0Bqsh5SvGaB9h5TI1fG
         0zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Rv2NO+yFqJWMVOjFHc3RS6H3RyCc+mco4V0qwHfjbmw=;
        b=pcUkwS8Jf2ku0iyLan8BsgcAD6XK7dptQJOIu1Q626skOw/uIsXKjiTvfwtkkx9Wct
         f+Xr9OGj1VROk1P7BvYtrQy8rA46mmrkj5dqzFjRLuuWReAQwhX59pOmCpHgcw/bgYFY
         2TivRgS5STatHcEItTIj23Ebv8b40pwHK91of4Jw/ZKrEzBbQ6gAa+IawsURjcwZtXeV
         MsVIrg494XL+ftwNg+fZ2YRkGUlBwFtRSI6HrxQTxP8aSNwrirVJ5zBUDV5LhDwJrJ5R
         QCKTAWuHGItdd56YFuEXsHVi1UwA4oV8fRWc1OGPg0c8LoPJHXgSKdclZruNQFZEg7JF
         kVZA==
X-Gm-Message-State: AMCzsaXsuZ3584vOpU6//pEOAkV59YsacRaqiFHzfZoNxIFI8GGVHLJz
        LlzIQPoFkHTyJsjXWozFXpmvRhMxHlIOUvlSWr8=
X-Google-Smtp-Source: ABhQp+R+BMTVu6P6G5uT15/qSO2fgUlkRODOGFxFSEzBRCJUu/rTVZjasyy4GOdNuYRTpLId3yDFup15l2fqx+W7hMg=
X-Received: by 10.200.46.114 with SMTP id s47mr39185807qta.165.1509087399424;
 Thu, 26 Oct 2017 23:56:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Thu, 26 Oct 2017 23:56:39 -0700 (PDT)
In-Reply-To: <926900b8-1aad-b02a-b3c6-2bc4930233fd@atlassian.com>
References: <20171026153111.21813-1-szeder.dev@gmail.com> <20171027005652.7796-1-istephens@atlassian.com>
 <xmqqzi8dcpx1.fsf@gitster.mtv.corp.google.com> <926900b8-1aad-b02a-b3c6-2bc4930233fd@atlassian.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Oct 2017 02:56:39 -0400
X-Google-Sender-Auth: 0-ZY5umrc-6jHV0mnR1G6yck2zs
Message-ID: <CAPig+cSH-y7ChDE_LW55M_wB=KhD7uJHXX=OvZ=1ri5KfYQ5Sg@mail.gmail.com>
Subject: Re: [PATCH v3] blame: prevent error if range ends past end of file
To:     Isabella Stephens <istephens@atlassian.com>
Cc:     Junio C Hamano <gitster@pobox.com>, szeder.dev@gmail.com,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        bturner@atlassian.com, Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 27, 2017 at 2:18 AM, Isabella Stephens
<istephens@atlassian.com> wrote:
> On 27/10/17 12:58 pm, Junio C Hamano wrote:
>> There should be an "is the range sensible?" check after all the
>> tweaking to bottom and top are done, I think.
>
> My mistake. I missed that case. I think this section of code is a little
> hard to read because it avoids treating an empty file as a special case.
> Why not do something like this:
>
>   for (range_i = 0; range_i < range_list.nr; ++range_i) {
>           long bottom, top;
>           if (!lno)
>                   die(_("file is empty"));

No need for this conditional to reside within the loop. Hoisting it
outside the loop would (IMO) make the intent even clearer:

    if (range_list.nr && !lno)
        die(_("file is empty; -L has no effect"));
    for (...) {
        ...

On the other hand, one could argue that "-L," (where comma is the sole
argument to -L), which specifies the entire file, should be allowed
even on an empty file without complaining that the file is empty.
Although it may not seem sensible for a human to specify "-L," perhaps
a tool would do so to override an earlier more restrictive -L range.
However, that may be too esoteric a case to worry about.

>           if (parse_range_arg(range_list.items[range_i].string,
>                               nth_line_cb, &sb, lno, anchor,
>                               &bottom, &top, sb.path))
>                   usage(blame_usage);
>           if (bottom < 1)
>                   bottom = 1;
>           if (lno < top)
>                   top = lno;
>           if (top < 0 || lno < bottom)
>                    die(Q_("file %s has only %lu line",
>                          "file %s has only %lu lines",
>                          lno), path, lno);
>           bottom--;
>           range_set_append_unsafe(&ranges, bottom, top);
>           anchor = top + 1;
