From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT: "stg new" vs "stg new --force"
Date: Tue, 17 Jan 2006 22:57:52 +0100
Message-ID: <20060117215752.GH32585@nowhere.earth>
References: <1137144291.20073.104.camel@dv> <b0943d9e0601160018x206faf9ck@mail.gmail.com> <1137517300.20556.26.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>, Charles Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Jan 17 22:54:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eyymo-0003IJ-T4
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 22:54:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWAQVyj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 16:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWAQVyj
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 16:54:39 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:46285 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S932285AbWAQVyj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 16:54:39 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6EC316E8E0;
	Tue, 17 Jan 2006 22:54:32 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1Eyypt-0006OI-An; Tue, 17 Jan 2006 22:57:53 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1137517300.20556.26.camel@dv>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14803>

On Tue, Jan 17, 2006 at 12:01:40PM -0500, Pavel Roskin wrote:
> Hello, Catalin!
> 
> On Mon, 2006-01-16 at 08:18 +0000, Catalin Marinas wrote:
> > On 13/01/06, Pavel Roskin <proski@gnu.org> wrote:
> > > 1) "stg new --force" becomes "stg new" and "stg new" becomes "stg new
> > > --empty", i.e. empty files can only be created with the "--empty"
> > > switch.
> > > 2) "stg new --force" becomes "stg record" or something.
> > > 3) "stg new --force" becomes "stg new --record" or something.
> > > 4) "stg new" works both with and without modified files.
> > 
> > Regarding (1), the newly created patch is empty anyway, you would need
> > to run 'refresh' to add the modified patches to it ('stg series -e'
> > would show the empty patches prefixed with a 0).
> 
> I was going to suggest that would be logical to run "stg refresh"
> implicitly if "stg new" is used on modified files.  But then I realized
> that it would be even better if future versions of StGIT allowed to
> refresh (i.e. add changes to) patches other that the current one.  In
> this case, indeed, you don't want the newly created patch to suck in all
> the changes in the local repository.

I commonly also feel the need to "stg refresh" only part of the
current changes.  Allowing to limit the files to be impacted by a
refresh could be a good addition.

It would even be useful sometimes to dispatch changes to a single file
into several patches.  When they are distinct enough to be in
different diff hunks, it is pretty easy to split an existing patch,
but it could also be useful to only refresh a patch with specific diff
hunks.  A possibility would be to add a filterdiff-like "-#<n>" flag,
in addition to the above-suggested "refresh <file>" (and possibly only
allow to specify a single file together with this flag).


Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
