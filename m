From: Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH] docs: Clarify what git-rebase's "--preserve-merges" does
Date: Tue, 31 Mar 2015 12:13:23 +0300
Message-ID: <87lhidlebw.fsf@javad.com>
References: <CAHGBnuO5Y=ejJLxktk0GsnXx8h2LwPW1i7TqDePhfZ_zLR_X9A@mail.gmail.com>
	<xmqqd23vzkon.fsf@gitster.dls.corp.google.com>
	<871tkblapv.fsf@javad.com> <55147D27.1060204@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 11:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcsEo-0005Ts-AY
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 11:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbbCaJN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 05:13:28 -0400
Received: from mail.javad.com ([54.86.164.124]:32922 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbbCaJN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 05:13:26 -0400
Received: from osv (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id DAD41618C9;
	Tue, 31 Mar 2015 09:13:24 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84)
	(envelope-from <sorganov@gmail.com>)
	id 1YcsEd-0005pr-4U; Tue, 31 Mar 2015 12:13:23 +0300
In-Reply-To: <55147D27.1060204@kdbg.org> (Johannes Sixt's message of "Thu, 26
	Mar 2015 22:41:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266517>

Johannes Sixt <j6t@kdbg.org> writes:

>> Junio C Hamano <gitster@pobox.com> writes:

[...]

> The patch was discussed here:
> http://thread.gmane.org/gmane.comp.version-control.git/198125
>
> The reason that this has not progressed any further is this response
> in the thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/198125/focus=198483
>
> where you basically say that a --first-parent mode is good, but it
> should be separate from --preserve-merges. I haven't made up my mind,
> yet, how to proceed from there.

As far as I can see, there are 2 separate issues:

1. How to calculate the set of commits to rebase.

2. How to rebase merge commits.

Can we leave (1) for a while at its current state and focus on (2)?
Johannes's patch contains a fix for that: use cherry-pick to recreate
merge commits instead of trying to re-merge. Could this change be
accepted alone, as a known fix for current buggy behavior of loosing
user changes in merge commits?

-- Sergey.
