Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FBF1F404
	for <e@80x24.org>; Mon, 19 Feb 2018 21:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753755AbeBSVkD (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Feb 2018 16:40:03 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:58254 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbeBSVkC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Feb 2018 16:40:02 -0500
Received: from homiemail-a5.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 6858D8E0FC
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 13:40:02 -0800 (PST)
Received: from homiemail-a5.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a5.g.dreamhost.com (Postfix) with ESMTP id CF865704071
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 13:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bit-booster.com; h=
        mime-version:in-reply-to:references:from:date:message-id:subject
        :to:cc:content-type; s=bit-booster.com; bh=17KrXlJdlapyYKwDj9jcu
        mIuydM=; b=aHVLxBCXyRnt82W3/1rccDxQvtEE+4fm0ud96gnXWYCvNr1CshU1U
        cR0M+IW+HL9aHqiQwWMdYo65eGgMS6Rf2/jspkcBSytIRKAcsSNa8OnH/3nZPIAu
        mbC9wqA7eZm3Fil8AMHWwMhKmTShrT6SmkEQzczxqTvOs+sTDXEB0E=
Received: from mail-lf0-f42.google.com (mail-lf0-f42.google.com [209.85.215.42])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sylvie@bit-booster.com)
        by homiemail-a5.g.dreamhost.com (Postfix) with ESMTPSA id 73E8170406F
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 13:40:01 -0800 (PST)
Received: by mail-lf0-f42.google.com with SMTP id v9so1383384lfa.11
        for <git@vger.kernel.org>; Mon, 19 Feb 2018 13:40:01 -0800 (PST)
X-Gm-Message-State: APf1xPDkaySVvBHgnkiulNy4ciEn5HXO048Jv2iAnjfQioKEUL3V/89T
        pD6xf9rKXzuqA3WKLVER/bguOBOw7xjsw83DfAk=
X-Google-Smtp-Source: AH8x2258dIPVQQsFvQk+7dSRSekSP/VWFAkNeBj8N5gN33Y/ttNlkjKvikpTvesOvfWBI0QW0XgHBNpJ1prlkgvJRQI=
X-Received: by 10.46.43.219 with SMTP id r88mr4375429ljr.26.1519076399662;
 Mon, 19 Feb 2018 13:39:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.242.5 with HTTP; Mon, 19 Feb 2018 13:39:59 -0800 (PST)
In-Reply-To: <87wozry7z4.fsf@javad.com>
References: <87wozry7z4.fsf@javad.com>
From:   "G. Sylvie Davies" <sylvie@bit-booster.com>
Date:   Mon, 19 Feb 2018 13:39:59 -0800
X-Gmail-Original-Message-ID: <CAAj3zPxiLxqgnKXth2EZZWwgYhW_cHEcxbM6_BqpzpHR_ipqyQ@mail.gmail.com>
Message-ID: <CAAj3zPxiLxqgnKXth2EZZWwgYhW_cHEcxbM6_BqpzpHR_ipqyQ@mail.gmail.com>
Subject: Re: cherry-pick '-m' curiosity
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 3:46 AM, Sergey Organov <sorganov@gmail.com> wrote:
> Hello,
>
> $ git help cherry-pick
>
> -m parent-number, --mainline parent-number
>            Usually you cannot cherry-pick a merge because you do not
>            know which side of the merge should be considered the
>            mainline.
>
> Isn't it always the case that "mainline" is the first parent, as that's
> how "git merge" happens to work?
>

First-parent will be whatever commit you were sitting on when you
typed "git merge".

If you're sitting on your branch and you type "git fetch; git merge
origin/master", then "mainline" will be 2nd parent.

Same happens if you type "git pull".

Further reading here:
https://developer.atlassian.com/blog/2016/04/stop-foxtrots-now/

"git revert -m" also has the same problem.


> Is, say, "-m 2" ever useful?
>
> --
> Sergey
