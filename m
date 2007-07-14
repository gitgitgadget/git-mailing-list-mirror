From: Jeff King <peff@peff.net>
Subject: Re: Possible to make a totally empty repository for remote access?
Date: Fri, 13 Jul 2007 22:58:19 -0400
Message-ID: <20070714025819.GA22559@coredump.intra.peff.net>
References: <54C69B03-C589-480E-80D3-75166DBF2D29@wincent.com> <7vtzs8lzgk.fsf@assigned-by-dhcp.cox.net> <95A1FBFA-DCB7-4767-B857-89660822C6E6@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 04:58:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9Xq7-0001fd-R9
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 04:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761927AbXGNC6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 22:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762807AbXGNC6V
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 22:58:21 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1645 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759756AbXGNC6V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 22:58:21 -0400
Received: (qmail 22984 invoked from network); 14 Jul 2007 02:58:46 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 Jul 2007 02:58:46 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2007 22:58:19 -0400
Content-Disposition: inline
In-Reply-To: <95A1FBFA-DCB7-4767-B857-89660822C6E6@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52434>

On Sat, Jul 14, 2007 at 04:19:41AM +0200, Wincent Colaiuta wrote:

> To make such pushes easier in the future you can create a local shortcut 
> file, .git/remotes/shortcut (or similar), with contents like:
>
> URL: git.server.example.com:/pub/git/test.git
> Push: master

The "new" way (by "new" I mean available for over a year, since v1.4.1)
is to put such configuration into your .git/config file:

[remote "shortcut"]
  url = git.server.example.com:/pub/git/test.git

Though if this is going to be the upstream from which you will be
pushing and pulling, you may want to call it "origin" (which will make
it the default for pushing and pulling).

Even more simply, you can get the same remote config that git-clone
would have set up by using the git-remote command:

  $ git-init
  $ git-remote origin server:/pub/git/test.git

-Peff
