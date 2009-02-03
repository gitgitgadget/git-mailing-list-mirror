From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-remote: make rm operation safer in mirrored
 repository
Date: Mon, 02 Feb 2009 23:54:28 -0800
Message-ID: <7vy6woc5vv.fsf@gitster.siamese.dyndns.org>
References: <76718490902020536g6f4bcee2i76ee046a8dc7d46@mail.gmail.com>
 <1233600014-82346-1-git-send-email-jaysoffian@gmail.com>
 <20090203072418.GD21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 08:56:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUG8X-0003n8-1H
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 08:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbZBCHyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 02:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbZBCHyf
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 02:54:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbZBCHye (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 02:54:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ACD8F2A559;
	Tue,  3 Feb 2009 02:54:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CFD282A557; Tue, 
 3 Feb 2009 02:54:29 -0500 (EST)
In-Reply-To: <20090203072418.GD21367@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 3 Feb 2009 02:24:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E53055D8-F1C7-11DD-BADD-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108162>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 02, 2009 at 01:40:14PM -0500, Jay Soffian wrote:
>
>> This version adds a test case. I also noticed that the check I'd added to
>> add_branch_for_removal() was generating spurious warnings because I'd added it
>> in the wrong place; this version moves the check below the
>> remote_find_tracking() checks.
>
> This version looks fine to me, and I would be OK with it being applied.
>
> However, I have one small nit. The output produces long lines with a lot
> of repeated text (assuming you have multiple matched branches, which is
> likely if you have a mirrored setup). So maybe it would be nicer to have
> something like:
>
>   warning: non-remote branches were not removed; you can delete them with:
>           git branch -d master
>           git branch -d next
>           git branch -d topic
>
> which is a little more obvious (to me, anyway), and allows you to cut
> and paste if you really did want to delete them.

Thanks for a review, and I actually shared that exact nit when I first
read the patch.  It would be a very good change to collect them in a list
and show a single warning at the end (I do not have particular preference
about the cut & paste-ability either way myself).
 
