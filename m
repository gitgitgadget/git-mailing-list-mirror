From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] git-svn: sanitize_remote_name should accept underscores.
Date: Wed, 25 Jun 2008 00:45:48 -0700
Message-ID: <20080625074548.GA8984@hand.yhbt.net>
References: <1214322898-9272-1-git-send-email-apenwarr@gmail.com> <20080625064435.GL21299@hand.yhbt.net> <20080625065556.GM21299@hand.yhbt.net> <7vfxr23s6m.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 09:47:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBPiY-0006bw-7B
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 09:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbYFYHpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 03:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbYFYHpu
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 03:45:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:39456 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752954AbYFYHpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 03:45:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 716AC2DC095;
	Wed, 25 Jun 2008 00:45:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfxr23s6m.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86251>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > Wait, nevermind, this is for remotes, not remote *branches*.
> >
> > Umm... are underscores now allowed in git config files?
> 
> In
> 
> 	[foo "bar"] baz = value
> 
> foo and baz must be config.c::iskeychar() (and baz must be isalpha()), but
> "bar" can be almost anything.
> 
> Isn't "not underscore" coming from DNS hostname part restriction?

No, nothing to do with DNS hostnames in the remote names.  I think I
just looked at remotes2config.sh one day and used it as a reference :x

It's late and I've had a rough few days, but shouldn't
sanitize_remote_name() just escape . and "?  Right now it's converting
stuff to . which has me very confused...

-- 
Eric Wong (in need of sleep and sanity atm...)
