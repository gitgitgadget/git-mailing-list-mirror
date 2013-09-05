From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Thu, 05 Sep 2013 16:13:35 -0700
Message-ID: <xmqqob86g8v4.fsf@gitster.dls.corp.google.com>
References: <926222C46F2240BDA71A004633E8DB7E@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Christian Couder" <chriscool@tuxfamily.org>,
	<git@vger.kernel.org>, "Thomas Rast" <trast@inf.ethz.ch>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Sep 06 01:13:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHikF-00011d-Ka
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 01:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786Ab3IEXNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 19:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42104 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698Ab3IEXNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 19:13:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C3613FDEC;
	Thu,  5 Sep 2013 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bji3R/wT5Jqs/GeVkdEdGeXrVEo=; b=thM9rj
	77eNccX/MluijTWCEJyWxgqBSsL9hh6zz+W1OsAaucut3zZCdl5HOVVl6PHxacCx
	MUjGTe+r6X3qT84M9mrLDnpGyVeHZaN1McEG9c2ihtpryzv9H8pDeSsPbCICQfjG
	+8zRCj7lzydDZ923CxmxOe96WvaYVueL273Ic=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nJZ+akH72VLd5/5sxqnW0U7Rl3zKPLqf
	rvEaNeryPmnla87rYEe+xDRs/wTQ+YA3MWksAR2GrX3nhk+vWr7YOB9YiYRiyZDU
	0BTpcn+GL7kfifAJtRLqQV/l25rekgAbI75verAKk6fDtG/jGblwM3TnSM5pMrm/
	q3aea8+Sdaw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EE773FDEB;
	Thu,  5 Sep 2013 23:13:41 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6A933FDE0;
	Thu,  5 Sep 2013 23:13:37 +0000 (UTC)
In-Reply-To: <926222C46F2240BDA71A004633E8DB7E@PhilipOakley> (Philip Oakley's
	message of "Thu, 5 Sep 2013 23:20:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CC0F0666-1680-11E3-8E7E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234001>

"Philip Oakley" <philipoakley@iee.org> writes:

> From: "Philip Oakley" <philipoakley@iee.org>
> Sent: Saturday, August 31, 2013 11:16 PM
>> From: "Christian Couder" <chriscool@tuxfamily.org>
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> ---
>>> Documentation/git-replace.txt | 4 +++-
>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-replace.txt
>>> b/Documentation/git-replace.txt
>>> index 736b48c..a2bd2ee 100644
>>> --- a/Documentation/git-replace.txt
>>> +++ b/Documentation/git-replace.txt
>>> @@ -21,10 +21,12 @@ replaced. The content of the 'replace'
>>> reference is the SHA-1 of the
>>> replacement object.
>>>
>>> The replaced object and the replacement object must be of the same
>>> type.
>>> -There is no other restriction on them.
>>> +This restriction can be bypassed using `-f`.
>>>
>>> Unless `-f` is given, the 'replace' reference must not yet exist.
>>>
>>> +There is no other restriction on the replaced and replacement
>>> objects.
>>
>> Is this trying to allude to the fact that merge commits may be
>> exchanged with non-merge commits? I strongly believe that this
>> ability to exchange merge and non-merge commits should be stated
>> _explicitly_ to counteract the false beliefs that are listed out on
>> the internet.
>>
>> It's probably better stated in a separate patch for that explicit
>> purpose to avoid mixed messages within this commit.
>>
>
> Not sure how this method of preparing a comment patch will pan out..
>
> --->8----

Make it "--- >8 ---" perhaps to balance out the perforation on both
sides.

> From a0c0e765cfd969c9c8a6ff3a2cb6b2f1391d2e7d Mon Sep 17 00:00:00 2001

Not needed nor wanted.

> From: Philip Oakley <philipoakley@iee.org>

Not needed but does not hurt.

> Date: Thu, 5 Sep 2013 22:54:04 +0100

Is OK but redundant given that your message has a timestamp when we
saw your patch for the first time anyway.

> Subject: [PATCH] Doc: 'replace' merge and non-merge commits
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
>
> This is supplemental to Christian Couder's 'replace' patch series
> (2013-09-03 69dada4 (Christian Couder): t6050-replace: use some long
> option names).
>
> It adds the clarification that merge and non-merge commits are
> replaceable.
>
> Merges are often treated as special case objects so tell users that
> they are not special here.

I think the last paragraph deserves to be in the proposed commit log
message proper.  It explains why it is a good idea to have the added
line in the documentation very well.

> ---
> Documentation/git-replace.txt | 1 +
> 1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/git-replace.txt
> b/Documentation/git-replace.txt
> index 414000e..f373ab4 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -26,6 +26,7 @@ This restriction can be bypassed using `-f`.
> Unless `-f` is given, the 'replace' reference must not yet exist.
>
> There is no other restriction on the replaced and replacement objects.
> +Merge commits can be replaced by non-merge commits and vice versa.
>
> Replacement references will be used by default by all Git commands
> except those doing reachability traversal (prune, pack transfer and
