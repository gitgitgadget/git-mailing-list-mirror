From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 09:23:50 -0800
Message-ID: <7vvcd9e7rt.fsf@alter.siamese.dyndns.org>
References: <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
 <CAMP44s0SDHVzSd-8Rq7Z1sbiQ6m0pxX+2pgx16_DoWnHeyNsNQ@mail.gmail.com>
 <20121113040104.GA9361@sigill.intra.peff.net>
 <CAMP44s1w3oZhEUM-cnO=kECH2bhdOTGVuKy8JS4uhWFbA_oi3w@mail.gmail.com>
 <20121113074720.GA18746@sigill.intra.peff.net>
 <7vpq3hfpm7.fsf@alter.siamese.dyndns.org>
 <20121113171445.GG20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:24:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKDd-0008PR-6O
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 18:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194Ab2KMRX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 12:23:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58510 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151Ab2KMRXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 12:23:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 594F29BE1;
	Tue, 13 Nov 2012 12:23:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DEcN9mjYLM3y+4SqbTsBHfASUKM=; b=Zw4syZ
	GlDiCmY76Ip+FWNMqZx/0EyuJjcW2Md8h3ZMPSw4pmm3Z+38WSsKyrbO2ePwUm7g
	JQRPB/q84q3xxZQiNK92y5krSQy0odBGI3Fcdrs5CQ5ahFMFhUlpj8ZjTlR8Fbuw
	vFKlN61FjsNmNQ0R7vv3QXQEHY9K9iyHiLnYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDcT811eUQeRY62NyfiFkVNweqjwzmMU
	CNxZ2QHemTpBSjXgv7PD+ntFjp+bisT8ZJkapnhn1ajIOYMww0Dz6oWASLaMOADE
	GQOXNAUx9agye3rDvBDXTUW8b6GIFIneFU5zWZ40EwQvaKsBB9u1IqcYu8+8lyXA
	4zylFk6PwVg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44AC69BDE;
	Tue, 13 Nov 2012 12:23:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F84E9BDD; Tue, 13 Nov 2012
 12:23:51 -0500 (EST)
In-Reply-To: <20121113171445.GG20361@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 13 Nov 2012 12:14:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4923C52-2DB6-11E2-A10D-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209645>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 13, 2012 at 08:13:04AM -0800, Junio C Hamano wrote:
>
>> >> That's right, AUTHOR_IDENT would fall back to the default email and full name.
>> >
>> > Yeah, I find that somewhat questionable in the current behavior, and I'd
>> > consider it a bug. Typically we prefer the committer ident when given a
>> > choice (e.g., for writing reflog entries).
>> 
>> Just to make sure I follow the discussion correctly, do you mean
>> that the bug is that we pick a fuzzy AUTHOR when COMMITTER is
>> specified more concretely and we usually use COMMIITTER for this
>> kind of thing in the first place but send-email does not in this
>> case (I do not see "git var GIT_AUTHOR_IDENT" returning value from
>> the implicit logic as a bug in this case---just making sure).
>
> Having discussed more, I think there are two questionable things:
>
>   1. Preferring author over committer
>
>   2. Failing to fall back to committer when author is implicit or bogus
>      (because "git var" dies).
>
> I think (1) may fall into the "this is not how I would do it today, but
> it is not worth a possible regression" category.
>
> I think (2) might be worth fixing, though. Certainly when the author is
> bogus (by IDENT_STRICT rules), which I think was the original intent of
> the "$repoauthor || $repocommitter" code. Probably when the author ident
> is implicit, though that is more hazy to me.

I agree with both points.  Thanks.
