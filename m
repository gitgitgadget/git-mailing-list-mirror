Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027E41F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 19:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfDVTUn (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 15:20:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39453 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfDVTUn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 15:20:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id l7so11252314ljg.6
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=keYuI3r5cc05DWc0SjIM2KcntgXcqZRF7qgO6vMjorI=;
        b=JLOylV26Sy8W7SSTuMzzuf78a1UnNTCIo18W8xlhpg2kp7IXAJUOEHiH6YmW5KiLT3
         T12EiQTtg8QFWiDxwcFIFFQpQbyhwG/nXDcgSa42UD9QfGf1fPD07rPdzYCYCxFtJkK3
         qOH+GHz/D/C77pXw7v7X75oCSp3tTSb4nxEt2/lMTr0B+wSCaUrcJvWnuVLRYXl6J/Sb
         S1bE1PPlQApP4OT0VrSLAN+qPJNbpOAxyxtAyb3wpebabwAN5k7qTJNnjgmmp/68NZWM
         wnl1kwT/uw+o+rI+KK5yVwWWsWWBeK8b3tTG39V8Lx5N/M+uWa39i7Vr4IUNZSq3/Yxq
         ArWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=keYuI3r5cc05DWc0SjIM2KcntgXcqZRF7qgO6vMjorI=;
        b=oYGIKaVgbX6uyIQHr4slg77Yq0LSlx5MW32ROEoooYydFiynhrv5Jq3t2WsGJaN44m
         ptsg8KCWi/QzcVsWNZcw5aZMwweqJ/uoBh9GwM9yyTCZ5VFCsM8lFAivuYyXv+qU6WmX
         8xLGzNlDfysZBqs8z6gFPn+wfZc8tDv6Bxy2f+TgRfSswGdc8dhITD8/B+gxoyazJHTP
         CNAlJ3eJznzbRrefDkvFMUNmmKGcj2JVtveemYw0kZQhgfBbCj9VbHezWwnJfJkaBR53
         Qp2Jz6nnnX/ZVBFKCfTy+H3MEcwok4LSuCWpz9KmVgMLWjFCzCN4IUBpVrE2oBLplL4+
         hB8w==
X-Gm-Message-State: APjAAAVnkU6m4P8D0quwAWtPzP4ARUuvelYEaF9Aa9sN9gk/dKxraSfM
        mjXAS3smny0vS+/AIAf96f9cEwTfp07tAVp04k4=
X-Google-Smtp-Source: APXvYqzVqEDJWv+RVJAEbShF/mB8OdALrrGIIuHrlfvaa88ND7Jbqgsl16kGnXC/aGmBPhSZTTJ92Qa4it+MXcpqEvg=
X-Received: by 2002:a2e:9c51:: with SMTP id t17mr11181493ljj.104.1555960841143;
 Mon, 22 Apr 2019 12:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190422000712.13584-1-phil.hord@gmail.com> <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
 <623d6ebd-60c4-916d-6295-4c648dbf3932@gmail.com> <CABURp0r9DBxoxLjjynNj-px7mFBA5--ZS7SoNniNu7MLPZkqwg@mail.gmail.com>
In-Reply-To: <CABURp0r9DBxoxLjjynNj-px7mFBA5--ZS7SoNniNu7MLPZkqwg@mail.gmail.com>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Mon, 22 Apr 2019 12:20:29 -0700
Message-ID: <CABURp0pEB-3m=wbWsVc9C82d3Jf2UW4fXnsSZ+GnTHKWRJo0NQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 12:16 PM Phil Hord <phil.hord@gmail.com> wrote:
>
> I have the same need.  I plan to have some switch that invokes this
> "in-place rebase" behavior so that git can choose the upstream for me
> as `mergebase $sequence-edits`.  In fact, I want to make that the
> default for these switches, but that feels too surprising for the
> rebase command. I plan to progress like this:
>
>     # --in-place switch is not supported; manual upstream is given by user
>     git rebase --edit foo foo^
>
>      # --in-place switch is added; now we can say this
>      git rebase --edit foo --in-place

I originally CC'ed Denton on this thread because he recently added
--keep-base.  I initially hoped it would do something similar to
--in-place, but on reading the patch discussion, I think it's for
something different altogether.  :-\   It's similar, though, in the
same way that --fork-point is; which may be another way to say "not
very."
