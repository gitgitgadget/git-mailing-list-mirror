Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B836D1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 20:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfACUfh (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 15:35:37 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:51292 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbfACUfh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 15:35:37 -0500
Received: by mail-wm1-f51.google.com with SMTP id b11so30339867wmj.1
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 12:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sMAgv5xRjyJ/oPlPpB5TzGfuiNDOT8YkiY2NJSrsx+o=;
        b=gEWBQDuVXSR3XsGGXPUmQt8fY+oBPqE3Ea7Z5XIsq1F+E1LeS+8kUwjbot1Eu7qrqu
         Yqq641bcs7P+pUqEx36q/8OTSAI/VTov21/TprnpuL+T5B7v1T6ppm4+R0zHRnnbOlds
         4E0ZmQ2jENYmhIPlWFW6ERjlGu+GigSGBZnflvGeRddmWUZKX5YsQVurj+i0/gdXmKF5
         r/zr4TGId2JjxsYFXn17FDVX4Zcx/MSmb0iiYmMjDR2yusuOEvLk3E1qJkR0adnZJ3zX
         C1QOUYu+lLdhXyjIGudT4l6t/B/2EeYqzvvb5mL3Pqtyc/bKeYiUiSll1O3giV+eaqpH
         t2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMAgv5xRjyJ/oPlPpB5TzGfuiNDOT8YkiY2NJSrsx+o=;
        b=otLXZkwxDRk5LMdUxvACP1uKgESimX8zAnhDVqf6biYaTPpxJVUV7wPu4+ODwqGp5A
         MFUDte5HN+tGaaUg/4T96X1lPEHDg2Ljd0ZJtjCzt9N5apDXrPm+Ra/Fc/OCGDVCEBrW
         k52FLQNgu0l8oadEDziMt52x1W3sV24d0XJ4z65kCFFXjsRR6tREogzh+YsblnERowjg
         mUhWEqmBtUwzwl6C+K+m6VU9TLpUelU2EQYVICRwD/1PViAND2U/gUzLPDEpj3jEmd2i
         KZhA3W6xLAV5tFiyC2dGCQKeUo2WdZ2flXq7dGEA21L3KnJQJjs9Bw1laleTpkp2QNZC
         tKBQ==
X-Gm-Message-State: AA+aEWbFpKxHyWJkZF5/EBXv/9YXBHFiBni8tEgdIvoT9v3V6glr6SH2
        su5mUqRydllDrPIcRvG3qn22gdng8pL59kZi06h+fQ==
X-Google-Smtp-Source: ALg8bN6adisE44eFgY5cCrmxyWzcOEySkZYU84tFCpjeMZ2eZBluubKJ9ntFemtW4i3iDHuO9Wbjg3EGIIiLgYcK/lM=
X-Received: by 2002:a1c:8791:: with SMTP id j139mr37849333wmd.86.1546547735148;
 Thu, 03 Jan 2019 12:35:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
 <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
 <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
 <CACsJy8C=O=ZDvD0ReSJOyAsNDEb5Yz-iFvs7oV5zAXaFf-dw5g@mail.gmail.com> <xmqqef9th4iy.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef9th4iy.fsf@gitster-ct.c.googlers.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Thu, 3 Jan 2019 12:35:24 -0800
Message-ID: <CA+dzEB=+ROLVjp36SQjucouc8YUWTvYBrN4QyS5fsStMPtbw_w@mail.gmail.com>
Subject: Re: Regression `git checkout $rev -b branch` while in a
 `--no-checkout` clone does not check out files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 3, 2019 at 12:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> A "fix" to Ben's optimization for this particular case should be
> fairly straight-forward.  I think we have a special case in the
> checkout codepath for an initial checkout and disable "carry forward
> the fact that the user wanted all the paths removed", so it would be
> the matter of adding yet another condition (is_cache_unborn(), which
> is used to set topts.initial_checkout) to the large collection of
> conditions in skip_merge_working_tree().
>

I think it might be simpler than that even -- the optimization treats
the following as equivalent when the current checked out revision is
deadbeef (even if the index / worktree differ), when before they were
not:

- git checkout -b newbranch
- git checkout deadbeef -b newbranch

If a revision is specified on the commandline it should be checked out.

Anthony
