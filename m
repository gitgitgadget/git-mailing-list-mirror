Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35F491FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 04:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751237AbdJLEsW (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 00:48:22 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:54201 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdJLEsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 00:48:21 -0400
Received: by mail-pf0-f194.google.com with SMTP id t188so799714pfd.10
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3wTkmETTieCEvqxoJx3e0Mz2Raf4/SbKG80UHEJLt3Q=;
        b=S7/cMW3LSqdpwZUKKDDIFEBJctYtO00Fsttwi9hDwfV5WLS97KFXJBDCW1xvkSVTue
         Z3yLCnG026ENFz7+s2nd+4xVNPzPMZXL/GnOZE7vbVU8a/gcO/PbKJC4Al8u5dGxlGdT
         xOPUpJNIQRmfjcisaBDExNNF5BL6ylCOBa8KvBxbbWo5vQTzh/NW9GFF7TliR8S6Bvaf
         K0CziCbT6J2XPiWizzS6x1wmzvIeAxen7tAehiR7j7iQzo+HoqKopxQfhK6NihdPzQ5Q
         XkC+4gmWLcHtsjncsmOhp/08XO72K9Wg+jelBjYbQLxroNEF/smBbMMRoBHpgfkVqeQA
         Q8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3wTkmETTieCEvqxoJx3e0Mz2Raf4/SbKG80UHEJLt3Q=;
        b=ebzQUSMYC9uyvx4uCbT7+y6W0Dc0ExaoVPUeI0AspgkKxOeqOUF7P91ANJQStPWVdj
         +1IyIYDgqkVeEgwtC4WLfvg1pP8C3QT84AvydQQ7hGKE9DyIfSuQZQ51gEe5BYwpNib6
         /wMU8lyxeSbhN3Ca6aq8MhJcC90nDgF0IR8qIYWt3L8f/sIjcXJD1RdJtjN7Kg0pf+R5
         vwfNndsANxHlmpDai/idRDkBgxtrq14s3RLizOglWPFIw/2syCuVpb86/juI/C0HGw8E
         BCZRIUEVVi79CDiCFXK53gRpYLxaPP+6zUw6yRJ5rPoYeyRCQaXo1BcwTW+S1v5URG7D
         tFNg==
X-Gm-Message-State: AMCzsaUQCkw+nu2A+RBXO6YtfPLE8U/r/FWQy6MeqbbWzmx0EEmgmZ7T
        NUdARAq9zakAC1MGfmPZ1uLGoFUu
X-Google-Smtp-Source: AOwi7QAYK84F8DvjWgKu9Ilc2QDjEg4zIpoIo4t5sjpWteDyjMgCPMBVrqWZcMbEy1CDDKlho8cBWQ==
X-Received: by 10.98.104.198 with SMTP id d189mr1159916pfc.55.1507783701094;
        Wed, 11 Oct 2017 21:48:21 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:9e:660c:b9bb:a349])
        by smtp.gmail.com with ESMTPSA id s86sm28819607pfi.74.2017.10.11.21.48.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 11 Oct 2017 21:48:20 -0700 (PDT)
Date:   Wed, 11 Oct 2017 21:48:18 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] color: discourage use of ui.color=always
Message-ID: <20171012044818.GE155740@aiede.mtv.corp.google.com>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-3-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012021007.7441-3-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Warn when we read such a configuration from a file, and nudge the
> users to spell them 'auto' instead.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt | 2 +-
>  color.c                  | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)

This warning only kicks in when `always` is being silently downgraded
to `auto`.  It makes sense to me.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
