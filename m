Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35942042F
	for <e@80x24.org>; Thu, 17 Nov 2016 03:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754325AbcKQDVX (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 22:21:23 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:38906 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbcKQDVV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 22:21:21 -0500
Received: by mail-it0-f52.google.com with SMTP id j191so15472960ita.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2016 19:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XSpWz4qIVEWbpr9fFUmh47T2vWx3q4PpECEzBVNxF/Y=;
        b=lSGNiEclkUI10+f8VUxcDL4OeMLct7I5njaotgwQYyLFOugEzwFfL4g6O37LH7/6N/
         lr0OAVTj2kiY85ygK+mVCdcmUmdI52ybhXN+nxQTM9BlMgdYTlGejWpQy9Lv1QIB+DdZ
         0SfhBSyAVgQDcCTiSdqfZ9oO5OmclIrQxUjbESnFSR2MMxMp9Z3qB/yJfQXt2XlzZTmR
         EMU7maceOSWQUl5aPcn4EDns1/wMXfrNh+5MqKl7EonfvliIbAV5JqpF5cdNYCZvHtpA
         /e4GQPBkh3tECHN/0/DE2zRI882jcp+iybM7lBJxDJaWsiEKQuG2esFAZIvnZMS1s/nw
         GsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XSpWz4qIVEWbpr9fFUmh47T2vWx3q4PpECEzBVNxF/Y=;
        b=aGj+fUo25PJj8DapZFzO6/l50MZegXgAK1TRZo3Od8Qs3+IcMZ+LQk4ETcYwP6GddA
         HYKu5m/VMPYKzlHFniLCA2gDzSmaJ2DEWBhpq0OxQrmsEcjbcFSAuf24hWrmBkwyB820
         t0rW4b5L1WwME26R9Qn7PogWyH4nGEe/DBT+YVtLLMkFyLr98aElG1h40oMHunSoH3yA
         JiNfMOuWDUMMiOVn6fw0VCBP1o819mrz09dYSbAtl2a3HmTzU3ryLW5tCw4r3+xx7X+7
         a2UyNLVG3YnPW9dB3yYrUIrhKIww12EvbNL9l62WtysJYhz/3SfxynzqvzORGOX9fpEi
         JSZQ==
X-Gm-Message-State: ABUngvdDHRhkUPJoD+VlS8fPaWsYkryJ0yj8r5DEHaFe9XBjYQ5ykcY4/zvj/oWd0qVrtDzGUWKg6MVmw3Nrpw==
X-Received: by 10.36.78.196 with SMTP id r187mr1549532ita.1.1479352880059;
 Wed, 16 Nov 2016 19:21:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.164.219 with HTTP; Wed, 16 Nov 2016 19:21:19 -0800 (PST)
In-Reply-To: <20161117014522.lzk43sfmpl4ted3d@sigill.intra.peff.net>
References: <CAM+g_Nsiu_qqapB+FvwJCBfwEYLTPdHg4DueQWHq4XDNXMCgpQ@mail.gmail.com>
 <xmqq7f83ouqs.fsf@gitster.mtv.corp.google.com> <CAM+g_Ns-9Sj5r0V2XXZfGQz+0XiO1O-hT03japEGibkNgh8a4A@mail.gmail.com>
 <20161117014522.lzk43sfmpl4ted3d@sigill.intra.peff.net>
From:   Norbert Kiesel <nkiesel@gmail.com>
Date:   Wed, 16 Nov 2016 19:21:19 -0800
Message-ID: <CAM+g_Ns8bxry2j0X5=1k+WwQ0ZbHP=19jHRsDovC6GFGvYtBCQ@mail.gmail.com>
Subject: Re: Rebasing cascading topic trees
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

More things I learned!

So there are (at least) 2 possible approaches: using history, or using
local tracking branches.  The latter looks actually nicer to me, with
the exception that if asks for a `git pull`.  Using `git pull
--rebase` actually also ends up with the same tree, but I like the
rebase better.

The following 2 scripts show the 2 approaches.  Only difference is in
the creation of topic/b and the last rebase command.

# History
mkdir topic; cd topic
git init
date > a; git add a; git commit -m a
date > b; git add b; git commit -m b
git branch -b topic/a
git checkout -b topic1
date > c; git add c; git commit -m c
date > d; git add d; git commit -m d
git checkout -b topic2
date > e; git add e; git commit -m e
date > f; git add f; git commit -m f
git checkout master
date > g; git add g; git commit -m g
echo "before rebase"; git log --oneline --graph --all
git rebase master topic1
echo "after rebase of topic1"; git log --oneline --graph --all
git rebase --onto=topic1 topic1@{1} topic2
echo "after rebase of topic2"; git log --oneline --graph --all

# Tracking
mkdir topic; cd topic
git init
date > a; git add a; git commit -m a
date > b; git add b; git commit -m b
git branch -b topic/a
git checkout -b topic1
date > c; git add c; git commit -m c
date > d; git add d; git commit -m d
git checkout --track topic1 -b topic2
date > e; git add e; git commit -m e
date > f; git add f; git commit -m f
git checkout master
date > g; git add g; git commit -m g
echo "before rebase"; git log --oneline --graph --all
git rebase master topic1
echo "after rebase of topic1"; git log --oneline --graph --all
git rebase --onto=topic1 master topic2
echo "after rebase of topic2"; git log --oneline --graph --all

On Wed, Nov 16, 2016 at 5:45 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 16, 2016 at 04:12:20PM -0800, Norbert Kiesel wrote:
>
>> Yes, `git rebase --onto topic1 topic1@{1} topic2` is the answer!
>
> See also the `--fork-point` option, which (I think) should do this for
> you (and is the default if "topic1" is the configured upstream for
> topic2 and you just run "git rebase").
>
> -Peff
