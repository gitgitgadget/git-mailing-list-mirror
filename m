From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Submodules
Date: Wed, 08 Aug 2007 12:41:17 +0200
Message-ID: <20070808104117.GK999MdfPADPa@greensroom.kotnet.org>
References: <a1bbc6950708071537xfa6b9a0ne8cf66e345fa31b4@mail.gmail.com>
 <Pine.LNX.4.64.0708072349400.14781@racer.site>
 <a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 12:41:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIiyi-0006T7-7D
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 12:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXHHKlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 06:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbXHHKlV
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 06:41:21 -0400
Received: from psmtp08.wxs.nl ([195.121.247.22]:63009 "EHLO psmtp08.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbXHHKlU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 06:41:20 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp08.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JMG00KHKB0TGF@psmtp08.wxs.nl> for git@vger.kernel.org; Wed,
 08 Aug 2007 12:41:18 +0200 (MEST)
Received: (qmail 24101 invoked by uid 500); Wed, 08 Aug 2007 10:41:17 +0000
In-reply-to: <a1bbc6950708071631w5d232e92gd0fa27158b27b5c3@mail.gmail.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55316>

On Tue, Aug 07, 2007 at 04:31:57PM -0700, Dmitry Kakurin wrote:
> This is exactly the level of details I'm talking about:
> * how come sumbodules are not initialized when I do a clone of super.

See you second question.

> I expect to be able to build super after I clone it. Is there a new
> (undocumented) flag to clone?

Not (yet).  Right now, you have to do

git submodule init
git submodule update

after you clone to fetch and check-out all (first-level) submodules.

> * is it OK to *not* init a submodule? will super become unhappy? Can I
> do commits to super in this case?

Yes. No. Yes.
In fact, only the "git submodule" subcommand are affected by a
"git submodule init".  Doing a "git submodule update" will actually
check out the submodules and from then on, the HEAD of this checked-out
submodule will be considered the content of the submodule in
the working tree of the supermodule.

> * why submodules should be listed in 2 places: in .submodules and in
> super/.git/config?

It only has to be specified in .git/config.
The value in .gitmodules (if present) is used by "git submodule init"
as a default value for the one in .git/config.

skimo
