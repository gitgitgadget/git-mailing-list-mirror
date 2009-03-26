From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: branch ahead in commits but push claims all up to date
Date: Thu, 26 Mar 2009 13:48:16 +0100
Message-ID: <20090326124816.GB3114@atjola.homenet>
References: <7001b7a00903240821v2155d234x6a10c80a3e987acb@mail.gmail.com> <7001b7a00903240822w70a57349xcc66a02cef62dc70@mail.gmail.com> <43d8ce650903240918q2ffdba44w241e0f378a11fd3d@mail.gmail.com> <alpine.LNX.1.00.0903241304090.19665@iabervon.org> <43d8ce650903241726s122cc468q4ea9188e1561832@mail.gmail.com> <alpine.LNX.1.00.0903242118270.19665@iabervon.org> <7001b7a00903241901w107e2973i9912eab114c9cde0@mail.gmail.com> <alpine.LNX.1.00.0903242304530.19665@iabervon.org> <7001b7a00903251023r1ce5cc0dnb29b7f9379408c42@mail.gmail.com> <43d8ce650903251905p6f9798f5u79be7dff3b118d5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Irene Ros <imirene@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 14:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmpMU-0002Hc-IZ
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 14:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756651AbZCZNJm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 09:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756009AbZCZNJm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 09:09:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:53639 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754805AbZCZNJl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 09:09:41 -0400
Received: (qmail invoked by alias); 26 Mar 2009 13:09:37 -0000
Received: from i59F569BB.versanet.de (EHLO atjola.local) [89.245.105.187]
  by mail.gmx.net (mp004) with SMTP; 26 Mar 2009 14:09:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+k4bAVZCCkkUYW8Hf5KdC9bhUI7WllKZ9uy2siWx
	ktE+Zh6P6QUQKc
Content-Disposition: inline
In-Reply-To: <43d8ce650903251905p6f9798f5u79be7dff3b118d5c@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114774>

On 2009.03.26 02:05:21 +0000, John Tapsell wrote:
> 2009/3/25 Irene Ros <imirene@gmail.com>:
> > Thank you for the explanation, doing a git fetch actually did do th=
e
> > trick although I still don't quite see the difference between
> > git pull origin myBranch
> > and
> > git fetch
>=20
> git pull origin myBranch    is equivalent to two commands:
>=20
> git fetch
> git merge origin/myBranch

No. If that was the case, the remote tracking branches would be updated
by the "git fetch" part. And there wouldn't be a difference between the
two commands WRT the handling of remote tracking branches.

git pull origin myBranch does something like:

git fetch origin myBranch
git merge FETCH_HEAD

The remote and the refspec are passed to "git fetch" by "git pull".
So because there's an explicit refspec, the default value from the
config is not used. And because the refspec has no right side, things
get stored to FETCH_HEAD.

Bj=F6rn
