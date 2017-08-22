Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C5E1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 20:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbdHVUIy (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 16:08:54 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:38252 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbdHVUIx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 16:08:53 -0400
Received: by mail-it0-f45.google.com with SMTP id x187so1002075ite.1
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=g2+rM5V80dL6P/Trj/Oa4bgVdEXoO7SX66WUTtMjPlc=;
        b=pkgV+ZclLXU4SIf+NHMdkAWb4K5Zeq1h5Yeax9aTURRk/9A8rH26rfQm/MupbsKxN9
         n1OywIUzMOSgd2UZDqH2XztUqPvnOFQ/rVO4EwSRH0SDV9wgMSYt0fAVPL2ArSv1+YjF
         d6OAeOzWOH+1wOuebetTahMeJCg7BvDyRh+rFQjDbEHPnbT7dVfTncvAQNCoQExmfbKK
         ySwhbRbY24Y2yTgs9E5JKq1fptMWXgAO+q7ij6BH34PpIicVXwpXgjuXVXIZtex2wdBE
         a9f2tyqheYzlGzRUi95OyLMhGw9CLkGoZJ0hIwZ0O/aurLqkaeCWelZSq01pzU3FepdT
         dOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=g2+rM5V80dL6P/Trj/Oa4bgVdEXoO7SX66WUTtMjPlc=;
        b=FkSG2LE6QJ232gp/PC5BPRQoP14t5gfGywd6EHwvrDxMS+ljF+2NyavY66DHy2/AWf
         i0ouYsJVIxVSU4vSpphEJklgM1VznVGVe9rkE7lUmbln7cmBbwsPJdRIHdHo4rCx/GwS
         aGRd/QvLI7jYy+FfOS02lQHkfTsTw/Y6fFjQDcLMxs6Q3fJWa9yHM7KXcyAjkQh+90B0
         OUYut+0TNRUiSsfAzO2tbWXaBeEzZ/81P4EzIHifAiWVfOVO4Ii5rgPcjJBN1mHNNXAl
         hG90EG3E/uPMvVBqYHxAn2flojl+n21Am52S8M6sIyStpwxLuLeeSVS5u9lgkV3KUk4y
         tjfg==
X-Gm-Message-State: AHYfb5j65hesn9/iL0fW1N7R51JslAYMtYk8hvfbcbwtBM/2RnLCSJE1
        RswDs3BU8cXf3Bud0fLIMsjRd1TwvQ==
X-Received: by 10.36.6.148 with SMTP id 142mr898765itv.173.1503432532844; Tue,
 22 Aug 2017 13:08:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.23 with HTTP; Tue, 22 Aug 2017 13:08:52 -0700 (PDT)
In-Reply-To: <xmqqfucj2y7d.fsf@gitster.mtv.corp.google.com>
References: <onhres$g9$1@blaine.gmane.org> <xmqqfucj2y7d.fsf@gitster.mtv.corp.google.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Tue, 22 Aug 2017 22:08:52 +0200
Message-ID: <CAHGBnuPpJtdTBPapFrKcEg6QknBkMjFzwmF0cx9S_2Uo+vp2HA@mail.gmail.com>
Subject: Re: Best way to check whether working tree matches a commit's tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2017 at 9:34 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> While this works, it feels sub-optimal. Is there a better / smarter way?
>
> I do not think so; you want three things to match and you have a way
> to compare two things at a time.

Right. I was just thinking if there's a lesser known command like "git
diff --no-index", but instead of taking two paths, take just one path
and a commit.

> By the way, I think your second check should compare
>
>         rev-parse HEAD^{tree} $that_commit^{tree}
>
> as you are checking if the tree exactly matches.

In fact, I was considering to use "git diff HEAD $that_commit" as I
don't really care whether the SHA1s are equal, but just about the file
contents / tree.

-- 
Sebastian Schuberth
