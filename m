Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56D8203BD
	for <e@80x24.org>; Fri, 15 Jul 2016 06:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbcGOGUn (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 02:20:43 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34803 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbcGOGUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 02:20:42 -0400
Received: by mail-io0-f179.google.com with SMTP id q83so96358013iod.1
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 23:20:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+r4fVvsNvfSbMEiduERolrIyBstxIHilIelE1DOmtLo=;
        b=rNBROdW4ZVueAXumeZ932zwdg1TOxddE5xtAp0hdBIk+of6SHmJKP7sacoBDzsBOE8
         1ZqeBWeOWpLhyfYL27fq0fwSU/fadlRpOnVQvkaghwp9jROMUWOX/Vzfy4MCCqPn2cXE
         NasluS0cFqPAbH7SAcwvqXSR37fymRFR5t2a6eSs8//f66zY3d2Fw5kbGJV+gytQTsQP
         xQxxxY/jMOwm2lK/bpHVUDLrVBVGboRETI2uxJRqhoxPxZYGLeaQQdPZSzXUrCMeZuhe
         b7mQMrIhhbzZC2ifxrF+FzXwmSywgkKo/55dT+vslqIQqdaI5CPzUlWltKLNelE0mpqb
         byOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+r4fVvsNvfSbMEiduERolrIyBstxIHilIelE1DOmtLo=;
        b=CcfpVPifzqbEQl3p/7pUehprBfaMj5iumiBnY+tmd+bf9kQRgkNJ7VmAYAcaRRk0dK
         ZbSjIRMDXK7xIgv3HEIha6pK5erNm/GZc6NSUMUhV//5uoU8N0s1sB07Znlzv5dA5Mb/
         qut3oiMUzXirEuyhhmw+qg+Q1mqCaw3Kml7usYSKLI4zIxQk1mTQKdWmlW6Yc42Sg4CY
         jpFfLObx8kz39wBZai7nbQtDiL/Z3u1K4DI405EH1i80mTj1C0H4fvxB0HL4qP7T4xz3
         U/SG3A5XwPjcXI4UcgGgmTGpGhY7NC6K3zPyLV/wXmd+0qhJW18aJxiLiTO2a/ojvoIr
         M+cg==
X-Gm-Message-State: ALyK8tIpYQpN/3KFUnJrxf2BCns7WN4o18+OUzwqX2RltRLBoPReOKf6uNLzAAomdrvev40MF+RHy6eOhmaCaQ==
X-Received: by 10.107.137.159 with SMTP id t31mr8588966ioi.34.1468563641903;
 Thu, 14 Jul 2016 23:20:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Thu, 14 Jul 2016 23:20:41 -0700 (PDT)
In-Reply-To: <2cc123136b25cae12dce2a6f30fe0ba5ae8dc811.1468510191.git.johannes.schindelin@gmx.de>
References: <cover.1468510191.git.johannes.schindelin@gmx.de> <2cc123136b25cae12dce2a6f30fe0ba5ae8dc811.1468510191.git.johannes.schindelin@gmx.de>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 15 Jul 2016 02:20:41 -0400
X-Google-Sender-Auth: mi3aHPpTwXhNcqf98KCnvMePrq0
Message-ID: <CAPig+cS=LVBhy1pqo2KXz-NoPZdPzkzTgV+S1Ro5+zOjDpKGPw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fsck: optionally show more helpful info for broken links
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 14, 2016 at 11:30 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When reporting broken links between commits/trees/blobs, it would be
> quite helpful at times if the user would be told how the object is
> supposed to be reachable.
>
> With the new --name-objects option, git-fsck will try to do exactly
> that: name the objects in a way that shows how they are reachable.
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> @@ -576,6 +598,7 @@ static struct option fsck_opts[] = {
>         OPT_BOOL(0, "lost-found", &write_lost_and_found,
>                                 N_("write dangling objects in .git/lost-found")),
>         OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
> +       OPT_BOOL(0, "name-objects", &name_objects, N_("show verbose names for rechable objects")),

s/rechable/reachable/

>         OPT_END(),
>  };
