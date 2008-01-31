From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-filter-branch.sh: don't use --default when calling rev-list
Date: Thu, 31 Jan 2008 01:27:09 -0800
Message-ID: <7vwspqcple.fsf@gitster.siamese.dyndns.org>
References: <47A109A7.1070502@nrlssc.navy.mil>
	<1201738186-28132-1-git-send-email-casey@nrlssc.navy.mil>
	<47A11317.2010409@nrlssc.navy.mil>
	<alpine.LSU.1.00.0801310048350.23907@racer.site>
	<47A125D9.2070105@nrlssc.navy.mil> <47A19211.5090409@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:28:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKViE-0000fv-OI
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:28:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765668AbYAaJ10 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765639AbYAaJ1Z
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:27:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765603AbYAaJ1W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:27:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F1DA2C9A;
	Thu, 31 Jan 2008 04:27:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 761AD2C99;
	Thu, 31 Jan 2008 04:27:16 -0500 (EST)
In-Reply-To: <47A19211.5090409@op5.se> (Andreas Ericsson's message of "Thu, 31
	Jan 2008 10:17:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72112>

Andreas Ericsson <ae@op5.se> writes:

> Well, if there's no filter specified it has nothing to do, so erroring out
> in the no-arguments-at-all case would be sensible.

Actually, not erroring out but just returning doing nothing (if
there truly isn't anything to do -- iow, the filtering operation
turns out to be identity function) would be more sensible.

No filter does not necessarily mean identity, by the way.  Think
"grafts" ;-).
