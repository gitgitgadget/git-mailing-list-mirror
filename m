From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [PATCH 1/2] git-gui: fix deleting item from all_remotes
	variable
Date: Sun, 13 Feb 2011 15:05:23 +0100
Message-ID: <20110213140523.GF31986@book.hvoigt.net>
References: <20110212164344.GA19433@book.hvoigt.net> <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@googlemail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Pat Thoyts <patthoyts@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 15:05:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PocZx-0008FD-AY
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 15:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907Ab1BMOF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 09:05:26 -0500
Received: from darksea.de ([83.133.111.250]:54112 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750932Ab1BMOFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 09:05:25 -0500
Received: (qmail 14023 invoked from network); 13 Feb 2011 15:05:23 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Feb 2011 15:05:23 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTi=hY1XpBNfhNDfM8kwgnitQXN-97mM-dkhCpTac@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166669>

Hi Pat,

On Sun, Feb 13, 2011 at 01:20:14PM +0000, Pat Thoyts wrote:
> On 12 February 2011 16:43, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > lsearch and lreplace both take the variable content as argument and=
 not
> > just their name.
> >
> > Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
> > ---
> > =A0lib/remote.tcl | =A0 =A04 ++--
> > =A01 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/lib/remote.tcl b/lib/remote.tcl
> > index b92b429..1383e97 100644
> > --- a/lib/remote.tcl
> > +++ b/lib/remote.tcl
> > @@ -264,8 +264,8 @@ proc remove_remote {name} {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unset repo_config(remote.$name.push)
> > =A0 =A0 =A0 =A0}
> >
> > - =A0 =A0 =A0 set i [lsearch -exact all_remotes $name]
> > - =A0 =A0 =A0 lreplace all_remotes $i $i
> > + =A0 =A0 =A0 set i [lsearch -exact $all_remotes $name]
> > + =A0 =A0 =A0 set all_remotes [lreplace $all_remotes $i $i]

If you were going to please wait with applying it. I just found another
location where this variable is changed in a wrong manner. I will updat=
e
the patch accordingly.

Cheers Heiko
