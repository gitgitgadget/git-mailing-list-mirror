From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Sat, 22 Sep 2012 13:16:57 -0700
Message-ID: <7vobkx3j9i.fsf@alter.siamese.dyndns.org>
References: <505CCA55.6030609@gmail.com>
 <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
 <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
 <20120921211217.GA24134@sigill.intra.peff.net>
 <CALkWK0nLLEF7wnUhF0JUAZVP6GG3KHmuYSDZLPS7uGCZPfhV3w@mail.gmail.com>
 <m2k3vn9gyu.fsf@igel.home> <7vhaqr3t6j.fsf@alter.siamese.dyndns.org>
 <CALkWK0kxmD_HJtnV0ShSdpgSjoLQHtv0=b4s=utG52zFLb2Bjg@mail.gmail.com>
 <7vwqzm3bhf.fsf@alter.siamese.dyndns.org>
 <CALkWK0nTWQ3g75fN5wQLwgeW986vAzGdXajSGCY5SdpK8W=0aA@mail.gmail.com>
 <CALkWK0kWJ3ndEMGzyGGMEa+ko3BTShC7_o-HVsXzFCGwRem5Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 22:17:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFW8W-0007D4-8M
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 22:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab2IVURB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 16:17:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41901 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab2IVURA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 16:17:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABC3282E8;
	Sat, 22 Sep 2012 16:16:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DwYnzgG+JWLdpJYjv7S5djkV/Tc=; b=rN+/j3
	vCGk9ynPnGCEvpsMd4liIqP7nIoEHfyz7M9bIewaR3xK2lgzFUWVzUKCp7Zh4lH7
	5EmvOaEMr5V+mqDgOxbSoTeJXcWlVEPcuNCupFeGq9GM5xwUz4zwGN46Uxps61Xq
	6Lr6nj2aq2IBWCAn3a1MciG3LAYKbE27D8k9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8ooYM/bRWLAJ0abzHIYc9Eqr8OlANyc
	sixtab12khSTrisGe3shF3Zjx657EQhqXSRsL6S7dl0h+63lXi8w8R1GDyNpwKJb
	+V+5oQ26QSiWdHOXUEBbIUg8K23026ZyybeQ1xMvauLhUAIEm1CgAXS7UsYCAJt4
	9vOkO62t0C4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 954B382E7;
	Sat, 22 Sep 2012 16:16:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E798D82DF; Sat, 22 Sep 2012
 16:16:58 -0400 (EDT)
In-Reply-To: <CALkWK0kWJ3ndEMGzyGGMEa+ko3BTShC7_o-HVsXzFCGwRem5Jw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Sat, 22 Sep 2012 10:27:01 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 766696A2-04F2-11E2-AFAA-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206211>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Here's a patch.
>
> -- 8< --
> From: Ramkumar Ramachandra <artagnon@gmail.com>
> Date: Sat, 22 Sep 2012 10:25:10 +0530
> Subject: [PATCH] test-lib: do not trust $SHELL
>
> Do not trust $SHELL to be a bourne-compatible shell.  Instead, use the
> Makefile variable $SHELL_PATH.  This fixes a bug: when a test was run
> with --tee and $SHELL was set to ZSH, $PATH on line 479 was not
> getting split due to ZSH not respecting $IFS.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---

The part that this starts letting run, which the original "Re-run
the command under tee as early as possible" wanted to avoid running,
does not affect anything that would affect how we run that tee magic
(e.g. "mkdir -p test-results" will still create it directly inside
the directory the test script was started in), so I think this patch
is safe _for now_.

However, it forces people who need to update earlier parts of this
script to be extra careful; it has been true before the patch, and
the patch makes it even more so.

I am not opposed to queuing this as an interim solution, but I
wonder if we can get rid of that double-launch altogether.

Instead of re-launching the script with its output piped to "tee",
can't we do the same by redirecting our standard output to the file
in the file, and spawn a "tail -f" that reads from the file and
outputs to our original output?  Something along the lines of:

        mkdir -p test-results
        tee_base=test-results/$(basename "$0" .sh)

        # empty the file and start "tail -f" on it ...
        : >"$tee_base.out"
        ( tail -f "$tee_base.out" ) &
        tee_pid=$!
	trap 'kill $tee_pid; exit' 0 1 2 3
	# ... and then redirect our output to it
        exec >"$tee_base.out"

and wrap it in a shell helper function that is called from where the
parsing of the command line arguments for "--tee" happens, and don't
forget to kill $tee_pid when we exit.

Hrm?
