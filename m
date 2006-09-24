From: Petr Baudis <pasky@suse.cz>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 24 Sep 2006 13:04:29 +0200
Message-ID: <20060924110429.GJ20017@pasky.or.cz>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 13:06:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRRoH-0001WS-Dh
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 13:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWIXLEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 07:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbWIXLEc
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 07:04:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20899 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751978AbWIXLEb (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Sep 2006 07:04:31 -0400
Received: (qmail 3827 invoked by uid 2001); 24 Sep 2006 13:04:29 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27655>

Dear diary, on Sun, Sep 24, 2006 at 12:37:57PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
>  - git-resolve is deprecated on "master" and will continue to be
>    so until 1.4.3.  We will remove it before 1.4.4 happens.

Woo-hoo!

>  - We should deprecate git-tar-tree.  However, it has been
>    around and advertised for quite some time, so we need to make
>    sure people would not get burned too badly.  It might be
>    worthwhile to rewrite git-tar-tree as a thin wrapper to
>    "git-archive --format=tar" and remove git-upload-tar now (in
>    other words, "git-tar-tree --remote" will continue to work,
>    but it will talk with "git-upload-archive", not with
>    "git-upload-tar" on the other end), release 1.4.3 with it
>    with a deprecation warning, and then remove it in 1.4.5.

I believe this is way too rushed, please consider keeping git-tar-tree
as the thin wrapper _much_ longer.

We still have ssh-pull and ssh-push around after more than a year of
their deprecation. (BTW, we might as well consider removing those. ;)

>  - packed-refs still has a few issues before it can hit
>    "master". 
> 
>    - deleting branches does not really work yet, as there have
>      been some discussions on the list.
> 
>    - dumb transports are unaware of it.  Trying to fetch a
>      ref that is packed would not work.

This is a big problem.

>    I feel this series to be a significant enough change that
>    deserve a bit careful handling.  Perhaps in 1.4.4 release.

I agree, there are some subtle changes there (like the heads ordering)
that could cause unforeseen problems, better be careful about it.

>  - Git.pm lost Git.xs which hopefully would make it a bit easier
>    to work for wider audiences.  Hopefully we can push it out to
>    "master" soon and see if anybody screams.  Depending on what
>    happens, it may be in 1.4.3 release.

Woo-hoo!

>  - git-show-ref and git-for-each-ref serve similar purpose (when
>    viewed in a bigger picture) but with different interface and
>    different set of features.  We should consolidate them into
>    one command before they hit in any released version.

Do I understand it correctly that those are the only interfaces for
scripts to access packed refs?

Ideally there would be some transition period provided so that I can
teach Cogito about them without having it broken for repositories with
packed refs for some time. But since packing refs is optional and
explicit action, perhaps it's not so critical.

Still, I looked forward for having those tools in the next release so
that Cogito can use them. Oh well. :)

>    Implementing "buffer-wide AND" will involve updating git-grep
>    but as a side effect we will also be able to say "find files
>    that have word A and B in them", which would be a useful
>    thing.  I'd push the current implementation out to "master"
>    soon and release 1.4.3 with it, and defer implementation of
>    the buffer-wide AND to a later version.

Yes. Those options are cool as they are and they can speed up gitweb's
search as well as cg-log -u.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
