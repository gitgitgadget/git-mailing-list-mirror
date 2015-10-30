From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Handle p4 submit failure
Date: Fri, 30 Oct 2015 09:44:29 -0700
Message-ID: <xmqqeggcmhle.fsf@gitster.mtv.corp.google.com>
References: <CAJA=mv4Tr_DoBMwR8hK_fEJ1PFCYTu17HHvEnFWMANGFcf0Wpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Pete Wyckoff <pw@padd.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Etienne Girard <etienne.g.girard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 17:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsCn8-0007hG-Vf
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 17:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759291AbbJ3Qoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 12:44:34 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751231AbbJ3Qod (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 12:44:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4CAA224A8E;
	Fri, 30 Oct 2015 12:44:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zByhq1y12BylNVDxu+FRxLGkfCs=; b=ij7o2A
	SRaf+xxb/+iaoYbhjk1dWyXjiwO/S2TYWTgBCEob30D9gEX8dAuZYLEcS5XeLtlc
	INmVi0PbOwkN8kgdMjvTYf2KBgP+Wcg64gEdRLUzl4wyZIBg8YEibinYUkKDZaUM
	P+DKe+Am2ym6QRTuW5fLXg6K78a0GjKdbZWlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qcThMXtA+EPBaH7IGShzP/Ns03NX6xcy
	zUqySGwyqT3MxywIXpb2Upcf2cGn6QFQJHjDKDpUAS6tOSeDUvMxJWaJMQl1QFWY
	xjdYU11naabIspHsx2wZrBVKT1BGdNt+ZBpyF9mcdlpWibQ/WMu9Ys3gYwRgG3sK
	NJiUwQsb+VQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D942E24A8D;
	Fri, 30 Oct 2015 12:44:31 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1345924A8C;
	Fri, 30 Oct 2015 12:44:31 -0400 (EDT)
In-Reply-To: <CAJA=mv4Tr_DoBMwR8hK_fEJ1PFCYTu17HHvEnFWMANGFcf0Wpg@mail.gmail.com>
	(Etienne Girard's message of "Wed, 28 Oct 2015 14:12:21 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E1BE4A0-7F25-11E5-9E28-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280493>

Etienne Girard <etienne.g.girard@gmail.com> writes:

> Clean the workspace if p4_write_pipe raised SystemExit,
> so that the user don't have to do it themselves.
>
> Signed-off-by: GIRARD Etienne <egirard@murex.com>
> ---

Thanks.  As I do not really do "p4", I am CC'ing this response to
the area experts.

First, one "procedural" comment.

You sent the patch from your gmail.com address, but signed it off
with another address (with name spelled differently).  If applied
as-is, the result will have your gmail.com address listed as the
author and that will be the name you would see in "git shortlog".

If you rather prefer to be known as the name and address you placed
on your sign-off, while sending the patch from another address, you
can do so by staring the _body_ of the message with what is called
an "in-body header", like this:

        From: GIRARD Etienne <egirard@murex.com>

        Clean the workspace if p4_write_pipe raised SystemExit,
        so that the user don't have to do it themselves.

        Signed-off-by: GIRARD Etienne <egirard@murex.com>
        ---
	  ... here you have the usual patch ...

That "From:" line would sit on the first line of the body of your
message, separated by a blank line from the body of the log message.

This is not even a problem from the project's point of view, but I
thought you would want to be aware of it, and may want a chance to
change it.

	Note: this time, you do not need to resend the patch; just
	please let me know if you want me to do the equivalent of
	the above while applying to make your murex address and name
	appear as the author in "git log" and "git shortlog" output.

FYI, you could override the "Subject:" of your e-mail header with an
in-body header (this is often useful when replying to an existing
discussion thread with a patch that shows a solution), e.g.

        From: GIRARD Etienne <egirard@murex.com>
	Subject: git-p4: clean up after p4 submit failure

        Clean the workspace if p4_write_pipe raised SystemExit,
        so that the user don't have to do it themselves.

        Signed-off-by: GIRARD Etienne <egirard@murex.com>
        ---
	  ... here you have the usual patch ...

>  git-p4.py | 71 +++++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 37 insertions(+), 34 deletions(-)
>
> The p4 submit command may fail, for example if the changelist contains
> a job that does not exist in the Jobs section. If this is the case,
> p4_write_pipe will exit the script. This change makes it so that the
> workspace is reverted before letting the script die.

Some of the information contained in this paragraph deserves to be
in the log message proper.  How about

        From: GIRARD Etienne <egirard@murex.com>
	Subject: git-p4: clean up after p4 submit failure

	When "p4 submit" command fails in P4Submit.applyCommit, the
	workspace is left with the changes.  We already have a code
        to revert the changes to the workspace when the user decides
	to cancel submission by aborting the editor that edits the
	change description, and we should treat the "p4 submit"
	failure the same way.

        Clean the workspace if p4_write_pipe raised SystemExit,
        so that the user don't have to do it themselves.

        Signed-off-by: GIRARD Etienne <egirard@murex.com>

or something like that?

While trying to come up with the above description, I started
wondering if the error message wants to differentiate the two cases.

When self.edit_template() returns false, we know that the user
actively said "no I do not want to submit", and "Submission
cancelled" is perfectly fine, but when "p4 submit" fails because it
did not like the change description or if it found some other
issues, it is not necessarily that the user said "I want to cancel";
it is more like "Submission failed".

Hmm?
