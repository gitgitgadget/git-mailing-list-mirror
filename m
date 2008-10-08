From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Implement git clone -v
Date: Tue, 7 Oct 2008 23:02:57 -0700
Message-ID: <20081008060257.GA15240@spearce.org>
References: <81b0412b0810041442i3aa29628lf66ef9b188fe8ce7@mail.gmail.com> <1223331590-22138-1-git-send-email-vmiklos@frugalware.org> <81b0412b0810062321h33abe076kd87b60bffdaf218b@mail.gmail.com> <20081007193956.GB536@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Oct 08 08:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnS9d-0003IW-2f
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbYJHGC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYJHGC6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:02:58 -0400
Received: from george.spearce.org ([209.20.77.23]:49922 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYJHGC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:02:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3C5AF38360; Wed,  8 Oct 2008 06:02:57 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081007193956.GB536@genesis.frugalware.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97759>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Tue, Oct 07, 2008 at 08:21:28AM +0200, Alex Riesen <raa.lkml@gmail.com> wrote:
> > Yes. Does it work? :)
> 
> Yes, it does. I'm not sure how to test it from the testsuite, maybe
> redirect the output to a file and grep in it? It's ugly, that's why I
> did not do so, but if you think a testcase is a musthave for this
> feature then that's the way to go, I guess.

Actually its not a bad way to test the feature.  Normally we disable
progress if stdout is not a tty.  If you redirect to a file then
-v should be needed to get anything at all on stderr.

You may be able to just test the size of the file:

	git fetch -v ... >out 2>err &&
	test -s err

-- 
Shawn.
