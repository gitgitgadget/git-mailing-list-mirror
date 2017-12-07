Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E08120C31
	for <e@80x24.org>; Thu,  7 Dec 2017 09:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750929AbdLGJ3L (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 04:29:11 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:34145 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdLGJ3K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 04:29:10 -0500
Received: by mail-wm0-f44.google.com with SMTP id y82so26393093wmg.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 01:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xJWsQUiB9akgmvE23/DO6QCWzQuANIb257gO9MQ08xA=;
        b=HsnxV/a2oKeYVxPB3L5lVF6AWW0IaMJW9Lta51GtRJoBsAiFKcwVVX0EwJN1rS5A8q
         pkzLsnOey5PdywYuJ8qZVI33zTW67NEM5xffG/Jx4RMFOkLbYT7/Cdm4TSHSgpGCVuGa
         HARwhVIGk2TSKisl4v9dkUNTCCZL2PgStE+oy6cEEfzQr+B5Es3jHI65SkHyvF68p9aj
         lX5PDgo2NONYlhnxAex9AXlNYRjwbYdhK2o+BZMBbfdGKSzfgLckoqPFIo8p8N445qsb
         TQOe60gfyUAbMRmc/V5pR2GoNQg6tcPLxucr4oqVwELkYMLM8jK6/J8hZVnxOYU6Aed5
         /c+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xJWsQUiB9akgmvE23/DO6QCWzQuANIb257gO9MQ08xA=;
        b=F5gSwdhHRwtbdEqBY3v/INYraQHmBE/kL2+l2pBhVrv4VfJAzhCzGa/VbMZLWGd411
         IqRK5oSFhPnquvkMudZTcL7WJ/kIjPcv8hHHLs/kIPs9bj/mgpQB/+OA4iPDEsCSJ/MK
         UGtyhYdXhTvDbk2Qix3mVIWF6EYQjM1zWjEXEByqKNISZ7Be6vPnJOkd1ox6BhrokAA/
         BbMZMthbK7vv+cJsGgYGoz6j5voqEZeMCenfUDoHuu6D5dAypJ2AjEsXidrpGzCNySUp
         Jbx2pXgvLl/JrEwmd8xjZy+HcNKfIJ3ODfZkS67r+MPif4XdMRB/EH6FWyrnBkteoB9t
         hzsg==
X-Gm-Message-State: AJaThX50SLGBT+lmHRG7npAZxb5xH+mHSwdfa29PGiRBNWljgG7MUQUY
        iBWKFMLaNsJQMs86ytfsR7c=
X-Google-Smtp-Source: AGs4zMabYVAwwISw0ojlYFjk+r3diGpEar43nQR4ZAVGfrhIrXRqAs4vFBNjJg1ko1Q3Epbm/3zNjA==
X-Received: by 10.80.139.203 with SMTP id n11mr44071851edn.200.1512638949293;
        Thu, 07 Dec 2017 01:29:09 -0800 (PST)
Received: from ltop.local ([2a02:a03f:40a3:e300:68d9:438d:c9cb:42c7])
        by smtp.gmail.com with ESMTPSA id 4sm2020181edf.81.2017.12.07.01.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Dec 2017 01:29:08 -0800 (PST)
Date:   Thu, 7 Dec 2017 10:29:08 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: partial_clone_get_default_filter_spec has no callers
Message-ID: <20171207092907.lrieior3ncwwc3wh@ltop.local>
References: <ec83f2d9-0d87-9d6b-4860-f4cd7c19984e@ramsayjones.plus.com>
 <89d06941-9bee-9334-d737-11ef7801cba2@jeffhostetler.com>
 <44d0c556-d5ba-186f-7493-f9900eccb442@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44d0c556-d5ba-186f-7493-f9900eccb442@ramsayjones.plus.com>
User-Agent: NeoMutt/20171027
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 01:59:26AM +0000, Ramsay Jones wrote:
> 
> BTW, if you are using a version of sparse post v0.5.1, you can
> get rid of the only sparse warning on Linux (assuming you don't
> build with NO_REGEX set), by using the -Wno-memcpy-max-count option;
> I have the following set in my config.mak:
> 
>   $ tail -2 config.mak
>   pack-revindex.sp: SPARSE_FLAGS += -Wno-memcpy-max-count
> 
>   $ 
> 
> [I haven't sent a proper patch, since the required version of
> sparse is not widely available yet.]

Note that sparse simply ignore unknown options/flags, so adding
it now won't create a problem and can already help those using
a recent vesion of sparse.

Regards,
-- Luc 
