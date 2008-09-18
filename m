From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: Always create a new RA when calling do_switch
	for svn://
Date: Wed, 17 Sep 2008 23:44:29 -0700
Message-ID: <20080918064429.GB13328@untitled>
References: <1221426856-2652-1-git-send-email-alec@thened.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alec Berryman <alec@thened.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 18 08:45:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgDGk-0001nn-Dd
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 08:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbYIRGob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 02:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYIRGoa
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 02:44:30 -0400
Received: from user-118bg0q.cable.mindspring.com ([66.133.192.26]:58464 "EHLO
	untitled" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751940AbYIRGoa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 02:44:30 -0400
X-Greylist: delayed 383 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Sep 2008 02:44:30 EDT
Received: from localhost.localdomain (localhost [127.0.0.1])
	by untitled (Postfix) with ESMTP id 3F4D133466B;
	Thu, 18 Sep 2008 06:44:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1221426856-2652-1-git-send-email-alec@thened.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96168>

Alec Berryman <alec@thened.net> wrote:
> 
> This was reported as Debian bug #464713.  An example repository can be
> found at svn://svn.debian.org/chinese/packages/lunar-applet.  When I try
> to clone it with 1.6.0.2.229.g1293c or 1.5.6.5, both using 1.5.1
> libraries, I see the following:
> 
> r158 = 1107cff6309c979751e0841d40b9e2e471694b26 (git-svn@159)
>     M   debian/changelog
>     M   debian/rules
> r159 = 010d0b481753bd32ce0255ce433d63e14114d3b6 (git-svn@159)
> Found branch parent: (git-svn) 010d0b481753bd32ce0255ce433d63e14114d3b6
> Following parent with do_switch
> Malformed network data: Malformed network data at /home/alec/local/git/libexec/git-core//git-svn line 2360
> 
> It looks like the user made several commits and decided to undo them by
> removing the directory and copying an older version in its place.
> 
> This appears to only affect access via svn:// and svn+ssh://; I tried
> with file:// but not with http://.
> 
> The first patch is a minor refactoring of some test code, and the second
> one actually fixes the issue for me.

Thanks Alec, and sorry for the latency.

This series is:
  Acked-by: Eric Wong <normalperson@yhbt.net>

-- 
Eric Wong
