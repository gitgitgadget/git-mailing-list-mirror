X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to .git/config
 on clone
Date: Thu, 07 Dec 2006 12:19:52 +0530
Message-ID: <4577B990.9090708@gmail.com>
References: <200612061207.23437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 06:55:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 38
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: palrel2.hp.com
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
In-Reply-To: <200612061207.23437.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33556>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsDA3-0001wt-FR for gcvg-git@gmane.org; Thu, 07 Dec
 2006 07:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031740AbWLGGzM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 01:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031745AbWLGGzM
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 01:55:12 -0500
Received: from main.gmane.org ([80.91.229.2]:39757 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1031740AbWLGGzK
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 01:55:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43) id
 1GsD9q-0002kF-K7 for git@vger.kernel.org; Thu, 07 Dec 2006 07:55:02 +0100
Received: from palrel2.hp.com ([156.153.255.234]) by main.gmane.org with
 esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Thu, 07 Dec 2006 07:55:02 +0100
Received: from aneesh.kumar by palrel2.hp.com with local (Gmexim 0.1
 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Thu, 07 Dec 2006
 07:55:02 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> Without any specification in the .git/config file, git-pull will execute
> "git-pull origin"; which in turn defaults to pull from the first "pull"
> definition for the remote, "origin".
> 
> This is a difficult set of defaults to track for a new user, and it's
> difficult to see what tells git to do this (especially when it is
> actually hard-coded behaviour).  To ameliorate this slightly, this patch
> explicitly specifies the default behaviour during a clone using the
> "branch" section of the config.
> 
> For example, a clone of a typical repository would create a .git/config
> containing:
>   [remote "origin"]
>   url = proto://host/repo.git
>   fetch = refs/heads/master:refs/remotes/origin/master
>   [branch "master"]
>   remote = origin
>   merge = refs/heads/master
> 
> The [branch "master"] section is such that there is no change to the
> functionality of git-pull, but that functionality is now explicitly
> documented.
> 
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This is really to help newbies.  By explicitly documenting the default
> behaviour, it makes it clearer what is going on.  It also means no routing
> through documentation to find out what config option needs changing.
> 
> It's possible that we would want to remove the default behaviour entirely
> if there is no "branch" definition in the config.  That would prevent
> accidents by users who don't know what pull does fully yet.
> 

I liked this. This avoid lot of confusion and the "magic" master  update.

-aneesh
