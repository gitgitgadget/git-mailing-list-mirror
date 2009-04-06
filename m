From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [question] how can i verify whether a local branch is tracking a
 remote branch?
Date: Sun, 05 Apr 2009 22:28:02 -0700
Message-ID: <7vy6uecpwd.fsf@gitster.siamese.dyndns.org>
References: <4d8e3fd30904050332w394cccbaq5b82d2a53ed357a3@mail.gmail.com>
 <20090405144413.GC2076@sigill.intra.peff.net>
 <4d8e3fd30904051425w6739a12fp5666e71e8b2d7958@mail.gmail.com>
 <20090406043426.GC12341@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 06 07:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqhSv-0004z0-0I
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 07:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbZDFF2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 01:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbZDFF2L
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 01:28:11 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbZDFF2K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 01:28:10 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C1F0FCB33;
	Mon,  6 Apr 2009 01:28:07 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 2A4ADCB31; Mon, 
 6 Apr 2009 01:28:04 -0400 (EDT)
In-Reply-To: <20090406043426.GC12341@coredump.intra.peff.net> (Jeff King's
 message of "Mon, 6 Apr 2009 00:34:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B5FDD0E0-226B-11DE-97DF-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115765>

Jeff King <peff@peff.net> writes:

> I don't think it would be unreasonable to expose this functionality via
> "for-each-ref". Something like this (which would need cleanup,
> documentation, and perhaps a :short variant):

I think that is a sane approach, but isn't "tracking" a misnomer?  I think
what you are describing is what is called "the upstream branch" by the
description of Documentation/config.txt::branch.<name>.merge, and not what
people call "tracking branch" (see Documentation/glossary-content.txt).

In a repository with a handcrafted fetch refspec, being able to show
"tracking" information would also be interesting (e.g. a clone of git.git
made with pre-1.5.0 git would say "origin's master" for refs/heads/origin
and "origin's next" for refs/heads/next), but the separate-remote layout
is the default these days, so it wouldn't be so interesting anymore.  In
other words, I am not suggesting you to add "tracking" information.

I also wonder if you want to say "this remote" and "that branch"
separately.  As far as I can tell you are not giving the former but only
the latter information?
