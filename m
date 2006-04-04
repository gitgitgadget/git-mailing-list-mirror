From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Add git-clean command
Date: Tue, 4 Apr 2006 12:58:18 +0200
Message-ID: <20060404105818.GA17326@mars.ravnborg.org>
References: <20060403221841.25097.18242.stgit@dv.roinet.com> <7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 12:58:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQjEu-0007hL-UP
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 12:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWDDK6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 06:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWDDK6V
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 06:58:21 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:54789 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751851AbWDDK6U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Apr 2006 06:58:20 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pasmtp.tele.dk (Postfix) with ESMTP id 8BF9B1EC349;
	Tue,  4 Apr 2006 12:58:17 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id C0CE643C21C; Tue,  4 Apr 2006 12:58:18 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmj2b3w3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18385>

On Mon, Apr 03, 2006 at 05:06:36PM -0700, Junio C Hamano wrote:
> 
> I am not opposed to the command in the sense that I do not want
> to forbid people from doing what they want to do, but on the
> other hand I do not see why people (apparently many people) want
> to have something like this.  Are their "make clean" broken?

No reason to waste time on make clean.
git ls-files -o | xargs rm
Does the same job nicely.

Other typical usecases for me:
Remove temporaries that I created while trying out stuff.
Often I have a bunch of files named 'x', 'xx', 'fisk' etc.
around for no use. An easy way to remove these without breaking
my 'allmodconfig' build is nice. It anyway > 1 hour to build and
I like to get rid of the untracked stuff in an easy way.

So use cases goes like this:
- Remove everything not tracked by git (including .gitignore files)
- Remove everything except tracked by git or ignored
- Remove ignored files (replacement of make clean) (seldom)

Above should work both from top-level dir and in subdirectories.

That is my minimal expectations to git clean.
What Pavel came up with cover everything except the make clean
replacement part.

	Sam
