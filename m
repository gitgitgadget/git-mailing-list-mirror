Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE76D1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 19:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbeITA6r (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 20:58:47 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32904 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeITA6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 20:58:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so6964733wrc.0
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 12:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=YmoHGHOYMCIyhuoY9Nc+kmzaZAd6VNkBDQ7vQMpnAkg=;
        b=fjqKM4UsInGfa0vty+0XvLsnZCPOzhhCrcsx8HHStPZUi8cLqSbm+bHSFYI2YqASu/
         oYctnWSk/RStxxMf7xmi4FUnY1jYbMP+Y+nncEgkhoOz70R/Id38ZiOLlyCacUpwdwWd
         MCt0n3tEopVBt/14sCKSZCGChEkPV8Nif/260JVaTjMUQ/y8uTcjdARXz8Bobr0Fj0A/
         xBviG9N/trlk9lkBhEFdUf/2+XKRS9+q2KFDQuALR3eM4WyRab9nHMTBER18F6nxF4GI
         Bz3HxqsdvX8xNfaCT8SVw1/5ArSva0b8JHzL0qUBb7KO1UxDVI+zYw+9B5F9pey19qQY
         hDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=YmoHGHOYMCIyhuoY9Nc+kmzaZAd6VNkBDQ7vQMpnAkg=;
        b=A6NXXiGG5NBaj/NvcmQ5jh50BdUi7+fDl9fG2CtFkADnONs97S9VqlUML6K4if6eXB
         sifpJCS4rd9dSBKgOv7ED6mI6P4HaYmuKNDwf1GIwKUNsjonkSjyIodmfkzzaHlEe/Fw
         6PndX0haN/7O4XOeHypCQ9vvQL2RZOFdvSyM3779IkhT6Vw8evBZMTvR+0uL39hgqP/j
         OdkTjVdX0qLTbinjpJQKfLT75vQpAxq9AB4dheLgL5HwUAm2ep4feG7eXSjCPeFSP8wT
         9Xv+LYdnbMLjEFN0rp2w49n/i6g3+h7/RZ5rNMFitN3sFuUaRUe/9BNRpY2C5Ii34JMz
         P1lg==
X-Gm-Message-State: APzg51D96uvirhOClrXWKhRvAzhNi2a0vek+DiNewKdPeqyreYGqKeG+
        C5LzlmodzvepSQqn2a9Gtpg=
X-Google-Smtp-Source: ANB0VdbC7blg3ODr6IzrBX7EdQdtIyG88tIUN+XgIS3gHX+3Kv9sxEmmQYtxEnoZsAHzNSgwtXYS3g==
X-Received: by 2002:a5d:4990:: with SMTP id r16-v6mr30502219wrq.116.1537384764862;
        Wed, 19 Sep 2018 12:19:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u127-v6sm4611233wmf.48.2018.09.19.12.19.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 12:19:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, smaudet@sebastianaudet.com
Subject: Re: [PATCH] add: do not accept pathspec magic 'attr'
References: <20180917015259.GA26339@sebastianaudet.com>
        <20180918173159.30300-1-pclouds@gmail.com>
Date:   Wed, 19 Sep 2018 12:19:23 -0700
In-Reply-To: <20180918173159.30300-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 18 Sep 2018 19:31:59 +0200")
Message-ID: <xmqqk1nh47no.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Commit b0db704652 (pathspec: allow querying for attributes -
> 2017-03-13) adds new pathspec magic 'attr' but only with
> match_pathspec(). "git add" has some pathspec related code that still
> does not know about 'attr' and will bail out:
>
>     $ git add ':(attr:foo)'
>     fatal: BUG:dir.c:1584: unsupported magic 40
>
> A better solution would be making this code support 'attr'. But I
> don't know how much work is needed (I'm not familiar with this new
> magic). For now, let's simply reject this magic with a friendlier
> message:
>
>     $ git add ':(attr:foo)'
>     fatal: :(attr:foo): pathspec magic not supported by this command: 'attr'
>
> Reported-by: smaudet@sebastianaudet.com
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Since Brandon is currently unreachable, let's do this for now.

Thanks.  This certainly make it better than the status quo.
