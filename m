From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] clone: simplify progress message
Date: Sun, 09 May 2010 15:15:03 -0700
Message-ID: <7vr5lk90yg.fsf@alter.siamese.dyndns.org>
References: <4BE60E89.8010709@pcharlan.com>
 <20100509110221.GA16639@coredump.intra.peff.net>
 <4BE7166A.5030107@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Mon May 10 00:15:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBEmd-0000YI-AA
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 00:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895Ab0EIWPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 18:15:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42061 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0EIWPa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 18:15:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ED22B1BA3;
	Sun,  9 May 2010 18:15:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=8wANeevT5RNmT4VMRErOi52tLrc=; b=YGzirj
	UxKA1sbEo0nI5fv40zGGYuS+wTPQVisZ5DwX5LxYG5zFjPUmKDWfIV3PPSMoIumE
	EBYSHEnbz3kF3vmYjk/LcpmN1sr6hmSzbu0o4VMW3VPpPulIHF5Ev0xMAJFTkxUo
	mg+6aG36Ps7T5bv/lc01HebDNWpYfm91/XVjc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ANAqV9LoIGMgP6c5rvpyb5gmEVeRxjEq
	yKArOyFUeeVB9x5qTUbssN8c4wpu2peHWTl924Jdsa0F31ksNEQl7L3YXAWTKP3Q
	4XUzo43cMxWZtVO3a5M2f6viNsOWoEFrU+OL3rIsqwqWSet9T1/ODuXdE+jSyYks
	b6cydJUuTu4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DFFB2B1BA2;
	Sun,  9 May 2010 18:15:24 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 86DE2B1B9E; Sun,  9 May
 2010 18:15:18 -0400 (EDT)
In-Reply-To: <4BE7166A.5030107@pcharlan.com> (Pete Harlan's message of "Sun\,
 09 May 2010 13\:09\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5DB87FE8-5BB8-11DF-866D-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146752>

Pete Harlan <pgit@pcharlan.com> writes:

> On 05/09/2010 04:02 AM, Jeff King wrote:
>> On Sat, May 08, 2010 at 06:23:21PM -0700, Pete Harlan wrote:
>> 
>>> "git clone foo bar" currently reports "Cloning into
>>> /path/to/bar/.git".  Change this message to "Cloning into bar" to more
>>> closely match the user's expectation.
>> 
>> I am a little torn on this. For most users, it is just another
>> implementation detail that makes git's output more confusing. And it is
>> likely to be the very first git message seen by many people. But at the
>> same time, it is telling you where the repository actually is, which is
>> something that can help users learn about how git works.
>> 
>> I guess it comes down to how much detail we want to show.
>
> For me it isn't only a matter of detail; I find "Cloning into
> bar/.git" misleading, since bar is getting more than a .git directory.

That is also misleading, as cloning is done into bar/.git and everything
else happens locally as part of the checkout.

I didn't want to go into nitpicky details, but you asked for it ;-)

> Pete Harlan (2):
>   clone: have progress report mention top level dir, not git dir
>   clone: add bare clone to the progress message

I think the squashing these two into one patch makes quite a lot of
sense.  Does any of the existing test need adjustments, by the way?
