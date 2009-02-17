From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/8] config: Reorganize get_color*.
Date: Mon, 16 Feb 2009 18:24:31 -0800
Message-ID: <7v63j9by1s.fsf@gitster.siamese.dyndns.org>
References: <1234832094-15541-1-git-send-email-felipe.contreras@gmail.com>
 <1234832094-15541-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 03:26:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZFf3-0004Ji-UQ
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 03:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbZBQCYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 21:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZBQCYj
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 21:24:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbZBQCYi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 21:24:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C92109A02C;
	Mon, 16 Feb 2009 21:24:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 838079A02B; Mon,
 16 Feb 2009 21:24:33 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1FB377D0-FC9A-11DD-A7F6-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110296>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> In preparation for parseopt.

I like this patch, because it clarifies what get_colorbool() and
get_color() functions are meant to do by moving the boundary of
responsibility between the two callers and these two functions.

The above log message does not do justice to the patch text.

>  builtin-config.c |   63 +++++++++++++++--------------------------------------
>  1 files changed, 18 insertions(+), 45 deletions(-)

I like a patch that results in code reduction, so I got quite interested
in seeing what you did.  But there was no magic --- you lost a lot of
comments on what each function is supposed to do.

They are all described in the documentation, and removal of these comments
that can go stale is probably a good thing, but you could have avoided
dissapointing me who expected a magic by mentioning the removal of the
comments (and why it is a good idea) upfront ;-)
