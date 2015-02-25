From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Tue, 24 Feb 2015 21:13:04 -0800
Message-ID: <xmqq4mqapo9r.fsf@gitster.dls.corp.google.com>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com>
	<xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com>
	<2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 06:13:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQUHb-0007Dh-KT
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 06:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750771AbbBYFNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 00:13:08 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750703AbbBYFNH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 00:13:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7531B3CA52;
	Wed, 25 Feb 2015 00:13:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8d60HamUPNcUXIHxNQONzw3Feo=; b=Sy5+r+
	0k3ZsolIb0g9vGvxz+3cuagC1vesj9ez0c3drmL4cfXeBk71qmIl+a2DtduSjcti
	c1xX1GcrbIspCK3nwQGAjGMSer4TPB5WSJzJEzinJMxagat43jhfVJbFVfOg0psh
	W2F1PQt91OsjkjjLn2CLBwp23djf8MJsKnnug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p4A72jogOzhz7BTHHwjsuStG8GMaGFnn
	x/AELxv2pB/MTfL2Ye85IGNiqpyGoP5ZsO/Pkiz/kyDBlqLpQnmdmblD9hr/N6Js
	VXYwTK2jQfJQoz0e/z0XgxAWye+ENmLoniVY3VHlb2rruB8X3GDmfpz1UNHLlbPj
	UCizj6amQTc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BD3F3CA51;
	Wed, 25 Feb 2015 00:13:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6D483CA50;
	Wed, 25 Feb 2015 00:13:05 -0500 (EST)
In-Reply-To: <2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com> (Kyle J. McKay's
	message of "Tue, 24 Feb 2015 16:55:26 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB019E56-BCAC-11E4-9BD9-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264367>

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> I can designate ;-), but I do not think I'd be the right person to
>> maintain or long-term-support it.  Are you volunteering to oversee
>> the "LTS team"?
>
> I could not promise a team of more than one member.  And that would
> not be full-time 24/7 either.

Heh. Making noises to find like-minded people would be the first
step to build a viable team, and hopefully you are already doing a
good job here ;-)

>> It would involve:
>>
>>    - Monitor "git log --first-parent maint-lts..master" and find
>>      the tip of topic branches that need to be down-merged;
>>
>>    - Down-merge such topics to maint-lts; this might involve
>>      cherry-picking instead of merge, as the bugfix topics may
>>      originally be done on the codebase newer than maint-lts;
>
> I've been cherry-picking fixes for a while now onto older releases.  I
> don't suppose down-merging would be that much more difficult with a
> fallback to cherry-picking.
>
>>    - Use the tip of the maint-lts branch in everyday work.
>>
>> The last item is the most important of the above, because I do not
>> have time for that.  I can help with the first two to some degree,
>> though.
>
> That's pretty much all I use at this point -- a slightly older release
> with cherry-picked fixes.  While it did cause me to find the problem
> with the first version of the loose alternates fix, having only one
> person use such a release doesn't provide that much coverage.

That is why I used the word "team".

> It occurs to me that if the "maint-lts" updates were limited to crash
> fixes, regressions and security issues then often the pre-built man
> pages and docs from the release it's based on could be used as-is with
> the exception of the new release notes which might save some time.

Cutting release tarballs including the pre-formatting docs might
consume a lot of machine time, but it does not cost me time at all.
I have Makefile for that ;-)

Judging which fixes that have proven themselves to be safe and sound
(by being in 'next', 'master' and hopefully 'maint' for some time)
are worthy enough of down-merging to the LTS track is something I'd
want to farm out to the LTS team.  I am already doing the "safe and
sound" part by deciding which topics to merge to 'maint' among the
topics that have gone through 'pu' to 'next' to 'master' branches,
but not all that are worthy enough to be merged to 'maint' may be
important enough to bother downmerging and updating LTS track with,
and picking which ones matter to the LTS users is what the folks who
are interested in the LTS can help.
