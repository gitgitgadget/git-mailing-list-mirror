X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Stop telling users we are 'defaulting to local storage area'.
Date: Fri, 15 Dec 2006 15:10:08 +0100
Organization: At home
Message-ID: <elua7a$v7q$1@sea.gmane.org>
References: <20061214230902.GA26506@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Fri, 15 Dec 2006 14:08:09 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 35
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34503>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvDjF-0006ft-MM for gcvg-git@gmane.org; Fri, 15 Dec
 2006 15:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752175AbWLOOHz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 09:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbWLOOHz
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 09:07:55 -0500
Received: from main.gmane.org ([80.91.229.2]:60854 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1752175AbWLOOHy
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006 09:07:54 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GvDj3-0001lU-C7 for git@vger.kernel.org; Fri, 15 Dec 2006 15:07:49 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 15:07:49 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 15 Dec 2006
 15:07:49 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Shawn O. Pearce wrote:

> Back in the old days of Git when people messed around with their
> GIT_DIR environment variable more often it was nice to know whether
> or not git-init-db created a .git directory or used GIT_DIR.
> 
> But now that we are making excuses in the documentation about why
> this message gets printed by git-init-db we should just remove it
> entirely.  It doesn't really help the user to understand what just
> happened.  It also breaks from our normal behavior of not printing
> anything if the command was successful.
> 
> Suggested by Andy Parkins in his Git 'niggles' list
> (<200612132237.10051.andyparkins@gmail.com>).

Perhaps we should print something _if_ GIT_DIR is set, then?

>        * Set up the default .git directory contents
>        */
>       git_dir = getenv(GIT_DIR_ENVIRONMENT);
> -     if (!git_dir) {
> +     if (!git_dir)
>               git_dir = DEFAULT_GIT_DIR_ENVIRONMENT;
> -             fprintf(stderr, "defaulting to local storage area\n");
> -     }
>       safe_create_dir(git_dir, 0);
>  

I'd rather leave block, even if it consist now of single statement.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

