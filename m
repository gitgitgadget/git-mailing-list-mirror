Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A36E91F424
	for <e@80x24.org>; Fri, 20 Apr 2018 08:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754314AbeDTIMd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 04:12:33 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34470 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754308AbeDTIM3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 04:12:29 -0400
Received: by mail-wr0-f172.google.com with SMTP id p18-v6so1376282wrm.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GeyWHKwpvkiqhDJ5i7EsTCdWdOo6wOEEhbFH9uhaxJk=;
        b=XgyLFpa8Okdry8wrxhfKVsg/k+2V/q//Qjvxx2Iot3PdkCYNstSSFYX/+WL9wOwIou
         pF0jILq4Shp5I8Efv/D881ZnkiiZgHnTrOUf0Bs7ykYgxYq0mTLSk0F6ovzxGDcHg0An
         oan08zN1MRzdyQFVA/aJhDWOhaM4MuLRP45kqqpXjrQ1l8eGVgwtBWHagb6QBstWpJUW
         NWY/wZsBeOjI2c4rpB4FZvcKsTnQW0M4QmJYfvamS7nyPe1BAmTmnlykgtObubeRoaAH
         IinKQ4Hn1KG6faOj+nMCnWuAEYU5pGa+pZEp2XOb6Dvmu1DtuOoikL55WJA3UlnqPSM4
         csGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GeyWHKwpvkiqhDJ5i7EsTCdWdOo6wOEEhbFH9uhaxJk=;
        b=PZAPIgyjaeacN6isI6Xc+/oIRe7HISNnYCBevbBIc89SOwBo0VL5E5WdxojRjiC8M7
         2/GJycr7AW3fhojJamzgYbtGXjRlRlmgsnd0xmEQLniYuFiAQx+Sjvyt3m3onFS4h8wz
         cI5uEov8tz8Zxy5fICEFZkJdyHgYv5PlR/1ndQv5KNNywaOe/Iv8pjrDo1UTeaD234ZI
         qmGRQXzS4Qp4C74MeGueqH2OHPiEaWchpFRcMoOU24bAQk8MtyRF+E1uWLpCL9bIzjOL
         lTIvZvrJ7oo9Rq0YtULqrI4qPKhX+9flRr7u/RZqzBm9c5QNxUlCFP8RYfisn8Tc8T++
         O2fg==
X-Gm-Message-State: ALQs6tDswVOThWPQnkeOOgYaw+Rs4itwdtoZg/JUJlo7OmIYUdey3j5Z
        gyWASw4W25nqH2zv/UVPBMs=
X-Google-Smtp-Source: AB8JxZpburkt0fuUc3qCnrl99xPD2eBkse7ww7mSvxsNbwN9IjRa20Cn6cM8RqtJkI3oz2TyLZWzYg==
X-Received: by 10.28.88.146 with SMTP id m140mr1252136wmb.10.1524211947892;
        Fri, 20 Apr 2018 01:12:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w186sm1103329wmw.27.2018.04.20.01.12.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 01:12:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: squash! Merge branch 'ps/test-chmtime-get'
References: <cb9ae7a4-88eb-9f74-1596-d24ed2dd4371@kdbg.org>
Date:   Fri, 20 Apr 2018 17:12:26 +0900
In-Reply-To: <cb9ae7a4-88eb-9f74-1596-d24ed2dd4371@kdbg.org> (Johannes Sixt's
        message of "Thu, 19 Apr 2018 19:50:24 +0200")
Message-ID: <xmqqtvs6b8k5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Junio,
>
> you may want to squash this into your merge commit of branch
> ps/test-chmtime-get (today it is fa57c0871fc9)
>
> -- Hannes
>
> diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
> index daeddc1cbc..aa22af48c2 100644
> --- a/t/helper/test-chmtime.c
> +++ b/t/helper/test-chmtime.c
> @@ -25,7 +25,7 @@
>   *
>   * To print only the mtime use --get:
>   *
> - *	test-chmtime --get file
> + *	test-tool chmtime --get file
>   *
>   * To set the mtime to current time:
>   *
> @@ -33,7 +33,7 @@
>   *
>   * To set the file mtime offset to +1 and print the new value:
>   *
> - *	test-chmtime --get +1 file
> + *	test-tool chmtime --get +1 file
>   *
>   */
>  #include "test-tool.h"

Thanks.

It might be a good idea to make a merge where one branch renames and
both branches make changes to the contents to always signal a
failure in auto-merge and require manual inspection of the result
even when the content level 3-way merge cleanly resolves to avoid a
gotcha like this.  If the renaming side had to modify existing
contents (i.e. it had to update "test-chmtime" to "test-tool
chmtime" for a feature that existed in the common ancestor), then it
is plausible that the updating side that introduced changes to the
contents (i.e. a newly added "test-chmtime --get") needs a similar
adjustment, which is what your patch shows.  On the other hand, if
the renaming side did a pure rename without content change, and the
other side updated contents, it is much less likely that we need to
adjust the new material added on the updating side for the rename.

We would be introducing a case where the entry for each of the three
stages is still present in the index even though there is no
conflict markers in the working tree files if we did so, so there
may be some stuff that needs adjusting to the fallout from such a
change (e.g.  "rerere remaining" might get confused).
