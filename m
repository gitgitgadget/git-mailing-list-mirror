Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 765611F4DD
	for <e@80x24.org>; Mon, 28 Aug 2017 07:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750838AbdH1HQb (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 03:16:31 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:34743 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdH1HQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 03:16:30 -0400
Received: by mail-wm0-f43.google.com with SMTP id f13so10846032wme.1
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4BwZ/OJ4OWXR4o9tTSg8NffgjELfO96REEpnxLnOj10=;
        b=bqPgCpN0HVlPicA8FXFy1SJbsvQz8hdol0GyZu0JKsqp2u+5oT0Xc+updhZON8OEeZ
         E0nHuDuiBQmEi4YTs4z/XjtFiGiDlak+K0E3FQMDokrIhH83BWlgrSbYWnzj9rycshsM
         3Y04CAGebzQ/IbcsAsRjGHeYgO8paTe5Go4KrT4uWipV7O4C1pSvd9W5+E6Xg11veUrA
         HE7hOOiDjuxyGh8e+zjTmSyraZj/yCbacQbtT3dRScjFx8DHZZITX9zTlQ8v/LxnH9x9
         ZDxG4DFt/dPlDzNyh7sttfClrx1S0R97ihtAm3SLPIJo4WOqsTlMyvmHPUgEmJXNQFVa
         1wPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4BwZ/OJ4OWXR4o9tTSg8NffgjELfO96REEpnxLnOj10=;
        b=Qb8YKoK1st/cJ82ZA8Xuixf8AxZJOCLK6CT/8LmyOBQWIRgXIG98A5k90C5XhPb79J
         O9UNDVUycw/K3otwHB/RMz1KVVQhrqS9gmo8r0AznzQ3TKLUPlEkAUl2esHCV/V7ZCuv
         Kn1VKFCkMmp8rY1hvCivf+CqmlGlzbRJ9Ca2szpSpXpyHZ4Yxfe3+5MbBMoBPP0eIDlq
         SV0eOUYmDTQ41QaEQK+oDOEAwvrEM9LgdC8eZ0M5kRxnKiyazxTaz28EaOtiGCly4oS5
         kTbaBUSA5m0QVskk8jipDlSaPPfvfnkV9gEXSYU5e+WjXfFjH/4qGdrJFZauW6iKQh+1
         nzcA==
X-Gm-Message-State: AHYfb5h2dyR4rbro8F0R2R81DBa39m2I27OUIyiIjWNiX/I4Iiedlg0Z
        /YEl3/lmfzto2UEvVCOUwBwV3UIYiQ==
X-Received: by 10.80.167.161 with SMTP id i30mr5762408edc.18.1503904588748;
 Mon, 28 Aug 2017 00:16:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.179.111 with HTTP; Mon, 28 Aug 2017 00:16:08 -0700 (PDT)
In-Reply-To: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
References: <8AF4A868-628B-42AE-B75E-4DF19F7C7A89@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 28 Aug 2017 00:16:08 -0700
Message-ID: <CA+P7+xok0bpgc7CwHB+vcLpODhjAkjgHq=cGZhmP+EpRvwSJzg@mail.gmail.com>
Subject: Re: Automatically delete branches containing accepted patches?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 11:44 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,
>
> I have lots of git/git branches and once in a while some patches make it
> into git/git master. If this happens I would like to delete my branch
> with the patch automatically. That's not easily possible as the hashes
> on my branches are, of course, not the same as the hashes on git/git.
>
> How do you deal with this situation? Do you manually delete your
> branches or do you have some clever script to share?
>
> Thanks,
> Lars

You might be able to use patch-ids and git-cherry, to see if similar
patches (those with identical patch ids) are upstream. The patch id is
only calculated from the diff I believe, so it's mostly stable at
least as long as the contents didn't need to be changed to apply
upstream. It's not 100% perfect, but it might help with what you're
after?

Thanks,
Jake
