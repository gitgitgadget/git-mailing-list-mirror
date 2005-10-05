From: Christopher Faylor <me@cgf.cx>
Subject: Re: First cut at git port to Cygwin
Date: Wed, 5 Oct 2005 11:54:57 -0400
Message-ID: <20051005155457.GA30303@trixie.casa.cgf.cx>
References: <433B3B10.5050407@zytor.com> <81b0412b0510040531m441ca759k6d1f3fbf0cd248ce@mail.gmail.com> <434299DB.7020805@zytor.com> <81b0412b0510050424h21fc06bav7677911f52b38426@mail.gmail.com> <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 05 17:58:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENBc8-0001oL-Sr
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 17:55:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbVJEPy7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbVJEPy6
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 11:54:58 -0400
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:31118 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1030191AbVJEPy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 11:54:58 -0400
Received: by cgf.cx (Postfix, from userid 201)
	id 7FCE313C101; Wed,  5 Oct 2005 15:54:57 +0000 (UTC)
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81b0412b0510050846l2258775co117bada2d2b5a1ad@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9714>

On Wed, Oct 05, 2005 at 05:46:08PM +0200, Alex Riesen wrote:
>On 10/5/05, Alex Riesen <raa.lkml@gmail.com> wrote:
>> On 10/4/05, H. Peter Anvin <hpa@zytor.com> wrote:
>> > > I noticed that rename(2) in my copy of cygwin (1.5.18-1) does not remove the
>> > > target and returns an error (probably EPERM, but I have reasons not to trust
>> > > strerror on that thing).
>> > > The repository was on FAT.
>> > > Taking "rename(2)" from cygwin's libiberty solved this (they unlink if link(2)
>> > > returns EEXIST).
>> > >
>> > > PS: Does broken rename(2) qualify a system "not worthy to support"?
>> >
>> > I just tried this with Cygwin 1.5.18-1 and didn't have any such
>> > problems.  I tried it on NTFS, FAT and Samba, using WinXP.
>>
>> It's on Win2k, there was multiple cygwin installations in path, the other one
>> supposedly is 1.5.5 (it's from QNX Momentics installation).
>> I had that old "cygwin1.dll" renamed into "cygwin1.dll-disabled" long
>> ago, though...
>> I can't reproduce this out of GIT context, and the error is not
>> reproducable after
>> I removed the other cygwin installation out of PATH.
>> Anyway, sorry, I should have tried this before posting.
>
>Still does not work for me. I cannot isolate the problem out of git,
>but at the moment the only way for me to make commit_index_file to work
>is to put unlink(indexfile) before rename(cf->lockfile, indexfile).
>
>For everyone interested, I attach cygwin's strace output here.

I'm sorry that I missed this thread.  I'm usually pretty alert to the word
"cygwin" showing up in a subject.

I'll go back and read the archives to catch up but, at the risk of
making an observation that has already been made, under windows you
can't always rename a file that is open.  Is that what's happening here?

--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
TimeSys, Inc.
