Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F10821F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 21:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389347AbfJ1V6w (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 17:58:52 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41330 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbfJ1V6v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 17:58:51 -0400
Received: by mail-oi1-f176.google.com with SMTP id g81so7258249oib.8
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 14:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0b6lXDLcD9AjU+cC7V/6mXvIJBkn27e4kRYsjVDaO0=;
        b=azexkeVsQe2oieEkjWMExNaZ0dmDWv5giHf+V9ZK3y82fD+HpY4sOb7ZIA7OJs6VEG
         1jIPWXT1oB0TBRhG+3K6fFRiJ+eckheQofo/LbjMkY5iouef76825Xwj1v3jp9P5/Pj3
         qvTKcrGEx0dXF0YgFny1Ufg820kSBe6AzasoEMUsC0qBv7prt81895dor+uls4/5Gtn0
         LL6RSAOk5vQgmJ3w4SDlCrxlS0fXPRiKuYdlNOZhbftqCNKARroYoQLAq1t4AgHDUHBi
         GgQdPNfaLpiH/wA3IKw2YjT6ZvyrV/KNPVOQIBoZOoytnhxFfQjjwfy//N/lo8REaUTe
         JdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0b6lXDLcD9AjU+cC7V/6mXvIJBkn27e4kRYsjVDaO0=;
        b=KpxWlOyTzh9u4UI9wc9HPV0jA+OS2wPVzZTInuiTtefC8kI2Fq+ee8RzlsHz5tlKZ2
         2MCFegFB06NVICr6E51+2HFoH28ehuh8rzj/lJJsXSPID3NkahhZo9s6Wo7sPdfnPFq+
         Uij81diFM6ewaOKHk+ylSAWlZW5m5vtc1Zr3zzLXEji8Wilqqh74TZYgeUGiIblgSu/v
         H7hifZ543v986SXMQX58d3yW34rNJdWmV9ZeWQVwx882pRZq5RIGzJJeL2KgHcD2Yeg/
         TnUql5UI8n5YA/3QP85NM480t6ZdXKzdApul66LAHkiUp/2Vh4LCDCW43PeetKlQ+9z1
         KJAg==
X-Gm-Message-State: APjAAAWOCvM5Su1fVOmJa7Mq7nSoHKCEsvFZHokjSI4TYkitzW3Q/by6
        HW4fJeblUhLyaULhlVXYtKcuWcOdkYkNbPd2PH2/4g==
X-Google-Smtp-Source: APXvYqybGGd0MMAadJ5BGKMJ2Po2J6T6oyTXhUFEtdQlHBo8aTt/oCJWAizye7aj9K2zyqt48rZhNcNeE68KilubLlY=
X-Received: by 2002:aca:dad6:: with SMTP id r205mr1230399oig.6.1572299930376;
 Mon, 28 Oct 2019 14:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAOc6etaQvNChdRZ70xsYQxqtgmZVxaKV9K7_zZeET3JuQ4HEXg@mail.gmail.com>
In-Reply-To: <CAOc6etaQvNChdRZ70xsYQxqtgmZVxaKV9K7_zZeET3JuQ4HEXg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 28 Oct 2019 14:58:39 -0700
Message-ID: <CABPp-BFWKJGiuRiE71yaLGfaOO3zobg4Hammyr37BZMghyXzgA@mail.gmail.com>
Subject: Re: conflict markers on recursive strategy with diff3 enabled
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Edmundo,

On Fri, Oct 25, 2019 at 12:19 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> Hi!
>
> I'm sitting down hunting for conflict examples and while looking
> through past conflicts in git I found one that has a format that I
> hadn't seen before. When merging the parents of 8b79343fc0 we get
> this:
>
> <<<<<<< HEAD
>
> /*
> * Unlink the .pack and associated extension files.
> * Does not unlink if 'force_delete' is false and the pack-file is
> * marked as ".keep".
> */
> extern void unlink_pack_path(const char *pack_name, int force_delete);
> ||||||| merged common ancestors
> >>>>>>>>> Temporary merge branch 2
> =======
> >>>>>>> 8b79343fc0^2
>
> That is with merge.conflictStyle set to diff3. What I would like to
> know is if the details about how the additional information that is
> not normally seen on a conflict has to be interpreted (to be read as
> "the part about the temporary branches"). I see some explanation about
> it in [1] but when checking inside "git help merge" all I see is that
> when you are using diff3 you will get the content of the parent but
> there's more stuff than just that. Is it documented somewhere?

The "||||||| merged common ancestors" section shows the content of the
merge base, which itself contained conflict markers.

The way the merge base can itself have conflict markers is as follows:
when you go to merge your two branches, git finds that there isn't a
unique merge base for doing the three-way merge.  You, in fact, have
more than one merge base.  And so, it first merges those (and if those
don't have a unique merge base, then their merge bases must first be
merged...and so on -- thus the name of "recursive" for the merge
algorithm).  When the algorithm runs into conflicts while merging the
merge bases, it simply accepts the version of the file with the
conflict markers as the correct resolution (because it has to pick
something, and that is unlikely to erroneously match the outer
contents on either side).

Thus when using diff3 conflict style, you can sometimes see nested
conflict markers.  And technically you can construct weird histories
where you have arbitrarily deeply nested conflict markers as well, but
it certainly isn't very common.


Hope that helps,
Elijah
