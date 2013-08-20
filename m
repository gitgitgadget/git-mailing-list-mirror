From: Junio C Hamano <gitster@pobox.com>
Subject: Re: netrc credential helper promotion out of contrib?
Date: Tue, 20 Aug 2013 12:28:39 -0700
Message-ID: <xmqqvc305fh4.fsf@gitster.dls.corp.google.com>
References: <87k3jjp9q5.fsf@lifelogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ted Zlatanov <tzz@lifelogs.com>
X-From: git-owner@vger.kernel.org Tue Aug 20 21:28:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VBrbj-0005H9-EV
	for gcvg-git-2@plane.gmane.org; Tue, 20 Aug 2013 21:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548Ab3HTT2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 15:28:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751045Ab3HTT2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 15:28:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D8A53A534;
	Tue, 20 Aug 2013 19:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pZbFgzplsb+LPUj9hC2xUM0GgVk=; b=pCmNp6
	CkjltbdMXfgkxVbOxCMW8Ufu6vca7V8+6v2hrCVtivrSCx9qEYk3DID0aHVcn0d+
	uX7rRgU2vXyN9pBl3Oks+n+VOoDFUbvfZUwKka6AZKEEQbhxQ60BzCltPPFBb1Iy
	pdF6/2en5pC0ImpyuhMSgb17NGK7tVC/IBJ0A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T9VwiVaCOTs3r+F0WJW3kiaxoqqj0cbC
	MVV7a3Z6sTWtbHVQ0DP8OyMkLaPWF/bY3h/W6Hr3vBaXYfxF9WKmx81woq8RTSYZ
	6XutviV1p6V46A2NtoIy2C6VDRYhmw5lkn9TOPGZCsEl42Vi6WEn5X4PaY7mpblN
	MH23F9WUDkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32C583A533;
	Tue, 20 Aug 2013 19:28:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9799F3A526;
	Tue, 20 Aug 2013 19:28:41 +0000 (UTC)
In-Reply-To: <87k3jjp9q5.fsf@lifelogs.com> (Ted Zlatanov's message of "Sun, 18
	Aug 2013 06:35:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B89A59B4-09CE-11E3-AAF3-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232635>

Ted Zlatanov <tzz@lifelogs.com> writes:

> A while has passed since contrib/credential/netrc was added. Is it OK to
> promote it to be part of the main installation?

I gave it a quick glance, and it seems to be cleanly written, except
that "EOHIPPUS" (End-of-Hippus?  Eohippus the extinct horse?) looked
a bit too strange to my taste ;-).  It does not seem to use features
older versions of Perl some people are stuck with do not support.

I do not mind seeing a patch that moves contrib/credential/netrc to
credential/netrc and adjusts the top-level Makefile.  The test
script needs to be updated to fit the rest of t/ hierarchy better,
though.
