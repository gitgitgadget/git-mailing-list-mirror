From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Run git gc only once and not for every patch.
Date: Fri, 04 Jan 2008 22:55:39 -0800
Message-ID: <7vve68ep78.fsf@gitster.siamese.dyndns.org>
References: <20080104185926.GA11912@redhat.com>
	<alpine.LFD.1.00.0801041437190.2649@xanadu.home>
	<7vhchtjphk.fsf@gitster.siamese.dyndns.org>
	<477EA06A.5090606@redhat.com>
	<7vmyrli73h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
X-From: git-owner@vger.kernel.org Sat Jan 05 07:56:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JB2x8-0000YA-8r
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 07:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752684AbYAEGzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2008 01:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752677AbYAEGzw
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jan 2008 01:55:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbYAEGzv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2008 01:55:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F4D47081;
	Sat,  5 Jan 2008 01:55:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C7F887080;
	Sat,  5 Jan 2008 01:55:45 -0500 (EST)
In-Reply-To: <7vmyrli73h.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 04 Jan 2008 14:00:50 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69646>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> I do not think moving "gc --auto" outside the loop hurts in
> practice because you are not likely to be rebasing a truly huge
> series every day, but cruft can accumulate during "git am" run
> and the "gc --auto" inside loop was meant to clean them up.  The
> idea was taken from importers that run repack every once in a
> while (e.g. cvsimport runs every 1k commits), but "gc --auto"
> was designed to be much more lightweight than a full repack and
> that was the reason it was placed in the loop without counting
> "every N commits".

Having said all that, I'll take your patch as-is except that I'd
drop the later part of the commit log message that explains
Wine's practice.
