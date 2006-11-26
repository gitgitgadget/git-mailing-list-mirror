X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use new .git/config for storing "origin" shortcut
 repository
Date: Sun, 26 Nov 2006 01:48:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611260141390.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <ekafpm@sea.gmane.org> <200611260003.31025.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 26 Nov 2006 00:48:20 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200611260003.31025.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32312>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go8Bs-0003XT-L2 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 01:48:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967181AbWKZAsN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 19:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935217AbWKZAsN
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 19:48:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:44998 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935213AbWKZAsN (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 19:48:13 -0500
Received: (qmail invoked by alias); 26 Nov 2006 00:48:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 26 Nov 2006 01:48:11 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Sun, 26 Nov 2006, Andy Parkins wrote:

> -			echo "Pull: refs/heads/${name}:$remote_top/${name}"
> -		done >>"$GIT_DIR/remotes/$origin" &&
> +			git-repo-config remote."$origin".fetch "refs/heads/${name}:$remote_top/${name}"
> +		done &&

This hunk is wrong: "git-repo-config remote.bla.fetch b" will _overwrite_ 
remoter.bla.fetch. To avoid that, you have to use "git repo-config 
remote.bla.fetch b ^$". (The last argument is a regular expression which 
has to be matched by the value-to-be-oreplaced.)

Ciao,
Dscho
