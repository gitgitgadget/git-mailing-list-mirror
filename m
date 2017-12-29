Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D291F404
	for <e@80x24.org>; Fri, 29 Dec 2017 23:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbdL2XQg (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Dec 2017 18:16:36 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:37239 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdL2XQg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Dec 2017 18:16:36 -0500
Received: by mail-qt0-f177.google.com with SMTP id f2so55653978qtj.4
        for <git@vger.kernel.org>; Fri, 29 Dec 2017 15:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h08+CFLJY6Jwhm+VABOWb2+rs/tK0Iv2mxlvXp7IsIA=;
        b=Oncbp0u07xPcQbd+80IbS9w0Fcs1lpUqviDr55Gr3Z+yPyYPqb7fxl3/iWJVV6U6Fs
         6JcghWwbtP+7gC0GdQPQyRqZnysVd04wEFmDYG00zTOagHMqJaYVoL1eGcc8DEBbWJWg
         gSrfiuc2hW4dQSDViuFwLJPG270iSs5rufnLobGmfS4uQzsgZz5vjhOdUYCIUopdx2rX
         PKp6yYtXSx6VrIAyIaLNNenwPHVruA5ROhsZ03jfEiMdl1DM3gaPzfmensXm664TxcIH
         eVA4CefNY2fhLIWPeVHWdu3ZfFg7xGW8ly/6uG/HnpGs+iCdNEzgLXPqUYEkIGGm4IlE
         CrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=h08+CFLJY6Jwhm+VABOWb2+rs/tK0Iv2mxlvXp7IsIA=;
        b=BTIPexje2TN5r1sRhZMoMKWQnVP2aHG0blrZxGHAd6+tys73xe8ePbR9z9+KG8DLCx
         qtoNPKdGcQBG7/nWXYm69X92QzKQ/33NHUUTqlc6F7AvufWl1jLn+ZMGJY3d0703vn5d
         vNOUUojhsXJ3cZqOiDDbl+LIhS3zrusWxsdZ3X/JubWs4vQs6m4N2KrgQacLSmqnzEST
         90x3H1mMCYmOzRGcg3KUjjDKb9iRSayDqydwjvMLxV/BMHPS9xjUxN9M8qT1NvoReGeg
         qHth6IZyXDOAy2o6Uq4XN96DUKI4V6+OyqlSDfczsZgGd72RGSggQvnaDeHJgaHvWs4x
         EHVA==
X-Gm-Message-State: AKGB3mKENghws4imk+PZphg+WGv425jEaAzVkkxzb62GmmX4dp9VUIoe
        EkSKrQjrSpIcihOFZ6B+J8Q=
X-Google-Smtp-Source: ACJfBosb44Yv6eO3u2EHtuI1OoIA3GYT1EDRM74m/+5FFnvWUnQBOuNL6UIv3LCsSKb5jkmokapJ1g==
X-Received: by 10.237.36.119 with SMTP id s52mr48158565qtc.199.1514589395064;
        Fri, 29 Dec 2017 15:16:35 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id x1sm23206047qti.91.2017.12.29.15.16.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Dec 2017 15:16:33 -0800 (PST)
Date:   Fri, 29 Dec 2017 18:16:31 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Zefram <zefram@fysh.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff-tree: obey the color.ui configuration
Message-ID: <20171229231631.GS3693@zaya.teonanacatl.net>
References: <87zi616vgf.fsf@evledraar.gmail.com>
 <20171229225121.13805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20171229225121.13805-1-avarab@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> No idea how to test this, in particular trying to pipe the output of
> color.ui=never v.s. color.ui=auto to a file as "auto" will disable
> coloring when it detects a pipe, but this fixes the issue.

You might be able to use similar methods as those Jeff used
in the series merged from jk/ui-color-always-to-auto:

https://github.com/gitster/git/tree/jk/ui-color-always-to-auto

He may also have some ideas about this issue in general.
(Or they could be tramatic memories, depending on how
painful it was to dig into the color code.)

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Subtlety is the art of saying what you think and getting out of the
way before it is understood.
    -- Anonymous

