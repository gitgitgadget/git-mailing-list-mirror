From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Fri, 6 May 2011 01:56:01 -0500
Message-ID: <20110506065601.GB13351@elie>
References: <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
 <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
 <BANLkTinQny-M0rL+Vs9L_cQhtVLyv6rqMw@mail.gmail.com>
 <4DB9329E.7000703@op5.se>
 <88795B20-6994-46A5-9710-2ADC84E04695@gmail.com>
 <7vhb986chl.fsf@alter.siamese.dyndns.org>
 <BANLkTi=+emhzqfiGxGbnJ=bm3oL7SvjhBw@mail.gmail.com>
 <7vbozg4eqw.fsf@alter.siamese.dyndns.org>
 <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>,
	"david@lang.hm" <david@lang.hm>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 08:56:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIExT-0007Dd-AQ
	for gcvg-git-2@lo.gmane.org; Fri, 06 May 2011 08:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1EFG4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2011 02:56:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38225 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1EFG4H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2011 02:56:07 -0400
Received: by iyb14 with SMTP id 14so2437427iyb.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 23:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=d0Hy35fmkXMZjW5yaURJPu8qC36nEMRRR4sib898lIs=;
        b=F6jotp6g7q+UNsbEFbkAa/VfGf2btFjoOuq8g6nEY67Zm5qwXLquPYnx18x2DUhP6t
         mky+0AiMtmA5nr31KPZwEvZJNOmLtio6QUVlXRrpCRS2ZgqkkXYlsPZ4NCC27Z85zK3l
         wPj9rj0/NRmhihNn2aYC0RB6pEzyDp/uT9UMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=e7LUGFmxRpLS3k3WHb7t9AfOTVD0YYKJK7V+tb5eDQ5sCsbMrEuvCVYpCMdhUMIYLb
         1I2y0gHBNedjnj8DhtHbugoSqcCEfQQSg6Sfedz1WOGP1RGk/SNeUC9cPR80xL4OJ5vL
         Lf2gIESH4GqAExkuAtuvBo1xcj8lZUPQxqB3s=
Received: by 10.42.134.129 with SMTP id l1mr2073432ict.73.1304664966082;
        Thu, 05 May 2011 23:56:06 -0700 (PDT)
Received: from elie (adsl-76-206-232-100.dsl.chcgil.sbcglobal.net [76.206.232.100])
        by mx.google.com with ESMTPS id c1sm1240618ibe.0.2011.05.05.23.56.03
        (version=SSLv3 cipher=OTHER);
        Thu, 05 May 2011 23:56:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTi=zrWR0GAm6n1Gs9XDCR6kXtjDW0A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172948>

Jon Seymour wrote:

> I would appreciate any feedback you (or others) have about:
>
>     http://permalink.gmane.org/gmane.comp.version-control.git/172419
>
> In particular, I would be interested in feedback about how to best support:
>
> - multiple extensions - do we want support installing extensions in
> their own directories, per Pau's suggestion or simply allow them to
> write to a common directory?
> - multiple extension directories - how to support Jonathan's
> requirement to allow user specific extension directories?

Well, let's step back for a moment.  What problem are we solving?
I still don't even know the answer to that!

Once upon a time, all git commands lived on the $PATH (typically in
/usr/bin, $HOME/bin, or some similar place) and could even be
invoked directly as git-commandname.  At some point someone noticed
that by running

	git-<TAB>

it was possible to read the list of all git commands.  Unfortunately
the list was very long, and this seemed like a much worse introduction
to git than the shorter list shown by "git --help".

There were also some related minor problems --- for example, git was
putting more pressure than necessary on filesystems and other
facilities to keep track of all the files in $bindir, and providing
the dashed forms of commands provides a temptation to use them
exclusively, making features (like aliases) of the git wrapper less
discoverable.  But the main thing was the tab completion.

The fix was to tuck away the individual commands somewhere under
libexecdir, outside $PATH.

Now at some point in this discussion I thought you were solving a
related problem.  If a person were to install 100 new commands for
git, or a single package with 100 commands in it, then

	git-<TAB>

would be daunting again.  So the task becomes to find a place to tuck
away these new commands without placing them on the $PATH.

But now I am less sure.  The motivating example has less than 10
commands; that doesn't seem worth all the fuss at all.  Why not just
install the command on the $PATH?  "git help work" _would_ work on all
the systems I have easy access to.  For example, if I write:

	install:
		install -m0755 git-work $(prefix)/bin
		install -d -m0755 $(prefix)/share/man/man1
		gzip -9 <git-work.1 >git-work.1.gz
		install -m0644 git-work.1.gz $(prefix)/share/man/man1/
		install -d -m0755 $(prefix)/bin

and the user runs

	make install
	PATH=$HOME/bin:$PATH

then "man git-work" will just work.  Similarly, "git work --help"
(which the git wrapper transforms to "git help work") would just work.

I see only a few potential problems remaining:

 1. There is no automatically generated documentation page pointing
    to the documentation for all new commands of this kind.  So
    I can run "git help -a" to learn about installed commands, but
    I cannot run "man git" to do so.  Likewise for info.

 2. On platforms like Windows that do not use manpages, my "git work"
    documentation will not show up with "git work --help".  For this,
    it would certainly be useful to have a GIT_HTML_PATH environment
    variable (or some similar name) that could be used to point to a
    list of directories with additional documentation.  The default
    could be something along the lines of the default library search
    path (but simpler), like:

	/usr/local/share/git/help:/usr/share/git/help

    Users installing new commands under $HOME might want to prepend
    something like

	$HOME/share/git/help:

    or whatever directory names suit their tastes.

    Even better might be a way for "git help" to ask the command
    where it puts its documentation, so "git help work" would
    internally run "git work --html-path".

 3. On a machine with multiple installations of git, my new command
    is not tied to any particular installation but shared by all of
    them.  This is a feature, not a bug.

 4. My command is visible with git-<TAB>, as mentioned above.

My comments about unprivileged users installing new commands were to
explain why an alternative solution to (2) that uses a single
directory where "git help" always looks would be inadequate.  I still
think that but luckily there is a large space of possible designs
without that problem; two are mentioned in the description of (2)
above.

Now problems 2 and 4 can be solved at the same time by introducing
something like a GIT_PLUGINS_PATH variable that could be shared for
both uses.  I'm not so convinced that's a good idea (I prefer to see
decoupled solutions to independent problems when it's simple to do)
but it could very well turn out okay.
