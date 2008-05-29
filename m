From: Petr Baudis <pasky@suse.cz>
Subject: Re: [cogito-0.18.2] Documentation/Code Mismatch: cg-switch -l
Date: Thu, 29 May 2008 19:28:17 +0200
Message-ID: <20080529172817.GA18781@machine.or.cz>
References: <20080527080417.GA32209@lifebook.rekudos.net> <m3mymc2kv6.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andreas Ericsson <ae@op5.se>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 19:39:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1m6P-00057y-2A
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 19:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755252AbYE2Ri4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 13:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755260AbYE2Riz
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 13:38:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42984 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753775AbYE2Riy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 13:38:54 -0400
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 May 2008 13:38:54 EDT
Received: by machine.or.cz (Postfix, from userid 2001)
	id BD119244C03E; Thu, 29 May 2008 19:28:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m3mymc2kv6.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83225>

On Tue, May 27, 2008 at 10:48:29AM +0200, Jakub Narebski wrote:
> Mark Lawrence <nomad@null.net> writes:
> 
> >> On Mon May 26, 2008 at 02:19:04PM +0200, Andreas Ericsson wrote:
> >>> Mark Lawrence wrote:
> >>>>
> >>>>I don't know if this is a bug or just my understanding, but I'm having
> >>>>trouble matching the behaviour of "cg-switch -l" with the documentation.
> >>> 
> >>> Cogito became officially unmaintained a very long time ago (late 2006?)
> >>> and will almost certainly not work properly with any half-recent version
> >>> of git. Don't use it.
> >> 
> >> Oh. That's only <sarcasm>slightly annoying</sarcasm> to learn now, given
> >> that I've spent the past two years learning and converting my projects
> >> over to cogito :/ Could somebody *please* update the cogito web page at
> >> http://git.or.cz/cogito/ and put a big (maybe even blinking) notice
> >> informing people of this?
> 
> Git Homepage (http://git.or.cz/) states:
> 
>   Cogito
> 
>     Cogito was a popular version control system on top of Git, aiming
>     at seamless user interface and ease of use. It provided much
>     better user interface in the past but later improvements of Git
>     made it mostly obsolete and it is not maintained anymore. Please
>     migrate to Git itself.
> 
> I guess that it should be mentioned stronly also on Cogito homepage,
> although the date of latest release ([2006-10-19]) is a bit of hint...

Good point. I have added a hint.

> >> Bit of a shame that it's died though, because I appreciated the simpler
> >> interface (and some of the output I find nicer).
> 
> BTW. I think one of the reasons Cogito died was that it tried to hide
> index, and used single branch per repository paradigm when dealing
> with remote repositories while git acquired powerful tool (git-remote)
> to deal with multi-branches remote repositories... and
> author/maintainer didn't have time to modify Cogito to include those
> features.

I think hiding index was not a mistake and certainly not a reason of
death. It died mainly because I lost motivation to extend it as Git
rapidly improved its user interface, and indeed also because of the work
required to implement remotes tracking (I did have some work in progress
that I'm not sure if I ever published; if anyone is interested, I can
push it somewhere).

> I'd say that Cogito was one of forces behind making Git easier to use
> (for example git-filter-branch is the equivalent of cg-admin-rewrite-hist,
> a single thing that was possible in Cogito but was not possible in Git,
> created when Cogito was announced to be no longer maintained/abandoned).

(Not single. I still use cg-export in some of my workflows to export
tree of some commit quickly. And I still did not have time to add
support for |fmt'ing git commit's -m arguments. But these are the
only things that I can think of straight away.)

> >> On a more practical note, am I likely to suffer any issues using pure
> >> git on repos created with cogito?
> 
> I don't thinks so.

Not strictly, but Cogito uses very old-style remote repositories
tracking model. I think Git still technically supports it, but you might
get confused when seeing hints and documentation expecting the modern
setup. You do not need to do anything about the central repositories but
I would advise you to simply re-clone the leaf repositories.

> P.S. As Cogito is OSS project, you can always [try to] revive it,
> I think even without changing its name...

I hoped somebody would when I announced end-of-life from my side, but
frankly I don't think it's worthwhile at this point. Cogito was Git's
counterpart for the whole of Git's early life and it shows in the code
very much - it goes at great lengths to achieve things that you would do
trivially with the newer Git interfaces. It's probably better idea to
hack away at things like EasyGit or even better improve documentation
and usage of Git itself.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
