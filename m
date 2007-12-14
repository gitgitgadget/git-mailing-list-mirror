From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Failed to make install-info
Date: Fri, 14 Dec 2007 09:45:54 -0800
Message-ID: <7vprx9rwz1.fsf@gitster.siamese.dyndns.org>
References: <E1J2q92-0001YT-BZ@jdl.com>
	<200712140635.39311.chriscool@tuxfamily.org>
	<7vejdpvmlw.fsf@gitster.siamese.dyndns.org>
	<E1J3Bg0-0004Ut-Ii@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 18:46:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3EcM-0003NC-6C
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 18:46:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754523AbXLNRqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 12:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbXLNRqM
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 12:46:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42236 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbXLNRqK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 12:46:10 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 30C8494F9;
	Fri, 14 Dec 2007 12:46:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 00AC694F7;
	Fri, 14 Dec 2007 12:45:55 -0500 (EST)
In-Reply-To: <E1J3Bg0-0004Ut-Ii@jdl.com> (Jon Loeliger's message of "Fri, 14
	Dec 2007 08:38:08 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68321>

Jon Loeliger <jdl@jdl.com> writes:

> So, like, the other day Junio C Hamano mumbled:
>> 
>> I personally feel that calling "install-info" is a bit too distro-ish
>> and should not be done in our Makefile vanilla build-and-install
>> procedure.
>
> Hmmm...  That's an interesting take on things
> given the top of the INSTALL file:
>
> 		    Git installation
>
>     Normally you can just do "make" followed by "make install", and that
>     will install the git programs in your own ~/bin/ directory.  If you want
>     to do a global install, you can do
>
> 	    $ make prefix=/usr all doc info ;# as yourself
> 	    # make prefix=/usr install install-doc install-info ;# as root

I was not talking about install-info target that copies generated *.info
files to $(DESTDIR)$(infodir)/.  That does not sound distro-ish at all
to me.

What I found questionable was $(INSTALL_INFO) invocation in that target
in the Makefile.
