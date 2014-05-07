From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 07/28] Added test cases for "guilt fold".
Date: Wed, 7 May 2014 17:06:02 -0400
Message-ID: <20140507210601.GA1459@meili.valhalla.31bits.net>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
 <1395387126-13681-8-git-send-email-cederp@opera.com>
 <20140506194026.GK1655@meili.valhalla.31bits.net>
 <CAP=KgsQ2fvVWZG7OwwWac+tMeWaPTEdSrgFqE5gVfSAqNn-VCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Wed May 07 23:06:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi92Y-0007ci-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 23:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbaEGVGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 17:06:06 -0400
Received: from josefsipek.net ([64.9.206.49]:1629 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbaEGVGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 17:06:03 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 1B83255654;
	Wed,  7 May 2014 17:06:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAP=KgsQ2fvVWZG7OwwWac+tMeWaPTEdSrgFqE5gVfSAqNn-VCQ@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248377>

On Wed, May 07, 2014 at 10:59:56PM +0200, Per Cederqvist wrote:
> On Tue, May 6, 2014 at 9:40 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> > On Fri, Mar 21, 2014 at 08:31:45AM +0100, Per Cederqvist wrote:
> >> Test that we can combine any combination of patches with empty and
> >> non-empty messages, both with and without guilt.diffstat.  (All
> >> patches are empty.)
> >
> > I feel like we should have *some* content there - most of the time, I care
> > more about the diffs getting folded than the commit message :)
> 
> I added these tests for a reason: the reproduce a bug in guilt that I found.
> 
> I'm afraid that having some content might hide the bug I found. (I'm also
> equally afraid that it might uncover other bugs in guilt, which would delay
> integration of this patch series. So adding more test cases with content
> is a good thing to do, but maybe not in this patch series.)

Fair enough.  I use guilt-fold all the time and it hasn't lost any of my
diffs, so I'm happy to defer this until some point in the future.

...
> > for using_diffstat in true false ; do
> >         for patcha in empty nonempty ; do
> >                 for patchb in empty nonempty ; do
> >                         echo "%% $patcha + $patchb (diffstat=$using_diffstat)"
> >                         ${patcha}_patch $patcha
> >                         ${patchb}_patch $patchb
> >                         cmd guilt pop $patchb
> >                         cmd guilt fold $patchb
> >                         fixup_time_info $patcha
> >                         cmd list_files
> >                         cleanup $patcha
> >                         cmd list_files
> >                 done
> >         done
> > done
> >
> > Aha!  That's better, IMO.
> 
> I'll try that and post a version 2 of the series. It might take a few
> days, though.

No problem.  I'm still the slower one of the two of us. :/

Jeff.

-- 
Keyboard not found!
Press F1 to enter Setup
