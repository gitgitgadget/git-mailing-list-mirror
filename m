From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please revert e371046b6473907aa6d62b7862a3afe9d33561e1
Date: Wed, 06 Jun 2012 10:41:18 -0700
Message-ID: <7vfwa8mj7l.fsf@alter.siamese.dyndns.org>
References: <m24nqoohss.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Wiegley <jwiegley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 19:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScKEd-0006b3-7s
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 19:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104Ab2FFRlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jun 2012 13:41:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44553 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932097Ab2FFRlV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2012 13:41:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC8998376;
	Wed,  6 Jun 2012 13:41:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LdQAV7y5CZT3qd+tgjinITyN5Ws=; b=WW3pFr
	hu0MdpUMdNDQg80KQjWGjt4NGFzuLdnzOFD/aMgbIduef+Xszsnjj6mCQpM/+//X
	x3B/BCzUHqjZlQWIAIM7QLWwFXlgT96PmpBM5EothkEB6Jn3hqVcZi9LGyEAV/j4
	IQ+XarwBFLqDFUfc8TzhX/ozrb5cX0XtLstk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qb5Uy8jdkmrrBtJOCEZnjcpAR/AQI04G
	CYA2e8QANbtrY/t3Kau9WSr7gCrlAqB/QIz6P37HmhyVsNTsdfprDcN45Rpac4jM
	8mEX29SFJFH4XPeNaOuDhqb8Tzy9sEpGxYuL+gU7heM7sUWPYJ14sEyubqIcAbKM
	jNHV9ZPHL24=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2F4F8375;
	Wed,  6 Jun 2012 13:41:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 44CEA8373; Wed,  6 Jun 2012
 13:41:20 -0400 (EDT)
In-Reply-To: <m24nqoohss.fsf@gmail.com> (John Wiegley's message of "Wed, 06
 Jun 2012 05:28:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3832AEC-AFFE-11E1-93EC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199340>

John Wiegley <jwiegley@gmail.com> writes:

> I've spoken to the author of this commit, Matthias Urlichs.  Here is an
> excerpt of our conversation:
>
>> On Sat, 2012-04-21 at 00:08 -0500, John Wiegley wrote:
>> > Just wanted to let you know that this bit me.  I have a client whose CVS
>> > repository I'm converting to Git, and they have _many_ log messages that
>> > are larger than 32k in size.
>> 
>> Feel free to submit a patch that reverts this. These days, there's probably
>> no user of cvs2git left, but at that time it was important to get the same
>> commit IDs back.
>
> This just needs to be reverted:
>
>     git revert e371046b6473907aa6d62b7862a3afe9d33561e1

That ancient commit does two things, and one thing that it claims to
do does not have anything to do with 32k limit.

Please send in a patch that exactly addresses the issue (it is
unclear if you want to keep or drop the removal of trailing
whitespaces that is done by that commit).  The proposed log message
needs to justify why breaking other people's repositories that were
converted by an ancient version of cvs2git is lessor of two evils
(the other one being logs longer than 32k are not kept for you).

Thanks.
