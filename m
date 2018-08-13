Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A394C1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 20:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbeHMXMh (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 19:12:37 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:36857 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMXMh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 19:12:37 -0400
Received: by mail-lf1-f49.google.com with SMTP id b22-v6so12197564lfa.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 13:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNr1Tvg85qyv4MguA/9hD4/LmsR9sWFVPdTqH0ppTVk=;
        b=H9AtKGggCpilEe+oL2RJ7WfNak2MEggV7LCLAiW1AqczbIm7tnOgxpoTbYqBnukm5o
         oUwfRzSth5WhBQVld3fmAGR6s/H+PLR2qeGriSL/djeozPri57hFFMtaSEEFawpfVAW9
         1Vt/jgSBWc4IxFz8o0p13YN1rRH/Pc9k68G9ARisAuiSYuJD+BITxU07KQ56QaalLoPl
         CnlNA1RkBwxrOmIbM/q3/9TnauGCQT+dmsu48t5cgDdvjayHAO82sT13F/onoiHnndQ9
         dqtt12yOdSE13MInLLvEBxyCs/RPxMqKqynIyePSRL7146Sm2gs1WsvE3fy6anYTTnhE
         153Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNr1Tvg85qyv4MguA/9hD4/LmsR9sWFVPdTqH0ppTVk=;
        b=uG0/RTGnYFe2MyofzkVV6hEkMvh4yB3ouBxI6hLFViXV9SyDXOAy0C61rBtzkXPSD4
         jz+F/h0XUII2ScuyUViGpza4n5UAu7Qr2bdOw17UryNDHCsf0m5anW13eq8HQUXmuDpl
         P2DV94FxzZenOA5PQ5LoJQCxCsPn8aqq6qucPU30pkRh/kyrk+GX5TUtLPZghEjMVzVl
         SXeTDZ3SNGQsPVsJBIy2ChrxFUG4A6a9/VZTgUSSgURY4Mg2wbed2IVH+2V08RA83ji5
         6HLBTbk3IAJcYimMm9hOQtebjakNT5zNzHRCjOLsbZ2/5cofKamQGoWzO8d1ouFTfAn9
         PGaQ==
X-Gm-Message-State: AOUpUlGBnzgtw4DmQz32obZX5ffdya1nF6qHhwiKzIPFX5NZDQtY/zzV
        Xu0IKAQly/SiOVyGtF8+96gFbxVyhUCI82nl3H4=
X-Google-Smtp-Source: AA+uWPzjjbuLbRE7YO4zxl+u6BoEd/VDzHiZ8Odk+ff9UOV+BTHQi8775cgMXHox/INVKRlQoiSm9rRXC0VmC9uKHLs=
X-Received: by 2002:a19:b2c7:: with SMTP id t68-v6mr12223197lfk.132.1534192128533;
 Mon, 13 Aug 2018 13:28:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180806152524.27516-1-newren@gmail.com> <20180807164905.3859-1-newren@gmail.com>
In-Reply-To: <20180807164905.3859-1-newren@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 13 Aug 2018 22:28:36 +0200
Message-ID: <CAM0VKjn6QAp-hQa3Qp07qZ2unNk20SXYoPwwFbpiLfqqx+KV+A@mail.gmail.com>
Subject: Re: [PATCHv3 0/5] Simple fixes to t7406
To:     Elijah Newren <newren@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 7, 2018 at 6:49 PM Elijah Newren <newren@gmail.com> wrote:

> Since folks like to notice other problems with t7406 while reading my
> patches, here's a challenge:
>
>   Find something *else* wrong with t7406 that neither I nor any of the
>   reviewers so far have caught that could be fixed.

Well, I'd hate to be that guy...  but since those who already
commented on previous rounds are not explicitly excluded from the
challenge, let's see.

- There are still a few command substitutions running git commands,
  where the exit status of that command is ignored; just look for the
  '[^=]$(' pattern in the test script.

  (Is not noticing those cases considered as "flubbing"?)

- The 'compare_head' helper function defined in this test script looks
  very similar to the generally available 'test_cmp_rev' function,
  which has the benefit to provide some visible output on failure
  (though, IMO, not a particularly useful output, because the diff of
  two OIDs is not very informative, but at least it's something as
  opposed to the silence of 'test $this = $that").

  Now, since 'compare_head' always compares the same two revisions,
  namely 'master' and HEAD, replacing 'compare_head' with an
  appropriate 'test_cmp_rev' call would result in repeating 'master'
  and 'HEAD' arguments all over the test script.  I'm not sure whether
  that's good or bad.  Anyway, I think that 'compare_head' could be
  turned into a wrapper around 'test_cmp_rev'.

>     - You get bonus points if that thing is in the context region for
>       one of my five patches.
>     - Extra bonus points if the thing needing fixing was on a line I
>       changed.
>     - You win outright if it's something big enough that I give up and
>       request to just have my series merged as-is and punt your
>       suggested fixes down the road to someone else.

Well, there's always the indentation of the commands run in subshells,
which doesn't conform to our coding style...

Gah, now you made me that guy ;)


>   (Note: If I flubbed something in v3, pointing it out doesn't count
>    as finding "something else", but do please still point it out.)
>
> :-)
