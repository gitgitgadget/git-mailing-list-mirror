From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-add--interactive: remove hunk coalescing
Date: Wed, 02 Jul 2008 15:35:48 -0700
Message-ID: <7vod5f7w3f.fsf@gitster.siamese.dyndns.org>
References: <1215035956-26192-1-git-send-email-trast@student.ethz.ch>
 <1215035984-26263-1-git-send-email-trast@student.ethz.ch>
 <7vtzf77wjp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 03 00:37:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEAwg-0004T0-3J
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 00:37:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbYGBWgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 18:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751613AbYGBWgE
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 18:36:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50733 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbYGBWgD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 18:36:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BF04F22D8;
	Wed,  2 Jul 2008 18:36:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 2373622D6; Wed,  2 Jul 2008 18:35:55 -0400 (EDT)
In-Reply-To: <7vtzf77wjp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 02 Jul 2008 15:26:02 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F1E0788-4887-11DD-82E6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87203>

Junio C Hamano <gitster@pobox.com> writes:

> Blindly concatenating the above two and feeding them to "git apply" *may*
> happen to work by accident, not by design.  This very much feels like a
> hack of "This works most of the time for me, your mileage may vary" kind,
> which we would want to avoid when we can.

Well, I changed my mind.  Let's run with this and see what happens.

The patch application is hunk-by-hunk in nature anyway, and if the user
munges the trailing context of the first half of an originally-single hunk
and the leading context of the latter half in an inconsistent way, we
would notice the problem anyway.
