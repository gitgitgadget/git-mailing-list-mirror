From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Formatting variables in the documentation
Date: Thu, 26 May 2016 09:18:17 -0700
Message-ID: <xmqqmvncyera.fsf@gitster.mtv.corp.google.com>
References: <1463587109-22476-1-git-send-email-tom.russello@grenoble-inp.org>
	<20160518181500.GD5796@sigill.intra.peff.net>
	<b06231ac-b100-2565-3bf7-99f268014788@ensimag.grenoble-inp.fr>
	<vpq8tz0hd2g.fsf@anie.imag.fr>
	<20160526043607.GB6756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Tom Russello <tom.russello@grenoble-inp.org>,
	git@vger.kernel.org, erwan.mathoniere@ensimag.grenoble-inp.fr,
	jordan.de-gea@ensimag.grenoble-inp.fr, stefan@sevenbyte.org,
	jrnieder@gmail.com, rybak.a.v@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 26 18:18:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5xzO-0001KF-N2
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 18:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbcEZQSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 12:18:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60211 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbcEZQSV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 12:18:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CD3B01D860;
	Thu, 26 May 2016 12:18:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QJbP7n59z5KARXiXelHkK9892F8=; b=xW5X84
	2cZ107MjSj0TTyEzBfrih0/kTP8IfyB0gkFEMMkIEpR1gG5EVuUksGdKc8BSQBEj
	2c2Spb70JOCW4Avytf1kLHw41PQJpvnKBxI7FtodgxDQkEKhJRP9cgw2NFSQtf1I
	EZVPfY5b5xvrzlcjCfmjf3G1oTfTmVi7Rvs9k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RTRS413mUQinO8kTi6TsEOzvAovQc6oS
	iEGaaAvfOLVCfNcGL2VPY8ON7GHtY20WkCFQD1ML4WohLGL9L/q3CbJDlesGbcc0
	VftmUJaytF2tqjU3pEkn7D0Zy6edkBvmpzzAXvoSooDXPlrmrQlk+0wgTn2tD+pj
	fnyCN71Hsko=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C345E1D85F;
	Thu, 26 May 2016 12:18:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3BD871D85E;
	Thu, 26 May 2016 12:18:19 -0400 (EDT)
In-Reply-To: <20160526043607.GB6756@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 26 May 2016 00:36:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7598D734-235D-11E6-9B80-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295661>

Jeff King <peff@peff.net> writes:

> On Mon, May 23, 2016 at 07:57:43PM +0200, Matthieu Moy wrote:
>
>> Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr> writes:
>> 
>> > Since 2.8.3 was out recently, we could flip MAN_BOLD_LITERAL on by
>> > default for this cycle to shake out problems as Jeff King suggested
>> > [2].
>> 
>> 2.8.3 was a bufix release, and flipping a controversial flag should
>> clearly not be done on a bugfix release. So, in this context, "beginning
>> of a cycle" means after a x.y.0 release.
>> 
>> Anyway, a patch enabling MAN_BOLD_LITERAL by default would need to cook
>> in pu and next as any other patches, so the time when the patch is sent
>> does not really matter.
>
> Yeah, I think a reasonable plan is:
>
>   1. Somebody produces a patch flipping the default. The patch is
>      trivial, but the commit message should tell why, and try to dig up
>      any possible problems we might see (e.g., why wasn't this the
>      default? Particular versions of tools? Some platforms?)

"git log -SBOLD_LITERAL Documentation/" tells me that it's not like
we had this on by default sometime in the past and then we flipped
the default back in response to some problems (which I forgot
about).

I just re-read the two iterations that introduced BOLD_LITERAL:

 * http://news.gmane.org/find-root.php?message_id=<1237881866-5497-1-git-send-email-chris_johnsen@pobox.com>

 * http://news.gmane.org/find-root.php?message_id=<1238136245-22853-1-git-send-email-chris_johnsen@pobox.com>

There was no particular "caveat" raised there to recommend against
using this on particular versions of tools or platforms.  It was
inertia that has kept the new optional feature "optional".

>   2. Assuming no problems, Junio merges the patch to "next". We get
>      any reports of issues from people using "next" day-to-day.

So I can do these steps myself up to this point.  After waiting for
a few days to see if somebody else with better memory tells me what
I forgot, perhaps.

>   3. Assuming no problems, Junio merges to "master". We hit more people
>      (who build from master). And also it would be part of the
>      pre-generated pages that Junio ships, so we might get reports
>      there.
>
>   4. Eventually it's released. We hope to get no problem reports there,
>      though it _does_ hit a wider audience at that point.
>
> Steps 1 and 2 can happen now. As we are in the -rc cycle right now,
> probably step 3 would happen post-v2.9. But there's no reason not to
> start the clock ticking now.
>
> -Peff
