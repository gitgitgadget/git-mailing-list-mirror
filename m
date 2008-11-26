From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] bisect: teach "skip" to accept special arguments
 like "A..B"
Date: Tue, 25 Nov 2008 21:42:26 -0800
Message-ID: <7viqqbhwl9.fsf@gitster.siamese.dyndns.org>
References: <20081123220249.2e7f30a5.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 06:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5DC3-0003ys-RP
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 06:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYKZFmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 00:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbYKZFmv
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 00:42:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbYKZFmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 00:42:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3906581368;
	Wed, 26 Nov 2008 00:42:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A6BE581365; Wed,
 26 Nov 2008 00:42:28 -0500 (EST)
In-Reply-To: <20081123220249.2e7f30a5.chriscool@tuxfamily.org> (Christian
 Couder's message of "Sun, 23 Nov 2008 22:02:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F4115C8-BB7D-11DD-93AA-8214C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101703>

Christian Couder <chriscool@tuxfamily.org> writes:

> The current "git bisect skip" syntax is "git bisect skip [<rev>...]"
> so it's already possible to skip a range of revisions using
> something like:
>
> $ git bisect skip $(git rev-list A..B)
>
> where A and B are the bounds of the range we want to skip.
>
> This patch teaches "git bisect skip" to accept:
>
> $ git bisect skip A..B
>
> as an abbreviation for the former command.

Although I fully realize that the established semantics of A..B in git is
bottom-exclusive, top-inclusive, and this suggestion breaks the UI
uniformity by deviating from that convention, I have to wonder if it would
be more useful if you let the bottom commit (A in your example) also be
skipped.

I would suspect that it would be more useful than the "replace" one, but
that is a separate issue.
