From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: How can I remove a remote branch from local repo that is
	removed at the server side
Date: Tue, 12 May 2009 09:27:43 +0200
Message-ID: <20090512072743.GA24446@atjola.homenet>
References: <4A091DB3.4070509@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Tue May 12 09:28:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3mPB-00031Q-Lk
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 09:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbZELH1q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 03:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbZELH1q
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 03:27:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:36234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754795AbZELH1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 03:27:45 -0400
Received: (qmail invoked by alias); 12 May 2009 07:27:45 -0000
Received: from i59F5A867.versanet.de (EHLO atjola.local) [89.245.168.103]
  by mail.gmx.net (mp007) with SMTP; 12 May 2009 09:27:45 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19JXMEoREJJQPAg3Bu8BGZIjUKAMR9fIuxOzD/lQy
	uQsDWiXgANwnQn
Content-Disposition: inline
In-Reply-To: <4A091DB3.4070509@ubicom.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118876>

On 2009.05.12 09:56:51 +0300, Yakup Akbay wrote:
> Hi,
>
> consider the following situation:
>
>    adg@adghp:~/myrepo$ git branch -a
>    * master
>      origin/HEAD
>      origin/master
>      origin/work
>
> I want to remove origin/work from my local repository which is no mor=
e =20
> existing at the origin. git fetch (or pull) does not help either. =20
> However, it disappears when I remove the following line in =20
> .git/packed-refs file:
>
>    021a032317425b136b5430c7dead94328996b9d0 refs/remotes/origin/work
>
> Is there command line version to do it?

To manually delete the remote tracking branch:
	git branch -r -d origin/work

To prune all remote tracking branches for "origin" for which the
corresponding branch on the remote is gone:
	git remote prune origin

Bj=F6rn
