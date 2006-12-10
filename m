X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: globs in partial checkout?
Date: Sun, 10 Dec 2006 22:00:29 +0200
Message-ID: <20061210200029.GF1708@mellanox.co.il>
References: <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 10 Dec 2006 20:00:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <e5bfff550612101151r5e77ddc0w8f61f36fc1f2920e@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 10 Dec 2006 20:02:13.0968 (UTC) FILETIME=[15CB8500:01C71C96]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14862.000
X-TM-AS-Result: No--5.297800-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33919>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtUqk-0004d5-5l for gcvg-git@gmane.org; Sun, 10 Dec
 2006 21:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762411AbWLJUAf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 15:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762443AbWLJUAf
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 15:00:35 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:50566 "EHLO
 p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762411AbWLJUAe (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 15:00:34 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com) by
 p02c11o143.mxlogic.net (mxl_mta-4.0.1-4) with ESMTP id
 1676c754.2174999472.9241.00-001.p02c11o143.mxlogic.net (envelope-from
 <mst@mellanox.co.il>); Sun, 10 Dec 2006 13:00:33 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with
 Microsoft SMTPSVC(6.0.3790.1830); Sun, 10 Dec 2006 22:02:13 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 10 Dec 2006
 22:04:59 +0200
To: Git Mailing List <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

I'm trying to checkout some files after doing "clone -n".
Should using globs there work? It doesn't:

st@mst-lt:~/scm/wireless-dev$ git checkout master 'include/net/ieee80211*.h'
error: pathspec 'include/net/ieee80211*.h' did not match any file(s) known to
git.
Did you forget to 'git add'?
mst@mst-lt:~/scm/wireless-dev$ git ls-tree master -- include/net/ | grep iee
100644 blob b174ebb277a96668f058e469b0753503c34f164b include/net/ieee80211.h
100644 blob eb476414fd726701d032e9e517751b9d3f7e38df include/net/ieee80211_crypt.h
100644 blob 429b73892a5fc62f91e4a4b05da40859604fa791 include/net/ieee80211_radiotap.h
100644 blob 617b672b1132e7fa3ff5f9c940b1692520dc8483 include/net/ieee80211softmac.h
100644 blob 4ee3ad57283fa3370bd2d1f71cd6ae559b556dbc include/net/ieee80211softmac_wx.h
mst@mst-lt:~/scm/wireless-dev$ git checkout master include/net/ieee80211.h
include/net/ieee80211_crypt.h include/net/ieee80211_radiotap.h
include/net/ieee80211softmac.h include/net/ieee80211softmac_wx.h


-- 
