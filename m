Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16BF20248
	for <e@80x24.org>; Sun, 10 Mar 2019 08:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbfCJI2C (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 04:28:02 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45486 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfCJI2C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 04:28:02 -0400
Received: by mail-oi1-f196.google.com with SMTP id t82so1336636oie.12
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vt+jPMs3rBl3avE2XOtlq//Kb3JT+U3jlvG2On/J7MI=;
        b=g1R502D9tEgOcNAPxWc2qHAikAbuMW3GY32w29cXGYTHt13TXLcXu53eXugDwpuJGa
         xeBOr7JhCO5KE+BultCpR1OokRS2ZCubfzEB/HjANSXcHbv2X2oPujXr+CgPKaGwxVpU
         xQ1tQ/NE2aRgWAtFa6urs35S37kXhYRC0Drb6iS20ChRBhPIcDVV1+2gte85zCVONUZF
         caBKN58d4K5h4dxUqwS3ZqqvSUpuZU/T4CcOT6YWdx5pgqQzYBb+2e8kmNAsx6cqfZrC
         tFHS8beNlj0A02pqZJJygWU02SIjqT7IPG+4KhGAQk0hG4vjoIQpu8E4Mz8FyhjZYBI0
         Og/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vt+jPMs3rBl3avE2XOtlq//Kb3JT+U3jlvG2On/J7MI=;
        b=XuPUH+3Lz5YbRy9f1PfBPlIl6cX/t6WD/j7gTjtSKsNkeDZU8oRxtsvQ3bxmb+Tpg9
         sqqFDARr9HFapEZApWnPBi8XIeJpmX3ZwjfW0qIWy6F5QU6WUfcianIHn5z43Z9gkdMT
         9jakhAWoyolilioAVMc3KfG9IIVGBwaWqg/nBDmQwiLwa6qV1DlTpbklQY+pjLeQgp6O
         /FIuqq22/lhps1YtUksdMDzQtjBHdeOPJAKRhXRdgH6nKCfQ+YY2qVwKvMpgxwbbFoEe
         C86BEz6YyMplWmZ6VvQLDIbFszZxOlhC75bDESWl6ftiMCCqZlNA7tZxr6w/pgHUAVwi
         DhzA==
X-Gm-Message-State: APjAAAWrgw5EBCq3TIMrd2Vnm5IkRMquZBGej7/J3lWzh5WCQmysOnMD
        lRCQm+SPiasHK5n2g67plLi3z4PN9R5gJkr98uE=
X-Google-Smtp-Source: APXvYqz/klG6/vkhw8ahk2eK1gthI1gX38HdZ7N3lbmBzpbyOS4+3hLhdabHsPuhvbZA7xllFHFlMzAVvwD6dSKplm8=
X-Received: by 2002:aca:3bd5:: with SMTP id i204mr13764990oia.167.1552206480937;
 Sun, 10 Mar 2019 00:28:00 -0800 (PST)
MIME-Version: 1.0
References: <20190309154555.33407-1-ttjtftx@gmail.com> <CAP8UFD26Zxt1FvwAajV48eBbhPv_q5oSLTekWxApcNpg=xRn3Q@mail.gmail.com>
In-Reply-To: <CAP8UFD26Zxt1FvwAajV48eBbhPv_q5oSLTekWxApcNpg=xRn3Q@mail.gmail.com>
From:   ttjtftx <ttjtftx@gmail.com>
Date:   Sun, 10 Mar 2019 16:27:50 +0800
Message-ID: <CAOAu_Y+GeHHsxVmqLajtM41H67L83Rxxkp3SqJ-G4GBv=uTDYg@mail.gmail.com>
Subject: Re: [GSoC][PATCH] tests: avoid using pipes
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the reminders.

On Sun, Mar 10, 2019 at 2:06 PM Christian Couder
<christian.couder@gmail.com> wrote:

> If you take a look at c6f44e1da5 ("t9813: avoid using pipes",
> 2017-01-04) you can see the following:
>
>     - it changes only one test file: t9813-git-p4-preserve-users.sh
>     - its title starts with "t9813: "
I adapted this format in my second version[1].

[1]: https://public-inbox.org/git/20190310080739.63984-1-ttjtftx@gmail.com

Thanks,
Jonathan
