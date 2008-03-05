From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: msgmft segfaulting on tiger
Date: Wed, 5 Mar 2008 02:19:15 -0500
Message-ID: <20080305071915.GI8410@spearce.org>
References: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com> <46a038f90802211559w457c5460k7447ba8b38352713@mail.gmail.com> <20080222065836.GE8410@spearce.org> <46a038f90802220957y7db67d8nb6b7ad784124546a@mail.gmail.com> <47C5A974.7080207@gmail.com> <alpine.LSU.1.00.0802271825330.22527@racer.site> <47C5AEFA.5020004@gmail.com> <alpine.LSU.1.00.0802272203270.22527@racer.site> <7vablmqc7q.fsf@gitster.siamese.dyndns.org> <47C7000C.1000809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Gabriel =?utf-8?Q?Salda=C3=B1a?= <gsaldana@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 05 08:20:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWnuy-0006Hq-A2
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 08:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbYCEHTW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 02:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752394AbYCEHTW
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 02:19:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38898 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbYCEHTV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 02:19:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JWnuF-0003oL-Qv; Wed, 05 Mar 2008 02:19:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C0B5020FBAE; Wed,  5 Mar 2008 02:19:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <47C7000C.1000809@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76182>

Gabriel Saldaa <gsaldana@gmail.com> wrote:
> Here's the output, hope it helps:
> 
> $ msgfmt --tcl -l C -d . /dev/null; echo $?
> msgfmt: unrecognized option `--tcl'
> Try `msgfmt --help' for more information.
> 1
> 
> somehow msgfmt doesn't recognize the --tcl flag.

Just to revive a nearly dead thead...  I have a workaround now in
git-gui maint that looks for this case and falls into our po2msg
script when msgfmt doesn't see --tcl.

I also set Paul Mackerras a patch for gitk, so it can do the
same thing.  Maybe Git 1.5.4.4 will include both patches.
 
> Junio C Hamano wrote:
> >Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>>$ msgfmt --tcl; echo $?
> >>>msgfmt: unrecognized option `--tcl'
> >>>Try `msgfmt --help' for more information.
> >>>1
> >>Darn.  I think that's the same exit code as for any other invocation 
> >>without filename.
> >>
> >>So it seems that there is no easy way to tell a --tcl aware msgfmt from 
> >>the other.
> >
> >How about...
> >
> >    $ msgfmt --tcl -l C -d . /dev/null; echo $?

-- 
Shawn.
