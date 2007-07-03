From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Re: being nice to patch(1)
Date: Tue, 3 Jul 2007 16:03:37 -0500
Message-ID: <200707032103.l63L3bm18209@f7.net>
References: <20070702125450.28228edd.akpm@linux-foundation.org>
	<200707031534.47004.agruen@suse.de>
	<20070703084926.2e834aa5.akpm@linux-foundation.org>
	<200707031803.15633.agruen@suse.de>
Reply-To: quilt-dev@nongnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: quilt-dev@nongnu.org, Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org Tue Jul 03 23:53:56 2007
connect(): Connection refused
Return-path: <quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org>
Envelope-to: gcvqd-quilt-dev@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5qJk-0007jG-4z
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 23:53:54 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1I5qJf-0003WN-Fu
	for gcvqd-quilt-dev@m.gmane.org; Tue, 03 Jul 2007 17:53:47 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1I5pXB-0004W5-2Q
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:03:41 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1I5pX8-0004Vm-KM
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:03:40 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1I5pX8-0004Vb-B8
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:03:38 -0400
Received: from server1.f7.net ([64.34.169.74] helo=f7.net)
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <karl@freefriends.org>) id 1I5pX7-00054S-OU
	for quilt-dev@nongnu.org; Tue, 03 Jul 2007 17:03:38 -0400
X-Envelope-From: karl@freefriends.org
X-Envelope-To: quilt-dev@nongnu.org
Received: (from karl@localhost)
	by f7.net (8.11.7-20030920/8.11.7) id l63L3bm18209;
	Tue, 3 Jul 2007 16:03:37 -0500
Resent-Date: Tue, 3 Jul 2007 16:03:37 -0500
Resent-From: Karl Berry <karl@freefriends.org>
Resent-Message-Id: <200707032103.l63L3bm18209@f7.net>
Resent-To: quilt-dev@nongnu.org
In-Reply-To: <200707031803.15633.agruen@suse.de>
X-Mailer: Sylpheed 2.4.1 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
X-detected-kernel: Linux 2.6, seldom 2.4 (older, 4)
X-detected-kernel: Linux 2.6, seldom 2.4 (older, 4)
Resent-Date: Tue, 03 Jul 2007 17:03:40 -0400
X-Mailman-Approved-At: Tue, 03 Jul 2007 17:51:56 -0400
X-BeenThere: quilt-dev@nongnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: quilt-dev.nongnu.org
List-Unsubscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/quilt-dev>
List-Post: <mailto:quilt-dev@nongnu.org>
List-Help: <mailto:quilt-dev-request@nongnu.org?subject=help>
List-Subscribe: <http://lists.nongnu.org/mailman/listinfo/quilt-dev>,
	<mailto:quilt-dev-request@nongnu.org?subject=subscribe>
Sender: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Errors-To: quilt-dev-bounces+gcvqd-quilt-dev=m.gmane.org@nongnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51538>

On Tue, 3 Jul 2007 18:03:15 +0200 Andreas Gruenbacher <agruen@suse.de> wrote:

> On Tuesday 03 July 2007 17:49, Andrew Morton wrote:
> > I guess one could try `patch -p1' and if that failed, `patch -p1 -u'.
> 
> Hmm, I'll think about that, thanks.
> 
> > But the problem is that patch will get stuck in interactive mode prompting
> > for a filename.  I've never actually worked how to make patch(1) just fail
> > rather than going interactive, not that I've tried terribly hard.  Any
> > hints there?
> 
> Patch -f will turn off those questions.
> 

darnit, both `-f' and `-t' work.  Sigh.  I blame the manpage: too long ;)

Incidentally, the offending patch
(http://userweb.kernel.org/~akpm/git-scsi-misc.patch) sends patch(1) into
an infinite loop with `patch -p1 -f' and `patch -p1 -t'.  Presumably
it will do the same when that patch is offered to quilt...
