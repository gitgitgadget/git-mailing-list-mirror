Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35DD82096C
	for <e@80x24.org>; Mon,  3 Apr 2017 10:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbdDCK4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 06:56:54 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35643 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751435AbdDCK4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 06:56:53 -0400
Received: by mail-wr0-f193.google.com with SMTP id p52so32508919wrc.2
        for <git@vger.kernel.org>; Mon, 03 Apr 2017 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=yXIxo898fUom/mWOm6yi2kOKVVvzcn/liwGm8AM4u4w=;
        b=JiIZXGcSm3bfMFcGULopuK/UjLKwUcRHTAoIc7aFraC3AMSpOOHo/O3c9FqG2496QE
         dE5vLEIsO3QDfLtSZY/UAAmdTgischzx0/gbtefLKiFB4vSe+6atOPGO+tqQfnGOimUj
         ebrCM02CSDNKfe6I8UYKfsY34HakaWziRKyacX2kptA63If6BGlZZK4PWtlmZ8PS/dwX
         Dwj5h0i2UQa2eYG7l3AfVVlVsgXgVwxw8EzMOb3FoBfRejNLtZiGyq/QusatDbgRfxXf
         wwJXqDay6nQDkjcSB/EButQcjOCisR1LKIMS+/+9tcMKIBkcalL/4mi5cRb3JIktKDMD
         JqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=yXIxo898fUom/mWOm6yi2kOKVVvzcn/liwGm8AM4u4w=;
        b=A1uaLTZE+T4iB/NGh7Q1Nr2CIq0uecPbfs8mynOQZwuO+6pYSlY7zZesPmng0JLSt2
         Frvj+ScYh/C/jLPpqdCKWQ94d7HgKfUpNqKXDOP0tJQZSdFeKC6TBo24Ym+gyImwNIhM
         4CXKvAj8idT0/Y1dCGbDFgxFu9FV20GVZWxRwHJwFYoUFyDyX0jj3GhmUtBhWeAUku7v
         ldjBfMDhGfH+74H2NZZ90Fb1CCWvflyhFXOcPPEYBdR2akcawpJ62EubSbjzEO1bQe7+
         O9Qp8OCqdGD06P83bl8lujUhRGnzhKVlyYPuBzSxre0V0weg8T2eRDNHY5fAkwwKWQcL
         TQlQ==
X-Gm-Message-State: AFeK/H3jyh8G+kvKu9s+LsL6O4FuGroN0SZq2xLE3i7Fr7sDrJ6gOFfS
        SVE2Uwm7DcU+Pw==
X-Received: by 10.28.134.70 with SMTP id i67mr8830146wmd.124.1491217011710;
        Mon, 03 Apr 2017 03:56:51 -0700 (PDT)
Received: from localhost.localdomain (x4db1f9bd.dyn.telefonica.de. [77.177.249.189])
        by smtp.gmail.com with ESMTPSA id u66sm13836708wmd.24.2017.04.03.03.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Apr 2017 03:56:51 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        gitster@pobox.com, git@vger.kernel.org
Subject: Re: Terrible bad performance for it blame --date=iso -C
Date:   Mon,  3 Apr 2017 12:56:41 +0200
Message-Id: <20170403105641.16912-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.2.613.g9c5b79913
In-Reply-To: <58E1F239020000A100025732@gwsmtp1.uni-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In the other case (for the user bored of waiting seeking for some
> entertainment ;-)) a "-v (verbose) option could be useful.  Or at the
> very least: If git is expecting that some operation will take (or
> already did take) a lot of time, give some message explaining why it
> is taking a lot of time, and maybe how to avoid that.

It already does so by default since v2.8.0, see aba37f495 (blame: add
support for --[no-]progress option, 2015-12-12).

  $ time git blame sha1_file.c |wc -l
  4026
  
  real    0m1.744s
  user    0m1.672s
  sys     0m0.068s
  $ time git blame -C -C sha1_file.c |wc -l
  Blaming lines: 100% (4026/4026), done.
  4026
  
  real    0m3.832s
  user    0m3.716s
  sys     0m0.112s

However, after a short peek at that commit, it only displays progress
by default when stderr is a terminal, which might not be the case when
invoked from emacs.

