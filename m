X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: git fetch with multiple remotes failing?
Date: Wed, 1 Nov 2006 01:12:42 +0100
Message-ID: <20061101001242.GF20017@pasky.or.cz>
References: <20061031155913.GA5157@mellanox.co.il> <Pine.LNX.4.64.0610310819170.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 00:13:01 +0000 (UTC)
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610310819170.25218@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30610>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gf3ip-0007hb-Hm for gcvg-git@gmane.org; Wed, 01 Nov
 2006 01:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946220AbWKAAMo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 19:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946221AbWKAAMo
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 19:12:44 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56760 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1946220AbWKAAMo (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 19:12:44 -0500
Received: (qmail 20403 invoked by uid 2001); 1 Nov 2006 01:12:42 +0100
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Dear diary, on Tue, Oct 31, 2006 at 05:32:06PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Tue, 31 Oct 2006, Michael S. Tsirkin wrote:
> > $ cat .git/remotes/origin
> > URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > Pull: +refs/heads/master:refs/heads/linus_master
> > $ cat .git/remotes/jejb-scsi-misc-2.6
> > URL: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git
> > Pull: +refs/heads/master:refs/heads/jejb-scsi-misc-2.6
> > $ git fetch -f origin jejb-scsi-misc-2.6
> > error: no such remote ref refs/heads/jejb-scsi-misc-2.6
> > Fetch failure:
> > git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > 
> > Looks I must give remotes one by one?
> 
> Yes. A single "fetch" will only ever connect to a single repository. If 
> you want to fetch from multiple repositories, you have to do multiple 
> connections, and thus multiple "fetch"es.

Note that I made a (hackish) patch for fetching from multiple
repositories in one connection (look for "Allow fetching from multiple
repositories at once"). It's currently in limbo since IIRC Junio wanted
some benchmarks, I don't have time to do them and the group I did this
for (the xorg people) has shown zero interest in testing the patch
either.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
