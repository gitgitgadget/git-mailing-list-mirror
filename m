From: Scott Wiersdorf <scott@perlcode.org>
Subject: Re: git log -S not finding all commits?
Date: Fri, 9 Oct 2009 06:41:50 -0600
Message-ID: <20091009124149.GA50560@perlcode.org>
References: <7ae12651.522df17b.4acda0f5.21a31@o2.pl> <4ACDACE6.9060509@op5.se> <362436ca.6b5d0fc3.4acdc7e1.41b23@o2.pl> <vpqbpkixgea.fsf@bauges.imag.fr> <vpq63aqxflu.fsf@bauges.imag.fr> <86tyy9qz08.fsf@blue.stonehenge.com> <vpq1vldx7xx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 14:45:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwEq6-0002ig-Qv
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 14:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427AbZJIMmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 08:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753247AbZJIMmb
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 08:42:31 -0400
Received: from deep2.securesites.net ([198.65.247.173]:3577 "EHLO
	deep2.securesites.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366AbZJIMma (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 08:42:30 -0400
Received: from deep2.securesites.net (localhost [127.0.0.1])
	by deep2.securesites.net (8.13.6.20060614/8.13.6) with ESMTP id n99CfquK016089
	for <git@vger.kernel.org>; Fri, 9 Oct 2009 06:41:52 -0600 (MDT)
Received: (from scott@localhost)
	by deep2.securesites.net (8.13.6.20060614/8.13.6/Submit) id n99Cfq3v016088
	for git@vger.kernel.org; Fri, 9 Oct 2009 06:41:52 -0600 (MDT)
Mail-Followup-To: Scott Wiersdorf <scott@perlcode.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <vpq1vldx7xx.fsf@bauges.imag.fr>
User-Agent: Mutt/1.4.2.3i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (deep2.securesites.net [127.0.0.1]); Fri, 09 Oct 2009 06:41:52 -0600 (MDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129797>

On Fri, Oct 09, 2009 at 10:55:38AM +0200, Matthieu Moy wrote:
> >
> >   perl -0 -ne 'print if /this/'
> 
> Also, this seems to actually print the \0 character. Perhaps a perl
> guru can give a simple solution to replace the \0 by a \n?

If you want some indication that there is a null character:

  perl -0 -ne '/this/ or next; s/\0/{NULL}/g; print'

otherwise:

  perl -0 -ne '/this/ or next; s/\0/\n/g; print'

Scott
-- 
Scott Wiersdorf
<scott@perlcode.org>
