From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [RFC/PATCH] Documentation: Don't assume git-sh-setup and
 git-parse-remote are in the PATH
Date: Sun, 29 Jun 2008 21:39:37 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806292131390.28041@harper.uchicago.edu>
References: <20080627151001.BIA19424@m4500-01.uchicago.edu>
 <20080628205817.GB3172@steel.home> <7vvdztmfrk.fsf@gitster.siamese.dyndns.org>
 <20080629053823.GA8262@sigill.intra.peff.net> <Pine.GSO.4.62.0806291026310.8371@harper.uchicago.edu>
 <7vbq1kawje.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 04:41:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD9KS-0004U8-Gc
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 04:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbYF3CkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 22:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbYF3CkS
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 22:40:18 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:40230 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbYF3Cjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 22:39:54 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5U2de0h027492;
	Sun, 29 Jun 2008 21:39:40 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5U2dbDW028289;
	Sun, 29 Jun 2008 21:39:38 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <7vbq1kawje.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86863>

Junio C Hamano wrote:

> jrnieder@uchicago.edu writes:
>
>> [patch to use . "$(git --exec-path)/git-{parse-remote,sh-setup}"
>> instead of assuming they are in PATH]
>>
>> Junio: I stole the commit message from you. I hope you don't mind.
> 
> I don't, but reading the script again, I suspect it is not clear enough
> that the user is also responsible for setting up GIT_DIR appropriately
> before using it, perhaps by sourcing git-sh-setup.  We probably would want
> to add it in a separate patch.

Doesn't git-parse-remote.sh begin

	GIT_DIR=$(git rev-parse --git-dir 2>/dev/null) || :;

? And I don't imagine we want people to source git-sh-setup before
sourcing git-sh-setup...

Confused,
Jonathan
