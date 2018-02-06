Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0897C1FAE2
	for <e@80x24.org>; Tue,  6 Feb 2018 04:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752556AbeBFEwp (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 23:52:45 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:38794 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbeBFEwn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 23:52:43 -0500
Received: by mail-qt0-f177.google.com with SMTP id z10so794075qti.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 20:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1Qo865EvQIieHlm3E1g/NvYko86QrxJjpu/oNhVBnno=;
        b=tHBGkPiAF1IQKJ59szI04r09fww2yyzUZ9DYEgW+RMZL5Bs8RAYjk13JN3Plu2zIn7
         bXxwDHA/R3ALRZnvO7okgrpzNaCl/chCQHZaqb8ER7ZET5NdiV4XIUl6ah3xY9TINBC+
         Vj9t8U1F5b1xDbajJFkURF8UlkuUIXqBNCuiGpfJyeNwVmACxHaBh9d+QR8cyQDevGid
         VuHOgvW2IZvIAO54P13YAcx3Zaa0mogwf50xbM+O0HXUgDoncK6nOMbWovThiFop47jn
         nTa4CujrEwPbWNHz7aHfUlHiHyE4v750m+Le1DEvNbbaachHsmPjtpX2vTW/yU4A2Mfq
         yjsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1Qo865EvQIieHlm3E1g/NvYko86QrxJjpu/oNhVBnno=;
        b=avIbVhJ07w4G/5RJ3Uguc2RGTLeEsW09VGA/n5XlSkJkvkMFuvTcTJHw7CvRkq4Bfc
         RNLnYFQ/zbOma42l98UWeh1nQaHVPFiEFpL0wh4cIEk5wp19phCUGGbukMpsxImPfsn6
         j5wz/Ma9Y5ockVDIkArcUrhkEmB6CedN9tXigRgSoOh5andUOvJJmBjo9VrFd4VFeVaf
         mFTixDl0tmO1zBZG9UNCMZi4CNxFiisbCRUqDQUH1g+UzQc0p58PexOYEemnj65Y/bn2
         HjiGOktLrFmobUPPmwcG2efPxkedC/ZMk8px96x2l4f/nf+eN/qglQXeCBQNN3yxf0iB
         qB6w==
X-Gm-Message-State: APf1xPCGhDgQkZU/O2HcF1wVVLftAasfwQWKntqICNnxyg8JRnzjWBII
        0O7o4VlA9HiInLuCOqA/MmKftH8dfXKdj08dfHg=
X-Google-Smtp-Source: AH8x225mgDQUuDAledHoZAs+Snj8pj6IZvhVUfzkIPq1f/6b3zaeuHkQHqOEtoI85XnMU99J7SKp++5CWbg+JRuVT+o=
X-Received: by 10.200.9.60 with SMTP id t57mr1725008qth.74.1517892762159; Mon,
 05 Feb 2018 20:52:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 20:52:41 -0800 (PST)
In-Reply-To: <20180205235735.216710-22-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-22-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Feb 2018 23:52:41 -0500
X-Google-Sender-Auth: XCz5EmNTek7yocebyjwlRNQMp4Q
Message-ID: <CAPig+cT6EmN=PFP9MUQG_J2QFoj8EH3TuXN8w64dYUKYiypX+A@mail.gmail.com>
Subject: Re: [PATCH 042/194] object-store: move alternates API to new alternates.h
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
> This should make these functions easier to find and object-store.h
> less overwhelming to read.

I think you mean: s/object-store.h/cache.h/

> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  cache.h                     | 52 ----------------------------------
>  object-store.h              | 16 +++++------
