From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdl_merge(): introduce XDL_MERGE_ZEALOUS_ALNUM
Date: Tue, 12 Feb 2008 17:34:09 -0800
Message-ID: <7v3arxzlke.fsf@gitster.siamese.dyndns.org>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com>
 <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org>
 <alpine.LSU.1.00.0802130003370.3870@racer.site>
 <alpine.LSU.1.00.0802130108060.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 02:35:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP6Wt-0000W3-Le
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 02:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbYBMBep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 20:34:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752424AbYBMBep
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 20:34:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbYBMBeo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 20:34:44 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D727C3740;
	Tue, 12 Feb 2008 20:34:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 EE383370F; Tue, 12 Feb 2008 20:34:26 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802130108060.3870@racer.site> (Johannes
 Schindelin's message of "Wed, 13 Feb 2008 01:10:04 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73732>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When a merge conflicts, there are often common lines that are not really
> common, such as empty lines or lines containing a single curly bracket.
>
> With XDL_MERGE_ZEALOUS_ALNUM, we use the following heuristics: when a
> hunk does not contain any letters or digits, it is treated as conflicting.

I like the general direction.

This might need to be loosened further if we want to cover
Voltage's case where the inconveniently common hunk had another
line, "int err;", which had alnums.  Perhaps we would want to
say "max N alnums" instead of "no alnums".
