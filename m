From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git add / update-cache --add fails.
Date: Thu, 28 Apr 2005 03:05:23 +0200
Message-ID: <20050428010523.GB3422@pasky.ji.cz>
References: <200504260726.04908.rhys@rhyshardwick.co.uk> <E1DQcOc-00054l-00@gondolin.me.apana.org.au> <87ll74go7o.fsf@coraid.com> <20050427173059.GE22956@pasky.ji.cz> <20050427180143.0447ceaa.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ecashin@coraid.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:00:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxO1-0002qg-20
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVD1BFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVD1BFb
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:05:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:28847 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262141AbVD1BFY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:05:24 -0400
Received: (qmail 5759 invoked by uid 2001); 28 Apr 2005 01:05:23 -0000
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050427180143.0447ceaa.pj@sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 03:01:43AM CEST, I got a letter
where Paul Jackson <pj@sgi.com> told me that...
> Petr wrote:
> >  	fd = open(path, O_RDONLY);
> >  	if (fd < 0) {
> > +		fprintf(stderr, "update-cache Error: %s\n", strerror(errno));
> 
> It's usually a good idea to indicate which system call you were
> attempting in such error messages, and if handy, the key argument.
> Just the errno might not mean much:
> 
> > +		fprintf(stderr, "update-cache open(%s) failed: %s\n", path, strerror(errno));

Sorry for being unclear, I meant that I did an analogous change in my
tree before; it is actually a little different:

	if (errno == ENOENT) {
		if (allow_remove)
			return remove_file_from_cache(path);
	}
	return error("open(\"%s\"): %s", path, strerror(errno));

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
