From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add compat/vsnprintf.c for systems that returns -1 on
 maxsize reached
Date: Wed, 05 Mar 2008 13:05:32 -0800
Message-ID: <7vejaonaoz.fsf@gitster.siamese.dyndns.org>
References: <200803041459.29000.michal.rokos@nextsoft.cz>
 <200803051455.57148.michal.rokos@nextsoft.cz>
 <47CEAE20.1030707@viscovery.net>
 <200803051600.06605.michal.rokos@nextsoft.cz>
 <20080305155412.GA19295@herod.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Rokos <michal.rokos@nextsoft.cz>,
	Johannes Sixt <j.sixt@viscovery.net>, GIT <git@vger.kernel.org>
To: Wayne Davison <wayne@opencoder.net>
X-From: git-owner@vger.kernel.org Wed Mar 05 22:07:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JX0on-0001pR-5b
	for gcvg-git-2@gmane.org; Wed, 05 Mar 2008 22:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbYCEVFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2008 16:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755516AbYCEVFv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Mar 2008 16:05:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61690 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639AbYCEVFu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2008 16:05:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 15CB313DC;
	Wed,  5 Mar 2008 16:05:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5465013DB; Wed,  5 Mar 2008 16:05:41 -0500 (EST)
In-Reply-To: <20080305155412.GA19295@herod.dreamhost.com> (Wayne Davison's
 message of "Wed, 5 Mar 2008 07:54:12 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76266>

Wayne Davison <wayne@opencoder.net> writes:

> I'd suggest using a longer buf, requesting a longer length (e.g. 3
> instead of 1), and then making sure that the resulting buf is right
> (e.g. "12" instead of "123").
>
> 		[[char buf[6];
> 		  if (test_vsnprintf(buf, 3, "%s", "12345") != 5
> 		   || strcmp(buf, "12") != 0) return 1;
> 		  if (snprintf(buf, 3, "%s", "12345") != 5
> 		   || strcmp(buf, "12") != 0) return 1]])],

That sounds like a sensible thing to do.

Other than that, the patch in

    Message-Id: <200803051646.13343.michal.rokos@nextsoft.cz>

looked Ok to me.

