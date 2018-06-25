Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424F81F516
	for <e@80x24.org>; Mon, 25 Jun 2018 21:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbeFYVZ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 17:25:56 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42463 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751749AbeFYVZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 17:25:55 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so6320258oib.9
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 14:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=P+QPAv5EP5LQcujbMGI7gBBtBEOIyE+ntqa24Jc8dW4=;
        b=gKVP273atC0b9A0NBNmyZHitKlnLRrfQ6yFsdD85Dj7M1k1LbHgv/PtEp2jwi9D4V5
         OR2RMJqXEv5M36q/SOl8aSrRLEpwDkWcUbNehEt3/mrCKtR/QxoBHZ6NcHtUIZny2jkl
         7dxLCHsafi2DKjsrFnSg/G1QdCV57GhifLMsuSWGHkC/gTedIzcTMyCMa33kD3MwhxR5
         xmD2N5jfC7YhwWK1eZPHZUZxR1oXnYJNIty4wQk7EIZrugAzW2sK/uMHB/2dhqPWWoCD
         GVJ1Gnn9J0JRE5o7+XrhZOY6h3QnuZnRy8ywDH+tKp1FTjYgInCzvjbXW/W+w2RzTyHe
         WX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P+QPAv5EP5LQcujbMGI7gBBtBEOIyE+ntqa24Jc8dW4=;
        b=EHwt7iUds/diXZjJj/3XhvFKHlHerYzGxy9FHYy/yEvZOJV3vtTvojTsb8r9cVI6nW
         Hxg4pc490OLqOZtUhkm8yl20KDFNlo2TyCU3YG5YhNNbBk1maB363VIB+byk4mIf96bb
         hVfarg4I7jlNWZ/Q30Eye9HlnlnEtdUgmphRH8vJpxCCP0cNI8FujJ+MW2jS00kmEAWf
         y5TRasPMkf9NrVZT7VAY0DLpVj2bjJ49NPxuWTUJneq6QjbeYKTq1vm0Pj9eyMaFyTbS
         G01xKt3416kjzTF1HZZ5a4kVRyuZYJjeUuERQlzwys9YNRbrxvgyJG93x0LWvzPEXcVW
         Q0OA==
X-Gm-Message-State: APt69E0mIKs41gzaA+IY6o4Diz4Oscsr/Q186jjo5C7aEznJ6amfu9rL
        d1e6b+J8jh+SSlh83/siEHQdZGJOCHg=
X-Google-Smtp-Source: ADUXVKJMiOzjFzRkrx5rC/L9PycZ5a5m8kbecb4yvJnUfZqEoXFb16BgpQdleDxHZXtBqXnJVM/z1A==
X-Received: by 2002:aca:8d3:: with SMTP id 202-v6mr8306143oii.249.1529961954407;
        Mon, 25 Jun 2018 14:25:54 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id p128-v6sm7983497oia.31.2018.06.25.14.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 14:25:52 -0700 (PDT)
Date:   Mon, 25 Jun 2018 16:25:51 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, peff@peff.net, gitster@pobox.com
Subject: [PATCH 0/2] grep.c: teach --only-matching to 'git-grep(1)'
Message-ID: <cover.1529961706.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is a resurrection of my previous topic [1] to add
'--only-matching' (in the style of GNU grep) to 'git grep'.

The changes are described in detail in each of the attached patches.

Similar to the series to add --column to 'git grep', I have restarted
this thread in order to not clutter the old one. I rewrote the patches
from scratch today, and have based them on tb/grep-colno, on top of
which they should apply cleanly.

Thanks in advance for your kind review :-).


Thanks,
Taylor

[1]: https://public-inbox.org/git/cover.1525492696.git.me@ttaylorr.com/

Taylor Blau (2):
  grep.c: extract show_line_header()
  grep.c: teach 'git grep --only-matching'

 builtin/grep.c  |  6 ++++
 grep.c          | 90 +++++++++++++++++++++++++++++++------------------
 grep.h          |  1 +
 t/t7810-grep.sh | 15 +++++++++
 4 files changed, 79 insertions(+), 33 deletions(-)

--
2.18.0
