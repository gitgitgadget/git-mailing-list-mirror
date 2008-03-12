From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 16:41:54 -0700
Message-ID: <7vk5k733y5.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site>
 <7vskywadum.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0803112234470.2947@xanadu.home>
 <7vbq5k77z0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803121153160.1656@racer.site>
 <alpine.LFD.1.00.0803121143170.2947@xanadu.home>
 <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl>
 <alpine.LSU.1.00.0803121705330.1656@racer.site>
 <20080312170155.GB11236@coredump.intra.peff.net>
 <B27EC8CF-482D-499B-B4E0-019049926C93@ai.rug.nl>
 <7vtzjb34y0.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803130028550.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pieter de Bie <pdebie@ai.rug.nl>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 00:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZaar-0004No-FH
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 00:42:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035AbYCLXmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 19:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752325AbYCLXmF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 19:42:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61229 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832AbYCLXmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 19:42:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 60647160E;
	Wed, 12 Mar 2008 19:42:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8F038160D; Wed, 12 Mar 2008 19:41:57 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803130028550.1656@racer.site> (Johannes
 Schindelin's message of "Thu, 13 Mar 2008 00:30:53 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77027>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Yes.
>
> In any case, most likely these objects would have been packed anyway 
> during that period, so they would have been pruned by the repack called by 
> git-gc.

Yes, that is the most probable way for these unused cruft to get removed.

> My patch really, really is about _unreferenced_ loose objects, i.e. 
> something you get by multiple "git add"s without commits.  And by merge 
> conflicts.
>
> IOW by objects that were never referenced by commit objects.
