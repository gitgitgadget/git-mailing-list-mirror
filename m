From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase: convert revert to squash on autosquash
Date: Fri, 8 Apr 2016 13:13:51 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604081309150.2967@virtualbox>
References: <1460041965-31526-1-git-send-email-mst@redhat.com> <alpine.DEB.2.20.1604071720160.2967@virtualbox> <20160407184026-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 13:14:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoUMc-0000hz-IB
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 13:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757551AbcDHLOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 07:14:03 -0400
Received: from mout.gmx.net ([212.227.15.19]:50280 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755802AbcDHLOA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 07:14:00 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M4nt7-1bkRET2jgD-00yzcc; Fri, 08 Apr 2016 13:13:52
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160407184026-mutt-send-email-mst@redhat.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:FBwdoYBS2jUpLqQSXFQt34TCEGFVx55tK9lgONDfBkT7tLdDmRb
 hj1NewsIKsJxvOaqKtVbTaMRWkY+DNUDwqqqcdJL04Epe0473ubQu+0GMNpixOyNNmMoY1c
 qnN43pDRIGwx78RfwS64v4ep5c555f95fcn4tx3RyK2r2oFYqudznBpB28Aj8y1/cE1OJNB
 hfzTBW5QMAs5l58WHgdFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vtBHuwtmWp0=:juPN8buRkR9hWpDyjqXIsG
 TJKrF02Wyjp+6REKBTSY6jGJplDme0dKtYPXs6WbbvfIXlNQ3yrZ9/1qWlWwT9JZq2sFg6Hcz
 EQPXcbDxJZhBDwHycgftdXoj98e18kcjqAxHrl1F3Is5HAUY3Va0s+E6TljSsb/IPwJwEe9TU
 bfunU9z8nJnKAYa3X1kcdSBg+TYVC3bhWXDJ7HkwX7LGcP59ghLus0G2SssTL3JcAhT24xBtv
 V8BTlwDSbWb0oCnNO9NjOG4if7jJLYJGsCxI0tpLoNU9rIuWfzsihYlPhsThZy90nI8Naeza7
 HU3Wn7OX/gcKTAJOg6Ab3G4FgAtERymULj/jt8w0QDMP+faLBO1xWeNOXXRnXXF2c3EqEsycU
 7do0yskrioXbYRpDVmKigVzZPdDr8zg0jwORMFfoXdCl+4Jg+HR7S1HyxBr6KHZ4TXwbcd4T5
 y/OIfXMeCmrlMKJVt4vmVtHRu4SVs6EqlWdRzQrfnPvYXHNEbeaj6Lp3uq0Ory4u4AkEQJ6ws
 cEBKs0N54JCpJ+7o0WrZxp9osJrd0ujC/ji+ePXBweazKU8lNwqbsbSqjMUSRRY/IB8WPl/TC
 xNn+jLCC3gEG3i1w6ywIrJU0+c8DNHkGOuYaiF/ad2FwCqK4si84JNCa9quI8bB7a06/0cVLG
 eWlQrzI2tCyko3zz+FNnxbR6BDaUBgz59IhA6FuT/epllkZ6ciAuVaRSkZfLV7ZuJ60mDCs38
 Tpn2kG4YJHEWq1l3fKp89YbemPt3bqJVLWn5/IidAlGI48LyeLu/Nb2286qG/afNChPpZlFS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291021>

Hi Michael,

On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:

> On Thu, Apr 07, 2016 at 05:23:09PM +0200, Johannes Schindelin wrote:
> > 
> > On Thu, 7 Apr 2016, Michael S. Tsirkin wrote:
> > 
> > > Reverts can typically be treated like squash.  Eliminating both the
> > > original commit and the revert would be even nicer, but this seems a bit
> > > harder to implement.
> > 
> > Whoa. This rings a lot of alarm bells, very loudly.
> 
> Whoa don't be alarmed. It's just a patch :).

It's just a patch. Like every major breakage would be. So: no, there is
reason to be alarmed if it is likely to disrupt normal usage.

> > It seems you intend to introduce a *major* change in behavior,
> 
> Doing this automatically for all users might be a bit too drastic for
> the upstream git.

That is a pretty safe thing to say, even without the subjunctive.

> If there's a commit later followed by a revert, history can be
> simplified by squashing them, and if the result is empty, removing both.

True. But that is not what the user told Git to do. If the user's
intention was to squash the reverting patch, she could have easily done
this:

	git revert -n deadbeef
	git commit --squash deadbeef

where "deadbeef" is the placeholder for the actual commit to revert.

And indeed, I use exactly this song and dance quite frequently, *iff* my
intention is to drop a patch.

A much better idea than co-opting the "Revert" commit message would be to
introduce a sibling to --fixup and --squash that you could call --drop.

Ciao,
Johannes
