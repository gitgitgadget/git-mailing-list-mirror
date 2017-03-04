Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 132492023D
	for <e@80x24.org>; Sat,  4 Mar 2017 12:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdCDMYw (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 07:24:52 -0500
Received: from srv1.79p.de ([213.239.234.118]:55056 "EHLO srv1.79p.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752115AbdCDMYu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2017 07:24:50 -0500
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Mar 2017 07:24:50 EST
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6b6f:6800:25a1:abd6:1ab4:a232] (p200300886B6F680025A1ABD61AB4A232.dip0.t-ipconnect.de [IPv6:2003:88:6b6f:6800:25a1:abd6:1ab4:a232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sven@cs-ware.de)
        by srv1.79p.de (Postfix) with ESMTPSA id 186A5220073;
        Sat,  4 Mar 2017 13:15:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cs-ware.de;
        s=mail2016; t=1488629748;
        bh=rWmSoXbv+iQnQG4SLGIqQ0waJXlpXJrfX0RiCz8mSbU=;
        h=To:From:Subject:Date;
        b=WbU8amP81hUl3Fy4h9P2/I9GxmrxNo6/DaiBa7mTCc3iNhlu4Z+/sfrE0tqSmwmtI
         9VGI8ls+Ia3QKmqipdjjg5j1ToGVD6+MkmhfpeJg/jRTi/EfT44G4KIgPZkm5ORr2T
         1sDgBaTqpO87eaaWt5L4FIX+d6vIWXeOUe54I2be9otDptQvcfhZSZgNNx0GMR9RUp
         YgqiNB/6hJFFXYvgqmVT2YcjceFepi6kYk530lG27lhv36NlmYD5nH1KW1kTKdAKfv
         eRTqohVPPnfcR9LF7lUuEksCPLzMXagGYe9evGzjWb/L1ST8lWmE5eMcXArlK6/hqM
         +LQdw7RKp32mw==
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
From:   Sven Strickroth <sven@cs-ware.de>
Subject: git init --separate-git-dir does not update symbolic .git links for
 submodules
Message-ID: <ede7618e-fdf9-7bb6-850b-2b03b4092306@cs-ware.de>
Date:   Sat, 4 Mar 2017 13:15:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

clone or have a repository with submodules.

Now issue "git init --separate-git-dir ../test" which moves the content
of the .git direcotry to the ../test directory and replaces the .git
directory with a .git file "link".

However, for all submodules the .git-file is not updated and still
points to the .git directory of the parent repository which now is a file.

This issue is present for me in Git 2.12.0.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server
