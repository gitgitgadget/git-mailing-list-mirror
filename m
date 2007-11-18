From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Alternates and broken repos: A pack and prune scheme to avoid them
Date: Sun, 18 Nov 2007 10:39:46 -0800
Message-ID: <7v3av3wg7h.fsf@gitster.siamese.dyndns.org>
References: <200711181225.52288.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Sun Nov 18 19:40:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itp3x-0000ha-Fp
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 19:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751735AbXKRSjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 13:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbXKRSjw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 13:39:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:58211 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692AbXKRSjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 13:39:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4818D2F9;
	Sun, 18 Nov 2007 13:40:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id CF8E7961FB;
	Sun, 18 Nov 2007 13:40:09 -0500 (EST)
In-Reply-To: <200711181225.52288.johannes.sixt@telecom.at> (Johannes Sixt's
	message of "Sun, 18 Nov 2007 12:25:52 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65380>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> Then the strategy of garbage collection can be arranged in the following way:
>
> - Repack by starting at the "most complete" repo and work towards the "most 
> borrowing" ones. During this phase "attic" packs are created. Borrowing repos 
> get a chance to salvage objects before the alternates prune them away.
>
> - Prune by starting at the "most borrowing" repo and work towards the "most 
> complete" ones. During this phase the "attic" packs are cleaned up.
>
> What do you think? Is this a way for a solution?

I would imagine that would work as long as it can be controlled
when all the involved repositories are repacked and pruned, such
as on repo.or.cz case (but on the other hand it is not really
controlled well there and that is the reason you wrote the
message X-<).
