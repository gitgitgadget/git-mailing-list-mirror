From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH/RFC] Do not use mktemp
Date: Tue, 12 Aug 2008 22:44:33 +0200
Message-ID: <20080812204433.GM10151@machine.or.cz>
References: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Aug 12 22:45:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT0kM-0004UY-Nc
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 22:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbYHLUog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 16:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbYHLUog
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 16:44:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47129 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbYHLUof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 16:44:35 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8A656393A811; Tue, 12 Aug 2008 22:44:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.62.0808121309000.18832@harper.uchicago.edu>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92138>

  Hi,

On Tue, Aug 12, 2008 at 01:14:27PM -0500, Jonathan Nieder wrote:
> Old operating systems may not even have mktemp; less old
> operating systems may have a mktemp which is not compatible with
> the usual post-1.5 version.  Let's try to do without.

  can you give some concrete examples?

  If there are really systems like that, I have nothing against
providing our own mktemp stub, but I'm not really fond of the approach
chosen in this patch. I see no reason why our stub shouldn't be
compatible with mktemp - what strikes me is a lot of code duplication
and arcane umask use at a lot of places, this should be encapsulated in
some mktemp() function.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
