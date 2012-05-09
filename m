From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/19] tests: add tests for the bash prompt functions in
 the completion script
Date: Wed, 09 May 2012 11:08:00 -0700
Message-ID: <7vzk9hrzwf.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-3-git-send-email-szeder@ira.uka.de>
 <4FAA25A7.4020300@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 09 20:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSBJ7-0001Kg-3e
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 20:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760695Ab2EISIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 14:08:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47076 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754952Ab2EISIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 14:08:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2E9370F3;
	Wed,  9 May 2012 14:08:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r9KY5hPPcP4Y6plVvdZsmarZfnA=; b=f4qTG2
	aC/wfR4Ye/3FrvNdOFCi+ZIibMapgX172OWAI+B65Vg0dHIHN0vQ5YdWVdY+G0GB
	xWuPdn1vOY8Ilzg0YcD7lFQ6z5GF3dFAz7Y/Qgslt07LVvYtQ2RjXSGmZp3PBCxm
	IVWYnAPCclhKePl+YKKdkMGcT8RBsSHSKR204=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XUqiA4aZdDXC47aP3syqsBDHz5yTYa/2
	2wLYvVC82ON5XOEo7U2HM6DKX2zU7Okqhs4vuBYme57XN9e75vbLlgN3w0dcC7Su
	yMc9TpKh2mVo35mCd4g6L08pRLEd6ztFzuMR9F6QlYuYcZesM66mGGzOPp6SzsBB
	r4Uo+0tbSVE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5BAA70F2;
	Wed,  9 May 2012 14:08:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49D5B70F1; Wed,  9 May 2012
 14:08:02 -0400 (EDT)
In-Reply-To: <4FAA25A7.4020300@viscovery.net> (Johannes Sixt's message of
 "Wed, 09 May 2012 10:07:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAD27094-9A01-11E1-A219-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197487>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] fixup! tests: add tests for the bash prompt functions in the
>  completion script
>
> - $TRASH_DIRECTORY is /c/dir style path, but git produces c:/dir style
>   paths. Use $(pwd), which is short for $(pwd -W) that produces the
>   latter, to assemble expected test data and paths read by git.

This comes up very often whenever somebody (including me) touches test
scripts.  We do have a write-up in t/README in "Dos and Don'ts" section,
but apparently that is not sufficient to avoid fix-ups.

Would it be possible to arrange so that $TRASH_DIRECTORY, $TEST_DIRECTORY
and $PWD are set to c:/dir style paths in Windows environment?  What would
we break if we did so?

The other direction of changing the Windows port of git to produce /c/dir
style paths would probably not work, as it would involve ripping out the
path mangling feature of bash in MSYS, which is done for some reason, I
presume.
