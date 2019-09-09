Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0CF1F463
	for <e@80x24.org>; Mon,  9 Sep 2019 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfIIVT0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 17:19:26 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:37321 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfIIVT0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 17:19:26 -0400
Received: by mail-vs1-f44.google.com with SMTP id q9so9815068vsl.4
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=tNY+KUexBPcLO43qV0oPp2bQAUN1ovmA0G0NNTSBGBk=;
        b=vUnEf9QrBKO9SiIUwrjoI90LHG781ztqb3TqAYN449QvTQsf3mcSAEJS2od70myEXo
         4I8TjeXncmO0vlD+tMrWC3u3c58AjFX2x2LW/rwDGpXpgq+YgvDLOKnOp4u7GFQSvCuH
         eTI9E+W0JChUY8ESFnY4BtbjP+XuR9K0bacsaVhZ4LoV3UQHn7Tjz1cnsxB+ayxdr1a4
         usHVpdeIIAYlNjguZD5Ejkzl5Z8H8AD8na+wqzzKWhmk5MniHBZ19p95asn5l2Eq7PQW
         wA+oSnpq8AdhCMLd5Rv6sk7SA/8by2D/tgHwKBpFrw47zauOmCz80BVe6rSYCGnPz4a/
         H/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tNY+KUexBPcLO43qV0oPp2bQAUN1ovmA0G0NNTSBGBk=;
        b=T4wBHzvgmrSpuFQOpnVh8nwjcNKbBorFLSxsxHSpFH+YVHdSPck5qLOu//pOLZagsF
         4CZyOJLhbzFPXCdrEWdvnfpRkRFRz6ojMnxB9ns3JW4RAuf+zO6bt50bQQbIHcUWVxmJ
         PV93wpC7TRCwsrqYRL9xLVBc96mvmmsLVK3adbHLQ8UhJ7HFaapOM0/8/DXmtJac02cX
         38YNY32yr9lnv+ZPLgXjxH/7QY4TlXdrL00yT+yyU86MmKHQDmRgekWTgUmnZUjR8Tn2
         bd/xjB1wC44Nd26vEbp6XTgxf6ZXfiIMUskFhMXpkYMco1Z3h0xRvyNHHMAkb/1qrCO+
         Gm5g==
X-Gm-Message-State: APjAAAXAQd7SMbQw/yykqw7aydt5X8DpWckJnVxPCsw8fenvveMo4Wjz
        6g3Mcb4YqZ1FgRrG8XGsvg3m9NzzVCVvTE+8BbJFCF1q
X-Google-Smtp-Source: APXvYqyIz6S/sa2dr+Zunv/Gu/boiSOiQtG7xV810XXyb23fdlMy6v5unAesMBpdP3IYuySRYkkelYVz5PgfE6b4O2g=
X-Received: by 2002:a67:e3c2:: with SMTP id k2mr12923853vsm.77.1568063965390;
 Mon, 09 Sep 2019 14:19:25 -0700 (PDT)
MIME-Version: 1.0
From:   Sebastian Gniazdowski <sgniazdowski@gmail.com>
Date:   Mon, 9 Sep 2019 23:18:46 +0200
Message-ID: <CAKc7PVDT0JXCAW=aON2jXidCgib=SjoUXU6Yh4t+xWB8QW4NPQ@mail.gmail.com>
Subject: [BUG] Password cannot contain hash
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
if the password contains a hash, then it's impossible to clone a
repository, either with https or ssh protocols. I've had to use a
`gitg' GUI to clone such a repo.

-- 
Sebastian Gniazdowski
News: https://twitter.com/ZdharmaI
IRC: https://kiwiirc.com/client/chat.freenode.net:+6697/#zplugin
Blog: http://zdharma.org
