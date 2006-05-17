From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Merge with local conflicts in new files
Date: Wed, 17 May 2006 20:50:41 +1200
Message-ID: <46a038f90605170150x361892abv8df226aa899f1a95@mail.gmail.com>
References: <8aa486160605161500m1dd8428cj@mail.gmail.com>
	 <7v1wut61aj.fsf@assigned-by-dhcp.cox.net>
	 <8aa486160605161611p4c9ddbc0v@mail.gmail.com>
	 <7vu07p35xn.fsf@assigned-by-dhcp.cox.net>
	 <1147852052.31879.50.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, Santi <sbejar@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 10:50:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgHjz-0001sK-9A
	for gcvg-git@gmane.org; Wed, 17 May 2006 10:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWEQIun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 04:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbWEQIun
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 04:50:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:15476 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751017AbWEQIum convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 04:50:42 -0400
Received: by wr-out-0506.google.com with SMTP id i4so178769wra
        for <git@vger.kernel.org>; Wed, 17 May 2006 01:50:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S+dxn74lVsY8xeEmUqcrOaaufCs61FnEvvCae3jkftXWkHSK1H45hCn0llxe9iedoD3i9QwJrFF6qmhYfrAaRnCQiT3hG/J1uRrOV6dJEY0MPIhDNpHlh4QF1s1NgcN6vyBm1nSyJ3jEm3aVGr6MhCIpp1WQ67AD8bZScYXY1MI=
Received: by 10.54.134.15 with SMTP id h15mr2203672wrd;
        Wed, 17 May 2006 01:50:41 -0700 (PDT)
Received: by 10.54.127.17 with HTTP; Wed, 17 May 2006 01:50:41 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1147852052.31879.50.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20173>

On 5/17/06, Pavel Roskin <proski@gnu.org> wrote:
> If a file doesn't "belong" to git, it belongs to its
> "supreme commander", i.e. the user, and should be approached with utmost
> care.

+1 here. Unknown files are precious (to take an Arch term) until git
is told otherwise.

> special options (e.g. --force or --hard), and for the files explicitly
> marked as transient (e.g. in .gitignore).

I think that if we turn into clobbering files listed in .gitignore
users will probably be screaming bloody murder. No git op should
clobber untracked files...

Arch has this strange concept of allowing you to list 'junk' files. I
could never figure out why it would want my authorization to remove
files randomly. For all its faults, cvs does the right thing -- it
will say 'checkout/update of foo.c blocked by foo.c in directory'. And
if you force it with -C it will rename the local file to
.#originalname-local or something like that.

Even the files I think of as junk are actually useful and should not
be messed up with. Editor temp files, for instance, are often listed
in .gitignore, and if you ask me, they are junk. Except while I am
working with my editor! ;-)

Another case is .project files from IDEs like Eclipse. People list
them in .cvsignore so that they are not committed, and yet preserved.
The user probably has a lot of personal settings there.

cheers,


martin
