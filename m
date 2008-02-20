From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Built-in checkout: wrong behaviour in subdirectories
Date: Wed, 20 Feb 2008 15:21:01 -0800
Message-ID: <7vhcg32p0i.fsf@gitster.siamese.dyndns.org>
References: <20080220223520.GA23642@localhost>
 <alpine.LNX.1.00.0802201740050.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 00:22:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRyGC-0005Ky-TE
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 00:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbYBTXVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 18:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYBTXVV
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 18:21:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYBTXVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 18:21:20 -0500
Received: from .pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FBF17CA4;
	Wed, 20 Feb 2008 18:21:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 4E4FC7CA0; Wed, 20 Feb 2008 18:21:09 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802201740050.19024@iabervon.org> (Daniel
 Barkalow's message of "Wed, 20 Feb 2008 17:44:44 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74567>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Junio: it looks like something used to cause read-tree to be run with 
> pwd being the working tree root in git-checkout.sh.

"Something"?  I think we explicitly cdup when switching
branches, and we should do the same in C rewrite.

        # We are switching branches and checking out trees, so
        # we *NEED* to be at the toplevel.
        cd_to_toplevel
