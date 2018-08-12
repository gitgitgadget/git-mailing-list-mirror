Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B9F1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 00:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeHLDGF (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 23:06:05 -0400
Received: from avasout06.plus.net ([212.159.14.18]:52867 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbeHLDGF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 23:06:05 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id oeGifyM92WLW2oeGjfN7CK; Sun, 12 Aug 2018 01:30:05 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=fJUXI6Se c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=RAe_SfsMxLjwZEMIz7sA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Christian Couder <chriscool@tuxfamily.org>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: function get_delta_base() is a file-local symbol
Message-ID: <b5b25177-38de-14ba-5d83-c8909ce0addd@ramsayjones.plus.com>
Date:   Sun, 12 Aug 2018 01:30:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI+dCHWgL4E6rvkQFpGg3njh+1cup/ONzWT0kqzyOMucBgJPF3UVoQEFiflA6K693V6jBs2bgypWROCdhD9D06K2cUYWZ429JoBjKqgC4k9RJuOW9hyl
 0nU97CyrxXm1Ujb18lhJjCv0iSoHW7zdBNyvVVgYfdH4nFsXhm1q1UEVfnukwbVjnhvbzPQCAcKfsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

My static-check.pl script has pinged me about the get_delta_base()
symbol from packfile.[co]. The first patch from your 'cc/delta-islands'
branch exports this symbol, saying that it will soon be called from
outside packfile.c. As far as I can tell, no other patch in that series
adds any such call.

Do you have plans to extend that series with additional patches which
will add such calls?

ATB,
Ramsay Jones
