Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3779B1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 08:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753247AbeF1IC4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 04:02:56 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53265 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752680AbeF1ICy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 04:02:54 -0400
Received: by mail-it0-f65.google.com with SMTP id a195-v6so11393245itd.3
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 01:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NlyoANOSacXWCTNYgF6B0YacawqAG3IPRhffIrd3gXU=;
        b=EgMVtMuMrvS/1OjrJllT+mXJKO+E4RVDPWtSMeMf45BedrfgyoDk7Sh20rVKyxFjZD
         tFcYk7hHAqPIzD75n/gdBfZylu49L6E1+JeWWJfPCQPGPyAHysB/wOcfzqzItdzvWGN5
         QV9dm9pbLE/Kq1lyjtcVVpzHTYXBCcJeVTH1IeZeJXhUmy31lDrGdIHshHBhbyocOCEZ
         +HJ8GC4gqMSPaJjXoNhy8JcUJhu1RWOzGK0nf1IZs9AMamyNqHDWHBapTGWMNEp4mElc
         2+uzhzUT8EKtWZjVfEC79rcz+XfdT0itFCBr1dQWDG/cqkY4pwejGdIjR5J01PSQQHSk
         XxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NlyoANOSacXWCTNYgF6B0YacawqAG3IPRhffIrd3gXU=;
        b=NG6Po9MBe7jUJf1F/GmVIZDbxNxs7WJvhdVO/CL+gbwGg3rrIwH8TjjubGaT2AJjSV
         1oyFKOETE9UcTxZ9P7/CXbpD4g83idwda2x1CBNI0A981W4AqbxMiPATq8BmDmVtjebG
         QgfnvOJ65yu+f+PEbIX1B6hs/SLPm8ZzACAzkUp1jINW7HxYLAFHTFaJuLkllEv9M0lQ
         6Z78hVTr4k5dmBd0hybNrZvweujXwn1g624n+dG6vjrde2IcHHlbYZZWLicyoXPpeT+k
         jrV/Q4YXGbb+YfrGInlNkpTO1SfUgRKtn/FzIEw+e3i4h1B7+04fr1xmz5uGpNmLdWzX
         xeSQ==
X-Gm-Message-State: APt69E325ayV/zZF4S2FMb1BuOdiGc2iQPS0Ljv156CoyWHe0MgRXprN
        p8IhpL8yvzdDKTi8xpHg3UlsVBuK5geumh6QA/E=
X-Google-Smtp-Source: AAOMgpfKsV0P1hWmKES1xLvEaLZLv2QxIPPD/Xciczh2iFsJU0Dc5N9kcEvpntVwTXPloFvW42CmNLT5+MEanZTD54I=
X-Received: by 2002:a24:6bd7:: with SMTP id v206-v6mr7192108itc.129.1530172973717;
 Thu, 28 Jun 2018 01:02:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 01:02:53
 -0700 (PDT)
In-Reply-To: <20180628074655.5756-4-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-4-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Jun 2018 10:02:53 +0200
Message-ID: <CAP8UFD1+r6LszVXf=Nv8cR4RoDWdXQV26su1oXN+WzbSdmrr+g@mail.gmail.com>
Subject: Re: [PATCH 3/5] rebase: refactor common shell functions into their
 own file
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 9:46 AM, Pratik Karki <predatoramigo@gmail.com> wrote:

> The motivation behind this is to call the backend functions
> *directly* from C, bypassing `git-rebase.sh`. Therefore those functions
> need to live in a separate file: we need to be able to call
> `.git-rebase--common` in that script snippet so that those functions

I think it should be `. git-rebase--common` (space missing between .
and git-rebase--common).

> are defined.
