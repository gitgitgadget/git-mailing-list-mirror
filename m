From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixing unclear messages
Date: Mon, 11 Aug 2014 11:21:20 -0700
Message-ID: <xmqqha1i7uqn.fsf@gitster.dls.corp.google.com>
References: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
	<1407683607-4143-2-git-send-email-ash@kambanaria.org>
	<xmqqsil37v4i.fsf@gitster.dls.corp.google.com>
	<CAP6f5MmE4ae81DZu-gbaax4nSh4WMcWCk453wJBfC4mKvmsfxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	jn.avila@free.fr, Xin Jiang <worldhello.net@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>, peter@softwolves.pp.se,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Alexander Shopov <ash@kambanaria.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 20:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGuE0-0004tI-Fb
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 20:21:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbaHKSVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 14:21:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53920 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbaHKSVf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 14:21:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 09D4E30E33;
	Mon, 11 Aug 2014 14:21:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DRp+RmhaxNiieJTxJ3Bv5y8I2F0=; b=p7PwGu
	qKDxGCNk05c0Ei6Z3fAsRbY5KsE+10RfUG++Y+1f+YhGvJDsco+Vk8OgdjGQDgCZ
	ZZctWnh6RHuouDbQ702Bs5r/73A9a2KBzHgqmNaucG0quvOJozP/VnsxS5p9fQxX
	yXeVFGS3KiDEUNtDZiUIXqC2HnB6tomsJkrwk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XBR+d5DTcvcfmFcHYLpr8m5kGRs2MTqd
	KzvWCdLM84iwKzwZ8n255NHuum9ipqNZpKEQUa9g79lSfbtIigkPGAbdlNRCQNnD
	CUBbF/yw9C12yM1zUch+r9E8JArrpKSyF6apsQFczgz5OXQq8+2seUT6UQH/qpl5
	yq49Nr6taB0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F082230E32;
	Mon, 11 Aug 2014 14:21:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 86C0D30E15;
	Mon, 11 Aug 2014 14:21:22 -0400 (EDT)
In-Reply-To: <CAP6f5MmE4ae81DZu-gbaax4nSh4WMcWCk453wJBfC4mKvmsfxA@mail.gmail.com>
	(Alexander Shopov's message of "Mon, 11 Aug 2014 12:13:21 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4C3C0410-2184-11E4-9736-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255126>

Alexander Shopov <ash@kambanaria.org> writes:

>>> -                     printf_ln(_("Huh (%s)?"), (*ptr)->buf);
>>> +                     printf_ln(_("Wrong choice (%s). Choose again."), (*ptr)->buf);
>> Why is this an improvement?
> Because 'Huh?' without intonation, gesture or a frown provided by a
> human being is hard to understand. It does not state that it is the
> choice the user provided is wrong and does not prompt the user for the
> next action.

This is shown in a human-interactive exchange where a menu has
already given by list_and_choose().  If there were something else
"Huh?" could mean after you give a response to that prompt, but I do
not think there is.

> You say that my change does not tangibly improve on an initially
> unclear and already obsolete message, am I right?

Not really.  This is not obsolete (it is a good trick even in
today's world order), but is not teaching anything new to the user
because it has to be issued too late (and there is no way to give it
before the user realizes it is necessary), so it is not "unclear"
per-se, but it does not help much.  If I were asked to say what it
is then, I would say "it reassures".

I do not strongly oppose its removal, but if we were to remove it,
we shold add a comment to the condition of the previous "if"
statement to remind us why no argument with "only" is allowed if
"amend" is set.

> There was a suggestion to have a separate function that is meant to
> echo messages when there are genuine bugs in Git (impossible cases
> happening, invariants breaking, etc.) This will allow factoring out
> the clause "This is a bug in Git. Please report it to the developers
> with an e-mail to git@vger.kernel.org." as a single message and I
> prefer that for ease of maintenance.

Yes, I see the primary value of this thread was to trigger that
suggestion to classify which die()s are BUG()s.

>>> -             die(_("Two output directories?"));
>>> +             die(_("Maximum one output directory is allowed."));
>> Why is it an improvement?
> Because the question only implies that the problem is the number of
> directories but says nothing how many directories there should be (0,
> 1, 3... 100?)

Because I've never imagined anybody would sensibly expect "mv a1
a2... dst1 dst2 dst3..." to work (what does that even mean?  Make N
copies of a$m and drop them into each of dst$n?), I never thought of
such a possiblity.  Trying to help more people is good, unless it
needs to be done by bending backwards, and your rewrite here is
definitely a good one in that sense.

> I am not sure what you mean or your objection would be, perhaps I am
> misreading the source of Git.
> ...
> Does this mean the following changes are totally unwelcome or you

FWIW, I see it as a feature to have small number of messages phrased
in colourful ways, especially the ones that do not require reaction
by the users (e.g. "trivial merge succeeded" does not trigger "oops,
I have to ^C and recover immediately") or the required reaction is
obvious (e.g. "you gave me no X and expect me to work?" can only
mean "ah, I have to give X")

We obviously do not want to overdo it, but the ones we have are all
old ones.
