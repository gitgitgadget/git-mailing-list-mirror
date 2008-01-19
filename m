From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging using only fast-forward
Date: Sat, 19 Jan 2008 02:43:57 -0800
Message-ID: <7vzlv2858y.fsf@gitster.siamese.dyndns.org>
References: <loom.20080116T151930-575@post.gmane.org>
	<863asxivlj.fsf@blue.stonehenge.com>
	<7vwsq9o6ls.fsf@gitster.siamese.dyndns.org>
	<402c10cd0801162253n6ab19f51y53d0baa16319adaa@mail.gmail.com>
	<402c10cd0801172258p9a1a97bt682fa012fcebd13c@mail.gmail.com>
	<7vodbibzch.fsf@gitster.siamese.dyndns.org>
	<402c10cd0801190228o68995493u9b8b40e1557092dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 11:44:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGBBh-00032V-Ok
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 11:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbYASKoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 05:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbYASKoE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 05:44:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061AbYASKoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 05:44:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AD4C35685;
	Sat, 19 Jan 2008 05:44:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 340885682;
	Sat, 19 Jan 2008 05:43:59 -0500 (EST)
In-Reply-To: <402c10cd0801190228o68995493u9b8b40e1557092dd@mail.gmail.com>
	(Sverre Hvammen Johansen's message of "Sat, 19 Jan 2008 02:28:55
	-0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71097>

"Sverre Hvammen Johansen" <hvammen@gmail.com> writes:

> The more I think about this is that --ff-only should really be
> specified as a merge strategy (single) and not as an special case of
> --ff.  All merge strategies can then take any number of commits, but
> will only succeed if the commits can be reduced down to two or fewer
> for resolve/recursive and one for single.

Interesting.

At one end of the spectrum, we have these crazy people who want
git to record something that is not a merge at all as a merge
with --no-ff.  At the other end of the spectrum, we have these
other crazy people who want git to outsmart them by allowing
them to throw random set of commits as potential parents,
remove duplicates and figure out how many real parents the
resulting merge should have (including the case that it may not
even have any).

I'll have to think about it, but it sounds like a promising
idea.
