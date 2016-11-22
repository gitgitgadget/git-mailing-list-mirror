Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFB3B1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933777AbcKVRwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:52:23 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34762 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755677AbcKVRvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:51:44 -0500
Received: by mail-qt0-f177.google.com with SMTP id n6so17217977qtd.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 09:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7KfZLWLHyL8PknRsCTl73t/cyzYBoIVGzxPHpLOaQRc=;
        b=era/8hBUVaHV8p97Fye51wSdUrzXYydT547GguMC5NlQ3bujfohLRwFXOqIES+Bc2X
         aEiLJyKDDkeyjmBwi4KaW5pRuddHIhY2mzUlD6Qpt+PN9gMKe+N1F7VvYagejMmJenCi
         iphn0WGoXLe5yT096UHamzdWx609xEzjSm87QQADWtSbYYhNnnn0w26caQep4xSGeHHH
         QiLPbcp/J/G+p9IkLYZGn2AvAGoAG3kEX6glfLKVkgsjYtMH7JioPhPYdi/LG8x0v/ne
         oO7THsd4j7H+/bLJliMb2PixAnV5SIaOeEr06uA2V5Ujs+SszOkJtXRWdil7NTviZ8ae
         8zbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7KfZLWLHyL8PknRsCTl73t/cyzYBoIVGzxPHpLOaQRc=;
        b=JsyhzrR4BkgVry+lcegyWSlpTLHmsDa/5towxVus5Po/APbOLwTpnbWrQDeT+LzckL
         6mZFy/rzpL2Hz25ixwthG27k6gZY5gd2BtfK/LDLxPDNXHK2sJw21qqqBMcCehkSEajz
         bjpA2e06uM76L45rP7RPUh7dcJHJpTnlKbo6rMn15y+mmSPZkiMF+aGAZqae6jWax8xK
         RzBhPFdlY56oobjmd6/QTpww2x8vC926hXPpx6ycYniawvOSioJb6nXF4ngzbaGTzT06
         N0+30hODA7ezB4AnfeD9x8aDXAwuHEEz6dQrPymAfH/vZQCE4yIFdms/ur0ctQzGxKCh
         F3Cw==
X-Gm-Message-State: AKaTC03GUlFpJd6+kLsf2JqZy9nxooVnCB60xHDXReapfbkKmD8U4gW3IlPgBNzq1un7YEIB8kd3A3EBIZkfYQii
X-Received: by 10.200.58.65 with SMTP id w59mr12254367qte.54.1479837095695;
 Tue, 22 Nov 2016 09:51:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 22 Nov 2016 09:51:35 -0800 (PST)
In-Reply-To: <CAHd499AjXh1YnVgBj_8j0fgvOgOn53y+sPBBy6y7mSM-+dCyVw@mail.gmail.com>
References: <CAHd499AjXh1YnVgBj_8j0fgvOgOn53y+sPBBy6y7mSM-+dCyVw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Nov 2016 09:51:35 -0800
Message-ID: <CAGZ79kbJ1vM=wd+53RezKEuucBCG96rL7dNhZpqR6m+brRAJ=w@mail.gmail.com>
Subject: Re: v2.11 new diff heuristic?
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 6:42 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> The release notes mention a new heuristic for diff:
>
> * Output from "git diff" can be made easier to read by selecting
> which lines are common and which lines are added/deleted
> intelligently when the lines before and after the changed section
> are the same. A command line option is added to help with the
> experiment to find a good heuristics.
>
> However, it lacks information on exactly how to use this new feature.
> I dug into the git diff documentation here:
>
> https://git-scm.com/docs/git-diff
>
> It mentions a "--compaction-heuristic" option. Is this the new
> heuristic outlined by the release notes?

yes.

> Is the
> compaction heuristic compatible with the histogram diff algorithm?

yes as the compaction heuristic is applied after the actual diff is performed.

> Is
> there a config option to turn this on all the time? For that matter,
> is this something I can keep on all the time or is it only useful in
> certain situations?

I think you can set diff.compactionHeuristic and it will use it by default.

>
> There's still so much more about this feature I would like to know.

The background story (and what this new compaction heuristic is doing)
is found at https://github.com/mhagger/diff-slider-tools
