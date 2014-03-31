From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] test-lib: '--run' to run only specific tests
Date: Mon, 31 Mar 2014 10:09:55 -0700
Message-ID: <xmqqlhvq8fbw.fsf@gitster.dls.corp.google.com>
References: <1395650987-5960-1-git-send-email-ilya.bobyr@gmail.com>
	<1395916370-1404-1-git-send-email-ilya.bobyr@gmail.com>
	<1395916370-1404-4-git-send-email-ilya.bobyr@gmail.com>
	<CAPig+cQeS6PAZN0nN_0LBfnFF_bGxC000cPSQFdSTVaHQD_haw@mail.gmail.com>
	<53351F26.9070007@gmail.com>
	<CAPig+cSDCJ=3BC0dDaJMtfsRx_89z-6knNuRbzY+V3uBXY6xsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, Git List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:10:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUfir-0002ca-O0
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 19:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbaCaRKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 13:10:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44357 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041AbaCaRJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 13:09:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A88B77EEE;
	Mon, 31 Mar 2014 13:09:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h4n0fx6O+eeoA8EcyR3+DQ+3W+k=; b=T4nEz+
	2a+227OV3wsq3fFeJt1RB+CiuTe+A+4PYfR7VqUzgkuGiuPhZ9mKTA9dP9n8xjWZ
	beEEMVvyLUjmtNigcNZJPIXXSkCJWyz5OyKE6woQ9KoD1S8OewSpIRyG+bTTY1bB
	t2He+kiHsEpZjNKuoMVgteCYA8SDuinAzDJaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KDnHzHrT239LL+khZbmUKUqdVbv8QXJ4
	ttzWjsXjcWIHST977aSm3fKNnA4z2L0SX6A5dzHvsSItkc+SKt+IIf8T1GUY2LOZ
	9GNBW6GtFiqbaBLeQQ8/J/AiUcl952LernP+kY2hNpSZjqNVdbq/2k+4AfgpbeGf
	Atm94LQaZqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0486177EED;
	Mon, 31 Mar 2014 13:09:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45FF377EEB;
	Mon, 31 Mar 2014 13:09:58 -0400 (EDT)
In-Reply-To: <CAPig+cSDCJ=3BC0dDaJMtfsRx_89z-6knNuRbzY+V3uBXY6xsA@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 30 Mar 2014 05:41:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 49A151F6-B8F7-11E3-BD65-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245493>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Since the relational operators are fairly self-explanatory, you could
> drop the prose explanation, though that might make it too cryptic:
>
>     A number prefixed with '<', '<=', '>', or '>=' matches test
>     numbers meeting the specified relation.

I would have to say that there is already an established pattern to
pick ranges that normal people understand well and it would be silly
to invent another more verbose way to express the same thing.  You
tell your Print Dialog which page to print with e.g. "-4,7,9-12,15-",
not ">=4 7 ...".  

Would the same notation be insufficient for our purpose?  You do not
even have to worry about negation that way.
