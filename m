From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git and mtime
Date: Wed, 19 Nov 2008 13:31:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811191327210.30769@pacific.mpi-cbg.de>
References: <20081119113752.GA13611@ravenclaw.codelibre.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Roger Leigh <rleigh@codelibre.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 13:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2m7b-00086h-7K
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 13:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbYKSMYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 07:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752603AbYKSMYG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 07:24:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:49672 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752580AbYKSMYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 07:24:04 -0500
Received: (qmail invoked by alias); 19 Nov 2008 12:24:01 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp012) with SMTP; 19 Nov 2008 13:24:01 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MAQEAdDHM8WPPvNx8dB/lMdsYV7a3e1fJ5zYHFd
	KVKImrkqnEuLEE
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20081119113752.GA13611@ravenclaw.codelibre.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101331>

Hi,

On Wed, 19 Nov 2008, Roger Leigh wrote:

> Would it be possible for git to store the mtime of files in the tree?

No, since this would wreck people's workflows:

	- compile in branch "master"
	- switch to branch "topic"
	- compile
	- switch back to branch "master"

Now you _want_ files in "master" that were changed in "topic" to be 
recompiled.

This is a quite common case.

However, nothing hinders you having your own ".gitmtimes" in the tree, and 
a script people can use as a hook, which applies the mtimes to the files.

Ciao,
Dscho
