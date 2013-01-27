From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] mergetools: Make tortoisemerge work with
Date: Sun, 27 Jan 2013 09:48:55 -0800
Message-ID: <7vzjzuwm7s.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
 <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de>
 <51024B02.9020400@tu-clausthal.de>
 <CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
 <5102837C.9000608@tu-clausthal.de> <7v622l5d87.fsf@alter.siamese.dyndns.org>
 <51032E96.2040209@tu-clausthal.de>
 <CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
 <5104F009.5020606@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sun Jan 27 18:49:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzWM5-00032N-Hu
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 18:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754159Ab3A0RtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 12:49:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46394 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496Ab3A0Rs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 12:48:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D07F2C607;
	Sun, 27 Jan 2013 12:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=McFwKsgm1ag4gldjOkPk+9P6r8s=; b=fsVa3x
	YFVgHNzO9cMQg3KQlxF9WZ2ER3q71slfSrLM3PvHON1+Zvm9fCE1vgZ1PPUR+l04
	pyzUdG8gR0fjFqCLyYlY5n2BBl60eA3u3NdfhLUjPaBv47BssGLdTQBAmapxel0f
	0oJhqsFcShnQ1FMluE1zePxqu7tzjjUQoBRSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aojdJnB1LbA22y4fD43V1ZfFBxpkNb3E
	TDgbUNeLcFRuDl01DNEVlkjTXPuWulDUDRuGXJYbcM5BEaHR//AhvuGCQXyyhexp
	S/9TtRDwCNZk1qn2Ji7aa8UyiZSKjMF6D9gSjSG/bVPaLyn+dqGqNuYa6/B25BmZ
	JRtc4sidWNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C558CC606;
	Sun, 27 Jan 2013 12:48:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 348BAC5FF; Sun, 27 Jan 2013
 12:48:57 -0500 (EST)
In-Reply-To: <5104F009.5020606@tu-clausthal.de> (Sven Strickroth's message of
 "Sun, 27 Jan 2013 10:14:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2EFFF38-68A9-11E2-AC5E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214710>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 26.01.2013 08:10 schrieb David Aguilar:
>> These patches look correct (I do not have the tool to test)
>> but I think we should fixup this commit message.
>> 
>> How about something like...
>> 
>> mergetools: Teach tortoisemerge about TortoiseGitMerge
>> 
>> TortoiseGitMerge improved its syntax to allow for file paths
>> with spaces.  Detect when it is installed and prefer it over
>> TortoiseMerge.
>
> This message implies, that I have to combine two patches again?!

We can see that [1/2] teaches mergetool to use tortoisegitmerge when
the user tells it to use tortoisemerge and the former is available.

The change in [2/2] is to use -base "$BASE" instead of -base:"$BASE"
when the real tool is tortoisegitmerge (when it is tortoisemerge,
nothing changes).

By reading these two patches, I would imagine that tortoisegitmerge
can accept both forms, i.e. -base:"$BASE" and -base "$BASE", but the
patch [2/2] considers that the latter form is preferrable in some
way.  As you talked about "paths with SPs in them", I would imagine
that is the difference?  That is -base:"$BASE" form will not work if
the varilable $BASE has a SP in it (even though it is encolosed in
dq, which does not make much sense from my POSIXy point of view, but
perhaps command line argument processing in the Windows land may
have different rules) but if you write -base "$BASE" then "$BASE"
will be taken as a single thing even it has a SP in it?  Also I
would guess that the reason why patch [2/2] does this only for
tortoisegitmerge is either because tortoisemerge will break paths
with SPs even if it is given -base "$BASE" form, or because it only
accepts -base:"$BASE" form? I cannot read it from your description,
but let's assume that is the reason.

If that is the case, then the log message for the second patch would
be easier to understand if it says so in a more explicit way,
perhaps like this:

	TortoiseGitMerge, unlike TortoiseMerge, can be told to
	handle paths with SPs in them by using -option "$FILE" (not
	-option:"$FILE", which does not work for such paths) syntax.

	Use it to allow such paths to be handled correctly.

But I cannot read exactly why the patch [2/2] considers -base "$BASE"
is preferrable over -base:"$BASE" from your original description, so
this may well be way off the mark.

In short, I think proposed log message for [2/2] was not clear what
is being fixed and how.
