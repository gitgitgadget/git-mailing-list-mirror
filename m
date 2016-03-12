From: Max Horn <max@quendi.de>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Sat, 12 Mar 2016 10:11:15 +0100
Message-ID: <006DA180-E4B6-404E-9377-F2BB41F65591@quendi.de>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org list" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 12 10:15:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aefe9-0004x5-LK
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 10:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbcCLJL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 04:11:27 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:53778 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750702AbcCLJLU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 04:11:20 -0500
Received: from ip-178-201-28-152.hsi08.unitymediagroup.de ([178.201.28.152] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	id 1aefZs-0003Ke-5M; Sat, 12 Mar 2016 10:11:16 +0100
In-Reply-To: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3112)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1457773880;169130b0;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288729>


> On 11 Mar 2016, at 00:04, Junio C Hamano <gitster@pobox.com> wrote:
> 
> A release candidate Git v2.8.0-rc2 is now available for testing
> at the usual places.  It is comprised of 459 non-merge commits
> since v2.7.0, contributed by 60 people, 19 of which are new faces.
> 
[...]

> Updates since v2.7
> ------------------
> 
> UI, Workflows & Features
> 
> * It turns out "git clone" over rsync transport has been broken when
>   the source repository has packed references for a long time, and
>   nobody noticed nor complained about it.
> 
> * "branch --delete" has "branch -d" but "push --delete" does not.

This states a problem, but not whether (and how) it was resolved?

[...]

> * Across the transition at around Git version 2.0, the user used to
>   get a pretty loud warning when running "git push" without setting
>   push.default configuration variable.  We no longer warn, given that
>   the transition is over long time ago.

That last sentence sounds weird... perhaps "the transition was completed a long time ago" ? Or "the transition ended a long time ago" ?

> 
> * README has been renamed to README.md and its contents got tweaked
>   slightly to make it easier on the eyes.
> 
> 
> Performance, Internal Implementation, Development Support etc.
> 
> * Add a framework to spawn a group of processes in parallel, and use
>   it to run "git fetch --recurse-submodules" in parallel.
> 
> * A slight update to the Makefile to mark "phoney" targets
>   as such correctly.

phoney -> phony ? (it seems in british english you can write "phoney", but according to a quickly Google search this is rarely used in relation to Makefiles; no surprise, given that the corresponding syntax element is ".PHONY" and you are not allowed to spell it differently ;-)

[...]

> 
> * Some calls to strcpy(3) triggers a false warning from static
>   analysers that are less intelligent than humans, and reducing the
>   number of these false hits helps us notice real issues.  A few
>   calls to strcpy(3) in test-path-utils that are already safe has
>   been rewritten to avoid false wanings.
> 
> * Some calls to strcpy(3) triggers a false warning from static
>   analysers that are less intelligent than humans, and reducing the
>   number of these false hits helps us notice real issues.  A few
>   calls to strcpy(3) in "git rerere" that are already safe has been
>   rewritten to avoid false wanings.

The above two messages are very similar, only the end differs a bit. Perhaps
merge them into one? I.e.. "A few calls to strcpy(3) in test-path-utils and "git rerere" that [...]"

Also: wanings -> warnings

[...]

> 
> * Asking gitweb for a nonexistent commit left a warning in the server
>   log.
> 
>   Somebody may want to follow this up with an additional test, perhaps?
>   IIRC, we do test that no Perl warnings are given to the server log,
>   so this should have been caught if our test coverage were good.

That last paragraph seems odd for a changelog?

[...]

> * The underlying machinery used by "ls-files -o" and other commands
>   have been taught not to create empty submodule ref cache for a

have -> has (the machinery is singular)





Cheers,
Max