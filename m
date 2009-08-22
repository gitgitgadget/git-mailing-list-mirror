From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2 (v3)] reset: make the output more user-friendly.
Date: Fri, 21 Aug 2009 22:44:48 -0700
Message-ID: <7v3a7k767j.fsf@alter.siamese.dyndns.org>
References: <vpqljlipcs6.fsf@bauges.imag.fr>
 <1250845079-30614-1-git-send-email-Matthieu.Moy@imag.fr>
 <1250845079-30614-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat Aug 22 07:45:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MejPW-0000OE-O9
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 07:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbZHVFoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 01:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbZHVFoz
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 01:44:55 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932666AbZHVFoz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 01:44:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D67E032612;
	Sat, 22 Aug 2009 01:44:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=51jGDiWQpcuzVEbz8D41S9Rv8Fo=; b=NuNlfE
	qzlORJHJWxdRQjsYN+ZGybXpDTV6U4hSMOuROmKPs6lR2ZpkdxM8i82baved2LDA
	h3CZMqq0/mpYfcLWMnmIh1ysdab5kPpQxiUrJlh+HbInRSwejVHGGupIr/hK+dsc
	jmk/lwGKn/AAr55KRjiMhCCQGYjCt336gwRp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7GcUKzt+Q7ViaJHcnEB5gdgNPvvc7Z9
	aglOCR20EOoq2ZiXb7q4QOAtxCcdJc6h/Vi7Ft3z2PUR7J0eGgh7upJEmZe4AQZX
	devpxKMQf/2F1NZZb2I7QNglI+3T8AshdyOovBlFGWbMryrJHY8LzbbZgfWOXNVT
	vJArSdVrPmE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BA17432611;
	Sat, 22 Aug 2009 01:44:53 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 86CE43260E; Sat, 22 Aug 2009
 01:44:50 -0400 (EDT)
In-Reply-To: <1250845079-30614-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 21 Aug 2009 10\:57\:59 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA9473D8-8EDE-11DE-8717-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126795>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> git reset without argument displays a summary of the remaining
> unstaged changes. The problem with these is that they look like an
> error message, and the format is inconsistant with the format used in
> other places like "git diff --name-status".
>
> This patch mimics the output of "git diff --name-status", and adds a
> header to make it clear the output is informative, and not an error.
>
> It also changes the output of "git add --refresh --verbose" in the same
> way.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

Thanks.  Will queue.

However, I'd change the justification.

    git reset without argument displays a summary of the local modification,
    like this:
    
        $ git reset
        Makefile: locally modified
    
    Some people have problems with this; they look like an error message.
    
    This patch makes its output mimic how "git checkout $another_branch"
    reports the paths with local modifications.  "git add --refresh --verbose"
    is changed in the same way.
    
    It also adds a header to make it clear that the output is informative,
    and not an error.
    
    Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

The output from reset in question is merely an informative side effect, as
opposed to what you actively ask "git diff" to give as its primary output.
As such, your "consistency" argument is pretty weak.  There is no reason
to expect that the informative message to resemble one particular format
(namely, --name-status) and not another (e.g. --stat or --name-only), as
you are not explicitly specifying what format to use; nor we would want to
make it customizable--after all it is just a friendly reminder.

Informative output from "git checkout $branch" when there are local
changes is a much better precedent to refer to.

After applying your patch and having compared these two sets of output:

        (1) without changes

        $ git reset --hard
        $ git checkout mm/reset-report
        Already on 'mm/reset-report'
        $ git reset
        $ git add --refresh -v Makefile

        (2) with changes

        $ echo >>Makefile
        $ git add Makefile
        $ git checkout mm/reset-report
        M       Makefile
        Already on 'mm/reset-report'
        $ git reset
        Unstaged changes after reset:
        M       Makefile
        $ git add --refresh -v Makefile
        Unstaged changes after refreshing the index:
        M       Makefile

I am somewhat inclined to suggest that we should drop the new "Unstaged
changes after ..." message, though.

By the way, "Already on .../Switched to ..." noise from "git checkout" is
also very annoying.  It is useless to report that the command did exactly
what the user told it to do.  Even more annoyingly, "git checkout -q" to
squelch this useless noise also squelches the "here are the paths you have
local changes" reminder, which is much more useful.

But that is a separate topic.
