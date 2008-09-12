From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Fri, 12 Sep 2008 12:58:39 +0200
Message-ID: <20080912105839.GV10360@machine.or.cz>
References: <20080909231009.GD10544@machine.or.cz> <20080911054030.GA6602@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Sep 12 12:59:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6NX-0004ah-34
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831AbYILK6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbYILK6n
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:58:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35700 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753507AbYILK6m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 06:58:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7787A393A816; Fri, 12 Sep 2008 12:58:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080911054030.GA6602@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95709>

  Hi,

On Thu, Sep 11, 2008 at 07:40:30AM +0200, Mike Hommey wrote:
> I just saw Martin Krafft's talk at debconf 8, showing TopGit, and I
> wonder why TopGit needs to keep top-bases/* references ? Isn't
> git merge-base enough for this ?

  the top-bases/ references are to determine what to base the patch
against. Consider patch structure like:

	         .---- A ----.
	vanilla <             > C
	         `---- B ----'

  Then, top-bases/C will consist of branches A and B, merging updates in
these branches over time, and you can get the current image of C's patch
by diffing top-bases/C and heads/C. There is no way how to get this by
using git merge-base, since that gives you only kind of "multi-way
diff" - I'm not even sure what would you call merge-base on in this
example.

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
