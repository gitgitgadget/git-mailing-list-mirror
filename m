X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] make cg-commit --review restore original tree state afterwards
Date: Fri, 27 Oct 2006 04:02:45 +0200
Message-ID: <20061027020245.GX20017@pasky.or.cz>
References: <20061021014723.B8E9C13810D@magnus.utsl.gen.nz> <4539EB15.3050405@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 02:08:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4539EB15.3050405@vilain.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30277>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdH3a-0005qU-FR for gcvg-git@gmane.org; Fri, 27 Oct
 2006 04:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946111AbWJ0CCr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 22:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946112AbWJ0CCr
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 22:02:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47823 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1946111AbWJ0CCq (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 22:02:46 -0400
Received: (qmail 9281 invoked by uid 2001); 27 Oct 2006 04:02:45 +0200
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Dear diary, on Sat, Oct 21, 2006 at 11:40:37AM CEST, I got a letter
where Sam Vilain <sam@vilain.net> said that...
> Ok, I ruined the error message.
> 
> This could also do with some enhancement; if you edit hunks of the
> patch, then the numbers in the hunks could be updated so as to not make
> the patch abort.  Also, if it does abort you should get the option of
> undoing everything, or editing the patch again...
> 
> Will try again with this another time.

Actually, on current master you can now use internal_commit. My idea was
that you internal_commit with the local changes as X, then rollback to
HEAD, apply new patch. If you fail at this point, you can do much saner
recovery since you can reset the tree and timewarp back to X and save
the modified patch at a suitable place.

Besides, you can just timewarp the tree back to X (w/o updating HEAD) at
this point to recover the changes excluded from the committed patch!

I guess timewarping/internal_commit may look like magic to everyone but
me so if the above is unclear, just say so and I'll try to be more
thorough. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
