Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FEF1201A0
	for <e@80x24.org>; Fri, 12 May 2017 01:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757437AbdELBOS (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 21:14:18 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36793 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755615AbdELBOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 21:14:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so3986761pfb.3
        for <git@vger.kernel.org>; Thu, 11 May 2017 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ua3NBcxTjWWVUpE7IfulpNJ3/kLl4nqpZ+KCsLjk29w=;
        b=VzULFsvUuylI3uC95x3cfExZfWvAf/qQyHGs2gUJ1Eb+wFuUdTNvPTuFud22JMzVje
         SPMz4LUTPacW5lVVHEItz6x2JkjYyqUECb52Zq70lGOt7yI6EqamG4lWP+1MP0H8gob2
         Q8rSCXJKa5On45dlUaJMGebA5cwvXXx80iMD2cCm6rAvEl6aIo6Ad7/C+wt41LQrxA1d
         o6fjtp5df6MJoFNGka/KjEaPw+oAJZoDOqTy8GdSDgH+Qg/14EYRkby/HIl8HCRsAxHg
         ap4sQWPZsrOhU1z69Z2N6DAlMp1dhCATzbUfICq3732rOskFPPTL5F97vIaoFquOgMWE
         Tq4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ua3NBcxTjWWVUpE7IfulpNJ3/kLl4nqpZ+KCsLjk29w=;
        b=SbUdk+eD4NiL8hYr+O9fZfcrBSi9n/JpoH2O/qw2IHsURA7k+fy9t0XT2rWmZ62jfx
         2zdhftnmVj1x4QdjeRl9RArJ4SZD0C7iUZSsckxdq0Be5dDgkWIDRM1qbHoyDeeKIUcc
         pnbhrmDsiHXiw3KQMEoP/yK7jIe5y5ztjKjBDiTF+yLKzNACcJamntHDZFT2pHDYpu2z
         GCE5v5WwiQCcyjCCCAxJkbRQKk23GkERAlGqMRfzmORnRYatV9OD2fz7UyEviQcY4ze6
         plwsQVSwLSkrd16zgbUUM2SVTownrLEfbUudHwMekMBcZ6f1SGfs4FbE+Xq1eTokKfGl
         Q4WQ==
X-Gm-Message-State: AODbwcAo1dUPocsgO5VFm6PTvltg9fLEW+9HEcXI8DTcNxigJvAeRY+r
        mR6OPuGTZ4Pm2g==
X-Received: by 10.84.143.129 with SMTP id 1mr1988271plz.105.1494551655850;
        Thu, 11 May 2017 18:14:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id f27sm2293347pga.41.2017.05.11.18.14.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 18:14:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
Date:   Fri, 12 May 2017 10:14:14 +0900
In-Reply-To: <cover.1494509599.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Thu, 11 May 2017 15:47:33 +0200 (CEST)")
Message-ID: <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Git uses the config for remote/upstream information in favor of the
> previously-used .git/remotes/ and .git/branches/ for a decade now.

The last time I thought about trying this several years ago, I found
that people who need to grab things from many places still do use
.git/branches/ and their use case is hard to migrate to .git/config,
primarily because the former is "one per file" and it is easy to
add/remove/tweak without affecting others.  Ask akpm@ if he still
prefers to use .git/branches/ for example.

Is it really hurting us having to support these old information
sources we treat as read-only?
