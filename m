From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 10:07:43 -0700
Message-ID: <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
 <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807230203350.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 19:08:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLhpZ-0005O1-LD
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 19:08:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752010AbYGWRHu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 13:07:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbYGWRHu
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 13:07:50 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbYGWRHt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 13:07:49 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 700D238351;
	Wed, 23 Jul 2008 13:07:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B1C643834E; Wed, 23 Jul 2008 13:07:45 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E03FA68C-58D9-11DD-8192-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89714>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, if you want to avoid CRs to _enter_ the repository, when you have 
> a lot of binary files tracked, you _do_ want to force all repositories to 
> crlf=input.

If you are on a sane system, you do not even want to pay the price of
conversion.  Only people on systems with CRLF line endings should pay the
price (because your aim is to convert on such systems).  Are we throwing
that out of the window when the project decides to use gitattributes?

How about setting autocrlf automatically on mingw/msys/cygwin versions,
perhaps via templates or a patch to init-db?  Would that, combined with
user education, be a viable alternative?
