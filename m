Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6AD1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935597AbdCXSib (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:38:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35192 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935521AbdCXSi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:38:29 -0400
Received: by mail-pf0-f196.google.com with SMTP id n11so1629399pfg.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IiBpBSC/oqwBdUci6EHDuEcjONwSqV1W0HjkV7wLmyA=;
        b=apHAKk6LCzHqSTBD9Q10VUxLA1bM2ipurGtaLVcMooEAnZDsw6xx5TKqHOkTHvh8qQ
         A5MbZsDPu+coMQtTY3q0fElqvOst2MAvYty8ibI+61k8muSadejjvPDMeFTg1HD6gyVk
         ohNxj5haubYwNY2JwuwF3gbFqtroNoE5aI4BodHWJMdtJzCiKQaVoXjB5eLBOlYRCIs0
         aCIvb1/RWWDdStnozcMRs73b+y49LUxi9kyf8lCnbY700mwGmeSQ//bcw5Gr291LHuFy
         3Ch9RPI3bfERrgAazNKYTRchqpd4Hz/4Fgb/gv5FxiI3Jrmb4UqiN7sY0lHQc+wP+ICy
         uAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IiBpBSC/oqwBdUci6EHDuEcjONwSqV1W0HjkV7wLmyA=;
        b=MancDEFE35wMCrmsXXSFpAnndz+wziTHlD1BK8T6tb3aiugby8mZQnpA0L6+Wl5WxO
         IY3+YRbtxP1FDcixw7+voMDDiYDP473G2TqK9yQM3kz+8qzmWTNROAGApxPjxJO7BCSe
         +DVmRELzo0mEiZx8lmtab1IcoaYIo9/jUElajNp8Tw2BUMlMkPNgEEtR8m3n936+YhNm
         GxUFpkTXtsEcFFjd73p5F5jeT/G/m3ceh/wFOtFGe4OawB+XwecNVlaktu/fyQjg2myl
         sbWzH7RBFIof/yNCQlbR8NRYg0oJEkBAVhG66BWxkh0HilINigz16+KQAjJGHBf447y+
         WeMg==
X-Gm-Message-State: AFeK/H26XBKiUlhEleYDogXGIp3+9ygSojY5EwEJuT3Wtr2iy2sTYEoS3lHyX6A1valRcQ==
X-Received: by 10.99.164.18 with SMTP id c18mr10771299pgf.40.1490380708151;
        Fri, 24 Mar 2017 11:38:28 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id z63sm6068104pfz.70.2017.03.24.11.38.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 11:38:27 -0700 (PDT)
Date:   Fri, 24 Mar 2017 11:38:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] log: if --decorate is not given, default to
 --decorate=auto
Message-ID: <20170324183825.GD31294@aiede.mtv.corp.google.com>
References: <20170324054631.21622-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170324054631.21622-1-alexhenrie24@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  builtin/log.c  |  9 ++++++++-
>  t/t4202-log.sh | 10 +++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)

Nice.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
