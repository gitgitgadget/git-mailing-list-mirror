From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: stash clear, was Re: git: avoiding merges, rebasing
Date: Fri, 19 Oct 2007 15:37:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0710191533490.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <200709301421.52192.bruno@clisp.org>
	<200710020347.43733.bruno@clisp.org>
	<4AD64749-F4A3-4A61-B1EE-D12523293661@lrde.epita.fr>
	<200710021350.54625.bruno@clisp.org> <47023699.3080606@byu.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bug-gnulib@gnu.org, Bruno Haible <bruno@clisp.org>, git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org Fri Oct 19 15:38:06 2007
Return-path: <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-gnulib@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iis34-000184-F1
	for gnu-bug-gnulib@m.gmane.org; Fri, 19 Oct 2007 15:37:58 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1Iis2w-0004jl-VO
	for gnu-bug-gnulib@m.gmane.org; Fri, 19 Oct 2007 09:37:50 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1Iis2q-0004jW-GK
	for bug-gnulib@gnu.org; Fri, 19 Oct 2007 09:37:44 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1Iis2o-0004jD-U4
	for bug-gnulib@gnu.org; Fri, 19 Oct 2007 09:37:44 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1Iis2o-0004jA-Op
	for bug-gnulib@gnu.org; Fri, 19 Oct 2007 09:37:42 -0400
Received: from mail.gmx.net ([213.165.64.20])
	by monty-python.gnu.org with smtp (Exim 4.60)
	(envelope-from <Johannes.Schindelin@gmx.de>) id 1Iis2o-0003OJ-9F
	for bug-gnulib@gnu.org; Fri, 19 Oct 2007 09:37:42 -0400
Received: (qmail invoked by alias); 19 Oct 2007 13:37:40 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO
	wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
	by mail.gmx.net (mp018) with SMTP; 19 Oct 2007 15:37:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dJxZfU0CdhyW2GzH4/Q7R5gv46Ujp4za5Af8ahU
	iLaI22S4v3deZL
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <47023699.3080606@byu.net>
X-Y-GMX-Trusted: 0
X-detected-kernel: by monty-python.gnu.org: Linux 2.6, seldom 2.4 (older, 4)
X-BeenThere: bug-gnulib@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Gnulib discussion list <bug-gnulib.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-gnulib>
List-Post: <mailto:bug-gnulib@gnu.org>
List-Help: <mailto:bug-gnulib-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=subscribe>
Sender: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Errors-To: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61706>

Hi,

On Tue, 2 Oct 2007, Eric Blake wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> [adding the git list]
> 
> According to Bruno Haible on 10/2/2007 5:50 AM:
> > Hello Benoit,
> > 
> >>>     $ git stash
> >>>     $ git pull
> >>>     $ git stash apply
> >>>     $ git stash clean              ; typo!
> >>>     $ git stash clear              ; fatal correction to typo!
> >>>
> >>> and lost 20 modified files. Well, not really lost. Just took me a  
> >>> while to
> >> I don't really see how and why you "lost 20 modified files".
> > 
> > I lost modifications to 20 files. "git stash clean" moved these modifications
> > into a stash named "clean", and "git stash clear" killed it.
> 
> While we're at it, I wish 'git stash clear' would take an optional 
> argument that says which stash(es) to clear, rather than blindly 
> clearing the entire stash.

I'd rather avoid "enhancing" stash clear.  IMHO it is a little 
misdesigned, making it way too easy to hang yourself.

Instead, how about writing a stash pop?  "git stash pop [<stash>]".  It 
would literally just call git stash apply && git reflog delete.  Should 
not be too difficult, now that I provided "git reflog delete" ;-)

Maybe even deprecating "git stash clear", or doing away with it 
altogether.

Ciao,
Dscho
