X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: cg-clone produces "___" file and no working tree
Date: Thu, 20 Apr 2006 14:34:20 -0700
Message-ID: <20060420213420.GD3653@tumblerings.org>
References: <20060419053640.GA16334@tumblerings.org> <20060419094916.GD27689@pasky.or.cz> <20060419142131.GD4104@tumblerings.org> <20060419144827.GX27631@pasky.or.cz> <20060420164908.GA540@tumblerings.org> <7vejzsywrq.fsf@assigned-by-dhcp.cox.net> <20060420200849.GA3653@tumblerings.org> <7vslo8xaql.fsf@assigned-by-dhcp.cox.net> <7vodywxago.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 20 Apr 2006 21:34:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vodywxago.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19000>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1FWgnH-00066S-BD for gcvg-git@gmane.org; Thu, 20 Apr
 2006 23:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751330AbWDTVe2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 20 Apr 2006
 17:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWDTVe2
 (ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 17:34:28 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:8337 "EHLO
 tumblerings.org") by vger.kernel.org with ESMTP id S1751330AbWDTVe1 (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 20 Apr 2006 17:34:27 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.61)
 (envelope-from <zbrown@tumblerings.org>) id 1FWgn6-00014Z-V8; Thu, 20 Apr
 2006 14:34:20 -0700
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Hi,

> honestly I would not recommend "runnning
> without installing" unless you know what you are doing ;-).

OK, you're right, the problem was that I was not doing a proper install. I
followed the directions and it worked. Thanks!

Be well,
Zack

On Thu, Apr 20, 2006 at 01:23:35PM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Zack Brown <zbrown@tumblerings.org> writes:
> >
> >> Not true. I went into the git source directory, and ran "make". Nothing more.
> >
> > Ah, I misunderstood.  You are trying to run it _without_
> > installing it.
> >
> > Well, then probably you do not have templates installed
> > anywhere, especially not where git-init-db expects them to be
> > found.
> 
> (sorry for the short message sent unfinished by mistake).
> 
> Running things without installing is somewhat tricky, but test
> framework needs to do that, so there are some things you would
> need to do.
> 
>  - "git init-db" takes --template argument; in the source area
>    before installing, they are built in templates/blt/.
> 
>  - "git" and programs that need to invoke other git programs
>    (e.g. git-send-pack) expects things to be found in gitexecdir
>    you set when you build.  If you are not installing, you need
>    to override that with GIT_EXEC_PATH environment variable.
> 
> There might be other things, but you should be able to find them
> from what t/Makefile and t/test-lib.sh do.
> 
> Having said that, honestly I would not recommend "runnning
> without installing" unless you know what you are doing ;-).
> 

-- 
