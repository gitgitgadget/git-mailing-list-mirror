From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT v2 28/29] Added guilt.reusebranch configuration option.
Date: Thu, 15 May 2014 10:29:50 -0400
Message-ID: <20140515142949.GB2735@meili.valhalla.31bits.net>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
 <1400013065-27919-29-git-send-email-cederp@opera.com>
 <20140514155324.GE1582@meili.valhalla.31bits.net>
 <CAP=KgsR66gX6WduCE8-GXDF7qZ=zV=X_CjLRh-PRb7CJoRTqjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Thu May 15 16:29:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkwfV-0002ZX-6g
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 16:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbaEOO3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 10:29:46 -0400
Received: from josefsipek.net ([64.9.206.49]:1681 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559AbaEOO3o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 10:29:44 -0400
Received: from meili.valhalla.31bits.net (c-98-209-117-250.hsd1.mi.comcast.net [98.209.117.250])
	by josefsipek.net (Postfix) with ESMTPSA id 9EFBF55654;
	Thu, 15 May 2014 10:29:42 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAP=KgsR66gX6WduCE8-GXDF7qZ=zV=X_CjLRh-PRb7CJoRTqjA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249101>

On Thu, May 15, 2014 at 09:37:05AM +0200, Per Cederqvist wrote:
> On Wed, May 14, 2014 at 5:53 PM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> > On Tue, May 13, 2014 at 10:31:04PM +0200, Per Cederqvist wrote:
...
> >> +
> >> +for i in `seq 5`; do
> >> +     if [ $i -ge 5 ]; then
> >> +             shouldfail guilt pop
> >> +     else
> >> +             cmd guilt pop
> >> +     fi
> >> +     cmd git for-each-ref
> >> +     cmd guilt push
> >> +     cmd git for-each-ref
> >> +     cmd guilt pop
> >> +     cmd git for-each-ref
> >> +done
> >> +
> >> +# Check that "pop -a" does the right thing.
> >
> > What exactly is the right thing?  no-op since the above loop poped
> > everything?  (I'd make the comment say what the "right thing" is.)
> 
> I'll rephrase that block of code like this:
> 
> # Check that "pop -a" properly pops all patches.
> cmd guilt push -a
> cmd git for-each-ref
> cmd guilt pop -a
> cmd git for-each-ref
> 
> Is that more clear? The test pushes all patches, checks that they
> are applied, removes them, checks that it worked.

Yeah.

Thanks,

Jeff.

-- 
NT is to UNIX what a doughnut is to a particle accelerator.
