From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 06:30:51 -0400
Message-ID: <20070918103051.GA22239@coredump.intra.peff.net>
References: <20070918072627.GB3506@coredump.intra.peff.net> <Pine.LNX.4.64.0709181115250.28586@racer.site> <46EFA84C.3080906@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 12:31:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXaME-0005is-Ex
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 12:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047AbXIRKa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 06:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbXIRKa5
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 06:30:57 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1224 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754825AbXIRKa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 06:30:57 -0400
Received: (qmail 26975 invoked by uid 111); 18 Sep 2007 10:30:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 18 Sep 2007 06:30:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Sep 2007 06:30:51 -0400
Content-Disposition: inline
In-Reply-To: <46EFA84C.3080906@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58574>

On Tue, Sep 18, 2007 at 12:28:28PM +0200, Andreas Ericsson wrote:

>> Yes, please!  Maybe somebody will then grab the low-hanging fruit of 
>> writing a "git-fast-export", which can be used to dump a complete 
>> repository in text format?
>
> I thought that was already taken care of since format-patch handles
> --root flag properly?
>
> Otherwise, "git repack -a --window=0 --depth=0" should provide an
> easily parseable dump of an entire repo.

I think he means a dump that you can meaningfully edit with sed or a
text editor. And even nicer, one that could be fed back into
git-fast-import. So you could do something like:

git-fast-export A..B >dump
vi dump
git-fast-import <dump

to rewrite history in a very flexible way.

-Peff
