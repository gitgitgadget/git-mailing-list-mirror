From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging using only fast-forward
Date: Wed, 16 Jan 2008 12:31:11 -0800
Message-ID: <7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
References: <loom.20080116T151930-575@post.gmane.org>
	<863asxivlj.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Hvammen Johansen <hvammen@gmail.com>, git@vger.kernel.org
To: merlyn@stonehenge.com (Randal L. Schwartz)
X-From: git-owner@vger.kernel.org Wed Jan 16 21:31:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFEvN-0000s6-F5
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 21:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYAPUbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 15:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYAPUbU
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 15:31:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751269AbYAPUbU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 15:31:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 586894A70;
	Wed, 16 Jan 2008 15:31:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C6B584A6C;
	Wed, 16 Jan 2008 15:31:14 -0500 (EST)
In-Reply-To: <863asxivlj.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "Wed, 16 Jan 2008 08:27:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70740>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Junio implemented a 7-line patch on the IRC channel (calling parts of it
> "for randal" or something, I believe :) to do precisely this.
>
> Perhaps you can test it, and submit it as if it were your idea.  I, for one,
> would use it as well.  I'm doing ugly things with parsing the output of
> git-status right now to achieve the same thing.

The mechanism itself is simple.  

	http://git.pastebin.com/m156a1856

A sane integration is a different story.

We have --ff and --no-ff options to merge.  How should this new
option --ff-only mesh with them?  Perhaps we would want to have
an option --ff that takes three values?

	--ff=never
        --ff=normal
        --ff=only

and have the first one be synonym for existing --no-ff, the second
one to be a synonym for not giving anything (or giving --ff
explicitly), and the third one to be this new mode of operation?
