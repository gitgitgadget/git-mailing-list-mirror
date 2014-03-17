From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GSoC Change multiple if-else statements to be table-driven
Date: Mon, 17 Mar 2014 00:31:44 -0700
Message-ID: <7v38ihuvq7.fsf@alter.siamese.dyndns.org>
References: <CAPig+cQu7D3AUghOSUOZBwf5+iHCPkxPbY1WuQmPJk1muCk7tQ@mail.gmail.com>
	<1394742059-7300-1-git-send-email-zhaox383@umn.edu>
	<CAPig+cRF_eQiGugR8TSks5ki375y-5wiQ7HWKyKRudJ5apd4cg@mail.gmail.com>
	<xmqqiorghgaj.fsf@gitster.dls.corp.google.com>
	<CAPig+cSG0YsdTGWWyxWrg+s235qDe7Xr-jXT2mOkpvA6OaGWyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yao Zhao <zhaox383@umn.edu>, Git List <git@vger.kernel.org>,
	Adam <adam@sigterm.info>, Michael Haggerty <mhagger@alum.mit.edu>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 08:30:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPS0P-0007bn-Iv
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 08:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542AbaCQHah (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 03:30:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756205AbaCQHag (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 03:30:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 140C96E255;
	Mon, 17 Mar 2014 03:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IXQeb/sIzJmnyJBePI3KcbUNe38=; b=lTkxvr
	w4/F4NYUalNehJ5BeEXd/h0k4VpENxOyjrnlFlhfRK+08EbLsayL+EuWw0uCbrs1
	7OWMdOiBn7YEOiK01dVctBdKAg2H7znezmSANY3VZqafQenylXWWKJu7u7DvM9af
	/Jiq6zy2w3BZUJlieyBuuuLZ10JiAhYuCHUek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rL4asx8kqN7QlJjy2jS4y0MDVNHD6PkK
	id7WLmyiAjB30MYKXgQwzHCytG2p3EhrkJ6cy0uaxCdel0UsODa6HuIT81eAfCZC
	EgHhrfu3j/+S5IBCGmIMAFAM5Gu/Tn2lZcwGgXZMO56gT3LfNAqUSaG9lFnn24L0
	vodas2MhrAw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2E2D6E254;
	Mon, 17 Mar 2014 03:30:35 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E7CF6E250;
	Mon, 17 Mar 2014 03:30:35 -0400 (EDT)
In-Reply-To: <CAPig+cSG0YsdTGWWyxWrg+s235qDe7Xr-jXT2mOkpvA6OaGWyg@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 17 Mar 2014 02:29:10 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 076338BA-ADA6-11E3-AC9A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244227>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Perhaps it is time to mark this microproject as "taken" on the GSoC
> page [2], along a fews others for which we have received multiple
> submissions.
>
> [2]: https://github.com/git/git.github.io/blob/master/SoC-2014-Microprojects.md

I actually have been of multiple minds on this.

 * After seeing that many candidates tried to solve the same micro,
   apparently without checking answers by other people, and seeing
   how they responded to the reviews given to them, I found that we
   had as equally good interactions with them to judge their skills,
   both techincal and social, as we would have had if each of them
   solved different micros.

 * Many reviewers may have gotten tired of seeing many novice
   attempts on the same micro over and over again, giving gentle
   suggestions for improvements. Because the _sole_ purpose of these
   micros were to help candidates get their toes wet in the process,
   duplicated efforts on the candidates' side are not wasted---they
   each hopefully learned how to interact with this community.

   But it is true that, if we were wishing to also get some trivial
   clean-ups in the codebase as a side effect of these micros, we
   have wasted reviewer bandwidth by not having enough micros, and
   reviewers may have had some feeling that their efforts did not
   fully contribute to improving our codebase, which may have been
   discouraging.

   Big thanks go to all reviewers who participated despite this.  If
   we had more micros, the apparent wastage of the reviewer efforts
   might have been avoided.

 * Many candidates did not even bother to check if others are
   working on the same micro, however, which would be a bad sign by
   itself. Concentrating on one's own topic, without paying any
   attention to what others are working on the same software, is
   never a good discipline.

   Some may argue that it would be unfair to blame the candidates on
   this---they may have picked up micros that haven't been solved if
   we had more---but after seeing that many candidates' submissions
   apparently did not take into account the reviews given to others'
   submissions on the same micro and/or had many exactly the same
   issues like log message styles as submissions on other micros
   that have already been reviewed, I personally do not think they
   are blameless.

So in short, yes it would have been nicer if we had more micros than
candidates, but I do not think it was detrimental for the purpose of
these micro exercises that multiple candidates ended up attempting
the same micro.

Again, Big Thanks to Michael for the excellent "micro" idea, and all
reviewers who participated.
