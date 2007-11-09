From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Thu, 08 Nov 2007 17:28:18 -0800
Message-ID: <7vtznwxl59.fsf@gitster.siamese.dyndns.org>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	<11945685732608-git-send-email-dsymonds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andreas Ericsson <ae@op5.se>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:28:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIfw-0002Gd-Tt
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:28:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbXKIB2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbXKIB2d
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:28:33 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57653 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754516AbXKIB2c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:28:32 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id A85E82F0;
	Thu,  8 Nov 2007 20:28:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2F11293AF2;
	Thu,  8 Nov 2007 20:28:47 -0500 (EST)
In-Reply-To: <11945685732608-git-send-email-dsymonds@gmail.com> (David
	Symonds's message of "Fri, 9 Nov 2007 11:36:07 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64108>

David Symonds <dsymonds@gmail.com> writes:

> Signed-off-by: David Symonds <dsymonds@gmail.com>
> ---
> 	Test 5 in this series fails because of a bug in git-ls-files, where
> 		git-ls-files t/../
> 	(with or without --full-name) returns no files.

Heh, you shouldn't do that ;-)

Seriously, that's a long standing limitation in the code, not to
deal with arbitrary combination of ups and downs, but I do not
think there is any fundamental reason to disallow something
like:

	cd Documentation && git ls-files --full-name ../t

Patches welcome.
