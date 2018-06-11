Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 151D31F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeFKQt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:49:28 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40548 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933497AbeFKQt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:49:27 -0400
Received: by mail-oi0-f68.google.com with SMTP id f79-v6so18492815oib.7
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7fGocxtnldWtKNJI9+CFousICzodqYVRe+CWikFe1s=;
        b=TClKMPf3ZgirW3u9FK7MtrDkXDOtGxXIj7ys04BHuj6Aehca1crqZy5FhfEEqilfGm
         PtR77BzMHiIj+7ABu7DE7ef+udSt2Xhsf3QNNT/5XxI3Bk/YiR+5hZRSm6FykLSN/yEM
         w/aSAWp8m5NidJTXbnVxURm1hUySapawLqoYtfCSRrOnpSMsxvFOSTiS/bXyWU343FXd
         u2/0X5uhDYyqV39eYaTesZdYRG0XSDktww2bjX2MBMPdmxrlOQZ22S/lJLac+qerDBCo
         LlsikbDXONY5tCr3ppzZ9jOpMRrj8eZWFH2aqvk2jvgUI/x3lAeP9oC0wtxKOUi6Hme6
         uzHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7fGocxtnldWtKNJI9+CFousICzodqYVRe+CWikFe1s=;
        b=dxEdaUXDaY/p2ZxJlhnfEUK/jleS5b+6NgPolNZbLPZJBcbARtLCrYaRLOanBLWfis
         yzm9Z2RjxtxmZfY1+wKrjM4Bv75DD+Dpmo8X0rjDyd5HUX4a+5/bCxL6JQww+QB40gC/
         3TVjpUxNv8f4hWvueyIf0aHxCfEDoN6Dqx7qGH0tiDt9AAZt01Y7gyHrhAaRZQFAbJ/g
         0Vwqb84p2Ga/Fm6NufbgmjoOOYq55EHJdlAEAcO8Z+S4puApWKq/Ux1Ch4CUoUpemufg
         F/Q+LPS7tV8JHtH0osOO+VU0dblC+q+MHvkVOtNlQ0cPI4WwSkLPikmKSaO4O9OcZFVP
         bphg==
X-Gm-Message-State: APt69E1MhqviRmzRGg33vHpzvZJCRUAJCmctCmZEQxZ9jmX4Mml9KBEz
        chcZo7dVGnkCDrFtHU0y3WRXg33wlKVGOQf0+Fc=
X-Google-Smtp-Source: ADUXVKIkaRFeIk/pugl+mgtl4Bo/rTfrjSAZF9mcpiuYPj47PgmNaK76mxiAwuLeWSIhZdJG/a0BoI0+oMI6CCHT+xc=
X-Received: by 2002:aca:ed53:: with SMTP id l80-v6mr9469477oih.281.1528735766744;
 Mon, 11 Jun 2018 09:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
 <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com>
 <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
 <CABPp-BHYm57n=ufg_SqmA-UnOEMivWJZytnPPSU3WSYNeEph0g@mail.gmail.com>
 <CACsJy8AOzwu+GJLTsGtN0dCnwxoRBQYpM6gzVebN++zjpXNu7w@mail.gmail.com> <CABPp-BES3XFmM16TTqRxnCkO=sbqkSuWf6gBsbLYya8MzogMgQ@mail.gmail.com>
In-Reply-To: <CABPp-BES3XFmM16TTqRxnCkO=sbqkSuWf6gBsbLYya8MzogMgQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Jun 2018 18:49:00 +0200
Message-ID: <CACsJy8A17oqM4wTQo8A=KMcStGQ=xdQuq8pORVGEezPZJxHuOA@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 6:44 PM Elijah Newren <newren@gmail.com> wrote:
> > What about merge-recursive.c? Given that this whole thing will take
> > many release cycles to finish, your work may get merged before mine
> > and I could do the conversion now (and resolve conflicts and resubmit
> > later). Of course if you like to keep merge-recursive.c the_index-free
> > now, I will not stop you ;-)
>
> I was just worried that since I was making changes in
> merge-recursive.c that it'd cause you conflict pain, so I offered to
> convert it.  If that pain doesn't bother you, feel free to do the
> conversion and we'll just work through the minor conflicts as we go.
> Besides, sounds like you've converted nearly all of git, so it may
> make sense to just keep it together in one big series.

OK let's just "quickly" get your series in then. I still have a few
files to go and a couple more places to look back and ponder. I'm in
no hurry to convert merge-recursive now :D
-- 
Duy
