From: Christopher Faylor <me@cgf.cx>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 16:29:47 -0400
Message-ID: <20051005202947.GA6184@trixie.casa.cgf.cx>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <434299DB.7020805@zytor.com> <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com> <20051005155457.GA30303@trixie.casa.cgf.cx> <20051005191741.GA25493@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 22:31:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENFtf-0006JW-VO
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 22:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030375AbVJEU3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 16:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030376AbVJEU3s
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 16:29:48 -0400
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:43955 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1030375AbVJEU3s (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 16:29:48 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 9E19D13C23D; Wed,  5 Oct 2005 20:29:47 +0000 (UTC)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20051005191741.GA25493@steel.home>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9729>

On Wed, Oct 05, 2005 at 09:17:41PM +0200, Alex Riesen wrote:
>Christopher Faylor, Wed, Oct 05, 2005 17:54:57 +0200:
>> >Still does not work for me. I cannot isolate the problem out of git,
>> >but at the moment the only way for me to make commit_index_file to work
>> >is to put unlink(indexfile) before rename(cf->lockfile, indexfile).
>> >
>> >For everyone interested, I attach cygwin's strace output here.
>> 
>> I'm sorry that I missed this thread.  I'm usually pretty alert to the word
>> "cygwin" showing up in a subject.
>> 
>> I'll go back and read the archives to catch up but, at the risk of
>> making an observation that has already been made, under windows you
>> can't always rename a file that is open.  Is that what's happening here?
>> 
>
>Don't think so, but will check in about 10 hrs. The code in question
>is in index.c, commit_index_file.

Ok.  Looks pretty simple.  FWIW, I've just built git on windows and I
don't see this behavior.  For the most part, it "just works".

I do see the gitk behavior but I'm tk illiterate too, unfortunately, so
I can't help there.

Cygwin's tcl/tk is a funny beast.  It is primarily included (by me) to
allow for the operation of the insight debugger and is more windows than
POSIX.  As was noted, it doesn't interact with Cygwin/X but just draws
windows using the Windows API.

So, tcl/tk are just barely supported in Cygwin currently.  I'm actually
a little surprised that it works as well as it does with gitk.
--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
TimeSys, Inc.
