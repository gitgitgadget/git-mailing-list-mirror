Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E4901F403
	for <e@80x24.org>; Mon, 11 Jun 2018 16:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933776AbeFKQox (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 12:44:53 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35394 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933508AbeFKQow (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 12:44:52 -0400
Received: by mail-ua0-f194.google.com with SMTP id s13-v6so10532614uad.2
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N2tZRmQTApoZ1hwDM/PwCejxhW8I4FUh2kcFDFzemw4=;
        b=DPNpTltnNp+b+5S4T5e/BX0IXJXrv09pshJbDlc8c2Qumn3O78kjb9P3d+TPEYHPKa
         X8XEUpFegb2qYFQxzBoooW6sl9QtKSvXyaOAcFBUJ3bqXLLJtB22r/hrxTzNw28cHTme
         yG3uqnj/pX9jWiPEY6qIo5oUpvSKxWe2geTtJO7uuVumGkLrIpsBzKbp7bjHFsy4VIPC
         KqORH6e3JSK+UPYoLN/i8IT+YZOpjvsxB711uFr17/J370KOvOArFMrE7mGmJpu2/jCh
         /Z5MmsBTbPCzisV9TvPzmmg/ib4HEmzROrHqe61T/Fh35Vud6jLA9ciCYl/r5PVXSsZo
         F5CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N2tZRmQTApoZ1hwDM/PwCejxhW8I4FUh2kcFDFzemw4=;
        b=HsABdjFCMaqyCyf8gvZ/T+0FD32XPHhlAb2gtCTFqdifHZAwBkomhxnPfwsfw7AP+T
         hS4DMSn/eGLAOgJ7kNXYi9kDsD95JNw98azi8P6tBuvEEYtDE+3b0rcfQYDXy4m4q0sU
         G40NMaHs5jRxXe6CCik3GMEX3IgUj/GOdRKGB4lddcl0HPOC2VB8y93KpaPPpyWngaH9
         ru5BqGZwIz26GBXDZwlOTn1dw/YwHv1sTO0quEz2jFF1AzHh0J5iRMHYWpKOoJAKDlAW
         hCipDYqRVSpUZ2kw9BmkdbWbLpn4NjZ4kyHwgm06FAl/qFgwQUxTWzjrAvomjpyvVzzt
         8yBw==
X-Gm-Message-State: APt69E3lke4f199etmoRTkHxBg9JaxR8FLpxDbEFX2cTeeNx+LZRp4Vy
        UvEELj1dLljnngsNvwthAYowrGzTetl/CmtnR7o=
X-Google-Smtp-Source: ADUXVKLqJJX1Y45KBQ1FLMG10wkhb1yaNDs7Fw+51W3mWztPkzg6gikWzhGBR/C8QaYUuDiMQgEdSyvmKfzXC1huo68=
X-Received: by 2002:ab0:1723:: with SMTP id j35-v6mr11966897uaf.154.1528735491427;
 Mon, 11 Jun 2018 09:44:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 09:44:50
 -0700 (PDT)
In-Reply-To: <CACsJy8AOzwu+GJLTsGtN0dCnwxoRBQYpM6gzVebN++zjpXNu7w@mail.gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
 <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com>
 <CACsJy8Ba74iSPf4_zFxuV=_uNJgL6Z2QunOvAvi3qab-6EWi5g@mail.gmail.com>
 <CABPp-BHYm57n=ufg_SqmA-UnOEMivWJZytnPPSU3WSYNeEph0g@mail.gmail.com> <CACsJy8AOzwu+GJLTsGtN0dCnwxoRBQYpM6gzVebN++zjpXNu7w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Jun 2018 09:44:50 -0700
Message-ID: <CABPp-BES3XFmM16TTqRxnCkO=sbqkSuWf6gBsbLYya8MzogMgQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 11, 2018 at 9:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> I was just about to send you an email to ask if you were continuing on
>> with the series.  I need diff-lib.c converted in order to make the
>> changes Junio suggested to index_has_changes at
>> https://public-inbox.org/git/xmqqvaaz5jcv.fsf@gitster-ct.c.googlers.com/.
>> Since you're already working on that, I won't duplicate your effort.
>> Thanks for tackling all of this.  :-)
>
> I'm not sure if it's possible to cherry pick this patch to continue
> your work (because of dependencies between patches) but it's
> https://gitlab.com/pclouds/git/commits/really-kill-the-index, commit
> "merge.c: remove...".
>
> Or you just leave it to me, update has_index_changes() to always take
> 'struct index_state *' and just pass &the_index in all uninteresting
> places. (Or not update at all if it's really not needed for your work)

Actually, I'm thinking maybe I should just push that series forward
without changing index_has_changes() to take an istate (since it's not
actually important to that series yet), and then once your changes
land, then update the function appropriately.  (Or maybe your series
will update that function too.)

> What about merge-recursive.c? Given that this whole thing will take
> many release cycles to finish, your work may get merged before mine
> and I could do the conversion now (and resolve conflicts and resubmit
> later). Of course if you like to keep merge-recursive.c the_index-free
> now, I will not stop you ;-)

I was just worried that since I was making changes in
merge-recursive.c that it'd cause you conflict pain, so I offered to
convert it.  If that pain doesn't bother you, feel free to do the
conversion and we'll just work through the minor conflicts as we go.
Besides, sounds like you've converted nearly all of git, so it may
make sense to just keep it together in one big series.
