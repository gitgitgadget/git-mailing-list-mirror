From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Mirroring svn
Date: Thu, 6 Dec 2007 01:43:17 -0500
Message-ID: <20071206064317.GC18698@coredump.intra.peff.net>
References: <1196922153.10408.101.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Harvey Harrison <harvey.harrison@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 07:43:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0AST-0002Jy-5S
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 07:43:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbXLFGnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 01:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbXLFGnU
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 01:43:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1036 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878AbXLFGnT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 01:43:19 -0500
Received: (qmail 28446 invoked by uid 111); 6 Dec 2007 06:43:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 01:43:18 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 01:43:17 -0500
Content-Disposition: inline
In-Reply-To: <1196922153.10408.101.camel@brick>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67258>

On Wed, Dec 05, 2007 at 10:22:33PM -0800, Harvey Harrison wrote:

> // fetching someone else's remote branches is not a standard thing to do
> // so we'll need to edit our .git/config file
> // you should have a section that looks like:
> [remote "gcc.gnu.org"]
> 	url = git://git.infradead.org/gcc.git
> 	fetch = +refs/heads/*:refs/remotes/gcc.gnu.org/*
> // infradead's mirror puts the gcc svn branches in its own namespace
> // refs/remotes/gcc.gnu.org/*
> // change our fetch line accordingly
> [remote "gcc.gnu.org"]
> 	url = git://git.infradead.org/gcc.git
> 	fetch = +refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*

FWIW, if you are writing a shell recipe for other people to cut and
paste, you can say this as:

  git config remote.gcc.gnu.org.fetch \
    '+refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*'

-Peff
