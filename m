Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B1E1F954
	for <e@80x24.org>; Sat, 18 Aug 2018 16:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbeHRT0N (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 15:26:13 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:38042 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeHRT0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 15:26:12 -0400
Received: by mail-io0-f195.google.com with SMTP id y3-v6so4936475ioc.5
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 09:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZ3BBGroyEX3bWM0M50nJMc5aib+4furMTIT2xgKLOo=;
        b=F5sGuksvJDsLuNmy2LiESgfOgDE1eLweHAUZr8qZMJWTBTK6xvLeP1grEUuzD5QUV/
         GyWnqfW1tlJ+POYZNgv0+FC13v0ar+LFqMFHRfDQgF1UDewRqwo80GkHho5oiZtIkFT8
         grO5q+e9wwjOrSvpODN/D8Lvx9aheoww0DOjrNmRx21nWFfz1uITlnS0fwKtPRPzgRFv
         HxxTlPqLCnFQOu/jC+NsetSdd3Sj9M54mwZXIx5dlk5DjlMrEflISAXggzx1HqS7d2TH
         jIwt2iPF1wl4aCZF4a7z5L08ZFSDBR8P+bF3rF4u7S06gSZmfQMq1QRgLwrsC3gGsKFb
         webg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZ3BBGroyEX3bWM0M50nJMc5aib+4furMTIT2xgKLOo=;
        b=EM2iIGR5K9eRwrIffHizFIYDM50Tz/7hN4X2zUR7n4xrAkJ7MuNyDPowrmmnvZ98qO
         zZ9XQytZTkIOjlGxvlThWBgBT9hh+8QO9LNUu2KfWIkKhdWMXUwji918eoDgt74uyF1D
         I5HCIIefXy7gdSm7VGtbVrt5hK5KrmnHI0ZaocdtQHd4bgZZ2l8p6JLBcMePn1BMTi90
         1vKjRw9wVZFiJgN+2Exme3najEWJMvF1SW9SdPMKQ+8zvD5lGNvJbRDRWZya8WlMhzRS
         U5Hf7PLeS4l89kwR8B4aCTrKCScUUmusbc7Ymaoz08PwCn8nJjAxhKt6DcqTKyuz2HmF
         6b2A==
X-Gm-Message-State: APzg51BMs5zedsbMEIi2By/9q+UPP2rnEjlTygno6HSsmdmP9wIfoq+8
        Q/mQ41RndmpaegsGIr6+E0+sqzIEwcjuFrYKbsI=
X-Google-Smtp-Source: ANB0VdafldZb8OTtzfdSixuRzouecGfD2+cUwL3WZj4lwLv9GGaBZfNaLM1k7h+Hr5DTn+uQKp/iKmvgicSdpTViXWQ=
X-Received: by 2002:a5e:d819:: with SMTP id l25-v6mr1042895iok.236.1534609078346;
 Sat, 18 Aug 2018 09:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534374650.git.matvore@google.com>
 <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
In-Reply-To: <5d3b4e4acb73009e4cefecd0965fe5dd371efea1.1534374650.git.matvore@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 18 Aug 2018 18:17:32 +0200
Message-ID: <CACsJy8AE+MwBzzUFRGLKVp6vaAg2W_KO-qbUU2LQpd=rMQw2sA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] list-objects-filter: implement filter tree:0
To:     matvore@google.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 16, 2018 at 1:54 AM Matthew DeVore <matvore@google.com> wrote:
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index a0ba78b20..8e3caf5bf 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -80,6 +80,55 @@ static void *filter_blobs_none__init(
>         return d;
>  }
>
> +/*
> + * A filter for list-objects to omit ALL trees and blobs from the traversal.
> + * Can OPTIONALLY collect a list of the omitted OIDs.
> + */
> +struct filter_trees_none_data {
> +       struct oidset *omits;
> +};
> +
> +static enum list_objects_filter_result filter_trees_none(
> +       enum list_objects_filter_situation filter_situation,
> +       struct object *obj,
> +       const char *pathname,
> +       const char *filename,
> +       void *filter_data_)
> +{
> +       struct filter_trees_none_data *filter_data = filter_data_;
> +
> +       switch (filter_situation) {
> +       default:
> +               die("unknown filter_situation");

This sounds like BUG() than die() without _(). And you probably want
to report filter_situation value too.

> +               return LOFR_ZERO;

And neither BUG() or die() returns.
-- 
Duy
