Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618D51F461
	for <e@80x24.org>; Mon, 13 May 2019 16:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730704AbfEMQlT (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:41:19 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:45224 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfEMQlT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:41:19 -0400
Received: by mail-ua1-f67.google.com with SMTP id n7so5048609uap.12
        for <git@vger.kernel.org>; Mon, 13 May 2019 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nNaM1RHe/iBSBhxQJ/AXQC63pbNkolGuRzQiEwRn8qE=;
        b=ffUnfArTRZcRqcznRHl6oUR1YAeZ1qLbcLKkkLZBn55Pv54Wk/+i4kb2/mv7kDlQYR
         SGDxdNLknGgkTSeDxHHp7tY4lBCuAuJwNj9rcwLxbRR38PZNXEUUprvgCclqND/Ya+UJ
         SEmd/hejz7AtodA4fZnCdXpUAOEzR5iIOpK22uXrWa33jH6nzrOPxNct0tLamA/AqC4+
         1t6Lxz3SqGAHSKSHbCVobD7r/QKFfVsIy4fidTg/nKroqwVyvy7XrjgsYj6AcMDmlt4I
         yaEmVJ3Hz+x2AEYmDurLoO0f1KGCqHXvGZpP/lo03XYZ7ITEUEmJ5uW/zj3pUQKPTadr
         65TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nNaM1RHe/iBSBhxQJ/AXQC63pbNkolGuRzQiEwRn8qE=;
        b=J6TAgJOHKqjbwyCgqjuX16a3RJz60OQrD8cjK++MESv1Jf2V7Xl04S51pQGJMQj4AF
         pkld6DS/6s4VYN7VNrVj3//K3cRA+k3yOjCCps5gDu8WAsyPFxkKBp5UUeNDj/pzyzmf
         6GrDxjmsw6vOZVZjox8Vvd7agmnJM7+FhbaxDl1scvPKQe8zuZC5JCt9jNuYkjz7P9OE
         GMmgXiNWlI1vhZAveGdY8Kog8Hkjr66G2a0at1vpyg5JAWcqUPfSp4oVegZb5Y9VTtmM
         jLPzMiAFpCcEfFWmGg7T6B5bPaB3BKV2YS9frSlwX/nzLDw2933gNXoKb2uKXuesXQLw
         ASWg==
X-Gm-Message-State: APjAAAW0fyuRZNxuOGvzX4vm4t0UAfRQXAolstbZXMCyuY+NRF0Uzeip
        nGRrxbBWHjEMrR6gKfZ33kcvoH+8jQ/NWOXXNmE=
X-Google-Smtp-Source: APXvYqzkqn24K/tvXYvHrBtAxbx2byycUrcTVUmvp8UN0FScRkohTmurbnLjX4r6t56odSgraSvxK5ysy/fvMutqm+8=
X-Received: by 2002:ab0:1410:: with SMTP id b16mr13153658uae.1.1557765678059;
 Mon, 13 May 2019 09:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190430182523.3339-1-newren@gmail.com> <20190510205335.19968-1-newren@gmail.com>
 <20190510205335.19968-6-newren@gmail.com> <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
 <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com> <nycvar.QRO.7.76.6.1905131219490.44@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1905131219490.44@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 May 2019 09:41:06 -0700
Message-ID: <CABPp-BHfqgWVvf67JkPvE=hgzhZ1Jzy=D+vTc=v2j9+hgJzs9A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 3:23 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Sat, 11 May 2019, Elijah Newren wrote:
>
> > [...] the craziness is based on how Windows behaves; it seems insane to
> > me that Windows decides to munge user data (in the form of the command
> > line provided), so much so that it makes me wonder if I really
> > understood Hannes' and Dscho's explanations of what it is doing.
>
> It is not the user data that is munged by *Windows*, but by *Git for
> Windows*. The user data on Windows is encoded in UTF-16 (or some slight
> variant thereof). Git *cannot* handle UTF-16. Git's test suite *cannot*
> handle UTF-16. So we convert. That's all there is to it.

Ooh, it's Git for Windows doing the conversion?  That means I can test
for the expected bytes with printf and grep, I only need to feed
special bytes to git via file instead of command line.  That's better.
:-)

> Ciao,
> Dscho
>
> P.S.: Of course it is not *all* there is to it. There is also a current
> code page which depends on the current user's current locale. We can
> definitely not rely on that, as Git has no idea about this and would quite
> positively produce incorrect output because of it. So we really just use
> the `*W()` functions of the Win32 API (i.e. the ones accepting wide
> Unicode characters and strings, i.e. UTF-16). I don't think we can do
> better than that.

Going off on a tangent for a minute...okay, so you need to do some
kind of conversion for Windows, but why is it automatically UTF-8 ->
UTF-16?  In particular, if i18n.commitencoding configuration option is
set (to something other than UTF-8), then couldn't you instead convert
the commit message specified on the command line from $(git config
i18n.commitencoding) to UTF-16?  Or, perhaps convert from $(git config
i18n.commitencoding) to UTF-8 before the automatic UTF-8 -> UTF-16
conversion?  It doesn't matter for this series anymore since I've
worked around it (by passing the bytes via an external file as
suggested by Hannes), but it seems like Git For Windows might be able
to still do better here.  Or maybe I'm still not understanding the
full picture.  Anyway, thanks for all the explanations and the help
getting this fixed up.

Elijah
