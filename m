From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: Grok special characters in tag names
Date: Thu, 21 Aug 2008 13:26:28 -0700
Message-ID: <7v3akyi07f.fsf@gitster.siamese.dyndns.org>
References: <1219329911-31620-1-git-send-email-johannes.sixt@telecom.at>
 <NWVPkDIELqWBHTU58gfzDqO8HR575ZDJVO2pYdPMtqv9aBLzMLvyZg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 21 22:27:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWGl0-0007eD-DQ
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 22:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754629AbYHUU0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 16:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754023AbYHUU0j
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 16:26:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbYHUU0i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 16:26:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CA0A66A13;
	Thu, 21 Aug 2008 16:26:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C232366A0E; Thu, 21 Aug 2008 16:26:31 -0400 (EDT)
In-Reply-To: <NWVPkDIELqWBHTU58gfzDqO8HR575ZDJVO2pYdPMtqv9aBLzMLvyZg@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Thu, 21 Aug 2008 11:38:20 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7439EA9A-6FBF-11DD-893D-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93202>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio complained that my initial version of this was fragile which has
> similarities with the above. Initially, I was blindly changing the first line
> to contain "object...", second line to "type...", etc.

Was it more about not limiting the munging to only the header part?  In
any case, I think what Hannes has in the patch is fine (although I did not
look the lines that follow outside the context).

> Would something like the following be equivalent _and_ clearer? Emphasis
> on "and" because both are necessary, not because I strongly feel it to
> be so.

I was bitten by a/i/c followed by literal text that behave differently
with various implementations of sed, and learned to stay away from the
construct long time ago.  Things might have gotten better these days, but
old habit and gut-reaction is hard to shake off.
