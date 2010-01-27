From: Petr Baudis <pasky@suse.cz>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 16:08:34 +0100
Message-ID: <20100127150834.GG9553@machine.or.cz>
References: <201001270819.39819.elendil@planet.nl>
 <7viqaorowo.fsf@alter.siamese.dyndns.org>
 <201001270936.14935.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:10:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Na9Vc-0001o8-6S
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 16:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab0A0PIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 10:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753169Ab0A0PIi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 10:08:38 -0500
Received: from w241.dkm.cz ([62.24.88.241]:49156 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563Ab0A0PIi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 10:08:38 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 3AE5186202A; Wed, 27 Jan 2010 16:08:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201001270936.14935.elendil@planet.nl>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138158>

On Wed, Jan 27, 2010 at 09:36:14AM +0100, Frans Pop wrote:
> On Wednesday 27 January 2010, Junio C Hamano wrote:
> > Frans Pop <elendil@planet.nl> writes:
> > > I'm currently using the following command for this:
> > >    git log --pretty=format:%H | grep -q "^<commit id>"
> > >
> > > Problem is that with large repos that can be quite slow.
> > >
> > > Is there a faster way to do the test?
> >
> > test "$(git merge-base HEAD $commit)" = "$(git rev-parse $commit)"
> 
> Great! If the commit ID is not present that only takes 1 sec versus 11 secs 
> for my test. (If the commit _is_ present and fairly recent my test can be 
> faster, but 11 secs delay when it's not present hurts more.)

Isn't something very wrong if grepping the log output is faster than
simple merge-base call? Can you post exact numbers?

				Petr "Pasky" Baudis
