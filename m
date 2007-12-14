From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Thu, 13 Dec 2007 19:22:43 -0800
Message-ID: <7vzlwevu2k.fsf@gitster.siamese.dyndns.org>
References: <20071211200418.GA13815@mkl-desktop>
	<20071212083154.GB7676@coredump.intra.peff.net>
	<7vir348e0l.fsf@gitster.siamese.dyndns.org>
	<20071212092512.GB20799@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 14 04:23:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3195-0005rv-Kb
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 04:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbXLNDXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 22:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755364AbXLNDXD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 22:23:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964AbXLNDXB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 22:23:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A2F288DA5;
	Thu, 13 Dec 2007 22:22:55 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AA6D8DA4;
	Thu, 13 Dec 2007 22:22:49 -0500 (EST)
In-Reply-To: <20071212092512.GB20799@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 12 Dec 2007 04:25:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68215>

Jeff King <peff@peff.net> writes:

>> the path at the beginning happens to be longer than 1024 then you will
>> run path-less "cvs status"?
>
> No, read the loop again. The length starts at 0, so we always go through
> the loop body once.

Sorry, you are right.

Perhaps pick a reasonably small but not insanely small value, like 16kB,
forget about the atomicity issues for now, as an interim improvement
patch?
