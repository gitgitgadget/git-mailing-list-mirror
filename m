From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce the config variable pack.packSizeLimit
Date: Sat, 09 Feb 2008 12:42:18 -0800
Message-ID: <7vwspdeuad.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802051423530.8543@racer.site>
	<7vfxw2g0gb.fsf@gitster.siamese.dyndns.org>
	<7vbq6qfz94.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0802091312350.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torarvid@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 21:43:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNwXc-000534-8p
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 21:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553AbYBIUmd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 15:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbYBIUmd
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 15:42:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbYBIUmc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 15:42:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D38D3746;
	Sat,  9 Feb 2008 15:42:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A6BB43745;
	Sat,  9 Feb 2008 15:42:25 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802091312350.11591@racer.site> (Johannes
	Schindelin's message of "Sat, 9 Feb 2008 13:15:07 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73263>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Minor modification that is necessary: MacOSX' find does not accept a find 
> call like that.  It must be
>
> 	bigger=$(find . -name test-4-*.pack -size +${limit}c) &&

That looks more traditional, but now you mention it, I agree
that it might not be so portable.  I've used "-size +$size" in
Ancient Unices, but 'c' suffix is a more recent invention (V7
did not have it, neither did 4BSD, IIRC).
