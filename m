From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/8] gitweb: Faster and improved project search
Date: Thu, 16 Feb 2012 12:40:54 -0800
Message-ID: <7vmx8iy0ix.fsf@alter.siamese.dyndns.org>
References: <1329338332-30358-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 21:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ry88Z-0006bS-JY
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 21:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044Ab2BPUk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 15:40:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752349Ab2BPUk5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 15:40:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4FF4665E2;
	Thu, 16 Feb 2012 15:40:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2BUcgNoLpzbzPZjIiqVFfw5sHyk=; b=C2GOgh
	I+soC8FL9HkLkJR05XSjdmqyyzBv21rO9csd51zU1Oe54fteL82Ksh6S8lAkG06o
	qoIs5nNwHeZ8XiA1HoyIePT6G/tyUKccPOJU6W3PzKn0VSsXyKsdWM8fvLARIy2+
	9tUmNNcrK8t3MTSAx9cgHWncZ4YwZr4pnDtEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sm1ld4FHoInJjxz8TYyWxjjuGFmmRy4o
	wAiE6FbwXWqa2G2v5xtJ4OjaxbKCeTGDU+dXjzVd0PjSmK/OZvIzxvibDMQH7RHU
	ZFHNZXIdUjx6UogkNSu211ip5QGUzDSKrWU8TulYTCMy1RzkRoqGcUUk/I64y9SB
	BWz8oqM+kxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 481A165E1;
	Thu, 16 Feb 2012 15:40:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C560D65DE; Thu, 16 Feb 2012
 15:40:55 -0500 (EST)
In-Reply-To: <1329338332-30358-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 15 Feb 2012 21:38:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 865F2CE2-58DE-11E1-B763-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190908>

Jakub Narebski <jnareb@gmail.com> writes:

> [Cc-ing Junio because of his involvement in discussion about first
>  patch in previous version of this series.]
>
> First three patches in this series are mainly about speeding up
> project search (and perhaps in the future also project pagination).
> Well, first one is unification, refactoring and future-proofing.
> The second and third patch could be squashed together; second adds
> @fill_only, but third actually uses it.
>
> Next set of patches is about highlighting matched part, making it
> easier to recognize why project was selected, what we were searching
> for (though better page title would also help second issue).
>
> Well, fourth patch (first in set mentioned above) is here for the
> commit message, otherwise it could have been squashed with next one.
>
> Last patch in this series is beginning of using esc_html_match_hl()
> for other searches in gitweb -- the easiest part.

Notice that you never said anything about what you wanted to achieve with
this entire series?  " -- the easiest part." does not mean anything.
The easiest part of what?

Where in the series do the "faster" and "improved" come from?  What do you
exactly mean by "faster" and "improved"?  In which commit would we find
the answers to the questions like:

 - What operation was slow and how you tackled that slowness?
 - What are the benchmark results?

In general, "improve" is such a loaded word (after all, patches sent to
the list are almost always meant to "improve" things) that it almost does
not convey a single bit of information.  Are you fixing bugs?  Are you
tidying up an unreadable piece of code?  Are you fixing styles?  Are you
producing prettier output?  Are you refactoring cut-and-pasted repetition
into a common helper function?  Are you adding a new feature?
