Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE64C1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfF0NsV (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:48:21 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43408 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfF0NsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:48:21 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so4818042ios.10
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghVFVV3gKAUM44v8Pi0E13qNcWbz//w1zgt+ybJj74A=;
        b=pScN1B7It02gYZfJSnipvN/DVczdPoPy7cLylb7TmIwZc1P70NDBqOfPz4ZIIdevVn
         o43RxvHqqwvHs2geiU5r0yWeKOoHAHvLTqdI25LOgCXj6tJhmc32CFbN2BdQJNmz/dC7
         1MdXUazRCQxNWzfSvk0/gXQfZMjFLeB480nttc0V4vTtO2DFdH8LnbOjNJAHf9eL7AyW
         DC4xnAyt397031YeKqfhP/4S+n/Uu1YCLYPXUe4DJtMjkUxYliV/0rhxecLsboFwYmLN
         O6+Ws9lSAcFFk6zdDkCoCfBgY8p0thCdrkV4AW3IeEYs6rvON6M9KEUkbxLOWoWI3Mlc
         f1wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghVFVV3gKAUM44v8Pi0E13qNcWbz//w1zgt+ybJj74A=;
        b=e2wfrv4jVg61ZHQ1Urig7qp6GjSnQIVCzCzbJxAcWFm/WAanpYShZiNxkhTDowjdFh
         3RN6ugED5n2J8K9pS9SEBGjGYcEOOBP/ST3vb5xy1zDW294DlmM8DJd+BSxTjqjUtmhC
         gMJFlda0A43bG2y1cY8wqCtQkrm5hTmXVikUTzPEU5k6L571tMJfp5/4InudDhbrEhNC
         yGCrXPLxAKBGLDirndWKp6a+LHA7GdK3eQFd2xfN/7FMmD82gz5wbLPS446YnpzQpqe/
         dCMI31OnZN5TNZUT/75B0+2YMCUmlVwgyUMTUJOlJUU6cqm6j+GS+UPfEP1AN1lHoxjj
         Gq4w==
X-Gm-Message-State: APjAAAWuzNLrUiREvTHtJVcNtvYNzaho/5yft79qq62Te2aIVDF0BOD8
        9BMUZLPQV7uk1vfrYeMifsBVuc0Dt5hEvrVOqDT4NA==
X-Google-Smtp-Source: APXvYqzRcr3bUIAeyGXTwfRIjmWTVdcjWjghGGeDobZBF6k/cTKFwKNwbRuWxYKjm76jlC9IxCiO0Ho7aufmKutnBLo=
X-Received: by 2002:a02:cc8e:: with SMTP id s14mr5011829jap.142.1561643300570;
 Thu, 27 Jun 2019 06:48:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-6-pclouds@gmail.com>
 <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com> <CACsJy8BjhQD-g69dr-yDCycgfrHZ8xJLgjD=LanRUBxAN6=Zrg@mail.gmail.com>
 <98afb501-ef57-9b64-7ffb-f13cea6fd58a@gmail.com> <CACsJy8CwWvKNbYvDqWc-zCwEPc_rz-P4y-SvXV-9jL8_XCFjZQ@mail.gmail.com>
 <93562f66-07a7-d074-e225-65afd7ced1d4@jeffhostetler.com> <f4f82ab4-2846-34f9-45ee-a2149fb15d17@gmail.com>
In-Reply-To: <f4f82ab4-2846-34f9-45ee-a2149fb15d17@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 27 Jun 2019 20:47:54 +0700
Message-ID: <CACsJy8BeUOv+He5c58iGO47XDkoKkAGQZqH0NM1fZcb2ESFscQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 8:42 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/27/2019 9:24 AM, Jeff Hostetler wrote:
> > On 6/27/2019 6:48 AM, Duy Nguyen wrote:
> >> On Tue, Jun 25, 2019 at 7:40 PM Derrick Stolee <stolee@gmail.com> wrote:
> >>>
> >>> On 6/25/2019 6:29 AM, Duy Nguyen wrote:
> >>>> On Tue, Jun 25, 2019 at 3:06 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
> >>>>> I'm curious how big these EWAHs will be in practice and
> >>>>> how useful an array of integers will be (especially as the
> >>>>> pretty format will be one integer per line).  Perhaps it
> >>>>> would helpful to have an extended example in one of the
> >>>>> tests.
> >>>>
> >>>> It's one integer per updated entry. So if you have a giant index and
> >>>> updated every single one of them, the EWAH bitmap contains that many
> >>>> integers.
> >>>>
> >>>> If it was easy to just merge these bitmaps back to the entry (e.g. in
> >>>> this example, add "replaced": true to entry zero) I would have done
> >>>> it. But we dump as we stream and it's already too late to do it.
> >>>>
> >>>>> Would it be better to have the caller of ewah_each_bit()
> >>>>> build a hex or bit string in a strbuf and then write it
> >>>>> as a single string?
> >>>>
> >>>> I don't think the current EWAH representation is easy to read in the
> >>>> first place. You'll probably have to run through some script to update
> >>>> the main entries part and will have a much better view, but that's
> >>>> pretty quick. If it's for scripts, then it's probably best to keep as
> >>>> an array of integers, not a string. Less post processing.
> >>>
> >>> I don't think the intent is to dump the EWAH directly, but instead to
> >>> dump a string of the uncompressed bitmap. Something like:
> >>>
> >>>          "delete_bitmap" : "01101101101"
> >>>
> >>> instead of
> >>>
> >>>          "delete_bitmap" : [ 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1 ]
> >>
> >> I get this part. But the numbers in the array were the position of the
> >> set bits. It's not showing just the actual bit map.
> >>
> >> The same bitmap would be currently displayed as
> >>
> >>   "delete_bitmap": [ 1, 2, 4, 5, 7, 8, 9, 11 ]
> >>
> >> And that maps back to the entry[1], entry[2], entry[4]... in the index
> >> being deleted from the base index. So displaying as a real bit map
> >> actually adds more work for both the reader and the tool because you
> >> have to calculate the position either way. And it gets harder if the
> >> bit you're intereted in is on the far right.
> >
> >
> > Thanks for the clarification.  That helps.
>
> Same here! We expect these to be much smaller than the full set, correct?

For split-index, the number of 1 bits should be about the size of your
working set, not the index size. In the normal case, then yes it
should be much smaller. After a big merge or branch switch, it could
get as big as the index. But I would hope the logic to re-split the
index kicks in, which essentially empties these bitmaps.

EWAH bitmap is also used in UNTR extension if I remember correctly.
Those bitmaps may have as many bits as the directories you have in the
index.

> Thanks,
> -Stolee
>


-- 
Duy
