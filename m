Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA70B1F770
	for <e@80x24.org>; Mon, 31 Dec 2018 11:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeLaLgi (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Dec 2018 06:36:38 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46350 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbeLaLgh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Dec 2018 06:36:37 -0500
Received: by mail-io1-f66.google.com with SMTP id v10so21144235ios.13
        for <git@vger.kernel.org>; Mon, 31 Dec 2018 03:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wfoZn1CJ7gI56lfuSWBzk0QJ7GfgEp0NkuqUnLzAPoU=;
        b=rvuR7+tzFWKfyPnoRhdLpXEjy4lnaIzohsLxO4NWGBOj+UjZ+FSRQeKMwYqvaHf/2k
         fo+sBaBuz2YYDCNqRLoBUWGrZREwLPKm08j6Zd9bMB3wqz+YZJkwhYGhObrklGbaVu5n
         fGQNILyk0UZ95y3Ajo8xMnnghQTn6QKpmC28Ypbf7E5XDr0oS9fpmBkFjxb6rqtpCC0T
         wZ8iYWAqGxeeR6ojFJ5PKvAcQW2J2dvwY67xFZxPANn8iX9sffUH6YgjhthVDpBxTbTR
         uwVaKmPyIllEKX9cXzdk7eGfCRE7fzpj/Af7oBje76n8g9i8gkVmotIhNQSEbLxtTgzo
         3EJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wfoZn1CJ7gI56lfuSWBzk0QJ7GfgEp0NkuqUnLzAPoU=;
        b=erXl8jblXSxYmtqObSQhdZnGbfbtCm59UatrIdrarQJc4cUKTIvtJGOrteiLYJmDJU
         5fzIIUtTmgrvhIDmnnA6novzuUfgUok22VTltmcsa3h9C/t9ED/iws6jFjkCUdbS7yYs
         R9kwwDdFUWoqKdoJnsaNQPf6VPJJSe/g7SJOtFopuLr70+5tCx4pVpkaroJ2gOCrS01a
         s9+zUILFkozlCivC9DV05f6Gx9Qcdvf1rf2N+cferSYIs46+k4lHtiPCBx6TN7jwCncv
         B/E3hJXMNsWggGW0XikqS2vjjhTF/1577IgWNRcTuwGIPayWICrpqhUkJi+7z8WzbIny
         Smhw==
X-Gm-Message-State: AJcUukcLk++5UFXh0la2v1NbY78v6oG5wa/zD5WHeReDw85yu7PCQmX/
        orT2PIjptlIcDh9xo30InNTzuByEXzFVLBTTsV6to7UsawTSPA==
X-Google-Smtp-Source: ALg8bN6IUr79EXvGqOSkFWcfXUv9quakoWoA0edLrhpdLD4Ay7/h3GDS4yK5+JZy/YXQb9Apl2C8Up7N+D3Tnbiw69Y=
X-Received: by 2002:a6b:c544:: with SMTP id v65mr25904265iof.118.1546256197174;
 Mon, 31 Dec 2018 03:36:37 -0800 (PST)
MIME-Version: 1.0
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch> <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch> <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
 <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
In-Reply-To: <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 31 Dec 2018 18:36:11 +0700
Message-ID: <CACsJy8C8DVz7u7z01Q3T_vY+DY-StwCQLhkhDJ6XK5C2z0agLA@mail.gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after 315a84f9aa0e2e629b0680068646b0032518ebed
To:     Marc Balmer <marc@msys.ch>
Cc:     Git Mailing List <git@vger.kernel.org>, roger.strain@swri.org,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 31, 2018 at 6:24 PM Marc Balmer <marc@msys.ch> wrote:
> In a (private) Email to me, he indicated that had no time for a fix.  Maybe he can speak up here?

Well, I guess Junio will revert when he's back after the holidays
then. Meanwhile..

> In any case, if I can help testing, I am in.  I just don't know the inner workings of git-subtree.sh (I am a mere user of it...)

If the repo you're facing the problem is publicly available, that
would be great so some of us could try reproduce.

Otherwise we'll need your help to track this problem down. in
git-subtree script line 640 (or somewhere close)

    progress "$revcount/$revmax ($createcount) [$extracount]"

could you update it to show $parents and $rev as well, e.g.

    progress "$revcount/$revmax ($createcount) [$extracount] ($parents) ($rev)"

Then please run these commands and post the output here

    git rev-parse <that-rev>^@

and

    git show -s --pretty=%P <that-rev>

where <that-rev> is $rev from the last few progress lines before bash crashes.
-- 
Duy
