From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cherry picking and merge
Date: Wed, 06 Aug 2014 16:20:55 -0700
Message-ID: <xmqqvbq5kxwo.fsf@gitster.dls.corp.google.com>
References: <51C01AAA-3CFB-4110-BAE9-7D04CA8EE53A@comcast.net>
	<20140801200201.GS12427@google.com>
	<20140801205040.GT12427@google.com>
	<CAK3OfOhbJJqLB4yPbuJyufytxNUSBLzKF6axc4jeU7eAjvXtgA@mail.gmail.com>
	<53E25090.7010803@gmail.com>
	<xmqqzjfhky3j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nico Williams <nico@cryptonector.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Stump <mikestump@comcast.net>,
	git discussion list <git@vger.kernel.org>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 01:21:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFAW7-0007Ry-PK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 01:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbaHFXVH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2014 19:21:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51510 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885AbaHFXVF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Aug 2014 19:21:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 06B7330D68;
	Wed,  6 Aug 2014 19:21:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=k/L8xyyd45ql
	kiUGiHNU5a0NKa4=; b=NZx3xiCCP78uGm5NOxnGOHKFQ6O/PU9KnP8fgih7Hca4
	Ossuhcx2T0zsgUMD7WV0kfg+B3sX3tsMDx7akFGRuo1mSdvmjZkW0epqh0avgych
	3yHGWQT/XQP+0fDvfaJPpmBqrWqrj1dihZsGxTUJMqbYqS9dKnsfsKOZpoKaGDU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ovNp5P
	tt1L1zDV3QkkpFAGWLgVvIaFh8T2qnb0czOUgGbCal2t6n7vzMp/C5DEUajQbQcn
	Jd3GsvThf+LcH7OdnEa0nHbFV88NuO3D4I1PT4IY1pnHbLzY+IeM6b9AlcJklfWp
	Dd/9e5d7l2emOInKqcrWZFe6BXrhKaX7wu26o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EF93A30D67;
	Wed,  6 Aug 2014 19:21:04 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B3BFB30D60;
	Wed,  6 Aug 2014 19:20:57 -0400 (EDT)
In-Reply-To: <xmqqzjfhky3j.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 06 Aug 2014 16:16:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 522B7350-1DC0-11E4-919A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254914>

Junio C Hamano <gitster@pobox.com> writes:

> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>
>> There was (long time ago) a long thread about idea of adding some
>> kind of 'weak' references (links), 'weakparent' that can be
>> automatically used by Git but do not pollute the commit message,
>> and do not affect reachability calculations.  Ultimately it went
>> nowhere (as you can see) - there were many problems.
>>
>> For example: how it would work for reverts and rebases?
>
> Perhaps some digging in the list archive before typing is in order.
> This may be a good starting point.
>
> http://thread.gmane.org/gmane.comp.version-control.git/46770/focus=3D=
46799

Here is another.

http://thread.gmane.org/gmane.comp.version-control.git/19126/focus=3D19=
149
