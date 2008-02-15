From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Automatically close stderr pipes created by
 run_command
Date: Fri, 15 Feb 2008 14:14:40 -0800
Message-ID: <7v1w7dhnov.fsf@gitster.siamese.dyndns.org>
References: <20080214062229.GB30516@spearce.org>
 <47B3F51C.3060002@viscovery.net> <7vfxvui1pz.fsf@gitster.siamese.dyndns.org>
 <200802152045.37755.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Fri Feb 15 23:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ8qK-0006iV-9k
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 23:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbYBOWPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 17:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756551AbYBOWPF
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 17:15:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51138 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbYBOWPD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 17:15:03 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A74718E6;
	Fri, 15 Feb 2008 17:14:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 1AB9018E3; Fri, 15 Feb 2008 17:14:47 -0500 (EST)
In-Reply-To: <200802152045.37755.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Fri, 15 Feb 2008 20:45:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73989>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> ... But practically in the case 
> where a fd > 0 is assigned to .in/.out/.err:
>
> - case .out, .err: the caller is required to close the fd early after 
> start_command() because (if this is a pipe) the child won't see EOF;
>
> - case .in: the caller must not read from the fd anyway, else the child gets 
> inconsistent input.
>
> So, while there *is* some inconsistency, the inconsistent cases can be clearly 
> separated into the cases fd > 0 and fd == -1.

Ok, sold.
