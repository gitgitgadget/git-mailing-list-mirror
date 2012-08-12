From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] git p4: fix branch detection with --use-client-spec
Date: Sun, 12 Aug 2012 12:30:57 -0700
Message-ID: <7vpq6vgb66.fsf@alter.siamese.dyndns.org>
References: <CANWnr5aqswATTM9_Zyw=w_x01=e8CqoCsn0Ybee0XvGSJ3F_yw@mail.gmail.com>
 <20120811165143.GA2004@padd.com> <7v4no8hgc0.fsf@alter.siamese.dyndns.org>
 <20120812140449.GA5635@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Korich <matthew@korich.net>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 21:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0dsu-00028f-Pn
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 21:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab2HLTbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 15:31:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55461 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752366Ab2HLTbA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 15:31:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A4B060C9;
	Sun, 12 Aug 2012 15:30:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sv3v6FCvvYnFQuElZ0a53qz2Y9Q=; b=ODdfeE
	FpywxwopBT/GqnlR6+6PpSKAs503JdY/Dp38q8QRapoP3qPwDZ5o4AFlhKCjatye
	eLs2o743JfhqVnhwAhx2kup2+SAthZE30Ph772xYvZWqfGOuqf0xyOyjGm4SnB5a
	GcOjHDCMG7PvVznpRDIbM9RotRmtMzI7TCrG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RTgC7F7frRK+ETVu3pFX7bixytSOUNic
	4F4qZz9KqCI0aBsAwDTdC4NJJeIfP3NV5Oc9tfc4OwLRFw4e/C15Ohg+kwjPqUJs
	RV5u26J8LN2uDa8X+LPOBVYcxW4d/f1tCleOx2daCR+TDxAGwpZzUDDVJnJibva1
	aqZS2lpW6GM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8408760C8;
	Sun, 12 Aug 2012 15:30:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E167D60C7; Sun, 12 Aug 2012
 15:30:58 -0400 (EDT)
In-Reply-To: <20120812140449.GA5635@padd.com> (Pete Wyckoff's message of
 "Sun, 12 Aug 2012 10:04:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3E5C6178-E4B4-11E1-90BE-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203314>

Pete Wyckoff <pw@padd.com> writes:

>> The description for [PATCH 5/5] blames v1.7.9-rc0~4^2~1, which tells
>> me it is the latter.  And if that were the case, and if this were in
>> the area of the system I oversee, I wouldn't push it to the upcoming
>> release at this late in the cycle, when I do not know what other
>> things it might break while fixing this bug (in other words, a fix
>> to an old bug is not an execuse to introduce a regression).
>> 
>> But git-p4 is not in my area, so if you meant this should go in the
>> upcoming 1.7.12 release, I'll queue them directly on 'master'.
>> 
>> Please tell me what your preference is.
>
> Good point about "already released bugs".  I confirmed it was
> broken in 1.7.11 too, so there's no reason to rush this fix into
> 1.7.12.  If you could queue it up in pu, that would be great.

OK, I've done so already last night when I wrote my message but
haven't pushed the result out yet.

Note (primarily to other people) that the above exchange does not
mean "a fix to an old bug is automatically disqualified during the
rc freeze period".  If the fix is so focused and obvious that there
is no way the change inadvertently and negatively affects other code
and introduce a new bug, it is perfectly fine to apply the fix any
time.  I don't know git-p4 well enough to tell if this five patch
series was in that "obviously safe" category myself, so I asked Pete
to decide it for me.

Thanks.
