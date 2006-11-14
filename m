X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] commit: Steer new users toward "git commit -a" rather
 than update-index
Date: Tue, 14 Nov 2006 18:55:51 +0000
Message-ID: <455A1137.8030301@shadowen.org>
References: <87k61yt1x2.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 18:56:23 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
In-Reply-To: <87k61yt1x2.wl%cworth@cworth.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31361>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk3Rx-0005K0-9G for gcvg-git@gmane.org; Tue, 14 Nov
 2006 19:56:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966231AbWKNSz5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 13:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933477AbWKNSz5
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 13:55:57 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:21514 "EHLO
 hellhawk.shadowen.org") by vger.kernel.org with ESMTP id S933476AbWKNSz5
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 13:55:57 -0500
Received: from localhost ([127.0.0.1]) by hellhawk.shadowen.org with esmtp
 (Exim 4.50) id 1Gk3RA-00027S-6n; Tue, 14 Nov 2006 18:55:12 +0000
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth wrote:
> As has been discussed recently, update-index isn't intended as a
> "porcelain" command so the mention of it in the output of git-commit
> does lead to some user confusion.
> ---
>  wt-status.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/wt-status.c b/wt-status.c
> index 7dd6857..4edabcd 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -126,7 +126,7 @@ static void wt_status_print_changed_cb(s
>  	int i;
>  	if (q->nr)
>  		wt_status_print_header("Changed but not updated",
> -				"use git-update-index to mark for commit");
> +				"use \"git commit <files>\" to commit or \"git commit -a\" for all");
>  	for (i = 0; i < q->nr; i++)
>  		wt_status_print_filepair(WT_STATUS_CHANGED, q->queue[i]);
>  	if (q->nr)
> --
> 1.4.3.3.gf040

Are we sure this isn't porcelain-ish?  We need to use it in merge
conflict correction and the like?  You can't use git-commit there as a
replacement.  I'd expect it to be 'git update-index' rather than
'git-update-index' of course.

