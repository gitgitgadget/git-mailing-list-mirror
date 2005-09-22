From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 6/8] cogito: Don't ever assume object type in cg-object-id
Date: Thu, 22 Sep 2005 11:46:43 +0200
Message-ID: <20050922094643.GC21019@pasky.or.cz>
References: <1127183120.31115.34.camel@dv> <20050921100040.GE24902@pasky.or.cz> <1127359625.8074.18.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 22 11:49:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EINfL-0003Nr-Pt
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 11:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030244AbVIVJqr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 05:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbVIVJqq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 05:46:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5263 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030244AbVIVJqp (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 05:46:45 -0400
Received: (qmail 27063 invoked by uid 2001); 22 Sep 2005 11:46:43 +0200
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1127359625.8074.18.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9099>

Dear diary, on Thu, Sep 22, 2005 at 05:27:05AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> As for fsck "yelling to death", when was the last time you tried that on
> the cogito repository fetched by cogito?  That's what I get:
> 
> [proski@dv cogito]$ git-fsck-objects
> missing tree 0842d4cb3cd36675c518c241b16cf25fad0c5384
> broken link from  commit 2c70421be7d88fbee49986d7a5584d1f010a25de
>               to    tree 8c365c79293c9a8a86dc6802f6230e389e876acb
> broken link from  commit 2c70421be7d88fbee49986d7a5584d1f010a25de
>               to  commit 659bd6b6489ae254a07b1bc578ff44778ed7b8b4
> broken link from  commit 463d05c7c4fe7f24da29749f4c7f25893fc20b8c
>               to    tree 0842d4cb3cd36675c518c241b16cf25fad0c5384
> broken link from  commit 463d05c7c4fe7f24da29749f4c7f25893fc20b8c
>               to  commit ed34298a39b05e05bd333d9dac658df19e5b2dab
> missing commit 659bd6b6489ae254a07b1bc578ff44778ed7b8b4
> missing tree 8c365c79293c9a8a86dc6802f6230e389e876acb
> missing commit c4cd9bc72a6e0ed355041d331bb4034d99738f82
> broken link from  commit d14925c87cdb6ca6345bcb3c8e34a2d659c79451
>               to    tree e5ea614d1884a02314a3be8e09cb3f8c786fc0e9
> broken link from  commit d14925c87cdb6ca6345bcb3c8e34a2d659c79451
>               to  commit c4cd9bc72a6e0ed355041d331bb4034d99738f82
> missing tree e5ea614d1884a02314a3be8e09cb3f8c786fc0e9
> missing commit ed34298a39b05e05bd333d9dac658df19e5b2dab


Heh, your database seems fairly broken.

> It's not like broken trees are exceedingly rare.  Sure, this must be
> some "better" kind of breakage, but anyway.

$ git-fsck-objects
error: b3e9704ecdf48869f635f0aa99ddfb513f885aff: object not found

and some dangling stuff, that's all I get. This seems to be caused by
the mere existence of that (empty) file, so I just removed it from the
objects database and all is fine now.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
