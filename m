Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C701F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 18:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbdAZSqt (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 13:46:49 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:33010 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdAZSq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 13:46:29 -0500
Received: by mail-io0-f178.google.com with SMTP id v96so43835072ioi.0
        for <git@vger.kernel.org>; Thu, 26 Jan 2017 10:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GtYZBXNud+FYWwyGIcMMT5XosDAza2x+l//OpyomfrY=;
        b=fks9Up0tSNWuuIbc+WN4JwrPRg2I07T3Z1IUfhANnxO11BSvZKVSdKwiuSVuQL6mWp
         B7x4no2zUYJ4sSQACxqJu7ml6xtKLORvjF7q9vq1tJMAx1JW8jB7OivmszUJYGg9llv8
         fMjft/DyBtK0twx79EoxZRSPLEgW26/eHKGcrl5fZLaOtS5sCqw07Fs4Z09I8v/xRgwy
         NyZF/fRjeo/oBjP5C9Kbat4uVl+ycQ7OJdzopNfhXC6OMDM3CJ5U6RrNaKquLKiIYK37
         cKQtvAiPNodbzG/PtZWqISPo2sEcmzFQkTtEcd1/LF6ZEcSrNzEI66FRZc63TRSzFDyk
         VOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GtYZBXNud+FYWwyGIcMMT5XosDAza2x+l//OpyomfrY=;
        b=TjztwT1Sfi8IdP+X9xhPyijAM3bYAlIpEX/it6ks637ciIu80ZtxciGKNfAo09FHyf
         xR38f5vCpTQhFt2opqoQY3xSQefeLR7c37h5e9BL5Jtj2ziDQShEi9dAAfAGVEs+H9dR
         fKp43AlvhTBt+4hODXjZR7r2foGCTD9V7ak3sRtDcPybws1XFdkmdJgL8yWkz50U0Cvk
         wF995sGYeh6NCP+alHxcLCvoyzIUlgqiSxPYffCCc2WSH+sTWa8XPa3IA/3oOW7UjNay
         5hRhZUddaQYILWrxfB/SCFpo3sH4DKoyh9+YwzQ/l2rQjD2LiDaROy2m+r82NPL4H/0M
         qEeA==
X-Gm-Message-State: AIkVDXKjB9SrzLipIX7wbUFAlR+cBfMagZK3L36MLE74CMwBM0qUj9MHAOmaR05BKGJ/o6O5vMNySgRcObYSFTqs
X-Received: by 10.107.16.14 with SMTP id y14mr4035952ioi.164.1485456364866;
 Thu, 26 Jan 2017 10:46:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 26 Jan 2017 10:46:04 -0800 (PST)
In-Reply-To: <20170126183030.28632-1-marcandre.lureau@redhat.com>
References: <20170126183030.28632-1-marcandre.lureau@redhat.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 26 Jan 2017 10:46:04 -0800
Message-ID: <CAGZ79kZkxnoKCyk9teQnEPjsnS7iEorZALY4dXE8Fy78ifur7g@mail.gmail.com>
Subject: Re: [PATCH] git-bisect: allow running in a working tree subdirectory
To:     marcandre.lureau@redhat.com, Duy Nguyen <pclouds@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ Duy, main author of the worktree feature.

On Thu, Jan 26, 2017 at 10:30 AM,  <marcandre.lureau@redhat.com> wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> It looks like it can do it.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  git-bisect.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index ae3cb013e..b0bd604d4 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -1,5 +1,6 @@
>  #!/bin/sh
>
> +SUBDIRECTORY_OK=3DYes
>  USAGE=3D'[help|start|bad|good|new|old|terms|skip|next|reset|visualize|re=
play|log|run]'
>  LONG_USAGE=3D'git bisect help
>         print this long help message.
> --
> 2.11.0.295.gd7dffce1c.dirty
>
