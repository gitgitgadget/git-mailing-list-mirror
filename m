From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn dcommit gone wrong and git-fsck
Date: Tue, 26 Aug 2008 19:36:05 +0200
Message-ID: <20080826173605.GA32301@atjola.homenet>
References: <g91bgi$8cm$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Bruno Harbulot <Bruno.Harbulot@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Tn-0005sQ-Od
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252AbYHZRgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Aug 2008 13:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757245AbYHZRgK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:36:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:59932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757134AbYHZRgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:36:09 -0400
Received: (qmail invoked by alias); 26 Aug 2008 17:36:07 -0000
Received: from i577B9D1D.versanet.de (EHLO atjola.local) [87.123.157.29]
  by mail.gmx.net (mp018) with SMTP; 26 Aug 2008 19:36:07 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18oi9Bl0tsos2y4y1HjDPskzArMCf7Sri5jK8whea
	/Rjmahh7lwZGQ4
Content-Disposition: inline
In-Reply-To: <g91bgi$8cm$1@ger.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93779>

On 2008.08.26 17:37:36 +0100, Bruno Harbulot wrote:
> Hello,
>
> I had 11 consecutive commits in my local git repository that I was =20
> trying to commit to an SVN repository, using "git-svn dcommit". The =20
> first 7 worked fine, as usual. However, when sending the 8th, I got a=
 =20
> "Bus error" (on OSX -- I'm not sure what the actual cause was).
>
> A further "git-svn dcommit" produces this error.
> Cannot dcommit with a dirty index.  Commit your changes first, or sta=
sh =20
> them with `git stash'.
>  at /opt/local/bin/git-svn line 406

1. git checkout $your_branch

2. Look up the latest commit you had on your branch using "git reflog"
   or "git log -g"

3. git reset --hard $that_commit

4. git svn rebase

5. check that your history is sane

6. git svn dcommit

That should do.

Bj=F6rn
