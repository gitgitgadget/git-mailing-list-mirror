From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: Re: [PATCH 08/10] run test suite without dashed git-commands in PATH
Date: Mon, 26 Jan 2009 23:13:49 -0700
Message-ID: <20090127061349.GA2417@comcast.net>
References: <1232840601-24696-3-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-4-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-5-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-6-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-7-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-8-git-send-email-mmogilvi_git@miniinfo.net> <1232840601-24696-9-git-send-email-mmogilvi_git@miniinfo.net> <alpine.DEB.1.00.0901250255250.14855@racer> <20090126064004.GA3004@comcast.net> <alpine.DEB.1.00.0901261201470.14855@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 27 07:15:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRhEF-00075h-Pe
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 07:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZA0GNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 01:13:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbZA0GNz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 01:13:55 -0500
Received: from qmta02.emeryville.ca.mail.comcast.net ([76.96.30.24]:46097 "EHLO
	QMTA02.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596AbZA0GNy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jan 2009 01:13:54 -0500
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52])
	by QMTA02.emeryville.ca.mail.comcast.net with comcast
	id 8REr1b00P17UAYkA2WDtMc; Tue, 27 Jan 2009 06:13:53 +0000
Received: from mmogilvi.homeip.net ([75.70.161.67])
	by OMTA13.emeryville.ca.mail.comcast.net with comcast
	id 8WDr1b00L1TYyYj8ZWDsrX; Tue, 27 Jan 2009 06:13:52 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id C585B89115; Mon, 26 Jan 2009 23:13:49 -0700 (MST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901261201470.14855@racer>
User-Agent: Mutt/1.5.4i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107314>

On Mon, Jan 26, 2009 at 12:06:08PM +0100, Johannes Schindelin wrote:
> So maybe I was wrong to assume that this is cvsserver specific, but then, 
> you made that mistake rather easy to make.

Yes, in retrospect I probably should have split off patches 6, 7,
8, and maybe 5 (5-7 fix issues that patch 8 exposes in the test suite)
into a separate patch series.  When or if a v2 is needed, should
I split them off then?

> >     4. The test-bin-wrapper.sh script does not actually need to set 
> >        environment variables (GIT_EXEC_DIT and templates) for purposes 
> >        of this patch.  But my thought was that in this form you could 
> >        run things straight out of the test-bin directory to manually try 
> >        out new code without needing to actually install a build or mess 
> >        with the environment variables yourself.  It could also be 
> >        extended to handle other global wrapper needs relatively easily, 
> >        such as valgrind.
> 
> Umm.
> 
> You missed the valgrind patch series.

Actually, I'm (poorly) alluding to some comments in the original patch
8 email, where I pointed out an expected conflict with the valgrind
patches.  To briefly recap, there are at least 3 possible strategies
of resolving such a conflict, and I'm not sure which makes the most
sense: Keep valgrind design, and extend it with limited bindir
support.  Keep limited bindir design and extend it with valgrind
support.  Or keep both, and have the runtime setup logic make
them mutually exclusive.

--
Matthew Ogilvie   [mmogilvi_git@miniinfo.net]
