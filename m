Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72463202A0
	for <e@80x24.org>; Sun,  5 Nov 2017 00:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbdKEAPm (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 20:15:42 -0400
Received: from mail.aegee.org ([144.76.142.78]:40703 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751777AbdKEAPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 20:15:41 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Nov 2017 20:15:40 EDT
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov@aegee.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org vA508Fqb018231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1509840496; i=dkim+MSA-tls@aegee.org; r=y;
        bh=xgKtFzZS3sdTGk+b20/SPfp3Gb2sFEeQonFFi/wh8Fg=;
        h=To:From:Subject:Date;
        b=dC2IxIyKKGn4JTePs06WAErDGDyKI9TLbCMwfafrcVGM6CTvvjXAJ02+sL2BE3bDS
         ztYz0RmK/m+N88X8m+m8ipD/F6yPPmtaHQAyVC/e1CCm4BmDjWTpWy18+FBKFyBwqc
         Xl7GasIMiYgH83vjnVnQ1og8i5SyvDFGn8qgW34ZLN+y+gyW7dzXps2tsPFM7V+OZN
         L6QlaQr7TWDcU+N6AQ7ACyi4Tijnfmwd+Tv08DFgpbzk4AHEmDl1f/oiaTO8D3oulR
         qTEW2S4395Z03qCVwNSSlNllC/4RGhr43yMY0yW2aEAWD3k4+bt8cxHgDLMevj4FyC
         rWbopbZ8tyzlp2uoZHNLcktnjTc8AZGLsu76qURszR2LSf71oE0LSN4HO45sia1Kr+
         ISq27SfsSEs7EhtGKBklz3C0HQu0SVvhR1p/lgRRFO+ZWgjY3jf9iy3fzuzgDGULzm
         qtY135FITKgi7fxG7XBffEvTNnTpEuip4k3Ki8LL2d7yIZQMBSAyUkb5AZll90CWBS
         UjE5+iz6JOeJ0q/LGt08KQ5xcT4n7OmXTPvRRg1vlcsCF1xmd/vBvFmkl2EHrhtW1D
         rz//1KBZkcc9oGsNyF1zGQcHUonbd+/v8syyYLBFAtRZOHt1gkrjH2RKqKidT2Dw3L
         BGUjuQe88MwL+evlFCKgR5u8=
Authentication-Results: mail.aegee.org/vA508Fqb018231; dkim=none
Received: from [192.168.178.46] (x5f74e65a.dyn.telefonica.de [95.116.230.90])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id vA508Fqb018231
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 5 Nov 2017 00:08:16 GMT
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Subject: git grep -P fatal: pcre_exec failed with error code -8
Message-ID: <635a9bd4-2aa9-4415-2756-b82370c55798@aegee.org>
Date:   Sun, 5 Nov 2017 01:06:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

with git 2.14.3 linked with libpcre.so.1.2.9 when I do:
   git clone https://github.com/django/django
   cd django
   git grep -P "if.*([^\s])+\s+and\s+\1" 
django/contrib/admin/static/admin/js/vendor/select2/select2.full.min.js
the output is:
   fatal: pcre_exec failed with error code -8


(But not with
git clone https://github.com/select2/select2
cd select2
git grep -P "if.*([^\s])+\s+and\s+\1" dist/js/select2.full.min.js

as the two select2.full.min.js files differ slightly in their size)

Any ideas?

Regards
   Dilian
