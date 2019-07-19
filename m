Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC3081F461
	for <e@80x24.org>; Fri, 19 Jul 2019 01:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfGSBPV (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 21:15:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38225 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfGSBPU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 21:15:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id az7so14747986plb.5
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 18:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pygRO92QEB5G2fUIAIIOljjT5JVTq3iysn5F23odync=;
        b=Zdu6T3U7eeItmfXte1gsDCSQ0hd6uXnoAaFygvAmZOGisx8LFxBaGPYH8B7qApURPh
         3eGnBqC7rsUuyng7lNXMssCe63+DYn3YlhKeQ6lGEvJscvSFl2jHJRh1WAXFRFFVsRJI
         JffNuXBgQrEUg6u6ycovfA7ecLCZY0sULUuHr3Zb99f+gH3/WmmtlqTRUWS9VStZU/+W
         oRdPMOALP4FNLkKnnBYInAUbn6AlfEhuG+48rZk189we0jvCG6Cek+ebf0e500FVrCB1
         D8GlC3WWNfWY/jz16S3vku8vBDTMZ8MkI3PvgYAyOeJmLxxGJhsgHib5ZW8WEhvT8XrL
         L6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pygRO92QEB5G2fUIAIIOljjT5JVTq3iysn5F23odync=;
        b=LTbwUoDLrkLU8zAzAZoxWkOnv671uKNC0rIdeTtbaSGiviQNlyNeewaZGqP4Y7ogOz
         MvaEw5vxySmMLgRIOiw2jK5RTBglnk5+5swR+QTvZqZn9hbc8SweorUGgmBjAjrPc4it
         gVBR7JJq8Yxmd+gA9L9YR58en1H7EMveN5qSlVMH+2Cu7+cbL73ioPEwy+BpAQ06gI4u
         RH3trmZNGdKHLpk6IBUfiHP4WqxWpnIEE9M5GHo5NESahyAThgfCIm4n7GoqoturfOqP
         yduyYMik2MzJd2Tgldl7QcxiCwoKfUhvqmNuM02ZlWWe67vEhwsVf0hX/5gFraO4jboh
         SJ3w==
X-Gm-Message-State: APjAAAUqA+dkRZ2DrpOSM/rC/2OOf3TQCNLFiVVvuRTiWdp4SOvBGt4U
        qXIn7ePo/XSz/UO0uOnjSBU=
X-Google-Smtp-Source: APXvYqz0TfgLNYWc8Myu1B5uTOx6RB8ln5hwVA2ktCPu+tyHYFc0bR1Dvbq9UlXXKJfxdDVux7avZQ==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr51762080pls.96.1563498919335;
        Thu, 18 Jul 2019 18:15:19 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id a3sm30936004pfo.49.2019.07.18.18.15.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 18 Jul 2019 18:15:18 -0700 (PDT)
Date:   Thu, 18 Jul 2019 18:15:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: spell out post-C89 rules
Message-ID: <20190719011516.GA251102@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com>
 <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
 <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
 <20190717005537.GB93801@google.com>
 <xmqqv9w01wdn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqv9w01wdn.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> -- >8 --
> Even though we have been sticking to C89, there are a few handy
> features we borrow from more recent C language in our codebase after
> trying them in weather balloons and saw that nobody screamed.
>
> Spell them out.
>
> While at it, extend the existing variable declaration rule a bit to
> read better with the newly spelled out rule for the for loop.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.
