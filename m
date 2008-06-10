From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Tue, 10 Jun 2008 13:19:07 +0200
Message-ID: <484E632B.7050600@op5.se>
References: <200805232221.45406.trast@student.ethz.ch> <200806090746.22512.johan@herland.net> <20080609122938.GA12210@sigill.intra.peff.net> <200806091931.51221.johan@herland.net> <20080609201734.GA15662@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 13:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K61td-00062q-ID
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 13:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751685AbYFJLTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 07:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbYFJLTN
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 07:19:13 -0400
Received: from mail.op5.se ([193.201.96.20]:50581 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751533AbYFJLTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 07:19:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 543D61B80362;
	Tue, 10 Jun 2008 13:15:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.001, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X037n8oKtsSc; Tue, 10 Jun 2008 13:15:27 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 0F8F51B8035A;
	Tue, 10 Jun 2008 13:15:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080609201734.GA15662@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84496>

Jeff King wrote:
> 
> The main problem I see at this point is that it screws up the line
> numbering for _every other hunk_, so later hunks in that file might not
> apply (IIRC, we usually save up all of the "yes" hunks and apply at the
> end). So it might be needed to do a --recount --check, and then actually
> apply at the end.
> 

I for one would really hate if the apply-at-the-end approach currently
used would be swapped around to "apply-as-we-go", because I sometimes
realize I'm committing a feature on top of a bugfix I've forgotten to
commit (or some such). I know I'd forget quite a few times to revert
the added changes after Ctrl-C'ing out of such cases if the current
approach is changed.

I know that wasn't what was proposed but at least anyone who
proposes it will at least think twice now before doing so, and
hopefully providing a SIGHUP hook to restore the index+worktree
to exactly what they were at the start of the interactive session.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
