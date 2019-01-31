Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFD51F453
	for <e@80x24.org>; Thu, 31 Jan 2019 13:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbfAaNJ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 08:09:57 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36242 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbfAaNJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 08:09:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so2503521wmc.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 05:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gCruDaSK8PgmkPSC0HzHXhYQHM46aZa6owe3I7aLRxs=;
        b=hDgdX3/jD9xoOCT2jHpz2gXffC2ShELWuu5aTPlByxWv1EUxjWhBUjcpBcimgKZHIZ
         fpnfzzllzjjq1cb+JNBnKRDYk0kWyd3gKxi3lyOfghgOv/k5/DFLRpZiqIGc4ZLuvAP7
         zLkQPN9/o/0nSQJQZLvOcSwh+bBreDpgbYHlP0GiFx6gGN3lv5YgKfPfgcu9xFtZcdXe
         2dSaZMMSUvqJy7wrrA9abakKkvU84fGzKey+V2J8IFbx2MUHhHu2P/wsvLSpNZ8gwmgC
         HJUM1hr7SnbpAFbsmfR0KhRpkU6gxMvKbBB9Xv02pwJiB1ZTE8rBM5hfU8TjbQ6EHPMU
         LSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gCruDaSK8PgmkPSC0HzHXhYQHM46aZa6owe3I7aLRxs=;
        b=SIJNo4e7fb78FOM044Iquhm5j6trvQCMqk2P1Y94PkQDoji6HGqFPcGKzx7hb49tWl
         g7SqpB67jp9szyhenQqu3X9GVMCQKeny9ozThwVn60Tq1/+YLBumpNmLwF0WVIvTlUvo
         kpTZRYj+/11aEBlw1obtrk4xWUwkJq4sWGdP5R6AYcMYtLqEkJgs2WvwXRix521sSmzS
         91zlsysylEHFnb2xs4YBPMduJs/eMPsSRMiqbVl7MgmqneJ/wAiu0L5jIgM3Y/pTF6TH
         Z2eQHv9vtvgGrbTvdtvwgR2/mC/Bia+0gmj4Mr4hBgyKiYTlttJ/OZQ2MOQV0JiUIfE4
         hkeg==
X-Gm-Message-State: AJcUukcpy49Dt8LKRgmccfkW3e3/Grb5LnoSrB+FIIEnLTqSzOlMM+tA
        +VuUOaHkSiEfL2ttggnhcEqstRrfEEQ=
X-Google-Smtp-Source: ALg8bN5RLAOvLz7J9Kn16nlUFoymXVsE8oPLeD3Seh0PBYhPNxEpkpYGdIRfdFErxF1CcOKWNbnAeg==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr30808395wmf.117.1548940195651;
        Thu, 31 Jan 2019 05:09:55 -0800 (PST)
Received: from szeder.dev (x4db675b2.dyn.telefonica.de. [77.182.117.178])
        by smtp.gmail.com with ESMTPSA id x10sm6274036wrn.29.2019.01.31.05.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 05:09:54 -0800 (PST)
Date:   Thu, 31 Jan 2019 14:09:53 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 08/19] checkout: split part of it to new command switch
Message-ID: <20190131130953.GJ13764@szeder.dev>
References: <20190130094831.10420-1-pclouds@gmail.com>
 <20190130094831.10420-9-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130094831.10420-9-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 30, 2019 at 04:48:20PM +0700, Nguyễn Thái Ngọc Duy wrote:
> diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
> new file mode 100644
> index 0000000000..953c9747b2

> +--orphan <new_branch>::
> +	Create a new 'orphan' branch, named <new_branch>, started from
> +	<start_point> and switch to it. See explanation of the same
> +	option in linkgit:git-checkout[1] for details.

Copy-paste error?  An orphan branch, by definition, doesn't have a
starting point.

