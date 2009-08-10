From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Feature Request] git export
Date: Mon, 10 Aug 2009 18:56:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908101855260.8324@intel-tinevez-2-302>
References: <200908101822.59940.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Mon Aug 10 18:57:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaYBF-0003Fw-Nj
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 18:57:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbZHJQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 12:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbZHJQ4l
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 12:56:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:36244 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932308AbZHJQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 12:56:40 -0400
Received: (qmail invoked by alias); 10 Aug 2009 16:56:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp035) with SMTP; 10 Aug 2009 18:56:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Wy2txx3+WP7CcyI/VWfdP8ak/+/YcsCROYDrk0Z
	ngkGBj6VeVOBvv
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200908101822.59940.thomas@koch.ro>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125489>

Hi,

On Mon, 10 Aug 2009, Thomas Koch wrote:

> could you please provide a simple solution to save a tree object into an 
> arbitrary location?
>
> I found some hints, that it would be possible by missusing either git 
> checkout-index or git-archive, but I think that it shouldn't require 
> that much GIT FU to do such a simple thing.

You can check out Documentation/install-doc-quick.sh and find that 
something like

	GIT_INDEX_FILE=.git/tmp
	export GIT_INDEX_FILE
	git read-tree $TREE
	git checkout-index -a -f --prefix=/the/path
	unset GIT_INDEX_FILE

should work.

Hth,
Dscho
