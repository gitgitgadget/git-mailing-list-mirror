X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sat, 25 Nov 2006 22:02:09 -0500
Message-ID: <20061126030209.GA29394@spearce.org>
References: <ekafpm@sea.gmane.org> <200611260003.31025.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:02:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200611260003.31025.andyparkins@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32317>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoAHu-0004RO-1O for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:02:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966902AbWKZDCO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967247AbWKZDCO
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:02:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:11236 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S966902AbWKZDCN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:02:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GoAHI-0004Xy-HK; Sat, 25 Nov 2006 22:02:00 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 BF22420FB09; Sat, 25 Nov 2006 22:02:09 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> If .git/remotes/ is now deprecated, then git-clone shouldn't use it.
> This patch adds the analogous definitions to .git/config using
> git-repo-config calls.
> 
> For example what was previously .git/remotes/origin
>   URL: proto://host/path
>   Pull: refs/heads/master:refs/heads/origin
> Is now added to .git/config as
>   [remote "origin"]
>   url = proto://host/path
>   fetch = refs/heads/master:refs/heads/origin
> 
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> I'm not sure if I'm correct in thinking that .git/remotes is deprecated.  If it is,
> this patch makes git-clone use .git/config instead.
> 
> Personally I like it, I think there should be as small a number of places for 
> configuring the repository as possible.

I agree.  There's all sorts of advantages to setting up remotes by
the config file.  Its also easier to load and work with in git-gui.
:-)

I've switched to the config file syntax completely, and a few folks
I work with have done the same, citing that it is easier to have
everything in one file.

-- 
