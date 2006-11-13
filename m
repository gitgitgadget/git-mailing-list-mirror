X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk broken or user error?
Date: Tue, 14 Nov 2006 09:05:39 +1100
Message-ID: <17752.60467.854884.206737@cargo.ozlabs.ibm.com>
References: <m2irhkr467.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 13 Nov 2006 22:07:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <m2irhkr467.fsf@ziti.local>
X-Mailer: VM 7.19 under Emacs 21.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31324>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjjw6-0006Jy-4c for gcvg-git@gmane.org; Mon, 13 Nov
 2006 23:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755363AbWKMWFq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 17:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbWKMWFq
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 17:05:46 -0500
Received: from ozlabs.org ([203.10.76.45]:1451 "EHLO ozlabs.org") by
 vger.kernel.org with ESMTP id S1755363AbWKMWFq (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 17:05:46 -0500
Received: by ozlabs.org (Postfix, from userid 1003) id 4606667EC5; Tue, 14
 Nov 2006 09:05:45 +1100 (EST)
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon writes:

> I tried a certainly incorrect thing; just commenting out the offending
> lines:

[snip]
> -    .bar.view entryconf 2 -state normal
> -    .bar.view entryconf 3 -state normal
> +#    .bar.view entryconf 2 -state normal
> +#    .bar.view entryconf 3 -state normal
>  }
>  
>  if {[info exists permviews]} {
> 
> And now gitk _seems_ to work.  No error message, and I can pass
> argument to gitk like --all (wow, very useful).

Those lines are intended to enable the "Edit view" and "Delete view"
entries in the View menu.  Those entries start out disabled and are
supposed to be disabled when the "All files" view is displayed, and
enabled when any other view is displayed.

I suspect that under OSX, the menu gets an extra entry, or something,
that throws off the numbering.  Instead of commenting out those lines,
could you instead try changing the 2 and 3 to "Edit*" and "Delete*"
instead?  If that works I'll do a patch to fix the problem properly.

> I posted about this in October [*1*], but didn't get any response.

I tend to read the git list intermittently (lkml and linuxppc-dev keep
me pretty much occupied :).  Please cc me on any gitk bug reports.

