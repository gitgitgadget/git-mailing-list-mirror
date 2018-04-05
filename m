Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4F6C1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 23:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeDEXdF (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 19:33:05 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:40519 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbeDEXdE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 19:33:04 -0400
Received: by mail-wr0-f179.google.com with SMTP id n2so27717129wrj.7
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 16:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=H9xGSpxXkVEcUhlt4Cg0V8CVIboyWsCOXah0RcDrMf0=;
        b=dVpAk3sZ1Yl4GKIKwCFi/OnI7yOuGetvMHj6tBueuCLZptWrf8UGg300eWuOjH5YA1
         5i5OlCpZP0WOaHeE+xD2qlI1GxU/bU+mWudi/5e7bY3aZbQGvONK3KrE83nxbV+v/9EW
         5i3ee9qc83op9o7P0hgbcZkDlFGLjh+Romr7swo68xai8fWQyj9F/LZq7XUkcaYeVWxy
         cZ0jwcQTRE+VaoFKzshn59y75/gp7GH045U2aXaMY9hEFg9M7izOuO6SkFe/l1gQ2ou6
         R49s2HX7tchpXPCOpHkRbJBp7nwipgPlhaiM2GWPMI67kY7j4qZsW2+cQWI6aqE6bwph
         nN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=H9xGSpxXkVEcUhlt4Cg0V8CVIboyWsCOXah0RcDrMf0=;
        b=mo+JvcC4QtzgqmoOn/HMR+SyCjYVqoyLScJDZa2/aJh3O9mtdBDbqDuOYaFxIEUAca
         OrHU7KISneQJh5N+Z7l2CYoQOjyiMy4JXWKq4wsWQU51+2utqIZcWNXQZ/Zrd8EmCewv
         AkjRRiKCcLM0fitg02uWqeRKykhUyS3WNbdxfCXLmBiqPGatqzjfpI85/u+ood8/yPPJ
         wlhisYPwUxcXgIBXW9aThN0RaM6nYLdnN7QcOgqtOL7c2F2YXuB1ef8BQXRCfvKvAezS
         4j/0WveLGxykHVsU5bKqOkGrY32nRLSMHs/yjDXRgWDvcbVSTZt/gw3XCEPPSftoQjAR
         OCmw==
X-Gm-Message-State: ALQs6tDmddgBm/HueKryJOa2Wwu0C7i+KmZt6A6ez2mgQV2j4KaN6I0D
        sVGT3Oz4mis0dlLbqO+ngwj7QLVMUDNWUTxUBSBVlQ==
X-Google-Smtp-Source: AIpwx499cDne2W7L0GnGnbrOg15CAG8FNRUzaLtNwKu1LNpvCCbpfl6emH1Bhu745POwPKGaLjwEH8+yQm+e8gv66XE=
X-Received: by 2002:a19:c1c8:: with SMTP id r191-v6mr13978502lff.45.1522971183472;
 Thu, 05 Apr 2018 16:33:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:9690:0:0:0:0:0 with HTTP; Thu, 5 Apr 2018 16:32:42 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804052131070.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1522190580.git.wink@saville.com> <nycvar.QRO.7.76.6.1803301231430.5026@qfpub.tvgsbejvaqbjf.bet>
 <CAKk8isqA6Ru05kRJ+xiVHEkzPgH24cKUZbbgw2tEnw4rhafDQw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1804051536080.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAKk8isqGe=H7aEtDZtKTpzQMxeshp0oC6tMwhA9rW=PhLt3buA@mail.gmail.com> <nycvar.QRO.7.76.6.1804052131070.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Wink Saville <wink@saville.com>
Date:   Thu, 5 Apr 2018 16:32:42 -0700
Message-ID: <CAKk8isrEsi7V-r2LBcOSjhXK7ipx8_1t7-nSW7P9LgovbcF=tQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] bdl-lib.sh: add bash debug logger
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 5, 2018 at 12:32 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Wink,

> Note: I have nothing to do with including it. That is the sole discretion
> of Junio (who is offline for a week or two, if I understood correctly).
>
> Ciao,
> Johannes

txs, I understand.
