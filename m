Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E28FD1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 15:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbeKFAyj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 19:54:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:34333 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeKFAyj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 19:54:39 -0500
Received: by mail-it1-f195.google.com with SMTP id t189-v6so7999728itf.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 07:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GNEUbV5KT3wKN23f/5hTAywEptXBDw8vzlKw/LerBdQ=;
        b=htvM1bfCAnHMltFbDpFS0weSBzhLvH7+flpWUw5AM0DzGHmoyOcxVTyzSWaZ4kv5r5
         WdRF1yf+t6IM7B2FgB/0zls8+pWvMOCmkNJLI4To8bBMVdnA3Jua1caUNH9aSXrUKbzw
         LrsV/Y2xeCOT9nIDIgH+L2HSKwAY1d71C0KAFivPZf61SU9rsfLmGsvGNSS2MBWkOSKj
         MTvEXvX50+TI95cbqirXP/yX+k3JHnbUWBahd9ihsNB0f90KbywrDLu/u0HsuhBisEqT
         v6MEqgi1FPPxPV3o9MZW4mm1LNajWiyqiNCjOaxmS2PiXwKa0RAFl4rJMdJpxAPEWpep
         fL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GNEUbV5KT3wKN23f/5hTAywEptXBDw8vzlKw/LerBdQ=;
        b=hXYPQ0LhVFVb43936Y4U2A7RhalFjM6kO5fH4nspUwnP/n0r5t4N3bK3TRI3MD8Fm/
         VWiZQ8Cb91OQ1peezOGtlniNB1rPciLw8xqVeMUXQSXvGm8VIn7V4IMsqc8r8QPzSBoG
         plHoEaIT5gkBvfX1B4iYIXWSgXJ4cAjTn7Og4JjOHdJ04WUeDkNgNi4zDv158II+MrLY
         c7FjedztwJh5H7C1O3DlmON81R2EEnB4qACRgXzJV14DHGS20S5VCK1JEld1ETf5QVwF
         hWVI6KD+ma0NI7BGRS4ZXSgafgVYIzn29VsXoCqFlncSf6qvGkYI+UJcMB8ZC9MEk4DI
         wdTw==
X-Gm-Message-State: AGRZ1gKD8aftnDloA9EyymdmS648TwJ7+Aorjs3v5RgyaVspIkGgbChF
        T5fzcKxW4uAovPsnkso2SG5gY4F/7VJgcLGqjC9uyw==
X-Google-Smtp-Source: AJdET5dlOU72rY9FPHNgk99trDV0safTe5AjYFLaYumNFpVteD/U0I1WCgbps+xXXaqcex5M2iYupZNTersbHkR8P5A=
X-Received: by 2002:a02:5748:: with SMTP id u69-v6mr20187107jaa.30.1541432063176;
 Mon, 05 Nov 2018 07:34:23 -0800 (PST)
MIME-Version: 1.0
References: <6afef19d-08f6-9cce-a491-3a49808c57ec@urlichs.de>
 <xmqqk1lsl448.fsf@gitster-ct.c.googlers.com> <fdedc47b-8661-9451-b4ef-12ec6bd13c04@urlichs.de>
 <20181105065136.GN25864@sigill.intra.peff.net>
In-Reply-To: <20181105065136.GN25864@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 16:33:54 +0100
Message-ID: <CACsJy8CAL37btX12ASXtzyQeD91nwz8q-hyQtgr4+Xf6iYcdbA@mail.gmail.com>
Subject: Re: "git checkout" safety feature
To:     Jeff King <peff@peff.net>
Cc:     Matthias Urlichs <matthias@urlichs.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 5, 2018 at 7:53 AM Jeff King <peff@peff.net> wrote:
>
> On Mon, Nov 05, 2018 at 07:24:42AM +0100, Matthias Urlichs wrote:
>
> > Hi,
> > > "git checkout <commit> <pathspec>" is a feature to overwrite local
> > > changes.  It is what you use when you make a mess editing the files
> > > and want to go back to a known state.  Why should that feature be
> > > destroyed?
> >
> > Not destroyed, but optionally made finger-fumble-save =E2=80=93 like "a=
lias rm
> > rm -i".
>
> There are a couple of destructive commands left in Git (e.g., this one,
> and "git reset --hard" is another). I didn't dig up archive references,
> but the topic of safety valves has come up many times over the years.
> The discussion usually ends with the notion that instead of warning
> that the operation is destructive (because that gets annoying when its
> purpose is to be destructive), we should make it possible to undo a
> mistake.
>
> So in this case, that would mean saving the working tree file to a blob
> before we obliterate it.
>
> See similar discussion in:
>
>   https://public-inbox.org/git/CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQ=
ypn3oBxkw@mail.gmail.com/
>
> for example.

That work is still ongoing (slowly). I realized that reflog code was
buried deep in files-backend.c and would not make sense to reuse in
its current form. So I had to move the code to a common place, which
adds more work. But it will be coming! Hopefully before 2020 at my
usual development speed.

While we're at it, I've been running something with that "index
reflog" (no pruning) for a month with lots of "add -p" and the file
size is just 163KB, so the reflog format seems promising for this
purpose.
--=20
Duy
