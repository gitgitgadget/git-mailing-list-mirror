Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8453F1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 00:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeAZAV1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 19:21:27 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:41146 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbeAZAV0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 19:21:26 -0500
Received: by mail-wr0-f170.google.com with SMTP id v15so9370262wrb.8
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 16:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bq0vj2+AiD8OKMgGdlN2L8n6czlCBjheiXMjQ6JhNkM=;
        b=t4xGeWuUeCb6RB2E7dViEqtrimAvIvfFRgJw38pxK6lQI3nNFh+yaYLhMwuhRSyN/9
         OyWGlPj5o+PzVj05AMveEFnF8j8xLwgWns8tgbxDpuTiUkB/NUL3P5pRRhepJyGm8ogO
         7NH2h+HkUex4UMiEouNidQQM/VZ0berLIdmC2sXkk1ocEOEu5X+r9bY5tsxkAFaGq6L7
         XT/Ep+7kB6+37Fvn0HeJnFwjqKq4ewd1m5EvKkG6BNzZ/kyn0xNe4mrM0hZF7V/ygQsf
         dxMm0jZuXcTE/QXnxc8y+moYPnDdp4MEKulYFw4EMWfxRkyi0zdKkAz3h0Y5xXnlSTQp
         mZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bq0vj2+AiD8OKMgGdlN2L8n6czlCBjheiXMjQ6JhNkM=;
        b=O1yyLSCwzUT1jWeyQmzstx2Rck3WyUZs1R9d3bIJMbYlWnFq9VeY5d23pcxAiUcamy
         EmhPcEQukRGGHI+Z63lyjOEc11GaxazvFxNKhdDECcGukPNXfU2NHER+1jnSIabV5LK3
         fxUulO5RgXgcCvXKTHQTioS8pk3+4RzvqBLShB6Ip+XuyfmapRnlIt4ubVvnz4E0/NKP
         vI39qU69Ei8DYZrAsqrTURfRzSB4S8Xr60ZXG5s77I5h8/DkN5w/sfo9QneA/Y6+CYl8
         AkCvQvAP6blLptbWfAYHA9WkPXAP+ZyYMs+f33BqSTSaLHgmCao6/ZO1HnwSbjvvVJeu
         yHJQ==
X-Gm-Message-State: AKwxytclo3hii5wrG5d++O/hIZ6xDCFMyWUyMP3ivhkgMbmWd2hOvPTV
        0v4D26O4xTUoCGrZpBFD3ZqSuConoeo1fNkjgTQ=
X-Google-Smtp-Source: AH8x2254dy/zm+Ojnew3aB91qQteNxTr/9eYLJxfQp65nVvmHJ3RizXDVnnu0UFjoJL7X0OlKXj/SS3AAidbYaNvYFg=
X-Received: by 10.223.152.83 with SMTP id v77mr4272174wrb.233.1516926084664;
 Thu, 25 Jan 2018 16:21:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.155.199 with HTTP; Thu, 25 Jan 2018 16:21:24 -0800 (PST)
In-Reply-To: <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com>
References: <20180123001648.24260-1-isaachier@gmail.com> <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
 <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com> <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com>
From:   Isaac Hier <isaachier@gmail.com>
Date:   Thu, 25 Jan 2018 19:21:24 -0500
Message-ID: <CAG6xkCa_nKtzhJJq=v7gazWe+8FnN3mz1vDftzZw2WUFqJ1bzw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

I have been looking at the build generator, which looks promising, but
I have one concern. Assuming I can generate a CMakeLists.txt that
appropriately updates the library sources, etc. how do you suggest I
handle new portability macros? For example, assume someone adds a
macro HAVE_X to indicate the availability of some platform-specific
function x. In the current Makefile, a comment would be added to the
top indicating when HAVE_X or NO_X should be set, and that option
would toggle the HAVE_X C macro. But CMake can test for the
availability of x, which is one of the main motives for adding a CMake
build. The current build generator uses the output of make, so all it
would know is whether or not HAVE_X is defined on the platform that
ran the Makefile, but not the entire list of platform that git
supports.

Bottom line: should I add the portability tests as they are now,
without accounting for future portability macros? One good alternative
might be to suggest the authors of new portability macros include a
small sample C program to test it. That would allow me to easily patch
the CMake tests whenever that came up. In a best case scenario, a
practice could be established to write the test in a specific
directory with a certain name so that I could automatically update the
CMake tests from the build generator.

Thanks for the help,

Isaac

On Wed, Jan 24, 2018 at 4:00 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
> On 1/24/2018 2:59 PM, Isaac Hier wrote:
>>
>> Jeff, no worries, fair enough. I know https://github.com/grpc/grpc
>> uses a shared file to generate code for several build systems instead
>> of maintaining them individually. I plan on doing the work anyway just
>> because I have my own reasons to use CMake in Git (for packaging in
>> https://github.com/ruslo/hunter is my main motive here). Whether or
>> not it is maintained upstream is not a real concern for me at the
>> moment.
>
> [...]
>>
>> I'll see how the Windows build currently works and if that makes
>> sense, maybe I'll try using that build generator here too.
>>
>> Thanks for the feedback,
>>
>> Isaac
>
>
> Look at the "vcxproj:" target in config.mak.uname (in the GfW repo).
>
> Jeff
