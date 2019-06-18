Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61CD21F462
	for <e@80x24.org>; Tue, 18 Jun 2019 16:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfFRQza (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 12:55:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34712 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQza (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 12:55:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so323931wrl.1
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 09:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PKHGEixIUuEpkt8+rFGX+y53tom/qJRX5dDJRDKuFB8=;
        b=tlZC1aDvDFemcoJRhtvjVU5ru8nGA/Z+ndfsPCU6rKTdlFRjxGxdsnhJ9IJBsxzYmI
         PiwWV7nWyhL3ix2X7wvp//sk0BvqJdAgJXnPuqHdPGi8y52xwELw9cDrd20dssvQVe1N
         SMs590EjTi7VbQXEke6VIMK5QewWztoS3Mb3XprtR2gxz1Fbbg7mQJ7gjP7sk9Un+VcQ
         fIuf4sQ7/wczRoNgXsHsT5gnxhrcIsLC3/HuURJKo1ff/4KTdqlLfgF6KS1p/qTXld/R
         TjW4d/SLQC3ZIUEDlEjM7JM6+BxuiHm88EdZz9Bi9B7i3Ey67QvRLXI9Gpa7WhRJYe+5
         WnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PKHGEixIUuEpkt8+rFGX+y53tom/qJRX5dDJRDKuFB8=;
        b=qkJqjQRkd4z3CGtr+lIMLWKrPDqxtdpn8QdEc0I3J8nC5y/EVJzSatINhVfTWayXCB
         4zPnJuITf4uUHdyMujBLWfeIs0QQXpzgcJYNtErfTs8PuW3NKbJuk7GKTrFQWpUARizD
         Iai/wBxBYG/sk1eIJy46SGvrkUKCw727dC8BJ9+/jhTn6GOV8aW37vyO6CQhpjNqGYWf
         ATp1QgPfP5t/FMd3lmajVfTw0D7D5ZkmbI7udgIRxqaCP4k4E1yNAe2pNNA6S/giELmN
         LbJVVcIwRsjTH0pO1LjOVK2+wPYgGBha2T8sqVBWolkn0jo8OUMrph8xFSVX+c1sG/nq
         AWZw==
X-Gm-Message-State: APjAAAWB1t1gtKQG/XQ9P+MqSiM2XG+4ExXtaFJvet/BpjtlgrfEOXbI
        tPDTKbKp2LMXtGnB6LtHdgM=
X-Google-Smtp-Source: APXvYqwDErEtNEiecM2d+bmIRXbbdfTeytkpSilKYm3cTSecR+x3CHuyJ/CYfQPg40b5YJmCYSBPcA==
X-Received: by 2002:adf:dd51:: with SMTP id u17mr66258866wrm.218.1560876928278;
        Tue, 18 Jun 2019 09:55:28 -0700 (PDT)
Received: from szeder.dev (x4dbda1c5.dyn.telefonica.de. [77.189.161.197])
        by smtp.gmail.com with ESMTPSA id o185sm1742402wmo.45.2019.06.18.09.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 09:55:27 -0700 (PDT)
Date:   Tue, 18 Jun 2019 18:55:25 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/10] t: add helper to convert object IDs to paths
Message-ID: <20190618165525.GN31952@szeder.dev>
References: <20190616185330.549436-1-sandals@crustytoothpaste.net>
 <20190616185330.549436-2-sandals@crustytoothpaste.net>
 <nycvar.QRO.7.76.6.1906172102180.44@tvgsbejvaqbjf.bet>
 <20190618012943.GB8877@genre.crustytoothpaste.net>
 <c9be7464-21f3-6651-500d-14137f0f1c0f@kdbg.org>
 <nycvar.QRO.7.76.6.1906181647480.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1906181647480.44@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 06:15:46PM +0200, Johannes Schindelin wrote:
> > Regardless of how it is implemented, I have another gripe with this
> > helper: the way it must be used requires a process: $(test_out_to_path
> > $foo)
> 
> Indeed.
> 
> > And looking through this patch series, I see a gazillion of *new*
> > process substitutions $(test_something...) and $(basename $whatever).
> > Can't we do something about it?
> 
> I wish there was. Unix shell scripting has not evolved much in the past,
> what, 3 decades? So I don't really see a way to "pass variables by
> reference" to shell functions, short of calling `eval` (which buys
> preciously little as it _also_ has to spawn a new process [*1*]).

> Footnote *1*: Theoretically, it could be a *ton* faster by using threads
> on Windows. But threads are pretty much an afterthought on Unix/Linux, so
> no mainstream POSIX shell supports this. They all `fork()` to interpret an
> `eval` as far as I can tell.

'eval' doesn't fork().  It can't possibly fork(), because if it did,
then any variables set in the eval-ed code snippet couldn't be visible
outside the 'eval'.

