From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] autodetect number of CPUs by default when using threads
Date: Thu, 11 Dec 2008 14:25:08 -0800
Message-ID: <7v63lqcptn.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAtzf-0002Wu-Vx
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757374AbYLKWZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757439AbYLKWZR
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:25:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139AbYLKWZP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:25:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E65B286942;
	Thu, 11 Dec 2008 17:25:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 314138693E; Thu,
 11 Dec 2008 17:25:10 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812111524370.14328@xanadu.home> (Nicolas
 Pitre's message of "Thu, 11 Dec 2008 15:36:47 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93E525F6-C7D2-11DD-A97D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102830>

Nicolas Pitre <nico@cam.org> writes:

> I've spent quite a while wondering why repacking in one repo was faster 
> than repacking in a clone of that repo on the same machine.  So let's 
> display how many threads are actually used.
>
> We have comprehensive test in Makefile to determine if threads are 
> available, just to not use them by default.  I think that code has 
> proven itself for long enough now not to let people benefit from it.

Hmm, it does appear that distros compile with THREADED_DELTA_SEARCH turned
on (I only checked Fedora and Debian), and I tend to agree with "long
enough" but "proven itself" feels bit too strong a statement.

I think defaulting to autodetect is a good change.  I do not like to add
new output to stderr deep in -rc, though.

Can we park this in 'next' and move it to 'master' after 1.6.1?
