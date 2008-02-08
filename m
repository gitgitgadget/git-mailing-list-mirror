From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git help -w should not create nohup.out
Date: Thu, 07 Feb 2008 19:40:21 -0800
Message-ID: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org>
References: <1202434421-8066-1-git-send-email-dpotapov@gmail.com>
	<alpine.LSU.1.00.0802080153570.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 04:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNK7K-00025B-9M
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 04:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758900AbYBHDkq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2008 22:40:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758075AbYBHDkq
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Feb 2008 22:40:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53834 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbYBHDkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2008 22:40:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 89BB9643B;
	Thu,  7 Feb 2008 22:40:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D9FD9643A;
	Thu,  7 Feb 2008 22:40:38 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802080153570.11591@racer.site> (Johannes
	Schindelin's message of "Fri, 8 Feb 2008 01:55:33 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73030>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 8 Feb 2008, Dmitry Potapov wrote:
>
>> git-help--browse uses 'nohup' to launch some browsers.
>
> Why?
>
> "nohup" should be used to start a program that should persist even after 
> you logged out.  I fail to see how this should be sensible for "git help 
> -w".  So "off with the head", uh, do away with the "nohup", I say!

True.  Christian, what was the reason you added nohup?
I would imagine if you did this:

	(1) open a new xterm;

        (2) in that xterm, run the browser, perhaps from
            git-help--browse, but without nohup, in the
            background;

	(3) exit the terminal

then the browser might get upset, losing its controlling
terminal.

But I suspect that would be a really broken behaviour.
