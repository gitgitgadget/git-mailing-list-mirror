From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Use is_pseudo_dir_name everywhere
Date: Fri, 09 Jan 2009 18:48:39 -0800
Message-ID: <7viqonzxiw.fsf@gitster.siamese.dyndns.org>
References: <1231457063-29186-1-git-send-email-aspotashev@gmail.com>
 <1231457063-29186-2-git-send-email-aspotashev@gmail.com>
 <1231457063-29186-3-git-send-email-aspotashev@gmail.com>
 <4966F6BB.90408@viscovery.net> <4966FB36.2030409@viscovery.net>
 <7vy6xk280e.fsf@gitster.siamese.dyndns.org> <20090109102407.GA4089@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 03:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLTve-0004nc-4K
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 03:50:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbZAJCsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 21:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZAJCsr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 21:48:47 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40137 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbZAJCsq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 21:48:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 747F48F828;
	Fri,  9 Jan 2009 21:48:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 830EC8F81B; Fri,
  9 Jan 2009 21:48:41 -0500 (EST)
In-Reply-To: <20090109102407.GA4089@myhost> (Alexander Potashev's message of
 "Fri, 9 Jan 2009 13:24:07 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 32E0EEBA-DEC1-11DD-8214-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105070>

Alexander Potashev <aspotashev@gmail.com> writes:

> I didn't think over the support of 'lost+found'.

Yeah, I do not think it is particularly a good idea, but that is what (I
thought) you implied in your original message.  

In any case, you can always do

    $ git clone -n $there it.git
    $ mv it.git/.git . && rmdir it.git && git checkout -f

or something like that (adjust what you move out of it.git when you are
doing a bare clone), so in that sense I do not deeply care about the
motivation of your patch myself.

But I liked the helper function to abstract away the many identical checks
we do for "is it a dot or a dot dot?", and that was the primary reason why
I commented on your patches.
