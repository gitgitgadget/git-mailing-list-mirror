From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git with custom diff for commits
Date: Mon, 17 Dec 2007 15:26:51 -0800
Message-ID: <7vbq8o6gxw.fsf@gitster.siamese.dyndns.org>
References: <60687a7d0712171456p14328817y5aa229f0df23c02f@mail.gmail.com>
	<Pine.LNX.4.64.0712172300510.9446@racer.site>
	<vpq1w9kaphg.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0712172310090.9446@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Gerald Gutierrez <ggmlfs@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4PN3-0005iM-Kg
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937329AbXLQX1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937240AbXLQX1H
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:27:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63570 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936858AbXLQX1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:27:05 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D2BA4DCF;
	Mon, 17 Dec 2007 18:26:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D87874DCE;
	Mon, 17 Dec 2007 18:26:52 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712172310090.9446@racer.site> (Johannes
	Schindelin's message of "Mon, 17 Dec 2007 23:11:58 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68662>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> It will show an empty output for "git diff", but I doubt thit will 
>> change anything at commit time. Probably the "filter" thing on the same 
>> file (also "man gitattributes") can help though.
>
> Ah, right.  I completely missed that you were talking about git-commit, 
> not git-log on git commits.
>
> Yes, setting up a "clean" filter that removes the timestamps is probably 
> the reasonable thing to do here.

I wouldn't do filters for something like that.  Can you guarantee that
the output from corresopnding smudge filter will load cleanly back to
the mysql database?

Just do not make the commit if you made only meaningless changes and
nothing else.  pre-commit hook would probably be a good place to do so.
