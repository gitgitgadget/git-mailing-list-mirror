From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 02:04:05 -0500
Message-ID: <20100104070405.GE7785@coredump.intra.peff.net>
References: <7vzl4zy5z3.fsf@alter.siamese.dyndns.org>
 <20100102115041.GA32381@do>
 <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
 <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <20100104060646.GA14520@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Jan 04 08:04:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRgzA-00029I-VB
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 08:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265Ab0ADHEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 02:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250Ab0ADHEM
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 02:04:12 -0500
Received: from peff.net ([208.65.91.99]:37010 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab0ADHEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 02:04:12 -0500
Received: (qmail 12854 invoked by uid 107); 4 Jan 2010 07:08:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 02:08:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 02:04:05 -0500
Content-Disposition: inline
In-Reply-To: <20100104060646.GA14520@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136097>

On Mon, Jan 04, 2010 at 07:06:46AM +0100, Mike Hommey wrote:

> Anyways, why not generate the hash-bang lines of the shell scripts from a
> Makefile variable that would be set to /usr/xpg4/bin/sh on Solaris and
> /bin/sh on others ?

We do that already (though we default it to /bin/bash). SANE_TOOL_PATH
is about picking up all the _other_ tools for use inside our shell
scripts, like non-crappy sed, grep, etc.

Brandon did some testing with ksh and sent a patch to default to the
stock ksh on Solaris and IRIX, which is probably saner than bash for a
default, but it seems to have gotten dropped:

  http://article.gmane.org/gmane.comp.version-control.git/129830

-Peff
