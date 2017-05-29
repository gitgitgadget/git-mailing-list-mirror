Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 678241FD09
	for <e@80x24.org>; Mon, 29 May 2017 02:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750893AbdE2CgW (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 22:36:22 -0400
Received: from userp1040.oracle.com ([156.151.31.81]:40992 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbdE2CgW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 22:36:22 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v4T2aLrw013794
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Mon, 29 May 2017 02:36:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v4T2aK8T032205
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Mon, 29 May 2017 02:36:20 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v4T2aKwM028828
        for <git@vger.kernel.org>; Mon, 29 May 2017 02:36:20 GMT
Received: from oracle.com (/24.246.5.213)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 28 May 2017 19:36:20 -0700
Date:   Sun, 28 May 2017 22:36:19 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     git@vger.kernel.org
Subject: 2.13.0-rc1 is broken on SPARC
Message-ID: <20170529023619.24zh2owkpxgzt3em@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20161126 (1.7.1)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

My SPARC build does not function and seg bus terminates on any command.
I have worked out the commit is the one that switched the default SHA1
code to sha1dc - commit e6b07da2780f349c29809bd75d3eca6ad3c35d19.  I
managed to get it working by following the instructions on updating the
library in commit 28dc98e343ca4eb370a29ceec4c19beac9b5c01e.

Should I generate & send a patch for this?  I would normally do just
that, but with an external library, the resulting patch required
conflict resolution on the merging so format-patch won't work with the
given instructions.

I should note that following the build instructions in commit
e6b07da2780f349c29809bd75d3eca6ad3c35d19 to switch back to openssl's
SHA1 implementation works fine.

Thanks,
Liam

