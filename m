Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A634D20248
	for <e@80x24.org>; Thu,  4 Apr 2019 09:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730528AbfDDJrf (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 05:47:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35055 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbfDDJre (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 05:47:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id y197so2606082wmd.0
        for <git@vger.kernel.org>; Thu, 04 Apr 2019 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=afUdYax6JkbUwjUNH5ucLzRIn/lzS8vr4SYmJ8J3IW4=;
        b=vNb9gKj3gidGDe6j4RDnNaNVgw91GQkPmnEXE8EBBeTkIPTtSz3wudjj7+WeLFg2Fu
         gL7YWpAqAuzvCdfsYYNHHT+SAJe8ajDIbRMocbrnwGArG6cTQXi9pXeWiR2FGTjQktfl
         hyVvk0vkiDCwQr8Hm9o76pvkDrQjLQXk5jH1+lWW15hNtjZKk+DFojVTD90OPWLUCZY3
         WbMaVCZqbLfHt47Q19r07IzPs9nM5VtQUU7HNRmDr1uHaexCaUiIEP+lmblJUoJpr+2c
         tw+O1gtk8zUILS5YPwI0/uFQOuJjJlFQRygP3U02lChH6BYm/PcNki7A/DOLjI0PPzC7
         1ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=afUdYax6JkbUwjUNH5ucLzRIn/lzS8vr4SYmJ8J3IW4=;
        b=Uem/dyCFF20e7Z2Qo17RaRQnbRK9t3RMFGX2V53VxPtSWFRACtSbfW6H+tFSSOqch3
         selxlBELPQ/xWZqD11erFawvL8mOL3FmCGWJc+gtuPJv2iHr59hug7VEdH5OqtV7yeT5
         Pcu7EG9VfZWlbkhxt96bheDWQNijWcS70dHZMSdoaklgRJLWZ5BrU8lVFOwmRzKh7Nt/
         HD5ZDbQGIZkaUE7ARgkWwEDtdU1iHd7IRVfXnpCr7qT3Smh2M68Fe0Jb3lWuCu40Y1Yj
         1pMGnDOBa9kym7V4MfNhTJ3Zwnq8cI72dQtafyE49DJklYriG1C07S/1P2EllLBiq2r3
         tk5Q==
X-Gm-Message-State: APjAAAU7xaMYt2j1eKiIMk64eVxo8S4aj4JShCx+Ng72AyOyDY7EHqd9
        RSQjLsOixtiiOefCxOIXOqqpVRwXLGU=
X-Google-Smtp-Source: APXvYqykwd1eHHtfHPiq2Lfp/vCwvqdXuyazZDGDO3vhAenVWNvKWPDeSWz2PpmS2G48KcIPHy39Pg==
X-Received: by 2002:a1c:f50a:: with SMTP id t10mr3302790wmh.86.1554371252757;
        Thu, 04 Apr 2019 02:47:32 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id m13sm20693532wmg.42.2019.04.04.02.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:47:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     Baruch Siach <baruch@tkos.co.il>, Joe Perches <joe@perches.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] send-email: don't cc *-by lines with '-' prefix
References: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
        <bc20070b-437a-9875-efd0-b4cad1413233@rasmusvillemoes.dk>
        <604795fe60991f22273cbb652eeeedc17985bc65.camel@perches.com>
        <xmqqh8c03dcz.fsf@gitster-ct.c.googlers.com> <874l7ekynt.fsf@tarshish>
        <xmqqk1gaf7oe.fsf@gitster-ct.c.googlers.com> <87zhp6jf2o.fsf@tarshish>
        <dd8160f8-0e5e-1024-53c1-1a9f23423af5@rasmusvillemoes.dk>
Date:   Thu, 04 Apr 2019 18:47:31 +0900
In-Reply-To: <dd8160f8-0e5e-1024-53c1-1a9f23423af5@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Thu, 4 Apr 2019 11:42:23 +0200")
Message-ID: <xmqq36myf6fg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> My ack for Baruch's original patch, which AFAICT is identical with
> Junio's suggestion, still stands. FWIW, I'm against Joe's suggestion of
> stopping at a line matching /^---/, since it's not unlikely somebody
> does something like
>
> ---- dmesg output ----
> bla bla
> ----
>
> in the commit message.

Hmph.  That does make sort-of sense ;-)

