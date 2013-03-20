From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: Alias pushurl from push rewrites
Date: Wed, 20 Mar 2013 07:35:58 -0700
Message-ID: <7vk3p2gmup.fsf@alter.siamese.dyndns.org>
References: <20130318220224.3b23a381@hoelz.ro>
 <20130318231043.GD5062@elie.Belkin> <7v38vsma9o.fsf@alter.siamese.dyndns.org>
 <20130319015541.GH5062@elie.Belkin> <7vwqt3i7p9.fsf@alter.siamese.dyndns.org>
 <5149AC88.9090206@hoelz.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	josh@joshtriplett.org
To: Rob Hoelz <rob@hoelz.ro>
X-From: git-owner@vger.kernel.org Wed Mar 20 15:36:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIK7z-0004VY-40
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 15:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab3CTOgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 10:36:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40052 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752024Ab3CTOgC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 10:36:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFC8C9886;
	Wed, 20 Mar 2013 10:36:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uwsw4mNI5ZOj1BR/U6VDRxP8Hgk=; b=dm94ZZ
	0fuLtUqa8RttbayIkJlJj3bgoRRlMFl2VWy/iI6TyAC829PQxrFIUfOJGrcCwNQw
	zWbVAa/5ofiyWj/5/5FBu69JOJ1zbV8RRlD+n9gVW5FYBYrJy6DVhwgcL1PkdH78
	AQ6YbQ6Wblx1r33hV8EwbjBKma6qWgsMb2g3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jk1/85L0RR7Ag3vMBnDmHbhrliXjSVbf
	h41BWqaFCyBlRpZvyPMQlp2WTdRC/oBJsl3MJuTtFYkuyRQuBOxy4bWDWPZhAszN
	EGlWQeNlfH00SH7iqWP7/cIW1oe/8CaC6wH4x/cp0Kr5NCBWFbAzhBWhTGa2haN9
	S6HAW4/LY/o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B415D9885;
	Wed, 20 Mar 2013 10:36:00 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D19A9884; Wed, 20 Mar 2013
 10:35:59 -0400 (EDT)
In-Reply-To: <5149AC88.9090206@hoelz.ro> (Rob Hoelz's message of "Wed, 20 Mar
 2013 13:33:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7BE45730-916B-11E2-BC27-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218609>

Rob Hoelz <rob@hoelz.ro> writes:

> On 3/19/13 7:08 PM, Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Junio C Hamano wrote:
>>>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>>>> Test nits:
>>>>> ...
>>>>> Hope that helps,
>>>>>
>>>>> Jonathan Nieder (3):
>>>>>   push test: use test_config where appropriate
>>>>>   push test: simplify check of push result
>>>>>   push test: rely on &&-chaining instead of 'if bad; then echo Oops; fi'
>>>> Are these supposed to be follow-up patches?  Preparatory steps that
>>>> Rob can reroll on top?  Something else?
>>> Preparatory steps.
>> OK, thanks.  I'll queue these first then.
>>
> Should I apply these to my patch to move things along?  What's the next
> step for me?

You would fetch from nearby git.git mirror, find the tip of
Janathan's series and redo your patch on top.  Perhaps the session
would go like this:

    $ git fetch git://git.kernel.org/pub/scm/git/git.git/ pu
    $ git log --oneline --first-parent ..FETCH_HEAD | grep jn/push-tests
    83a072a Merge branch 'jn/push-tests' into pu
    $ git checkout -b rh/push-pushurl-pushinsteadof 83a072a
    ... redo the work, perhaps with combinations of:
    $ git cherry-pick -n $your_original_branch
    $ edit t/t5516-fetch-push.sh
    ... and then
    $ make test
    $ git commit
