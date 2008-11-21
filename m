From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: git-status for submodules
Date: Fri, 21 Nov 2008 17:42:47 -0500
Message-ID: <20081121224247.GB27049@foursquare.net>
References: <20081120033615.GA21128@foursquare.net> <7vabbtqga8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 23:44:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3ek1-0008El-RO
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 23:44:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbYKUWna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 17:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754207AbYKUWna
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 17:43:30 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:50513 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYKUWn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 17:43:29 -0500
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id mALMgmxB003937;
	Fri, 21 Nov 2008 17:42:48 -0500
Content-Disposition: inline
In-Reply-To: <7vabbtqga8.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101545>

On Fri, Nov 21, 2008 at 06:56:15AM -0800, Junio C Hamano wrote:
> My understanding is that this is exactly by design.  The supermodule
> tracks which commit in the subproject is bound to the tree location.


> the submodule support is geared toward supporting this layout:
> 
> 	- "super" has a subproject X at "sub"
> 
>         - When you do a real work on the subproject X, you do so as if
>           there is no supermodule.  IOW, subproject X has to be able to
>           stand on its own.

It's true that subproject X has to be able to stand on its own.  That
is important from git's perspective as well as for managing subprojects
in general.

But I don't see the advantage in hiding submodule information from the
supermodule, and if that hiding is by design, I think the design is wrong.
In order to manage the various modules effectively (actually, in order to
manage any git repo effectively), you need to know what's changed,
and git-status is the way to do that.  I don't see why submodules should
break that.

With the new submodule foreach command, though, it should be possible
to add that as a config option, similar to the way submodule summary
is handled now.  Maybe I can cook up a patch for that.

- Chris
