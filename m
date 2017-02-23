Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49FF0201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 09:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751099AbdBWJd5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 04:33:57 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:35515 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750992AbdBWJd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 04:33:56 -0500
Received: by mail-ot0-f177.google.com with SMTP id w44so20129508otw.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 01:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WVyN0BEAbx4DBrhAdqXim7waXzqATXq1NIBab1kG8rM=;
        b=fvewU0+x42Wg0Z61gx/BR73exMmfx4P569QQVsSbIqgdmdEY7aVVkhjOH68VnboXoc
         E+7hrTB3NuxJq2+wwvgGXXJUKHUrQw5zcPGReaicq3nkrubSXII29nzzH4cD6lgUEXp4
         N6HguRVsZg5YGeTUG9F8aqg6PhpkXFFjCJm4uPaqc8vvBHFf3HLuExCyEnzsG/r0jqV9
         SomzghnarWqXXhCOgrwS5G8M1tfNjZ1exEtKHDHia0DNbGs07O2i05Ou42VBjhNow/hB
         /H59z7x1l7dKh7dDKy+Ez4WzxaII4KgI1ZirqnzoAJu7X3Qi0KbfWkstyEqyWvdCsLvF
         a/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WVyN0BEAbx4DBrhAdqXim7waXzqATXq1NIBab1kG8rM=;
        b=eL1864s1+8V1T2GYDoWJHgBWvxwCpfrkSZgLJRbpi7fJ/jVcw4IPeWAEWcQ5GGeOGj
         O90ngq8ZRRONbT8X7o7H47xRO4Cug51zvLTf1bqKWSttxJzeLgEwaj7w3/hKPkeQsm2A
         f6B1QUtdghatpNJzG+zW3CDkJ6S6fHGR4PWhXwP7n2gqrrL3HhJd7LdRyouJrQcO8rOd
         5EEE+lUPa0Or7bLvw0Xvol0BWbotGoGIRdDNLcl9HZlxoELmnJf/ih8MIjZtmlRczO3O
         3sbYkno7TcBvd0QE1u/OFOMZh2yaEW9b9c6WKgbbhkBB00jriExDL62sQIDBB0ZKzNt+
         JZfg==
X-Gm-Message-State: AMke39kuRsIlNPTLOZPm+MbVbVJb9dLThaS8XrPgGe/QwaPCpCt+7Amn7gAnd1DqiemgpW+mR+VrWSUVAnw1Kg==
X-Received: by 10.157.46.202 with SMTP id w68mr3313338ota.225.1487842435653;
 Thu, 23 Feb 2017 01:33:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 23 Feb 2017 01:33:25 -0800 (PST)
In-Reply-To: <20170221011035.847-2-kyle@kyleam.com>
References: <20170217035800.13214-1-kyle@kyleam.com> <20170221011035.847-1-kyle@kyleam.com>
 <20170221011035.847-2-kyle@kyleam.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 23 Feb 2017 16:33:25 +0700
Message-ID: <CACsJy8BJgL1i85nZ9CpAXCKaG+PQQkjRKLFPWzbsMF8WN8TEjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] delete_ref: accept a reflog message argument
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 8:10 AM, Kyle Meyer <kyle@kyleam.com> wrote:
> diff --git a/refs.h b/refs.h
> index 9fbff90e7..5880886a7 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -276,8 +276,8 @@ int reflog_exists(const char *refname);
>   * exists, regardless of its old value. It is an error for old_sha1 to
>   * be NULL_SHA1. flags is passed through to ref_transaction_delete().
>   */
> -int delete_ref(const char *refname, const unsigned char *old_sha1,
> -              unsigned int flags);
> +int delete_ref(const char *msg, const char *refname,
> +              const unsigned char *old_sha1, unsigned int flags);

Is it just me who thinks it's weird that msg comes in front here? The
key identity, refname, should be the first argument imo. You'll
probably want to update the comment block above if msg can be NULL. We
have _very_ good documentation in this file, let's keep it uptodate.
-- 
Duy
