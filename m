Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0B501F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751883AbeCWRSj (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:18:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38382 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeCWRSb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:18:31 -0400
Received: by mail-pl0-f65.google.com with SMTP id m22-v6so7827496pls.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O8GIqHpJARcoTLEnuJ7Jsb4bE4+2Rfo61KTUEbBnPps=;
        b=Q1IcIRU+2TgLvWa8+KGUAkKPfslc97QoCZZCd8qtsVQDxvW+flycmmjd6Og0C0GdfL
         qJ/OASRrMFI8tzoLkn8T4+/oEBuTTrVrHoKT1iUM3z1OsUzYKmycBz+bl3/DSV+KW5Ol
         IGOBT3P+3ninzV4/duwqTAY10efc7R2ckrZU6k5lBAKCYJXV2siliKek3sQiWXQgwtHb
         JWVYPxBW3I3IDZG2osoXqsaPDe0B0rLJEWOirRe536Q2oLWIcXUqDbJy/VIAQI/1J4t8
         xFJoDMsshRICQUzfWzOZer6esvTITHYYrLELknA3xkYn9xsxPh1KBzGY8/+KbNv9irH8
         Jzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8GIqHpJARcoTLEnuJ7Jsb4bE4+2Rfo61KTUEbBnPps=;
        b=JuHRzQtDLfTiSazIbTe5MR36Coue/5LgG+cvPwfzv/Td4nRnFUWDRIAM6olOfCzw+L
         8dGHJ3HVHlH2VzOk5QpxwzVeioRVDfCyaTEMXoPlTEPzbaFn1G2p+0zlhyqZL1sAamju
         pceXyTunqr0Yc+C2IoR61wXdFO/Qqb5+8ME/yT6E+jkAkqwDQZksqlMFctgz1FPjF5Sh
         2uo2sIbW/0vk2QXUZKOC9O1Hur0C8pCOIA9LdRU6ujA3VN/Ep5UmXTGZw1CxVGn9ipWH
         W6Y6wLuEYQihcTUlRWtN+pJUUfcjrjRzyV2E9XE45/GenTHhN85gaJDLQBbGjtlQW7/1
         SZ4g==
X-Gm-Message-State: AElRT7F5mUUNoLpgfh3tIbef62cNMCijkc/QGmJwYi/YWlr5W5tjFSTj
        uLkXjbJSDUfAvxhgdgZEol0=
X-Google-Smtp-Source: AG47ELsK2179SjSWu6bs6t9b4tor3OyZcF9xr/lG6ty15qu2SQeUGTkvLz1otqWtdubzAbro/UtTTQ==
X-Received: by 2002:a17:902:108a:: with SMTP id c10-v6mr25181038pla.22.1521825510305;
        Fri, 23 Mar 2018 10:18:30 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id s89sm19997981pfk.54.2018.03.23.10.18.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 10:18:29 -0700 (PDT)
Date:   Fri, 23 Mar 2018 10:18:28 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        avarab@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3] json_writer: new routines to create data in JSON
 format
Message-ID: <20180323171828.GD179915@aiede.svl.corp.google.com>
References: <20180323162952.81443-1-git@jeffhostetler.com>
 <20180323162952.81443-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323162952.81443-2-git@jeffhostetler.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Add basic routines to generate data in JSON format.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>

If I understand the cover letter correctly, this is a JSON-like
format, not actual JSON.  Am I understanding correctly?

What are the requirements for consuming this output?  Will a typical
JSON library be able to handle it without trouble?  If not, is there
some subset of cases where a typical JSON library is able to handle it
without trouble?

Can you say a little about the motivation here?  (I know you already
put some of that in the cover letter, but since that doesn't become
part of permanent history, it doesn't help the audience that matters.)

This would also be easier to review if there were an application of it
in the same series.  It's fine to send an RFC like this without such
an application, but I think we should hold off on merging it until we
have one.  Having an application makes review much easier since we can
see how the API works in practice, how well the approach fits what
users need, etc.

Thanks and hope that helps,
Jonathan
