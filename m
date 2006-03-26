From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 20:11:14 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603252005360.12437@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
 <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0603251030340.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 06:11:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNMb5-0003Fs-Jy
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 06:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbWCZELV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 23:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWCZELV
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 23:11:21 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:7562 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751581AbWCZELU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 23:11:20 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C6B54> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 25 Mar 2006 20:11:19 -0800
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603251030340.15714@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18026>

On Sat, 25 Mar 2006, Linus Torvalds wrote:

> I don't need "patch", since I wrote my own anyway. It's just called
> "apply" instead of "patch".

Oh, ok. I thought you were calling out GNU patch for the task.


> Doing "apply" is not only much simpler than doing "diff", but I needed my
> own much earlier: it's much more timing-critical for me (applying 200
> patches in one go), and git needed something that could honor renames and
> copies, and the mode bits too.
>
> Besides, I hate how GNU patch bends over backwards in applying crap that
> isn't a proper patch at all (whitespace-corruption, you name it: GNU patch
> will accept it). Also, I made "git-apply" be all-or-nothing: either it
> applies the _whole_ patch (across many different files) or it applies none
> of it. With GNU patch, if you get an error on the fifth file, the four
> first files have been modified already - aarrgghhh..
>
> See "apply.c" for details if you care. It's stupid, but it works (and it
> _only_ handles unified diffs - with the git extensions, of course).

So is xdl_patch(). It handles unified diffs, a simple ignore whitespace 
changes, and all (methink) the fuzzy merge features of GNU patch.
Okie then, drop me an email if you find bugs in the libxdiff code, so I 
can fix the main library.



- Davide
