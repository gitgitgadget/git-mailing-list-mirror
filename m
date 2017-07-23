Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F345203F3
	for <e@80x24.org>; Sun, 23 Jul 2017 08:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752345AbdGWIlS (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 04:41:18 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33393 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbdGWIkb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 04:40:31 -0400
Received: by mail-lf0-f49.google.com with SMTP id p2so19481906lfg.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tf7xaf910xTpCV3zS7a+28fePYrn8ajWT/J2ugEMJpw=;
        b=ntzuyWn4X5tnM1Up+IhrfeQQlVcWFMQ1Lq0aAK9GsfUPsBy8DvkzeZBQHMs18Pedyh
         eyM3pdlMyvr13yITTAJ9xTkabhf33sC6s0jWeUtj6t3KK0AA5tqsGdyC8QGmP942pvJd
         7A8TjAI1FYVTXIxeSOIAn3KstO7cAvkHxOtUDUHK7vIBJ4MDErkBdUAhEWP7m9u3c5Y8
         KtMRuxyxkrUd8E90Wsu5aAUej2A3Nz+bhnAf1W7Gq4AI+afgZhNM3A9TOkxFmC2nuO3h
         xt6MBcJsty/eaUI+gGN1BKP0tOzUk7c3iI2njBLQDzQOuqG8G84NZpB/t3bVJ8YcdaI/
         F67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tf7xaf910xTpCV3zS7a+28fePYrn8ajWT/J2ugEMJpw=;
        b=ILWpmCOTqCBFDML0oIJtf+BHF5VbI19rOrdM2/ucDj1vOF4W4h/wPHx/mvV9xN7Bjx
         Pau2jY2wUo8pNZ5Vu2g4EwntB0DFynxcXGJ4WCXJZe7cOCNirLoXiX5j3wScuAAEWFwt
         n8BpTv55LgEglivtObFjPCuu5TdcdLAbtF3K9WqVceL9Acr9n0viXbsH0xo76V2lv00s
         oPHTjbfgGDREb1h1RYGkIIu9lmCCjd82bwBzgHfg84GoTskvN2EXggAuhJbdHfzV4Vg7
         RkaswrFkdOCAwDhSQpYjPKRsq2SJjeqB0G5aDCZYGSFnK3amohwLmkOCw7vMYwN8N/Dh
         LzWg==
X-Gm-Message-State: AIVw1135kPIcvOEQ4YNfKAqiZjDVEEf4FvK0A5uxEVAOHdc20mlDvaJ6
        lx9usPXz4NQd1nqA73dKU+QjKk5tDw==
X-Received: by 10.46.88.6 with SMTP id m6mr3008584ljb.58.1500799229544; Sun,
 23 Jul 2017 01:40:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.74.18 with HTTP; Sun, 23 Jul 2017 01:40:08 -0700 (PDT)
In-Reply-To: <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru> <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 23 Jul 2017 01:40:08 -0700
Message-ID: <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
Subject: Re: git gc seems to break --symbolic-full-name
To:     Stas Sergeev <stsp@list.ru>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 21, 2017 at 12:03 PM, Stas Sergeev <stsp@list.ru> wrote:
> I wanted some kind of file to use it as a
> build dependency for the files that needs
> to be re-built when the head changes.
> This works very well besides git gc.
> What other method can be used as simply
> as that? git show-ref does not seem to be
> giving this.

There's no real way to do this, and even prior to 2007 when the file
always existed, there's no guarantee it's modification time is valid.

I'd suggest you have a phony rule which you always run, that checks
the ref, and sees if it's different from "last time" and then updates
a different file if that's the case. Then the build can depend on the
generated file, and you'd be able to figure it out.

What's the real goal for depending on when the ref changes?

Thanks,
Jake
