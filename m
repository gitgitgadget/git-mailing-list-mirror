Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C6C72047F
	for <e@80x24.org>; Wed, 27 Sep 2017 13:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbdI0NuM (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 09:50:12 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:44212 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdI0NuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 09:50:11 -0400
Received: by mail-pg0-f49.google.com with SMTP id j16so7807179pga.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=v3S0IToOIKW3/mNne9Q1xr5+C06GJ2hc4/SAQEBTjcM=;
        b=cFNK6nVLZSfODzl7Xqy6fCNAg/DGbxYOqOdk26CCCRwTCKiiDhwT2ew+MDYJlP/ydF
         1wnucqllNEhZuaSejvhNKzcBAMYxGjUVS2Hb9Bj31oc9pcSr1NbkDfeDBj+98oLHaCrq
         eEvubkfkLu+7KEDkPVP5OSGpS0yaw0XXgfLSo8vBTnvmf45n/N4nVdVvA9QrFacR70mv
         IYbqHgzZPlSfqiGctfraJ8lUZsPf3GVlwkQ6RyoBy3EG8GBmFVC6Le8Xo35qL6SkzhXG
         LXb1Qhpd6b/8f5PF+R5JWQ4QBE0Q8AKZbK5dwGdFW1VgGnv/Tx4Xu71q0MDdU0yLXerS
         WxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=v3S0IToOIKW3/mNne9Q1xr5+C06GJ2hc4/SAQEBTjcM=;
        b=qQRr2394G6BMqev40JiwKVwH+71jq321TTh7m0vQnUWmwaOUUSuO+uyojA+VvFqqhN
         Jj19KQhQIUSCm7EHAHjysks0skLOFURQ6FbTVcKnIxq0ZDCRmsY6DaLM8aM+zWEMSrrO
         v++o5WubWXpJ1DMf+kvHyHh0WuH0dq2PkxZSCX8rnVH3j1cs1E3rdscyc26gYdhmmJdi
         JfDwXZqeRxxQr35M2G0i7ca+/e8f+YK+BwFeYMCxGLntfLcX1MtDDY8eL+pnpcIqgsKs
         UummWp7l4uAewpnjopua1/P0+AcNMGyGT0hdAWi8bpjCh7s4UNuiFA1K+2+6+u+7C+fy
         EQaQ==
X-Gm-Message-State: AHPjjUi1NWpFth/caV0wnMKx6rc5zk5HBqrHvCA6YMH6Igda0FtaJBD5
        GGmy1BHh3Md9MJL+/fcXgyI=
X-Google-Smtp-Source: AOwi7QA8ZqmMeYm3FWdTmbSjD14+mvkLC35XGBPsz+UdeW2JhrV4VupZSRb36kCO5w2pf9ZOxX/ibQ==
X-Received: by 10.84.131.74 with SMTP id 68mr1353139pld.227.1506520210798;
        Wed, 27 Sep 2017 06:50:10 -0700 (PDT)
Received: from unique-pc ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id p77sm21034283pfa.92.2017.09.27.06.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Sep 2017 06:50:10 -0700 (PDT)
Message-ID: <1506520205.6209.4.camel@gmail.com>
Subject: Re: [PATCH] git: add --no-optional-locks option
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
In-Reply-To: <20170927064026.5xa3ydaggmknvulw@sigill.intra.peff.net>
References: <20170921043214.pyhdsrpy4omy54rm@sigill.intra.peff.net>
         <79ed4c34-1727-7c1e-868a-1206902638ad@gmail.com>
         <20170927064026.5xa3ydaggmknvulw@sigill.intra.peff.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Wed, 27 Sep 2017 19:20:05 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1 
Content-Transfer-Encoding: 8bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-09-27 at 02:40 -0400, Jeff King wrote:
> On Sun, Sep 24, 2017 at 01:08:41PM +0530, Kaartic Sivaraam wrote:
> 
> > 
> > So, if I get that correctly "git status --no-optional-locks" is a way to get
> > the "current" status without updating the on disk index file?
> 
> It's actually "git --no-optional-locks status", since it's a git-wide
> option (it's just that "status" is the only one who respects it for
> now).

Thanks for correcting the command. Now let me ask my (corrected)
question again! So, if I get that correctly "git --no-optional-
locks status" is a way to get the "current" status *without updating*
the on disk index file?

---
Kaartic
