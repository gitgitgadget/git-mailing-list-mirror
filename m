From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: allow users to silence Git 2.0 warnings about "add
 -u"
Date: Sat, 23 Feb 2013 00:44:47 -0800
Message-ID: <7v621j8lmo.fsf@alter.siamese.dyndns.org>
References: <1361513224-34550-1-git-send-email-davvid@gmail.com>
 <7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com>
 <vpqd2vssnh7.fsf@grenoble-inp.fr> <7v621ks1cf.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7F-wunjT_SS0mw+WUgoM3-Lu9bA3JUKk4sQiWWK0N9Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 09:45:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9AjM-0003wm-7X
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 09:45:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933Ab3BWIov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 03:44:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51596 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754575Ab3BWIov (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 03:44:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EE378D83;
	Sat, 23 Feb 2013 03:44:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g9GcUhGIDBGnuKe44Rf6FzRN3K8=; b=PtdUNZ
	SASTCBnJEZ4FlGawGDESLqLfkxJUbC/BxVD12ZDcLOvUYALVp2PAOer1LCdubgPQ
	3VqnCPvAq1yFgnGlKC6UbLLBtSV83x4jbhFP4aNQHFavnRF/Mcv0jPGKDQhNnHJT
	3BTO4G7Q7+0B48EzPZLikAV2HzC3V/bwxoaDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uMBJd+R+p17W+OK+2V6WM2FezVMA2PwS
	9eBwJ6r0SdICYjAY3WACoujEWwJ08jWKQZ3RT3jHnIVWclzlPWbF4mlDrocErfFz
	hpsJZK2UUBQP+rmKuCcMNuyoCxy7sUzc66tpgqBV8K925+Jlq9aoc+2f2cHlfrk3
	pdgq2gJS25o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2336A8D81;
	Sat, 23 Feb 2013 03:44:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 571378D77; Sat, 23 Feb 2013
 03:44:49 -0500 (EST)
In-Reply-To: <CAJDDKr7F-wunjT_SS0mw+WUgoM3-Lu9bA3JUKk4sQiWWK0N9Jw@mail.gmail.com> (David
 Aguilar's message of "Fri, 22 Feb 2013 23:59:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 48735B42-7D95-11E2-9819-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216893>

David Aguilar <davvid@gmail.com> writes:

> I was originally concerned that "git add -u" was going to die()
> and we would no longer be able to use it without pathspec.
> My concerns were unfounded.
>
> (If I am not understanding this correctly then it is a sign
>  that the draft release notes can be made more clear)

Yes, that is exactly why I asked you to suggest improvements to that
paragraph.

>> Another problem with use2dot0 configuration is that it would invite
>> people to imagine that setting it to false will keep the old
>> behaviour forever, which is against what you set out to do with the
>> patch under discussion.
>
> I agree with both sides.  There's the part of me that wants the 2.0
> behavior now with a config switch for the same reasons as was
> discussed earlier...

If that is really the case and you want the full-tree behaviour, you
would have been using "git add -u :/" already, and then you wouldn't
have seen the warning.

Why do we have this thread then?

The reason may well be "I've heard about the :/ magic pathspec, and
I thought I understood what it does at the intellectual level, but
it has not sunk in enough for me to use it regularly".

The warning, and "you can squelch with either :/ or ." to train the
fingers (not "set once and forget"), is exactly to solve that
problem now *and* *in* *the* *future* during the 2.0 transition
period.

You also said that it often is the case for you that you stay in a
narrow subtree without touching other parts of the tree. If that is
the case, you may *not* want 2.0 behaviour, which forces Git to run
around the whole tree, trying to find modified paths outside of your
corner that do not exist, wasting cycles.  You want "git add .", and
you are better off starting to train your fingers so that they type
that without thinking now.  I think the conclusion during the old
discussion was not "we want configuration", but "this is not per
user and configuration is a poor approach. Depending on what you are
working on right now, you would want 'only here' sometimes and
'whole tree' some other times".

> We would never want to go back to the old behavior when 2.0
> roll around.  Jakub's "future.wholeTree" suggestion makes
> sense in that context as the entire "future.*" namespace
> could be designated as variables with these semantics.

Not at all. Even you who visit this list often do not regularly use
the ":/" to affect the whole tree and see the warning. What do you
imagine other people, who do not even know about this list do and
say, at sites like stackoverflow where uninformeds guide other
uninformeds?

  Q. Help, Git 1.8.2 is giving me this warning. What to do?
  A. Set this configuration variable. No other explanation.

Renaming use2dot0 to future does not solve anything.

> OTOH a positive thing about adding configuration to get
> the better behavior is that the code path materializes
> sooner, and it will be better exercised before 2.0.

That is not an argument for adding temporary configuration, as it is
not the only or even the best way to do so.  It can be easily an
cleanly achieved by cooking in next until 2.0.

An ulterior motive for going that way is to encourage more people to
run 'next' ;-). Recently we are seeing bugs discovered only after topics
graduate to 'master', which is not a good sign X-<.
