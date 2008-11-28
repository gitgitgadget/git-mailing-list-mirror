From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: timestamps not git-cloned
Date: Fri, 28 Nov 2008 01:59:45 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0811280058230.19665@iabervon.org>
References: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com> <87tz9sv3rb.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dhruvakm@gmail.com, git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Nov 28 08:01:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5xLc-0004B0-4l
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 08:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbYK1G7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 01:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbYK1G7r
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 01:59:47 -0500
Received: from iabervon.org ([66.92.72.58]:43599 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYK1G7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 01:59:47 -0500
Received: (qmail 26657 invoked by uid 1000); 28 Nov 2008 06:59:46 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2008 06:59:46 -0000
In-Reply-To: <87tz9sv3rb.fsf@jidanni.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101866>

On Fri, 28 Nov 2008, jidanni@jidanni.org wrote:

> >>>>> "d" == dhruva  <dhruvakm@gmail.com> writes:
> 
> d> Also, if you clone from systems across time zones, what time do you
> d> expect to set on the files.
> 
> I'm just used to tar, cpio, scp -a, rsync -a, ar, etc. using 'date +%s'
> seconds internally, so no timezone problem.
> 
> I hate it when I get some latest WhizBang.tgz, only to untar it to
> find all the files' dates the same, when in fact the README hasn't
> been touched in seven years, but you can't tell that from ls -l. I
> recall some content tracker was involved.

Well, README was just touched; it wasn't on your disk at all shortly 
before. This would make a big difference if, for example, you unpacked 
"foo-1.0" on top of "foo-1.1" and the timestamps were from when the files 
were originally created, and now all of the source files that changed are 
older than the object files and the build system does nothing.

Of course, with archives, you don't unpack different versions into the 
same directory, but with a version control system, you'll do it all the 
time, so you really need the system to put on disk the times when those 
files were last put there. If you want to know when the README you've got 
is from (and a whole lot more) "git log README" will tell you, although it 
won't tell you if somebody yesterday changed the README they're 
distributing from some other text to a file that's been sitting on their 
disk untouched for seven years.

	-Daniel
*This .sig left intentionally blank*
