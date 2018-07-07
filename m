Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30EEB1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 06:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeGGGpG (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 02:45:06 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:41663 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751517AbeGGGpF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 02:45:05 -0400
Received: by mail-io0-f196.google.com with SMTP id q9-v6so12737887ioj.8
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 23:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oHnlfHbANhsM0ecAXaKJePy4CNPwW3Q5wKMoHZ/fiAY=;
        b=E4menwpw5qhGXoEeV5mtThDFK0bwWmAVxmM6JU/2Z0W4Xo4e2Df3Wp91AFG2CjRTXP
         btbaa+/0H9NrzdlJjQNmwlSRaFg5qC2fomWUspS0IZu1dkZvON89qOuIm0CUyCOKjXpS
         z9rbN4ukxHjtqfW9EBsBltLOLuI1Y97etOwQCVqVHX0xHt0xCMi/a7QM5q7jnhtlQVoZ
         xdqnWR4L4uMTnwaM+boIbgre9e1VFANhlm56OmqSB4B1dJzz6ZCQVeh6mLgCgr4dm6rE
         Ai2yg2p5MG2dRd+Sv2akKhObfSWBuD6iWtUinXbw5eRq05n3Pu0sIrOK9g2LN10TlvL9
         vdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oHnlfHbANhsM0ecAXaKJePy4CNPwW3Q5wKMoHZ/fiAY=;
        b=M4hsv0M3a6Ndj4pVGnFKuyb52YkV9U22I+wCl4IlkYJ8qc9wRgEs9CTUBhiKKBrQKM
         oOHms2XIGwNr1GVC/QiH5WSyU6MNuERy5undDihpfKPwM4wN4fUGWyDueEtgRpmXoK2M
         nzWFI57blIlVim7b7GMS2t++krri/m96ZTZyUT40bkaFRibBHxZwlOudCWyr8/yTzbg9
         Io+DSEEx1LIgTujhgPqQ9jJKxNzoMU/8Wu4KTLdwqMz5ItPGBUh8PmNYdeA/4dza3N4W
         bk5/91yRvaovpH5t5eO2FRyZfs2xVIqq2QUK+JkhzSwEO3Dv1SlvCGYHaOFo3JlUTi4V
         QAaA==
X-Gm-Message-State: APt69E0gXssZaSsEY52N9aCRaUVw56aXERYl2jBKvI9wunqkhOslu+wv
        iByqjRjAYvp0p6qZlQNZRbyPPJc5I4ac8DzzOT9zYGJo
X-Google-Smtp-Source: AAOMgpeeHzzHkwKEjPglaeF1vjC6sxPA6uY+7RLA6uMPK2CVAd462vBe2zKnELrjS9RDqO/YV47BCTdsKXflkWkQHfE=
X-Received: by 2002:a6b:5a08:: with SMTP id o8-v6mr10823553iob.5.1530945904467;
 Fri, 06 Jul 2018 23:45:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 23:45:03 -0700 (PDT)
In-Reply-To: <20180706120815.17851-5-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com>
 <20180706120815.17851-1-predatoramigo@gmail.com> <20180706120815.17851-5-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 7 Jul 2018 08:45:03 +0200
Message-ID: <CAP8UFD3_+0EDSzcrx9f70HBpWKvr94re5ZimuXDhfTZzJpfCvQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] builtin/rebase: support running "git rebase <upstream>"
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 6, 2018 at 2:08 PM, Pratik Karki <predatoramigo@gmail.com> wrote:

> +       switch (opts->type) {
> +       case REBASE_AM:
> +               backend = "git-rebase--am";
> +               backend_func = "git_rebase__am";
> +               break;
> +       case REBASE_INTERACTIVE:
> +               backend = "git-rebase--interactive";
> +               backend_func = "git_rebase__interactive";
> +               break;
> +       case REBASE_MERGE:
> +               backend = "git-rebase--merge";
> +               backend_func = "git_rebase__merge";
> +               break;
> +       case REBASE_PRESERVE_MERGES:
> +               backend = "git-rebase--preserve-merges";
> +               backend_func = "git_rebase__preserve_merges";
> +               break;
> +       default:
> +               BUG("Unhandled rebase type %d", opts->type);
> +               break;

Nit: I think the "break;" line could be removed as the BUG() should always exit.

A quick grep shows that there are other places where there is a
"break;" line after a BUG() though. Maybe one of the #leftoverbits
could be about removing those "break;" lines.

> +       }
