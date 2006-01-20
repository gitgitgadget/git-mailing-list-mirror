From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] "sleep 1" sleeps too little on cygwin
Date: Fri, 20 Jan 2006 10:40:55 -0500
Message-ID: <20060120154054.GA3392@trixie.casa.cgf.cx>
References: <7v4q41zd1t.fsf@assigned-by-dhcp.cox.net> <20060118185229.GA3001@steel.home> <7vmzhtqakl.fsf@assigned-by-dhcp.cox.net> <81b0412b0601190701g2696b1a9l14f3d288875e11ab@mail.gmail.com> <20060119182822.GA32022@trixie.casa.cgf.cx> <20060119221227.GB3601@steel.home> <20060119222553.GB7567@trixie.casa.cgf.cx> <7vbqy78zwy.fsf@assigned-by-dhcp.cox.net> <20060120033548.GE5090@trixie.casa.cgf.cx> <81b0412b0601200723k1a271046u9c310d9c9b7d83f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 20 16:41:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzyNt-0002G4-1W
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 16:41:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWATPk7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 10:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWATPk7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 10:40:59 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:62396 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1750788AbWATPk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Jan 2006 10:40:58 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id 3C2AE5A8006; Fri, 20 Jan 2006 10:40:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <81b0412b0601200723k1a271046u9c310d9c9b7d83f0@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14967>

On Fri, Jan 20, 2006 at 04:23:10PM +0100, Alex Riesen wrote:
>On 1/20/06, Christopher Faylor <me@cgf.cx> wrote:
>> On Thu, Jan 19, 2006 at 05:13:17PM -0800, Junio C Hamano wrote:
>> >Christopher Faylor <me@cgf.cx> writes:
>> >>Inodes are only calculated by hashing the path name when the OS lacks
>> >>the support to provide a "real" inode and in that case there is no hard
>> >>link support available so it's a non-issue.
>> >
>> >Does that mean on such filesystems "mv foo bar" would change the i-num
>> >of the moved entity?
>
>It is just a rename. It will not change inode by definition (the file is the
>same, it is the name which was changed). To get inode change you
>have to create it, like "cp foo bar; rm foo". And now, if a filesystem
>has (or exports) inodes, would the inode change. If it does not, you
>really can't say anything about the inode (it can even change, and
>does in this case, being calculated from pathname).
>
>> I just tried this on Windows XP.  On a FAT32 or a NTFS filesystem the
>
>I have FAT32. It does not support inodes"
>    $ : > foo
>    $ stat foo |grep node
>    Device: 111712fch/286724860d    Inode: 3595119992080318288  Links: 1
>    $ mv foo bar
>    $ stat bar |grep node
>    Device: 111712fch/286724860d    Inode: 3595119974866484701  Links: 1

Ok, I must have been hallucinating.  I just tried it again.  It doesn't
work on FAT32.

cgf
