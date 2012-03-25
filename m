From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [GIT GUI PATCH 1/2] git-gui: teach _which procedure to work
	with absolute paths
Date: Sun, 25 Mar 2012 19:09:47 +0200
Message-ID: <20120325170947.GD38866@book.hvoigt.net>
References: <cover.1332523097.git.hvoigt@hvoigt.net> <e7a733b5ad4e2009aec205235a95a610ee18947b.1332523097.git.hvoigt@hvoigt.net> <7v8virt8qw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 19:10:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBqxZ-0004og-LW
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 19:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668Ab2CYRKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 13:10:20 -0400
Received: from darksea.de ([83.133.111.250]:59792 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756621Ab2CYRJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 13:09:49 -0400
Received: (qmail 20308 invoked from network); 25 Mar 2012 19:09:47 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 25 Mar 2012 19:09:47 +0200
Content-Disposition: inline
In-Reply-To: <7v8virt8qw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193874>

Hi,

On Fri, Mar 23, 2012 at 12:31:03PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> >  git-gui/git-gui.sh |    4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> > index ba4e5c1..35cdee8 100755
> > --- a/git-gui/git-gui.sh
> > +++ b/git-gui/git-gui.sh
> > @@ -429,6 +429,10 @@ proc _git_cmd {name} {
> >  proc _which {what args} {
> >  	global env _search_exe _search_path
> >  
> > +	if {[file exists $what]} {
> > +		return [file normalize $what]
> > +	}
> 
> Has $what been verified that it is either an absolute path, or contains a
> directory separator, at this point in the code?
> 
> Otherwise, "_which Makefile" would say "Yeah, that is the one I will
> launch" in a directory that has a "Makefile" even when the user does not
> have "." in his $PATH, no?

Thats a good point. Will add something for that if we have another
iteration which depends on Berts patch which seems to try to achieve the
same goal as this series.

Cheers Heiko
