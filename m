Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A0551F51A
	for <e@80x24.org>; Fri, 11 May 2018 06:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752467AbeEKGZL (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 02:25:11 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:46420 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbeEKGZK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 02:25:10 -0400
Received: by mail-oi0-f46.google.com with SMTP id y15-v6so3833978oia.13
        for <git@vger.kernel.org>; Thu, 10 May 2018 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8eP7vKFddqWXLzBxGxYVIzJiGorNW084IsRDSDVLSPo=;
        b=ayuDMt7D7nJ5pdGTN6B/KfN8O4EeQD9HbNalNvq6AMGFCrvMfbAMXCzGqR8mXbAuPA
         f72sLRSv1MHhje071lqPpf01lAhm7jowNaQCIp05GM+666L5Eww7xmAjJkVj+aJrf7d4
         NdI3td49QvKohzA6IG5OefFueyOl1ngKiF5nWIg7ltzbwg7Z9XjgjOiAuvPrvLa/f+2c
         0nGhUusIFXQeXegkfYopdyqgK9wimxOmTGxCnKXfkifkzQ8a86m2R4FaE6/RvvWcc78H
         dTkKGytpAhLAi/G0i+XQs5AhljTXZqOf7xf4MrLeg/YwW7/guLQ1nA18oT11OAWQ8ppl
         MM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8eP7vKFddqWXLzBxGxYVIzJiGorNW084IsRDSDVLSPo=;
        b=jDoeXG95tnGZvg4RkbLEiOnVVtZ94KBH3ox3U5wbElpj4MNqkprnkEECNSKWW8L7NH
         RmnLOXA4WokwTUwvhk5X+yX+rEXDyvjDUOP3Ecv6clQ1J4UVs1MzkzW4EH7bO96a/pXz
         5M5AjKiOUQ/BDIibdyObjOc4hbfsz/3J1KAJZ1HuysQZ/b/TrAtw+4bFrsqLbDybaPX4
         aILG4MpFacOa2mpP0fSrI50XqfI7wcNnDOX3X/HkHY66z00ZU+YzUe/iqSEaOavhVEW7
         18zk7RaTvJS7tJf0doAS8iIzt8ItcRfucZbnbuJFVBev/8Fbwn/Hv86yH3OlXIGu1QIx
         4Fyw==
X-Gm-Message-State: ALKqPwf+ZthvyMkEAKmiLkw9vxR9YqJXzEmHMemt4SHBrRYdgkW+b9Ih
        EuaUWwtw2lf/D0833DWPSvZzN0bICzQEU/H0sUw=
X-Google-Smtp-Source: AB8JxZrbdaOfVLTCHBKULZC19dq327we38+fNgF2sbBVi0rufTP3RQYas8QZzTm4/3vxXrVlfaEoxXoyLKnJaHoVxWg=
X-Received: by 2002:aca:ce42:: with SMTP id e63-v6mr2700586oig.34.1526019910017;
 Thu, 10 May 2018 23:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Thu, 10 May 2018 23:24:39 -0700 (PDT)
In-Reply-To: <xmqqvabug298.fsf@gitster-ct.c.googlers.com>
References: <20180510141927.23590-1-pclouds@gmail.com> <xmqqvabug298.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 11 May 2018 08:24:39 +0200
Message-ID: <CACsJy8C5=+7cVV3nQ5qkgz4pT1QqpEoXE15MkW99vyrwHUnMXA@mail.gmail.com>
Subject: Re: [PATCH 0/9] completion: avoid hard coding config var list
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 11, 2018 at 8:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> While at there, this config list is also available to the user via
>> `git help --config` if you can't remember the exact config name you
>> want and don't want to go through that big git-config man page.
>
> Makes a reader anticipate a new user of levenshtein code, perhaps
> ;-)

Why would you go and write that for? Now I want to do it :-) Yeah I
think config name typo has been a common complaint (including from
me).
--=20
Duy
