From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sharedRepository derived from file permissions
Date: Mon, 08 Oct 2012 09:46:43 -0700
Message-ID: <7vhaq4nc7g.fsf@alter.siamese.dyndns.org>
References: <1210080955590.12283@wes.ijneb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Hills <mark@pogo.org.uk>
X-From: git-owner@vger.kernel.org Mon Oct 08 18:46:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLGTo-0000Wz-RL
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 18:46:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094Ab2JHQqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 12:46:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37707 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823Ab2JHQqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 12:46:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90F97986A;
	Mon,  8 Oct 2012 12:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=e5BdDU+HBI0KP+h4BgDNCoyGGJE=; b=sFuqdA
	dCqkDHOuJFNmHxr8EEp2axt/cIFgE7waiW13U9PWF9iFcAwepFljKjN+rNDdZX5E
	U+zkwUNb3WXMIRmzIF4AWoY9ypO3tndYpYZltAb/aTv9teOfvUUfcUUqllgkD1cw
	GT8e+50/JG2E0V0UBXJyEH4Q/V5TEDvaFz3Do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iODalm74IBfIwY3GHZAnEJKfULvBvwLr
	+VV4pcsJy5whVxmaW1tG+xMfKOqrb9ZzLO6T5TZC16qIxWwXv1PYDdr1WcpnDBPr
	gboRLcjPnPrfAdHJCGq+ONlYp3D2Qbuo34+b/Wm3g02shCgh9BrOdn28iySzAQy9
	Csvdbdg+0qU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DD6F9869;
	Mon,  8 Oct 2012 12:46:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED94E9868; Mon,  8 Oct 2012
 12:46:44 -0400 (EDT)
In-Reply-To: <1210080955590.12283@wes.ijneb.com> (Mark Hills's message of
 "Mon, 8 Oct 2012 10:07:30 +0100 (BST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE7EA44E-1167-11E2-9D63-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207240>

Mark Hills <mark@pogo.org.uk> writes:

> We make extensive use of unix permissions and core.sharedRepository -- 
> multiple developers push to the same repo.
>
> I have often wondered why core.sharedRepository is needed at all as a 
> separate configuration?
>
> It looks like it might be easier (and less confusing to users) to derive 
> this attribute from the top-level .git directory?

Hrm, clever ;-)

> Is there a reason why Git doesn't just follow (and echo) the top-level 
> permissions?

Other than "we did not trust that all the end users are capable of
doing the right 'chmod 2775 .git && chgrp project .git", with a
little bit of "we didn't think of that when we wrote the system", I
do not recall any.
