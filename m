From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: [PATCH] git-svnimport: Parse log message for Signed-off-by: lines
Date: Wed, 6 Sep 2006 01:17:54 +0300
Message-ID: <20060905221754.GI14732@sashak.voltaire.com>
References: <20060905184611.GB14732@sashak.voltaire.com> <7v1wqqc8dh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 00:12:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKj9x-00054G-G7
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 00:12:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbWIEWMm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 18:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWIEWMm
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 18:12:42 -0400
Received: from taurus.voltaire.com ([193.47.165.240]:13351 "EHLO
	taurus.voltaire.com") by vger.kernel.org with ESMTP id S965195AbWIEWMm
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 18:12:42 -0400
Received: from sashak ([172.25.5.107]) by taurus.voltaire.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 6 Sep 2006 01:12:40 +0300
Received: by sashak (sSMTP sendmail emulation); Wed,  6 Sep 2006 01:17:54 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wqqc8dh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 05 Sep 2006 22:12:40.0334 (UTC) FILETIME=[670432E0:01C6D138]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26495>

On 14:26 Tue 05 Sep     , Junio C Hamano wrote:
> Sasha Khapyorsky <sashak@voltaire.com> writes:
> 
> > Hi,
> >
> > This feature was useful with importing https://openib.org/svn/gen2 .
> >
> > Sasha
> >
> > This add '-S' option. When specified svn-import will try to parse
> > commit message for 'Signed-off-by: ...' line, and if found will use
> > the name and email address extracted at first occurrence as this commit
> > author name and author email address. Committer name and email are
> > extracted in usual way.
> >
> > Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
> 
> Thanks.
> 
> I do not think the first signed-off-by is necessarily the author
> of the change, so we are risking miscrediting (or misblaming) a
> wrong person. 

Right, there is such risk, so this feature is optional and by default is
"off".

> Having said that, using the committer information
> has the same miscredit problem, so this change might be Ok, but
> I am not sure if it adds much improvement.
> 
> I will wait for an ack/nack from somebody who use svnimport and
> know it well.

Sure.

BTW, what about to importing subdirectories, like this:

 <trunk>/path/to/subdir
 <branches>/path/to/subdir

Is this could be improvement?

> 
> BTW, I do not appreciate the first six lines of your message
> being _before_ the proposed commit log message.  Please have it
> between "---\n" (that comes immediately after your own
> "Signed-off-by:") and the diffstat, like this:
> 
>         This add '-S' option. When specified svn-import will try to...
>         ... in usual way.
> 
>         Signed-off-by: Sasha Khapyorsky <sashak@voltaire.com>
>         ---
> 
>           Hi,
> 
>           This feature was useful with importing https://openib.org/svn/gen2 .
> 
>           Sasha
> 
>          git-svnimport.perl |   31 ++++++++++++++++++++-----------
>          1 files changed, 20 insertions(+), 11 deletions(-)
> 
>          diff --git a/...

Ok.

Sasha
