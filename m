From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: copying objects from another repo?
Date: Tue, 24 Jul 2007 12:14:08 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241213000.14781@racer.site>
References: <20070724103503.GC18701@mellanox.co.il>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:14:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDILX-0000gt-HS
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933568AbXGXLO2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933497AbXGXLO2
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:14:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:41992 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932497AbXGXLO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:14:27 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:14:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 24 Jul 2007 13:14:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/m5T0ImRfmVaj4Uuc2sesstkJbcd33t+ChNwtujl
	hfS/OSuuXI3jh4
X-X-Sender: gene099@racer.site
In-Reply-To: <20070724103503.GC18701@mellanox.co.il>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53568>

Hi,

On Tue, 24 Jul 2007, Michael S. Tsirkin wrote:

> I had some missing objects that I managed to locate
> in another tree. So - how to get them to my repo?
> Here's what I came up with:
> 
> cd ~/scm/good_tree
> git tag -f foo dfaa7049e9ebe227cfcffc49d3de16716764bcbd
> cd ~/scm/bad_tree
> git fetch-pack ~/scm/good_tree dfaa7049e9ebe227cfcffc49d3de16716764bcbd
> 
> And I repeated this for all missing objects.
> But is there a better way to do this?

This is what I have done in such a case:

In the valid repo:

	$ git gc
	$ scp .git/objects/packs/* the-broken:repo.git/objects/packs/

In the broken repo:

	$ git gc

Done.

Hth,
Dscho
