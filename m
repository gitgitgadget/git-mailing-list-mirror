From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 22:44:27 +0200
Message-ID: <877gjrpsk4.fsf@hexa.v.cablecom.net>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
	<7va9ong9oa.fsf@alter.siamese.dyndns.org>
	<CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
	<7v38ufer2x.fsf@alter.siamese.dyndns.org>
	<CALkWK0m5Q_e3q6Yg94-K+jU_SS7ovR2wnz-_Nr3cMz_YM=SMDQ@mail.gmail.com>
	<CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 22:44:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV6YN-0001Em-VQ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 22:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872Ab3DXUob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 16:44:31 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:23582 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757676Ab3DXUob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 16:44:31 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 22:44:23 +0200
Received: from hexa.v.cablecom.net.ethz.ch (46.126.8.85) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 24 Apr
 2013 22:44:27 +0200
In-Reply-To: <CALkWK0=5tE0pXj-XTe4g9LdCO78yrPNwyom5fupF1WTToY2TZw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Thu, 25 Apr 2013 00:30:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222317>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Ramkumar Ramachandra wrote:
>> I'm also considering making the first
>> argument optional (just git log ~rebase.autostash), and defaulting to
>> mean [nearest fork point].
>
> Actually both can be optional.  In A~B, A defaults to [nearest fork
> point] and B defaults to HEAD.
>
>     git log ~
>
> Isn't it beautiful?

Please don't.  The syntax you propose doesn't work for several reasons,
but do we really need one?  How often would you actually use it?

Ok, since you ask, the reasons are:

* Looking for the nearest fork point is expensive and subject to change
  by simply fetching.  I hope you meant "... and exclude its upstream",
  i.e., A defaults to @{u}, which might be at least somewhat useful.

* ~ is already taken; in your syntax, A~1234567 is ambiguous because
  1234567 can both be a SHA1 and a number of generations to go back.

I personally think we have enough magic revision syntax to last at least
another decade.  If you propose to add some, please make a patch that we
can cook in next for a few release cycles and then conduct a straw poll
if people actually use it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
