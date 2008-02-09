From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 11:53:22 +0100
Message-ID: <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 09 11:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNnKi-0000Hp-Tl
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 11:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395AbYBIKwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 05:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbYBIKwc
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 05:52:32 -0500
Received: from mailer.zib.de ([130.73.108.11]:51102 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796AbYBIKwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 05:52:30 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m19AqPKB013511;
	Sat, 9 Feb 2008 11:52:25 +0100 (CET)
Received: from [192.168.178.21] (brln-4db92967.pool.einsundeins.de [77.185.41.103])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m19AqOrP019587
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 9 Feb 2008 11:52:24 +0100 (MET)
In-Reply-To: <20080209030046.GA10470@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73208>


On Feb 9, 2008, at 4:00 AM, Jeff King wrote:

>
> I really think that Steffen's "default to pushing only the current
> branch" approach fits much better with the model described in your
> workflow, and is generally a safer default. IIRC, the main  
> objection was
> that old-timers like the current push behavior better. Steffen, was
> there objection to a "push.onlyHEAD" config option?

There might have been an argument like: We should have a single
default because otherwise the behaviour of git depends on the
local configuration of the user.  This may cause even more
confusion than it tries to solve, because now you always need
to start first talking about the local configuration of the
users before you can start explaining how to actually solve the
problem.

Personally, I decided it is safer to teach users to explicitly
type what they mean.  I'd probably not use the push.onlyHEAD
config option.

I also proposed that the default could do nothing if no explicit
push lines are in the configuration file.  Users would be forced
to explicitly type what the want: Either they can say "--matching"
or they can say "--current".  This is similar to the new
"git clean" default.  But I remember there *was* objection against
this because everyone would be forced to type more and different
than "git clean" the default of "git push" is considered "safe",
so there's no need to protect the user from "git push".

Junio proposed various possible changes to the configuration
variables that could resolve the issues.  I do not remember the
details.

	Steffen
