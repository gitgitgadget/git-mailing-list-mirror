Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F9CB1FAE2
	for <e@80x24.org>; Wed, 14 Feb 2018 19:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163117AbeBNToj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:44:39 -0500
Received: from mail-yw0-f175.google.com ([209.85.161.175]:42575 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162994AbeBNToi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:44:38 -0500
Received: by mail-yw0-f175.google.com with SMTP id e65so7029018ywh.9
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kbR443RIFKSPc66T8zazRjayWpwAqWD00WvVVwA/WjY=;
        b=AcA23WPboxiZFzdskVmfyfJRorwj+OniP71xFlzVuNi0l7HFL5WrrU5tI3M11ykGan
         ZqItcxX68AB5BMuk1xIzq8Ca+GUSKxqTj9PtYJEJP42/QsuVeQ2yDqzCW7OkhFaOC4on
         zDwjQJHGrPgdYf1gx6CLTzMg/DnEllu5gv3Po5xg3dYhSlbc0ELwVtzbx8rmYv4+uoFo
         CJqwsYD8ejMuo74Wy3sSpcpEFAroMYvQXOWwVldnEeMSlAnbz+NttrZ00JdB1krgZpiX
         pwE3m4EjV6JGNLVH7iHS+qg7dPEnH2fV6FWYSZirXyNvje6Abgsfo9ZKzi5VBC1LFJta
         f4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kbR443RIFKSPc66T8zazRjayWpwAqWD00WvVVwA/WjY=;
        b=oRfi2lh3Xh5WLAyC/oOPL39tBqFHFGzaIl4UxCEUMFmdtBT10HdsXjNSIVlGllvBJy
         4lWNa24c3RYz0kLHEhWwOO2imTPWlYXV+gYY4p79H+bFhhNjGfXzp5zpz8nHUQHjGdOG
         +wNSZeI0vPt3Z9vRknPrj7JPgZLnbR3IOafK78+w36wrqtk148LOdQoi5zKXzmDsRm+/
         gabiiO7pz6MnIrxYX8rwON0L0q+bx/32ksQ5xbgMdPleRblF7rPxUqjLjQdp9awXkIlf
         eEDXOTDukKXZwwfs6wyb3KFe2/JnhmeoW+GT+53nVmYj2Mk2LukICHgSOHEjBexksqne
         6rvg==
X-Gm-Message-State: APf1xPCxGysac9fyJQ7VtolLwazuWJAb/nFP39KiTKtpeslHMAEycp0p
        w1lyvjZqUGWQnjc983v91vIPTuB7hQ0NcQpXdRfMlQ==
X-Google-Smtp-Source: AH8x226sL0wNRrYRmq8UvKyGGaMtpH+yM5EftQQSE+54RmR74oqbT5PA0wtkvkR2TYT1q5EHBC3xEldPxCW1Pf9LzH0=
X-Received: by 10.13.221.19 with SMTP id g19mr273568ywe.249.1518637478045;
 Wed, 14 Feb 2018 11:44:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Wed, 14 Feb 2018 11:44:37
 -0800 (PST)
In-Reply-To: <20180214185206.15492-1-newren@gmail.com>
References: <20180214185206.15492-1-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 14 Feb 2018 11:44:37 -0800
Message-ID: <CAGZ79kZCOafZWSjz1x15K1LvEbwiMibY-mj_Lia6J_B3jg0-4g@mail.gmail.com>
Subject: Re: [PATCH v8 00/29] Add directory rename detection to git
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 14, 2018 at 10:51 AM, Elijah Newren <newren@gmail.com> wrote:
> This patchset introduces directory rename detection to merge-recursive.  See
>   https://public-inbox.org/git/20171110190550.27059-1-newren@gmail.com/
> for the first series (including design considerations, etc.)  This series
> continues to depend on en/merge-recursive-fixes in next, at least
> contextually.  For the curious, follow-up series and comments can also be
> found at
>   https://public-inbox.org/git/20171120220209.15111-1-newren@gmail.com/
>   https://public-inbox.org/git/20171121080059.32304-1-newren@gmail.com/
>   https://public-inbox.org/git/20171129014237.32570-1-newren@gmail.com/
>   https://public-inbox.org/git/20171228041352.27880-1-newren@gmail.com/
>   https://public-inbox.org/git/20180105202711.24311-1-newren@gmail.com/
>   https://public-inbox.org/git/20180130232533.25846-1-newren@gmail.com/
>
> Also, as a reminder, this series fixes a few bugs somewhat as a side effect:
>   * a bug causing dirty files involved in a rename to be overwritten
>   * a few memory leaks
>
> Changes since v7 (full tbdiff follows below):
>   * Added Stefan's Reviewed-by.
>   * Squashed commits introducing new hash structs and associated functions
>     into the commit that used them to avoid unused function
>     warnings/errors.
>   * Added or clarified a number of comments where things were unclear
>   * Minor stuff:
>     * Style (and typo) fixes for commit message and comments
>     * Avoiding casting with hash initialization function
>     * s/malloc/xmalloc/
>     * struct assignment
>     * s/20/GIT_MAX_RAWSZ/

Even the interdiff has Stefan's Reviewed-by.

Thanks for being persistent,
Stefan
