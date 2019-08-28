Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED13E1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 14:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfH1OdU (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 10:33:20 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:34519 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1OdU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 10:33:20 -0400
Received: by mail-ed1-f48.google.com with SMTP id s49so314969edb.1
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RTAMTQ0R8nDymWM0PizcB6M1kh9E4X7Zh50MrpkQ5JY=;
        b=MetvU/+wM/jDN7nACnEjl88ia81+WszMU7k65xloHuwYCZycKpmPNqQpvB15m5w4Yg
         VKL8JZkWNTHupMYVuePjKPdmIyUfrU0YUzp6XgApxNgVtg7u6gYPWjGJUxiUuszsak+X
         ScYL52HbegnsFtAEUdUqHd5M3cx7Z6Oc6ZNcH+IHfFMpAm6inbx5lCLOZWhjUKefXrEb
         p9t1Ycq+SjNF0oR2CaWpsGior5wl+ZGiwdH0CI2DP8RVSMjyFVRjGgK7DVENARfTcHRZ
         pI9q4G4GbDloB/IO/iRfbGHKTw9gXyHgcIabr+ZsNOPigc/6ef7AKwcrNdJV/z/KAis7
         vC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RTAMTQ0R8nDymWM0PizcB6M1kh9E4X7Zh50MrpkQ5JY=;
        b=eDhn7hpU744cgaDJpx5QFalxkawyjG6Qr0E6k/BlXp+8Zx12xRiwMOm2XOW7xz17dT
         KXAXLv3SuhL1yhP20sSkSQFpQrAVHUqTeFGQlhknwZJSvywNbteuuv529sqUnl77sQ4H
         9uElyTswdNWi3+9nD4Ysjzes22KKqpO/s0T7GVjG9DXgov4IvxrMy5DBJprLOxyV2mfe
         ihKu7c5m49OtdA7MTqFIytn74nQ+rLPhusKX45vJTV1t7UdoIVaqKfAy2cltDd7d64ke
         910CHE45u5LUCohQ4dxi4dFQxgFJOCKFd56zrRGDkazlvQpaQcTR93ajwWMAbpATsb/+
         0zcA==
X-Gm-Message-State: APjAAAUorqXNQzNxUSM3i4liYeHgT08JbFXeyDGnMjh0H3PsLknapG82
        o3NRqKLy6nx2VFbdpMFfZdY=
X-Google-Smtp-Source: APXvYqx9911A87pCLW+SZSrKKOgHHRJzW4UBAUDaPQ88VNWg9LKmKPVijubXynOKoRNkCSjnVoCb9A==
X-Received: by 2002:a17:906:1dd6:: with SMTP id v22mr3480347ejh.277.1567002798674;
        Wed, 28 Aug 2019 07:33:18 -0700 (PDT)
Received: from instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal (1.133.65.34.bc.googleusercontent.com. [34.65.133.1])
        by smtp.gmail.com with ESMTPSA id w14sm489155edf.7.2019.08.28.07.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Aug 2019 07:33:17 -0700 (PDT)
From:   "Giuseppe Crino'" <giuscri@gmail.com>
X-Google-Original-From: Giuseppe Crino' <giuscri>
Date:   Wed, 28 Aug 2019 14:33:15 +0000
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Giuseppe =?iso-8859-1?Q?Crin=F2?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190828143315.GA4477@instance-template-2.europe-west6-a.c.vaulted-journal-250706.internal>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
 <20190823082900.GG20404@szeder.dev>
 <20190826191455.GA25695@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826191455.GA25695@sigill.intra.peff.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 03:14:55PM -0400, Jeff King wrote:
> But we'd still need something at least for
> GECOS, where "Your Name,,,," is common.

As I understand this, those commas are *not* removed by
strbuf_addstr_without_crud(). Instead they're skipped from /etc/pass
-- see `ident.c/copy_gecos()`.
