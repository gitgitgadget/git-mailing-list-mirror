From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Small rerere in rebase regression
Date: Wed, 25 May 2016 07:38:12 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605250710340.4449@virtualbox>
References: <57434572.6030306@kdbg.org> <xmqqy4708ss0.fsf@gitster.mtv.corp.google.com> <57437693.3030106@kdbg.org> <xmqqk2ik77cr.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1605241510370.4449@virtualbox> <5744B00D.4020006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 25 07:38:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5RWk-0002sG-7x
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 07:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbcEYFii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 01:38:38 -0400
Received: from mout.gmx.net ([212.227.15.18]:49885 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbcEYFih (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 01:38:37 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lj1Cw-1bgQEl31m2-00dDOm; Wed, 25 May 2016 07:38:29
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <5744B00D.4020006@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:I/XUoKsL7sNhV9Y8SQC70jp5zjvTuziHL7U4lSEWvaZMdgwPD86
 +rg9V36Hrt7ns2N99cJF3oEoEmUe4pfi44sx4U+ARWsrwOhIP1ZIoVYkOQ1qhQgEN8yK2TM
 VXaln3yqvL8DNakNhCFN4nXbkomYF/Xq2vuXRblx5BL0o/QeksqNh96qFlN8r0UryxaGRwi
 jiqU9yEBMDZBz12/v6fzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:53kdUFUGkvw=:F0dHapqafYLq4UODeS7f5q
 WVZI65Hp6NZ9K1auJCaGemTpcUdbsP02lYNpwtqX3+lVGT6w7BbcExNpyOOpwbffQmZfZ/R+w
 Gf8wibmOnDU14fyVfuJDH6hhx+jZ8h3OBLSJ4iIDE7fjmiUhYNgRUhglaYJ+uCjrq+03JKEMg
 PnNIRNYHTGwdYco6/zWNX3ss+jFBTUUy7CitqQhZhR6JrbG6Lc4ps83AjOem7PsY2yHUixsH9
 UEu4EGVQscTP9nBszBG4rZu5OLGUkgaT3g8wjClft/bg1vDOvBI6XhKYLdVKxX6aKMy3CTrMG
 OW3vqtHeKeqC3a7z2TcPpZ+mKaswJ/1+PyX6gmw76k88YjQbRYxRKT/uK3Njx+nPl6xANmHPF
 GUEkPOB0dhXQ1cxh7XiHQ7HF4/EKdjh9NCPAFOL4mtNNpD7K/sp/bbVJSegeTtKEGk9n/W9JK
 rzp7QqdS5OJWCPdqMhl722y7I22erxU4qPw/fuXkhEIEwOP1jEQGVCYQWAZMGeIefN/4pL7Yv
 6tTTMnK7j86R10451Jzg85lh6X+LZ29gjA9A7RUMhtWV43vcgbSKUNmIibc7jU2Nagyy/To04
 jRXpxIodOhTkVuT/iiQiuevlbtmQi4wnffsagyJ1lRPbRQ+Yhr3FKqlmHGbOBzK6bOqB8n4c1
 L/N3zHtn5wHgI1j0y8rF/geEjeomIPLbpdHu3QtBegH2c2a8isq9qCcuLLXEn27VU8PLFzD0z
 I+Q356VRlLLgM5fAZmwZy0/Lh1Wt5kyRnSpXTb9lLf0Sz6Ozf/ngoe7E4zuxU3EDI4Fe2chP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295560>

Hi Hannes,

On Tue, 24 May 2016, Johannes Sixt wrote:

> Am 24.05.2016 um 15:18 schrieb Johannes Schindelin:
> > Hannes, could you quickly test whether
> > https://github.com/dscho/git/tree/interactive-rebase calls rerere twice,
> > too? (Please call interactive rebase with the GIT_USE_REBASE_HELPER=true
> > to avoid running the interactive rebase twice.)
> >
> > I have a hunch that it does not call rerere twice, which would be a nice
> > bonus in that patch thicket
> 
> It prints the message only once:

Thanks for confirming.

> Could not apply fa62fea... mastergittest@master|REBASE-i 1/1:1008> 5~
> 
> (Take note of the missing LF at the end of the message.)

Oops. Good catch, thank you! I just fixed this:

	https://github.com/dscho/git/commit/0393d7bb2d

> Can this result be interpreted as another indication that the "git rerere"
> call in die_with_patch can be removed, or are the two git-rebase
> implementations too different to be comparable?

The code used by the rebase--helper is not *quite* the same as the entire
cherry-pick code path. For one, we run the sequencer directly, without any
of cherry-pick's option parsing.

Having said that, yes, we inherit sequencer's rerere() call that was part
of cherry-pick originally ever since aa1a011 (Make cherry-pick use rerere
for conflict resolution., 2008-08-10) (amd which was moved to
builtin/revert.c in 81b50f3 (Move 'builtin-*' into a 'builtin/'
subdirectory, 2010-02-22) and refactored out into the sequencer in 043a449
(sequencer: factor code out of revert builtin, 2012-01-11)).

I did notice that rerere() call when implementing rebase -i's
functionality in the sequencer, and dropped the extra call in
error_with_patch() (the libified version of rebase -i's die_with_patch
function).

In short: yes, the explicit `git rerere` call can be dropped, that is
essentially what I did in the rebase--helper branch.

Ciao,
Dscho
