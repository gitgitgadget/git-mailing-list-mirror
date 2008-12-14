From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: How to maintain private/secret/confidential branch.
Date: Mon, 15 Dec 2008 01:55:18 +1100
Message-ID: <20081214145518.GA26380@mail.local.tull.net>
References: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Lew <lukasz.lew@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 14 15:56:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBsOk-00013v-K9
	for gcvg-git-2@gmane.org; Sun, 14 Dec 2008 15:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbYLNOzY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Dec 2008 09:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753599AbYLNOzY
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Dec 2008 09:55:24 -0500
Received: from vps1.tull.net ([66.180.172.116]:60341 "HELO vps1.tull.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753516AbYLNOzX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Dec 2008 09:55:23 -0500
Received: (qmail 7652 invoked by uid 1015); 15 Dec 2008 01:55:22 +1100
Received: from [10.0.0.67] (HELO tull.net) (10.0.0.67) by vps1.tull.net (qpsmtpd/0.26) with SMTP; Mon, 15 Dec 2008 01:55:22 +1100
Received: (qmail 2452 invoked by uid 1000); 15 Dec 2008 01:55:18 +1100
Content-Disposition: inline
In-Reply-To: <c55009e70812140549t6547c1d6jf7780f91b5074e73@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SMTPD: qpsmtpd/0.26, http://develooper.com/code/qpsmtpd/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103086>

On Sun, Dec 14, 2008 at 02:49:50PM +0100, =C5=81ukasz Lew wrote:
> I don't know how to make such a scenario work:
> - two repositories: pub, priv
> - priv is clone/branch of pub
> - there is some constant developement both in pub and priv
> - there are regular syncs with pub in priv
>=20
> Problem:
> Occasionally I want to push some changes from priv to pub.
> Then after syncing with pub I want to get as few conflicts as possibl=
e.
>=20
> Is it possible to do with git?

Git can do almost anything. One should instead ask "How to do this
with git?" :-)

If I understand your problem, you could solve it with git cherry-pick
and rebase. On priv, make a for-public branch from a pub branch. Then
cherry-pick the commits you want from your private branch into the
for-public branch. Push your for-public branch to pub, then rebase
your private branch.

Nick.
