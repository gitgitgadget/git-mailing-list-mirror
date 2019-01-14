Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75B5211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 15:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfANPDp (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 10:03:45 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37931 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfANPDp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 10:03:45 -0500
Received: by mail-it1-f196.google.com with SMTP id h65so12521862ith.3
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 07:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s8GPDjSb07XyU8QMdl6bT5fUGWDdbos4R48v6bHCS0c=;
        b=MomQRw3uykHPSvWPOEHLjMOzjuYuoiPCIPusnSnOpJlIc6WbxIdwd7Bih/a+i5O72d
         I2CFvbmRJSrKY2/YvOX94pImhpx59WTpX4T8BW7wvTzNnY5xPEkiV3j/PLWz7LgXOo8h
         4E3g9ljkfEJnAFGOh/xqVHy7wRhqNDb2eoc2AtJ8Z/eNq1cJi7t33fpjjZbv8F2yQ5Gf
         LI4a5CL3W/v7nJOTbikOSGf0T5pkKKNdv1mDda5pPtLyK1tDpPl4u2CEuVIkSsc2MuAD
         R0Wca/MmUpO2LU+PkU+NggTBlngLaC1D+mVjOixpniT+tJaTYGinW+E657dodKr+bzj8
         j8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s8GPDjSb07XyU8QMdl6bT5fUGWDdbos4R48v6bHCS0c=;
        b=Q07dTxHnVnrYYJOr9OBBvRwhd0E68lSzfRXQe2hBN/SKUjRxZW1nI/eU3T5+ZMBWUH
         Xsm/JK9/k6ni9BLiN1Wztc85lYcsnMfTo0dJNBfwX9y8irT1HkDQPXM//5LdPT6ivaJv
         xsX0QXsIJqR+hqPN5oiPy+31NA4yIWEUyVJ+9zlfIneJevCUwAYlku0pU5zs9iNO31+o
         3OjFn5TuO7Bb6esdLHngZZV+jh0kUfrvhd1ayeczlGt5E6Ra5OnSgO+eK0hPuN71N+pd
         opj1xbVzLR40XJKOMApo4YDvnaf8DG99U5LfFNZDUJldjKff62Q/pkrUb8tNZslEijM8
         qWlg==
X-Gm-Message-State: AJcUukcl7IQSmgstH4FTqQkYr1HKCKQPY5BNzZOcve3/meNeqbkhzjLZ
        6/+vOxIAfASMorPdh1Y/oWfjAYBscQtIsoilFZ7RuFTp
X-Google-Smtp-Source: ALg8bN7WqM0pNH/YZg36WTpL4e1KgKpO063nFn/jEolbBlrusR6cssxAcik/p+nDOoBxdUJXbp+YwtQ7SrEhbdl1GOc=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr8150270ith.123.1547478224408;
 Mon, 14 Jan 2019 07:03:44 -0800 (PST)
MIME-Version: 1.0
References: <002601d4ac18$83d4a210$8b7de630$@nexbridge.com>
In-Reply-To: <002601d4ac18$83d4a210$8b7de630$@nexbridge.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 Jan 2019 22:03:18 +0700
Message-ID: <CACsJy8AEi4gzRpHY+ehFz3GEOaQ0rmdC2kKMpUSp80cdQbuc6g@mail.gmail.com>
Subject: Re: [Possible Bug] Commit generates GC repack failure
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 14, 2019 at 9:51 PM Randall S. Becker
<rsbecker@nexbridge.com> wrote:
>
> Hi All,
>
> I'm trying to track down what happened this morning. We had a commit that
> caused a background gc to occur. What happened was:
>
> $ git commit -m "history commit ... "
> Auto packing the repository in background for optimum performance.
> See "git help gc" for manual housekeeping.
> warning: The last gc run reported the following. Please correct the root
> cause
> and remove .git/gc.log.
> Automatic cleanup will not be performed until the file is removed.
>
> fatal: open /dev/null failed: Invalid function argument

sanitize_stdfds() in setup.c can attempt to open /dev/null then
redirect stdout and stderr to it. I think this is part of the
daemonization that is done in background gc.

> fatal: failed to run repack
>
> Obviously the /dev/null open was not right, but I don't know where this is
> in the git code to investigate further. Any pointers on where to look would
> be appreciated. This started happening at  2.20.1 on the NonStop platform.
>
> Cheers,
> Randall
>
> -- Brief whoami:
>  NonStop developer since approximately 211288444200000000
>  UNIX developer since approximately 421664400
> -- In my real life, I talk too much.
>
>
>
>


-- 
Duy
