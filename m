X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut
 repository
Date: Sun, 26 Nov 2006 14:30:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611261429420.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ekbnr6$naq$2@sea.gmane.org> <200611261210.52154.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 26 Nov 2006 13:31:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200611261210.52154.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32344>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoK6D-0006zV-N6 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 14:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935380AbWKZNbD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 08:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935386AbWKZNbD
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 08:31:03 -0500
Received: from mail.gmx.de ([213.165.64.20]:16805 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935380AbWKZNbB (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 08:31:01 -0500
Received: (qmail invoked by alias); 26 Nov 2006 13:30:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp031) with SMTP; 26 Nov 2006 14:30:59 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 26 Nov 2006, Andy Parkins wrote:

> -		echo >"$GIT_DIR/remotes/$origin" \
> -		"URL: $repo
> -Pull: refs/heads/$head_points_at:$origin_track" &&
> +		git-repo-config remote."$origin".url "$repo" &&
> +		git-repo-config remote."$origin".fetch "refs/heads/$head_points_at:$origin_track" ^$ &&

You do not need the "^$" here: this _is_ the first entry. I would even 
argue that this _has_ to replace whatever might be there (could be 
introduced by some bogus templates, for example), since the first fetch 
entry has a special meaning for pull.

Ciao,
Dscho
