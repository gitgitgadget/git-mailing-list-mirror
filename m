From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Wed, 17 Mar 2010 16:58:42 +0100
Message-ID: <20100317155842.GA2557@m62s10.vlinux.de>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock> <4BA07DC7.9070502@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 17 16:58:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrve7-0005Ze-7W
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 16:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab0CQP6y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 11:58:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:43836 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753161Ab0CQP6x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 11:58:53 -0400
Received: (qmail invoked by alias); 17 Mar 2010 15:58:51 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp023) with SMTP; 17 Mar 2010 16:58:51 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/g1X8QltHgAW4KXpuKVgyZw/c2bnrWAVakLE+/T5
	C2z0qd8lXOieq5
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id B89C7D4006; Wed, 17 Mar 2010 16:58:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BA07DC7.9070502@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142405>

On Wed, Mar 17, 2010 at 07:59:19AM +0100, Johannes Sixt wrote:
> Jonathan Nieder schrieb:
> > If I am understanding properly, your idea is that this would be use=
d on
> > a branch after =E2=80=9Cunmerging=E2=80=9D it from master:
> >=20
> >     B --- C --- D [topic]
> >   /              \
> >  A ---  ...   --- M ... --- U [master]
> >=20
> > Here M is a merge commit and U a commit reverting the change from M=
^
> > to M.
>=20
> If I were to re-merge topic into master a second time after this
> situation, I would install a temporary graft that removes the second
> parent of M and repeat the merge. After the graft is removed, the his=
tory
> would look like this:
>=20
>      B --- C --- D --------------.   [topic]
>    /              \               \
>   A ---  ...   --- M ... --- U ... N [master]
>=20
> Are there any downsides? I don't know - I haven't thought it through.
>=20

Might be. If there is any branch starting anywhere in between M and U
which also needs to merge [topic] will also cause you headaches :-)

       B --- C --- D --------------.   [topic]
     /              \               \
    A ---  ...   --- M ... --- U ... N [master]
                         \
                          x --- y [side_branch wich needs to merge topi=
c]=20

--
Peter
