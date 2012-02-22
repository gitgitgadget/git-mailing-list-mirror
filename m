From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: added git-diffall
Date: Wed, 22 Feb 2012 13:06:14 -0800
Message-ID: <7vzkca8to9.fsf@alter.siamese.dyndns.org>
References: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
 <7vd397g8ic.fsf@alter.siamese.dyndns.org>
 <CAFouetiLmK3dXLRkBh+cTNA_OMPS77xo8z95WK5y4tk-o-UUog@mail.gmail.com>
 <7vbooregj6.fsf@alter.siamese.dyndns.org>
 <CAJDDKr72rPqp1z-12Ht3Q2UaeUVFutKwoOgkD1G+SbhsBs+p1A@mail.gmail.com>
 <CAFouetgyYRKT7h1h4hv40Kxp=ibq1Hw-1mzFe6DsyAUknXKyYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 22:06:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0JOI-00020Q-Hj
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 22:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab2BVVGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 16:06:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60615 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab2BVVGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 16:06:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89DEB6F99;
	Wed, 22 Feb 2012 16:06:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sIp9KWDz49wCXnZmRIMiwpIZmuM=; b=GYnl+g
	RsEx8rU0YUWbAtyWiHhA7ZNwFNFurc+BlJuwxUr2YanuNCUbq9q2dDY2bnZBqrSm
	FgJ3fzYodlJlMi1Jw/Pq4LOzMkmQVczXMUKAXjCex77ymynhVfYGZchiabITC/DW
	uRn9q/eZRWGSMDPBojoKxxY6os4pSF92TN2jw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sOzEjMdDwAPcJIJrjKZLl9oYKOtmm+9V
	9OBpbskraqJ8G1YUXicZB+/jtb673k9cVAiSRO6NHs5Z3sR4TwJS5OfwOm2xoHsd
	xhLZxg/zlgJEUXlrobQTMmC9cN5V5GRmbmdXV/OoDlB/wwIQ7l1MC1kUwlzJgPpS
	e4VaV2e9Uk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8172C6F98;
	Wed, 22 Feb 2012 16:06:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 130E16F96; Wed, 22 Feb 2012
 16:06:15 -0500 (EST)
In-Reply-To: <CAFouetgyYRKT7h1h4hv40Kxp=ibq1Hw-1mzFe6DsyAUknXKyYQ@mail.gmail.com> (Tim
 Henigan's message of "Wed, 22 Feb 2012 15:14:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F006A84-5D99-11E1-858B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191291>

Tim Henigan <tim.henigan@gmail.com> writes:

> I have not heard back from the user, but I tested on Ubuntu earlier
> today.  I found that when using an older version of the script
> (fbedb7a in the GitHub repo), I could repeat the error.  It is the
> 'git-diffall' script that fails silently, I believe due to a bash-ism
> that was fixed in a subsequent commit.

Thanks.

That would explain it, especially given that you've been doing:

> For what it is worth, since that bug was originally reported, I have
> been running "checkbashisms" [1] on the git-diffall script.  That
> utility reports that the script is clean.

The checkbashisms scritp is interesting ;-)

I do not get much of the comment removal and string munging that happen
before it really start to check the contents for bash-isms, but most of
the check logic contained within the %foo_bashisms seem to be looking for
the right kind of mistakes people who are too used to bash make very
often.
