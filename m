From: Miles Bader <miles.bader@necel.com>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 20:22:15 +0900
Message-ID: <buo4p7xtw9k.fsf@dhapc248.dev.necel.com>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil>
	<5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil>
	<20080611213648.GA13362@glandium.org>
	<alpine.DEB.1.00.0806112242370.1783@racer>
	<20080611230344.GD19474@sigill.intra.peff.net>
	<co7kgJpJNdIs2f8n_PwYKAS7MwV9t1G_P3BPr1eXTZ4ytUHcsPvVaw@cipher.nrlssc.navy.mil>
	<20080612041847.GB24868@sigill.intra.peff.net>
	<u5dYyGz0Q8KNQXnvGOEGmG2BTfT-vJCEFeSUa2I_99Q@cipher.nrlssc.navy.mil>
	<20080613054840.GA27122@sigill.intra.peff.net>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 13:28:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K77Rq-0000D1-1y
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 13:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbYFML1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 07:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYFML1G
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 07:27:06 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:39525 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbYFML1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 07:27:04 -0400
Received: from relay31.aps.necel.com ([10.29.19.54])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id m5DBLcjZ019413;
	Fri, 13 Jun 2008 20:22:15 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.20] [10.29.19.20]) by relay31.aps.necel.com with ESMTP; Fri, 13 Jun 2008 20:22:15 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Fri, 13 Jun 2008 20:22:15 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 2604D4E7; Fri, 13 Jun 2008 20:22:15 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <20080613054840.GA27122@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 Jun 2008 01:48:40 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84866>

Jeff King <peff@peff.net> writes:
> So I think we are disagreeing not on how stashes should expire, but
> rather on what a stash _is_, and what it is useful for. And I am open to
> arguments that stashes are useful for longer-term storage. But I also
> find the expiration behavior useful

I don't think anybody is really arguing that stashes aren't _mostly_
useful for short-term storage.

I think the problem is that _sometimes_ stashes end up sticking around
longer than people suspect, and this is not necessarily planned (or even
intentional).  I've done it -- I'll stash some changes "temporarily" in
a little-used working directory, then end up doing something else and
forgetting to re-apply the stash.  I'll then revisit that working dir a
long time later, wonder where my changes are, poke around a bit, and
find them in the stash; no prob.

-Miles

-- 
80% of success is just showing up.  --Woody Allen
