From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git log: avoid segfault with --all-match
Date: Wed, 18 Mar 2009 11:33:36 -0700
Message-ID: <7vbpryfzpb.fsf@gitster.siamese.dyndns.org>
References: <1237399576-27323-1-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 19:35:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk0bi-0007mC-5v
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 19:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011AbZCRSdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755816AbZCRSdn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 14:33:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41480 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbZCRSdn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 14:33:43 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32AEAA288D;
	Wed, 18 Mar 2009 14:33:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2D8B7A288B; Wed,
 18 Mar 2009 14:33:37 -0400 (EDT)
In-Reply-To: <1237399576-27323-1-git-send-email-barra_cuda@katamail.com>
 (Michele Ballabio's message of "Wed, 18 Mar 2009 19:06:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4DD68CC0-13EB-11DE-A4EA-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113648>

Michele Ballabio <barra_cuda@katamail.com> writes:

> Avoid a segfault when the command
>
> 	git log --all-match
>
> was issued.
>
> Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
> ---
>
> Not sure if this is the right fix, nor if it would be better a
> warning or an error.

I think ignoring it makes sense; you could alias "git log --all-match" to
something like "git lg", and when no grepping option appears it will still
work.

I'd add s/was issued./was issued, by ignoring the option/; or something
like that, though.
