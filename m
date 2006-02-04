From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: 2 questions/nits about commit and config
Date: Sat, 4 Feb 2006 22:59:26 +0000
Message-ID: <200602042259.27080.alan@chandlerfamily.org.uk>
References: <20060204212337.GA8612@blinkenlights.visv.net> <7voe1mvkls.fsf@assigned-by-dhcp.cox.net> <7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Feb 04 23:59:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5WNO-0003gD-Qb
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 23:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537AbWBDW71 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Feb 2006 17:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWBDW71
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 17:59:27 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:62145
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S932537AbWBDW70 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 17:59:26 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.50)
	id 1F5WNJ-0007uq-PV
	for git@vger.kernel.org; Sat, 04 Feb 2006 22:59:25 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
In-Reply-To: <7vhd7evk38.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15607>

On Saturday 04 February 2006 22:24, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> > An example of such semantic change would be: if I am in
> > subdirecotry foo/, commit changes to files in that subdirectory
> > and subdirectory alone.  But that is actively _encouraging_
> > partial commits (commits that records a state that never existed
> > in your working tree as a whole) so I personally am not so
> > enthused to buy such a _feature_.
>
> Before people start complaining about it, I take this part
> back.  "git commit -a" inside a subdirectory "foo" is not much
> different from "git commit foo/a foo/b foo/c" from the toplevel
> directory to explicitly say "Don't worry about what I told the
> index so far; I want to check in changes only to these paths",
> and making a partial commit out of the current HEAD and the
> specified working tree files using a temporary index (while
> updating the main index at the same time), so I am inclined to
> say we should support it that way, since during the previous
> discussion we have pretty much settled how we would want "git
> commit paths..." and "git commit --include paths..." commands to
> behave.

And I did describe a use case this morning in another thread for this v=
ery=20
thing.  For convenience I repeat it here

[Incidentally there is a use case that doesn't seem to have been discus=
sed in=20
this thread which I use cg-commit all the time for and will now have to=
 see=20
if there is a use index file equivalence for. =A0That is, I am developi=
ng a web=20
application and in the running version the database framework (iBatis) =
is=20
using Tomcats connection pooling. =A0In order to run my JUnit test harn=
ess, I=20
don't have tomcat, so I need to define a different version of iBatis=20
configuration file to used its own database connection. =A0So I have cr=
eated a=20
test branch and edited the configuration file in that branch, and I upd=
ate=20
both code and tests in a edit/compile/fix and text loop until I have wr=
itten=20
or changed both code and tests. =A0I then do a cg-commit which lists th=
e files=20
I have changed. =A0I ONLY commit those in the test harness - by deletin=
g the=20
others from cogito's list of files to commit - and then repeat the comm=
it=20
commiting the rest]. =A0I then switch back to my master branch and cher=
ry pick=20
commit that is the code changes - not the text harness]

In this case the tests, and the code that it was testing were in differ=
ent=20
subdirectories, so the ability to go into one directory and commit all =
in=20
that directory, followed by the ability to go into the other and do the=
 same=20
would be extremely useful.


--=20
Alan Chandler
http://www.chandlerfamily.org.uk
Open Source. It's the difference between trust and antitrust.
