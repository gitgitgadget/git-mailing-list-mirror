From: Michael Meeks <michael.meeks@novell.com>
Subject: copying git repositories ...
Date: Mon, 28 Feb 2011 14:25:02 +0000
Organization: Novell, Inc.
Message-ID: <1298903102.14697.127.camel@lenovo-w500>
References: <1298388877.32648.171.camel@lenovo-w500>
	 <993F66D7-7659-4AA5-9931-1EB66CAA01DB@silverinsanity.com>
	 <1298565560.32648.258.camel@lenovo-w500>
	 <201102252155.13466.andres@anarazel.de>
Reply-To: michael.meeks@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org,
	kendy@novell.com, Norbert Thiebaud <nthiebaud@gmail.com>
To: Andres Freund <andres@anarazel.de>
X-From: git-owner@vger.kernel.org Mon Feb 28 15:25:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu42l-0005GW-4b
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 15:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab1B1OZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 09:25:42 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:42250 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754020Ab1B1OZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 09:25:41 -0500
Received: from [192.168.0.5] (mmeeks.gotadsl.co.uk [213.208.123.138])
	by nat.nue.novell.com with ESMTP; Mon, 28 Feb 2011 15:25:39 +0100
In-Reply-To: <201102252155.13466.andres@anarazel.de>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168112>

Hi Andres & Brian,

	Thanks for your help;

On Fri, 2011-02-25 at 21:55 +0100, Andres Freund wrote:
> > On Tue, 2011-02-22 at 10:55 -0500, Brian Gernhardt wrote:
> > > FYI: `git clone foo bar` will use hard-links to copy the object
> > > files and is both very fast and space efficient.  (See the
> > > description of `--local` in git-clone(1), which is used by
> > > default for local repositories since git 1.5.3.)  It's also
> > > guaranteed to work while the correctness of `cp -lR` depends
> > > on implementation details of git.
..
> > 	Sounds like just what I need. Unfortunately, it didn't clone some of
> > the pieces I needed; eg. other configured remotes, I ended up with just
> > 'origin' - which was unexpected (and less wonderful than cp -lR ;-).
..
> See the --mirror option for clone

	I tried all of this; none of it did what I had hoped :-)

	git clone src dest

	yields a different repository, with a totally different config /
remotes setup - missing all but a new synthetic origin pointing at the
local files and which can't be git pulled from in the normal way; ie. it
behaves extremely differently to the cp -lR result.

	git clone --mirror src dest

	yields a similar problem-repository, which is for extra measure a bare
checkout, and thus also not what I need.

	I'm really looking for an equivalent of 'cp -lR foo baa' that:

	* uses hard links to save space
	* produces precisely-a-duplicate repository

	For #2 - I would use the verb 'clone' except of course the 'clone' I'm
talking about would be one that is identical, the same, with no
differences (not eg. missing a few limbs ;-) 

	Clearly cp -lR is bad & evil and all that; but it yields exactly what I
need to effectively manage my local trees, multiple checkouts, and
different builds without burning the entire disk.

	Is there a blessed 'cp -lR' wrapper for git that is functionally
identical ? [ and I'm happy of course for some slow divergence, and loss
of efficiency as I pull more changes from time to time into each tree ].

	Sorry for the noise,

		Michael.

-- 
 michael.meeks@novell.com  <><, Pseudo Engineer, itinerant idiot
