From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix a small memory leak in builtin-add
Date: Tue, 30 Oct 2007 01:28:32 -0700
Message-ID: <7vk5p5ngzz.fsf@gitster.siamese.dyndns.org>
References: <1193641233-3880-1-git-send-email-tsuna@lrde.epita.fr>
	<1193641233-3880-2-git-send-email-tsuna@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Oct 30 09:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImmT2-0001OV-1y
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 09:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbXJ3I2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 04:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbXJ3I2j
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 04:28:39 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:45521 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbXJ3I2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 04:28:38 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C00A32F0;
	Tue, 30 Oct 2007 04:28:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 3598C8F3A4;
	Tue, 30 Oct 2007 04:28:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Benoit Sigoure <tsuna@lrde.epita.fr> writes:

> prune_directory and fill_directory allocated one byte per pathspec and never
> freed it.
>
> Signed-off-by: Benoit Sigoure <tsuna@lrde.epita.fr>
> ---
> I don't know whether this was intentionnal or not (since it's
> only a matter of having small chunks of memory not being
> reclaimed and I don't think we can enter these functions
> twice, so these are not leaks in the sense that the program
> will consume more and more memory).

I think it was just a slop.  Thanks for catching it.
