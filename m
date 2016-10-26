Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 454FE2022A
	for <e@80x24.org>; Wed, 26 Oct 2016 13:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934848AbcJZNec (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 09:34:32 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38955 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934646AbcJZNe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 09:34:29 -0400
Received: by mail-it0-f68.google.com with SMTP id q75so877292itc.6
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 06:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZD/KUcigdsphrHVsZ6byFfmsbzI0WAGuZiY07qXE0Z8=;
        b=o/CeSfyoYmSgxhiYBWgiDCwrtGQ56rSzl5sfTRbkOX6qFwQEGzCWy1AS5tOirdTE2s
         d2t+XZoB5ZixddEsE4nuynGA6jMpDEyH3wSqzyHYMPKSx4hIsVX5iZ9EuzsBBfbxXr1g
         5s76TkGekmubYou0527vPtrbBSuPXLJ+cpPcqW/aLqcxIbk9YC9jeDPYL/3buhvcp0Xg
         qfWcDOSDaZXtOpwTDAcom+d89C+EbpCJ72gLt8ecxKhM3UTD01+k2XIg/hT+LTDCtN8W
         Hr2dpcyQUcoiznp69+2Gkn06PkRo2b4AicFEb4/0AQkaFz/3/IVt3fr6yDeOS6DpV2yQ
         u7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZD/KUcigdsphrHVsZ6byFfmsbzI0WAGuZiY07qXE0Z8=;
        b=bCQ/b57TZfJ8XRQukiZOkGKaATNRn2IvTSDpfslOZRTu6xLOVKxckQX+K+mPVt99d8
         9+zegqpKdVoMMyKGTN8bBKyICn4DUrZwZOxv3RU+gbIevdvvfLrChqIM1Aar0jTXi7pj
         oLDbyzMk5bnFHPVF8ct0Dm7P11A9nhN45Of0zjNxuIybNlhjHTbPryu05Rcm9C/1xFri
         8fiPYg0qskogBAywUic/0NCLsVh6EGSfvE7k8PEYAnnBNWQELlcNV7ma3UBMmzK2pYwZ
         8iQUZn4S6MeDbySJ4Fcq8zFJxN+UHVVxgHmH8DzXM7FlnrIlS1JvVkP7D7YbvU+XecMd
         Q1AQ==
X-Gm-Message-State: ABUngvefUaBg0ar084avldVdfgdfVVYkZeTLBtikOZTZIjLD/1GaOr6sp4nsDFLx/IfVqwMACzmF7+BuzzBc+g==
X-Received: by 10.36.103.201 with SMTP id u192mr2207223itc.3.1477488867869;
 Wed, 26 Oct 2016 06:34:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Wed, 26 Oct 2016 06:33:57 -0700 (PDT)
In-Reply-To: <20161022233225.8883-33-sbeller@google.com>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-33-sbeller@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 26 Oct 2016 20:33:57 +0700
Message-ID: <CACsJy8DhsaTY1w_e-0O5d4KLxr4Gmo3g9rDagQq1ooSHywcRoQ@mail.gmail.com>
Subject: Re: [PATCH 32/36] pathspec: allow querying for attributes
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>, bmwill@google.com
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(sorry if this should have been answered if I went through the series
patch by patch, I wanted to do a proper review but finally have to
admit to myself I won't, so I just skim through a single giant diff
instead)

On Sun, Oct 23, 2016 at 6:32 AM, Stefan Beller <sbeller@google.com> wrote:
> +attr;;
> +After `attr:` comes a space separated list of "attribute
> +requirements", all of which must be met in order for the
> +path to be considered a match;

What about (attr=abc def,attr=ghi lkj)? Does it mean (abc && def) ||
(ghi && lkj), or abc && def && ghi && lkj? Or is it forbidden to have
multiple 'attr' attribute in the same pathspec?
-- 
Duy
