From: Junio C Hamano <gitster@pobox.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Wed, 07 Sep 2011 04:21:04 -0700
Message-ID: <7vwrdk4mzj.fsf@alter.siamese.dyndns.org>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kyle Neath <kneath@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 18:16:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Knw-00008z-CE
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 18:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253Ab1IGQQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 12:16:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756246Ab1IGQQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 12:16:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BEB05961;
	Wed,  7 Sep 2011 07:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xUp/cNR3ilPBbjbUVuUjjyIwigo=; b=fVF00A
	Hyn4AylmwmtRovWTQIsALjtvXuZEx0GRRDEvPSgDcWzq/yxBE2ittV+vnYAOnrmp
	7xlWkE73TROHRm1r73/ZtCVH2euEjYSFpI72LxdKAISbGsEW17K1j4BzjDoi3ISU
	whv+efaE74WgW+EbESwXGC9qtFGnH+l1tN0aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i3xoJIOAVHO3/bG7PxmhdyCBxDESTFkN
	igSzDumcMDZPAOm+1H6hhyy4Xb13wlfVwUhwU60jFW187aG/hcbhammU/77QxOD0
	NxUKCcO3JRTOPol36I6s/4RimdoYV3koWBL1IOd7MPJ313110YKIeAnPcmCo3z4J
	djAFcx6ewOc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 63A475960;
	Wed,  7 Sep 2011 07:21:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D3771595E; Wed,  7 Sep 2011
 07:21:05 -0400 (EDT)
In-Reply-To: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com> (Kyle
 Neath's message of "Tue, 6 Sep 2011 22:33:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A4BA432-D943-11E0-A1F4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180861>

Kyle Neath <kneath@gmail.com> writes:

>> * jk/http-auth-keyring (2011-08-03) 13 commits
>> ...
>>
>> Looked mostly reasonable except for the limitation that it is not clear
>> how to deal with a site at which a user needs to use different passwords
>> for different repositories. Will keep it in "next" at least for one cycle,
>> until we start hearing real-world success reports on the list.
>>
>> Not urgent; will not be in 1.7.7.
>
> This is very disheartening to hear. Of all the minor changes, bugs, and
> potential features, I believe that http credential caching is the absolute
> most important thing that git core can do to promote adoption. I've believed
> this for more than a year now and I'm incredibly disappointed that it's being
> shelved for yet another release.

You are misreading the message utterly wrong that it is not even funny.

If this were a new, insignificant, and obscure feature in a piece of
software with mere 20k users, it may be OK to release a new version with
the feature in an uncooked shape. The feature may turn out to work only in
a very limited scope but not general enough to accomodate other needs you
did not anticipate, and your next version may have to fix it in a backward
incompatible way, forcing existing users to unlearn what the initial
uncooked design and implementation gave them, but by definition such an
insignificant and obscure new feature in a system with a small userbase
wouldn't have been used by too many people by the time you have to fix it,
and the extent of the damage is limited.

Git is not that piece of software with only 20k users, and a lot more
importantly, credential caching API is not a feature in an insignificant
and obscure corner of the user experience. We have to have at least a warm
fuzzy feeling that the API is right from the start so the plug-ins people
write for our initial version and the data its users will accumulate with
it will not go to waste by hastily releasing a version with an uncooked
design and implementation.

"Not urgent" is not "Not important". Quite the contrary, it is important
enough that we cannot afford to be hasty.

See http://thread.gmane.org/gmane.comp.version-control.git/180245 for an
example of how a discussion can be done to help us get closer to the warm
fuzzy feeling of getting the API right in a more mature manner. Don't feel
too bad if you become ashamed of the rant you wrote contrasting with that
exchange. It is a sign that you are learning.

> Then again, perhaps the fact that we spent development time hacking around
> git's limitation is a data point in itself. Git GUI developers are spending
> development time to fill a hole in git core.

Welcome to open source. Do not expect others to scratch every itch of your
niche. Think of it as an opportunity granted to you to make a difference,
not as a roadblock somebody else threw at you because they hate you.

Be thankful, not whiny.

Be good.

Have fun.
