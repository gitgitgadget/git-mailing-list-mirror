X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 23:27:08 +0100
Organization: Dewire
Message-ID: <200611012327.08967.robin.rosenberg.lists@dewire.com>
References: <200610261641.11239.andyparkins@gmail.com> <200611012029.41869.andyparkins@gmail.com> <7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 22:26:11 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30670>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfOX2-0001GL-AJ for gcvg-git@gmane.org; Wed, 01 Nov
 2006 23:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752520AbWKAWZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 17:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbWKAWZ5
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 17:25:57 -0500
Received: from [83.140.172.130] ([83.140.172.130]:1829 "EHLO
 torino.dewire.com") by vger.kernel.org with ESMTP id S1752520AbWKAWZ4 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 17:25:56 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 81882802801; Wed,  1 Nov 2006 23:22:32 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 29631-10; Wed,  1 Nov
 2006 23:22:32 +0100 (CET)
Received: from [10.9.0.5] (unknown [10.9.0.5]) by torino.dewire.com (Postfix)
 with ESMTP id 08A1D8003E1; Wed,  1 Nov 2006 23:22:29 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

onsdag 01 november 2006 21:49 skrev Junio C Hamano:
> Andy Parkins <andyparkins@gmail.com> writes:
> > On Wednesday 2006, November 01 18:28, Junio C Hamano wrote:
> >> So from that point of view, the above commandline perfectly
> >> makes sense.  However, giving anything but HEAD with path makes
> >> us go "Huh?"  It is unclear what this should mean:
> >>
> >> 	git-reset [--hard | --mixed] HEAD^ oops/file1
> >
> > I don't understand.  Why wouldn't that mean reset oops/file1 to the state
> > it had in HEAD^?
>
> Path limiters everywhere in git means "do this only for paths
> that match this pattern, and empty path means the pattern match
> every path -- the command's behaviour is not different in any
> other aspect between the case you gave no limiter and the case
> you gave _all_ paths as limiters".  So the other paths remain as
> they were (both index and working tree), and HEAD needs to be
> updated to HEAD^ in the above example.
>
> While that perfect makes sense from mechanical point of view, I
> am not sure what it _means_ to keep some paths from now
> abandoned future while having some other paths reset to the
> rewound commit, from the point of view of end-user operation.
>
> In other words, I do not have a good explanation on what "git
> reset [--hard|--mixed] <commit> <path>..." does that I can write
> in the documentation.

You could refer to git-checkout although checkout doesn't have something 
corresponding to --mixed. The --hard option would correspond to the -f flag 
in checkout.

It is like "cherrypicking" content (not changes) from a particular commit.  

Where did the soft option go? 

Since checkout already does the work.. Is there any need for extending 
git-reset, other than that's where people look for this feature. The man page 
could be extended instead.

