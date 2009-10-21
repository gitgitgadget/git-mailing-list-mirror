From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Wed, 21 Oct 2009 00:32:30 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910210023050.14365@iabervon.org>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl> <alpine.LNX.2.00.0910202001050.14365@iabervon.org> <BLU0-SMTP889B2109047E949E039EFDAEBF0@phx.gbl>
 <alpine.LNX.2.00.0910202044150.14365@iabervon.org> <20091021031528.GB18997@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1836985930-1256099550=:14365"
Cc: Sean Estabrooks <seanlkml@sympatico.ca>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 06:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0SsK-0005hQ-I5
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 06:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbZJUEc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 00:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbZJUEc0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 00:32:26 -0400
Received: from iabervon.org ([66.92.72.58]:56321 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711AbZJUEc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 00:32:26 -0400
Received: (qmail 7179 invoked by uid 1000); 21 Oct 2009 04:32:30 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2009 04:32:30 -0000
In-Reply-To: <20091021031528.GB18997@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130883>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1836985930-1256099550=:14365
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Wed, 21 Oct 2009, Björn Steinbrink wrote:

> On 2009.10.20 20:55:25 -0400, Daniel Barkalow wrote:
> > Maybe it should be fine to do:
> > 
> > $ git fetch long-url-here master:temp
> > $ git merge temp
> > $ git checkout other-branch-that-also-needs-it
> > $ git merge temp
> > 
> > But "temp" is "refs/remotes/temp", not "refs/heads/temp"?
> 
> One (maybe important) difference there is that the "pull" gets you:
> 
>     Merge branch 'pu' of git://git.kernel.org/pub/scm/git/git
> 
> Even with "master:tmp". But with fetch+merge (storing in refs/remotes):
> 
>     Merge remote branch 'tmp'

It would be nice to improve that in general, I think. You may fetch before 
merging in order to check out what you're getting, and then lose 
FETCH_HEAD (or have not specified the branch), and you have to contact the 
remote server again if you want the message with its url.

> As a minor side-effect, having the "tmp" ref makes re-running the pull
> (for whatever reason) cheaper, as without it, the fetch step would
> possibly re-fetch the whole stuff (not reachable through any local ref).

Only if the merge failed, but yes.

	-Daniel
*This .sig left intentionally blank*
--1547844168-1836985930-1256099550=:14365--
