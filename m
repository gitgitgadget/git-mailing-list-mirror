From: Junio C Hamano <gitster@pobox.com>
Subject: Re: I'm a total push-over..
Date: Fri, 25 Jan 2008 11:07:46 -0800
Message-ID: <7v63xh7mgt.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.00.0801230922190.1741@woody.linux-foundation.org>
	<87fxwmv5tf.fsf@jbms.ath.cx>
	<alpine.LSU.1.00.0801251250120.5731@racer.site>
	<87abmtvkd8.fsf@jbms.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JITuj-0006tH-KV
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 20:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755575AbYAYTIB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 14:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754824AbYAYTIB
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 14:08:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741AbYAYTIA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 14:08:00 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B742C13C3;
	Fri, 25 Jan 2008 14:07:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EB2A13C0;
	Fri, 25 Jan 2008 14:07:47 -0500 (EST)
In-Reply-To: <87abmtvkd8.fsf@jbms.ath.cx> (Jeremy Maitin-Shepard's message of
	"Fri, 25 Jan 2008 13:19:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71728>

Jeremy Maitin-Shepard <jbms@cmu.edu> writes:

> In theory, I agree that this is possible, but in practice it may not be
> reasonable at all.  Consider two possible comparison functions:
>
> 1. compare file names as strings case-insensitively assuming a latin 1
> encoding
>
> 2. compare file names as strings case-insensitively assuming a UTF-8
> encoding
>
> Actually writing a hash function such that two strings hash to the same
> value if either of these comparison functions says that the strings are
> equal would appear to be rather difficult.

Once you start adding more "case folding" supported filesystems
to the repertoire, such a unified hash function Dscho suggests
needs to throw paths that other (N-1) "case folding" filesystems
treat as distinct but only 1 filesystem treats "equivalent" into
the same hash bucket.  I would say not just difficult but the
resulting function would have too many collisions to make it
ineffective.
