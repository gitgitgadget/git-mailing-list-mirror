Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9030200B9
	for <e@80x24.org>; Fri,  4 May 2018 16:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751476AbeEDQfC (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 12:35:02 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38310 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeEDQfB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 12:35:01 -0400
Received: by mail-vk0-f66.google.com with SMTP id 10-v6so13719615vkh.5
        for <git@vger.kernel.org>; Fri, 04 May 2018 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6xtA8AQWTWoxqEIsBe5x7SgywZPM6Uap7lJc0QPphnc=;
        b=mx88cb/53i/snFm74mYqMhHFNsPWp+YjYPjMdcNiGL9bCNkf78rmH2ZXAi4M9eDwZE
         vXofJXgMPafED1eWGWB8XRPWmC3xDyk03JsUAnyjq4nxF9LFAT0U83ZXYo1QVty5Pekz
         zAjC9b/M8to39BcESfuBPoGsD5oc6+oUcS3uqcQpmTIu6LJkeK4a4j22KTseocv4UmSM
         k/v0SYqrCS0vwBu3wN7IU4jr9sMMD6wBiyGTv57pNdIs2fjT/e+PbsU51Vuy9qisXxRB
         WXv8s10kqPJdl1gPFszKGIs0pjshwwxJT2RNrW5StlhKn7jqHMBzLoDQBNFW6sHg1W3+
         rZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6xtA8AQWTWoxqEIsBe5x7SgywZPM6Uap7lJc0QPphnc=;
        b=IY5NIpLED9XuFJVtgvI8SDPZj0GNlfyYiWalNh5uJMGtFW6JuapkIlgNU57JVyV01Z
         V8voycZdZvAXRz0py5iPwrP6CeNwEuzBW8LxAFjFpHJfi5dwK2XQ6WkDJieWDApjUjql
         jcOevgi0deiVK/zJb6KTPR6q9ID3OlI2yjb6KCESwkoFkkggZXh+hcMB9qQ+eCjkieqa
         x0Bdqrq/UDzYOxKuABV2XOPh4WfrGb/w37dqOCkX4ninzi1+Sx4bNxkZIYDOdERRlAZM
         lAFmWXZd1UugZWmeaGJPErGvGJLt+M9s3RmuAYVcixiOeVy9oyLHwN53a5PppjD0woTE
         pVmA==
X-Gm-Message-State: ALQs6tBqXa550pQVPTYNvkjm/O/FqvpkEICkEynm3gzoURoWa0Gpupp9
        8kVb0V4b6A5xyETY/zIwW5RzF0Yce04rQqf+WtM=
X-Google-Smtp-Source: AB8JxZo6vqhZDKn4J1xP4kXvCtKbGFEEUFM48Icfh1jrE8KURgJHzJtptC5UPJD2LyrmUpnh0VM+jg0q2P0COH8iefM=
X-Received: by 2002:a1f:c155:: with SMTP id r82-v6mr24638504vkf.76.1525451700334;
 Fri, 04 May 2018 09:35:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 4 May 2018 09:34:59 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <71b00bbf-07e7-11e1-046b-f0241b82ebd3@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1805032224150.77@tvgsbejvaqbjf.bet> <850f1ad6-752d-85ae-ebad-feae09a76c54@ramsayjones.plus.com>
 <nycvar.QRO.7.76.6.1805040829390.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 May 2018 09:34:59 -0700
Message-ID: <CABPp-BERh1FGzEJSu+6Z0aGC3dJxx+P=9xwdCCsPgnG8jWvQMg@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 11:40 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> I actually have a hacky script to fixup commits in a patch series. It lets
> me stage part of the current changes, then figures out which of the
> commits' changes overlap with the staged changed. If there is only one
> commit, it automatically commits with --fixup, otherwise it lets me choose
> which one I want to fixup (giving me the list of candidates).

Ooh, interesting.  Are you willing to share said hacky script by chance?

(And as a total aside, I found your apply-from-public-inbox.sh script
and really like it.  Thanks for making it public.)
