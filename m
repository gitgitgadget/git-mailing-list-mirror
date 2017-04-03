Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD48E1FAFB
	for <e@80x24.org>; Mon,  3 Apr 2017 19:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdDCTkW (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 15:40:22 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33278 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbdDCTkV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 15:40:21 -0400
Received: by mail-pg0-f50.google.com with SMTP id x125so129811625pgb.0
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EqFV1eJT9Wpp5x3ZzGCfllLRU14OKPsSFlQPd3QSR3c=;
        b=HxBgWLTC++M+is7N9g/kVU7FXy5EDAN5HM5lrdN9xGtNnPdKG8bWVsnJ6h1tZ72h0q
         mcscGzm1iKWWq7a6bgPx1LpsgnrmJxfHmcFwkoYWU7UoTbDTdURBRgoN97fjlE6IajHy
         P/QTgBeiIktuU8UzJIe5vQC5ROuTriUU7rFsWQeVjKJ+fXb4hlJIV6UXQlmisHD/xRUr
         HEamw5hb+TdpnKk0//qc3H0CKECZjwtUFHPOWZHXUsVBND+ew+JNBW/44Ijk3U8VpcBu
         qtKA1K9EGUYd1sXnwJWH7p306FieqQF0EXDUUaVi0Wd4Ct4dRpjUXCCfC+P8L94KiKVi
         hxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EqFV1eJT9Wpp5x3ZzGCfllLRU14OKPsSFlQPd3QSR3c=;
        b=LzHY8Zr4hwUXMWVSSqpG9qdkYyuA8amgqJWSx1MZOURUkkgjAVIVOe8YxNNexJiBfp
         OsqBsbNnmAJOITpy4HmB8r+VRmCu4BgM48mDS7V7ZjBwercGfAOlaJGBDNxNM5zESjg2
         fDfwtRjJzVDLvZYyq1QhmJviP7Uf2xSe25IGhfNWvJhPRB/flZAPTTYgdZbBotyVhdEO
         dHTo93SSFODxlkFR0iCYdHxLEwbjH3mneeuI3Rq0K7iqcNHJO6XS1uT17ItZNEIaZZMi
         9BcjGILEIalu4LhYUYh7hy0XF+na6JN012pZ0NDRyfDb9FgAobxnlRe+vgn+3Ldp/NpR
         ik6g==
X-Gm-Message-State: AFeK/H2cfeoTaks9uWyARm0oXFg6mtGBNw2rmdSROzVRE9RuFcm+AgSD2j1RF5lgbvBgxkMbaVcOJFvR8Kz1ABjl
X-Received: by 10.84.232.131 with SMTP id i3mr23698686plk.172.1491248421143;
 Mon, 03 Apr 2017 12:40:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Mon, 3 Apr 2017 12:40:20 -0700 (PDT)
In-Reply-To: <20170324120433.2890-1-pc44800@gmail.com>
References: <CAP8UFD3xOMbXgH5JATS7-cK_d0YA7Mvkk-ZpLh8sn-KYNm3wxg@mail.gmail.com>
 <20170324120433.2890-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 3 Apr 2017 12:40:20 -0700
Message-ID: <CAGZ79kbmriQoJgjF0-Kv1QzU2NWn=2EGN10CbNTKYO4zCBMFaA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v4] t2027: avoid using pipes
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jon Loeliger <jdl@jdl.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 24, 2017 at 5:04 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Whenever a git command is present in the upstream of a pipe, its failure
> gets masked by piping and hence it should be avoided for testing the
> upstream git command. By writing out the output of the git command to
> a file, we can test the exit codes of both the commands as a failure exit
> code in any command is able to stop the && chain.

Sorry for dropping the ball here.
This patch is identical in code that Torsten reviewed and has a
slight grammar fix in the commit message.

> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>

I reviewed the patch it it looks fine.

Thanks,
Stefan
