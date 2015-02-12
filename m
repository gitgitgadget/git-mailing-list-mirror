From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Keep original author with git merge --squash?
Date: Thu, 12 Feb 2015 12:18:51 -0800
Message-ID: <xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
	<20150212092824.GA19626@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:18:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0Dz-0004AB-2j
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbbBLUSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 15:18:55 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751099AbbBLUSy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 15:18:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9DAFA3700C;
	Thu, 12 Feb 2015 15:18:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aGVYBzqFspt+R4EuKsIRU6M+igM=; b=O3I3EL
	t5NxEbQ589bkeF8sVHnpcfhcEqOowVWp/KwLDZjU4Vg6W3Nb4W7QnErJ1GO2hnyP
	Av3Q3duX483rZJsnSWBbiP6q5+LZvNjPHiFvG0UmpngjnCMx3/pgecL3gMLaZn8X
	EazC492kLrbj9FbEbt6nNUmPI9OtyEPu5Bc94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lnInWMYJjothR09wr2CEZmXkQkG6HgBL
	wv9EGPeAIIUwzsOa/NY1dT2jI1dvSejXuUEftf3tZCjrIriKUrPc7f6jAojhpPpd
	YmRnDbF/8rAkv6VW/FPpk1Je3a9vIAdwWXMSVZW8QT6ev0tEobKP2xk2sf7cca7w
	et7uPfzzs40=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 93B1D3700B;
	Thu, 12 Feb 2015 15:18:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12B2F3700A;
	Thu, 12 Feb 2015 15:18:52 -0500 (EST)
In-Reply-To: <20150212092824.GA19626@peff.net> (Jeff King's message of "Thu,
	12 Feb 2015 04:28:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5D0DA85A-B2F4-11E4-AEC9-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263762>

Jeff King <peff@peff.net> writes:

> On Wed, Feb 11, 2015 at 09:21:04AM -0800, David Glasser wrote:
>
>> (I'm not sure if this should be a flag to --squash or to commit.
>> Maybe `git merge --squash`; `git commit --use-squashed-author`?  Seems
>> like it should be not too hard to implement; SQUASH_MSG is pretty
>> parseable.  Or just a config value.)
>
> It sounds like "git commit -c" is close to what you want, which will
> pull the author and commit message from a particular commit. But I don't
> think there is a convenient way to name the commit in your case (it is
> likely to be the first commit on the branch you are squash-merging, but
> there isn't a shorthand for that).

I thought David was primarily interested in the case where a branch
authored by a single person, so specifying the tip of the branch
being "merged" would be sufficient, no?
