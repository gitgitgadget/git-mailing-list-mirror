From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Thu, 25 Apr 2013 09:32:03 +0200
Message-ID: <87li87awwc.fsf@linux-k42r.v.cablecom.net>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
	<877gjrpsk4.fsf@hexa.v.cablecom.net>
	<CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 09:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVGf6-0007f5-Us
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 09:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab3DYHcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 03:32:08 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:46277 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754094Ab3DYHcG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 03:32:06 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 25 Apr
 2013 09:31:58 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 25 Apr 2013 09:32:04 +0200
In-Reply-To: <CALkWK0kn7mEosWSdWs1Jjx-L32wmL51W=X7ny9BYQMttG1LPvQ@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 25 Apr 2013 02:24:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222351>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Thomas Rast wrote:
>> I personally think we have enough magic revision syntax to last at least
>> another decade.  If you propose to add some, please make a patch that we
>> can cook in next for a few release cycles and then conduct a straw poll
>> if people actually use it.
>
> Isn't it obviously incredibly useful?  I'm working on a topic branch I
> need to send out to git.git, and I want see how my WIP looks: should I
> have to rebase on master just to see this?
>
> Why such a huge resistance against such a small feature?  Can you
> think of ways in which it is myopic (and therefore a pain to keep
> supporting, if we find it undesirable)?

What's the problem with cooking it for a while?  You can start using it
immediately.  I'm just somewhat annoyed that the syntax is rapidly
converging to Perl-style line noise.

I already hate half of the existing syntax, and I cannot remember using
^! (except while investigating what 'git diff C^!' does and why not),
^@, @{-N} (only the related 'git checkout -'), @{date} and @{relative},
^{}, :/foo, and ^{/foo}, *at all*.

In fact I had to look up the second half of that list on the manpage.

That's not to say that they are not useful for *someone*.  But it does
motivate my suggestion that unless we have tried it and *found* that
someone for a new syntax, let's not make it any more magic.

> On a related note- In my opinion, :/ is broken, because it blocks
> composition completely.  I would've really liked {:/quuxery}~3.

I guess this constitutes an argument in my favor (i.e. that the syntax
is too convoluted to understand and know):

^{/foo} is the same as :/foo, except it properly groups.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
