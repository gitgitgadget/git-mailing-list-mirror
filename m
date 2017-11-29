Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 093C320A40
	for <e@80x24.org>; Wed, 29 Nov 2017 18:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbdK2SfZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 13:35:25 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37495 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdK2SfY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 13:35:24 -0500
Received: by mail-wr0-f170.google.com with SMTP id k61so4292644wrc.4
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 10:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JtgbGYRn/bk2+HYX9E2a5bP0Y/0UntT/fgUK+BBy9Zc=;
        b=RN+FIr5MLEP9IS1CxX+gdDdM3tNTPeELd07sF9a7PGiB2eL25u0yDSLcfYRko50AS5
         dlzfDg5uu/8JblHvlJmkTAM7u/s16hDR2L4/+O+UnMp4jkXvrbaunhFOvVs9J9ToFEeM
         NB42Gwq7rNxr0bnr9fTeH4E6+ccXQXh4d65uHtvwr5DGLQ0KXZEi00NwIoG63VBmqEUb
         sgE2lrVdgiqcznbB7NwsfX5MKNWAfa/BkAj1lzAY5GS+hQ3f7uB9CHzchUx+2aHlzNfX
         SLnPHDcBihaDmh0FODTop1UNabxfMKsK4JlVfQq5Y50qiD/nrbxJp19OcNmi2LSux2QG
         gBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JtgbGYRn/bk2+HYX9E2a5bP0Y/0UntT/fgUK+BBy9Zc=;
        b=fubpHh4eluy2sNIcBB7O+ArwrsLX7uftRtQZfWQcCJdGWboPKlVy6X7KfRtBNWld91
         c2OonWqOiJ7w43PAe50fnNZeO4RXqcMFUHTXaDJ/e6IJGDWzLluDzPsLYehNAtMYOyge
         4WlALE0wp7jlQr/mcEq5PZDn2VhVdORQNhrYws5pPu78INoSp24B82vbK6Gt3GclAK/4
         ivekA2VhcGXV+PXVGFg/DUxpA068v+O+GtGwmRLLLUogItR6lm8hW5pjkJHDTYSVjrUf
         ACZ6CojhF+0xKXt1cVdzfGYbW53ADZGBx/N7gRF9qrxs35H3nnQll6WjW+tz2ENSNxsA
         Rk+w==
X-Gm-Message-State: AJaThX53eoLTOt/Kt1TPngblml6JIqGnlDO5Pwak3h2HpKWCP0TRYyVm
        KZHPhOwbFquYF3rdiTewOVI=
X-Google-Smtp-Source: AGs4zMYKF/6mVL1LEcvh8QFyraHrg6VIOv3wnCuNd/kQeB1VG7V1er18qymqTrDQsRasLoZIdUBoXA==
X-Received: by 10.223.179.26 with SMTP id j26mr3534935wrd.123.1511980523675;
        Wed, 29 Nov 2017 10:35:23 -0800 (PST)
Received: from laptop.local (host-78-145-151-122.as13285.net. [78.145.151.122])
        by smtp.gmail.com with ESMTPSA id t135sm1728692wmt.24.2017.11.29.10.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Nov 2017 10:35:22 -0800 (PST)
Date:   Wed, 29 Nov 2017 18:35:16 +0000
From:   Thomas Adam <thomas@xteddy.org>
To:     lars.schneider@autodesk.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, kaartic.sivaraam@gmail.com,
        sandals@crustytoothpaste.net, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 0/2] launch_editor(): indicate that Git waits for user
 input
Message-ID: <20171129183514.wze5trxjfgqxqs7z@laptop.local>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129143752.60553-1-lars.schneider@autodesk.com>
User-Agent: NeoMutt/20170714-87-e4144b (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 29, 2017 at 03:37:50PM +0100, lars.schneider@autodesk.com wrote:
> +		if (print_waiting_for_editor) {
> +			fprintf(stderr, _("hint: Waiting for your editor input..."));
>  			fflush(stderr);

Just FYI, stderr is typically unbuffered on most systems I've used, and
although the call to fflush() is harmless, I suspect it's not having any
effect.  That said, there's plenty of other places in Git which seems to think
fflush()ing stderr actually does something.

-- Thomas Adam
