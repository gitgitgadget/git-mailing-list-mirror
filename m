Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F1A31FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 22:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdFSWO0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 18:14:26 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:52405 "EHLO
        gproxy4.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752152AbdFSWOZ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Jun 2017 18:14:25 -0400
X-Greylist: delayed 1676 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jun 2017 18:14:25 EDT
Received: from cmgw4 (unknown [10.0.90.85])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 9C371175B22
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 15:46:28 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmgw4 with 
        id almR1v00X0QvKlu01lmUS3; Mon, 19 Jun 2017 15:46:28 -0600
X-Authority-Analysis: v=2.2 cv=QdwWhoTv c=1 sm=1 tr=0
 a=gch/BGY/Gm5DEW28s2kmlQ==:117 a=gch/BGY/Gm5DEW28s2kmlQ==:17
 a=IkcTkHD0fZMA:10 a=LWSFodeU3zMA:10 a=SCtjg9rPZWL_A8k3XR8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.net; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:References:In-Reply-To:Date:To:Reply-To:From:Subject:Message-ID:
        Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YAb/E/Tdaa7bANtiqepMK/oL/yQjjV+oU4Zqexe+U3o=; b=AI7s9aTiPt8XGP0uT97dCUTJ+q
        w4p35Pkhc3hczrQW710loz3L8gtnAzdVG26Syq6ICOMDEffL55XPsisi940+P0atUV7l7rxwYcLYD
        D0GJUpsgoHxmNLn0rs00XuBlp;
Received: from [50.226.24.42] (port=38904 helo=pdsdesk)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.87)
        (envelope-from <paul@mad-scientist.net>)
        id 1dN4V7-000D0L-07; Mon, 19 Jun 2017 15:46:25 -0600
Message-ID: <1497908782.6463.8.camel@mad-scientist.net>
Subject: Re: Git Strange behaviour with remote deleted branch
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Reda Lyazidi <reda.lyazidiprojet@gmail.com>, git@vger.kernel.org
Date:   Mon, 19 Jun 2017 17:46:22 -0400
In-Reply-To: <39331ce5-dbf9-170e-e550-784db10b966f@gmail.com>
References: <39331ce5-dbf9-170e-e550-784db10b966f@gmail.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 50.226.24.42
X-Exim-ID: 1dN4V7-000D0L-07
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (pdsdesk) [50.226.24.42]:38904
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2017-06-19 at 23:33 +0200, Reda Lyazidi wrote:
> with git I noticed when I removed a remote branch with git push origin 
> --delete <the branch>
> in my clone when I used git branch -a I don't the deleted branch
> but my colleagues still see it.
> 
> I tried with two clones in my PC, with the first one delete branch and 
> the other still sees it
> despite git pull .

Normally Git will not remove a remote's branch refs on a fetch (or
pull) operation.  This is a safety measure, since you might still have
a use for that branch (for example to run diff against or similar).

In order to remove branches that have been deleted in your remote, you
must use the --prune (or -p) option to git fetch or git pull:

  git pull -p

will get rid of them.

