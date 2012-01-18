From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pulling signed tag: add howto document
Date: Wed, 18 Jan 2012 13:22:09 -0800
Message-ID: <7v62g8n1tq.fsf@alter.siamese.dyndns.org>
References: <7vehuyosaa.fsf@alter.siamese.dyndns.org>
 <7v62g9q55f.fsf@alter.siamese.dyndns.org> <4F16E228.5050203@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 22:22:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rncxh-0007ip-4P
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 22:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132Ab2ARVWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 16:22:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61936 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750709Ab2ARVWN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2012 16:22:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F3DE7A2B;
	Wed, 18 Jan 2012 16:22:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DGevYUiuipO/ybuzz41DfBf1ufE=; b=vALyVA
	Q7GIUqrZ7cVuCfIBYdvWH62VOrvYGEFLHJl6WHf150RMNhrUZQWGLoT777jcB4N+
	3I7VyFHmvy+2mWehp6VxfXJF3sp1Fo/RTcXkSNkYUI63ShO1V9gfpu/GdhkvXYwr
	6ciuLR+Sv3iCtBchKydwSyI7Prr0mTCRQFBBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMJgKxeYVphmjlM1RG7L+94uq9/ZOWvt
	q2u3F68A1si0tfVPY5vJtfMIvb6oAhhYbo7I3we13zt0Kt7uRXlQkfR3b9zRjpq7
	K45FxBBYmnoihKxB8zB7YJ3otlvtamwJUPjfVS2sBF6H4rkCHLw4CwNtYD9eIVrA
	hOueyR7mJtc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 168E27A2A;
	Wed, 18 Jan 2012 16:22:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69C267A29; Wed, 18 Jan 2012
 16:22:10 -0500 (EST)
In-Reply-To: <4F16E228.5050203@xiplink.com> (Marc Branchaud's message of
 "Wed, 18 Jan 2012 10:15:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B621E92-421A-11E1-A3D6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188763>

Marc Branchaud <marcnarc@xiplink.com> writes:

>> +A contributor or a lieutenant
>> +-----------------------------
>> +
>> +After preparing her work to be pulled, the contributor uses `git tag -s`
>> +to create a signed tag [*1*]:
>
> Given that the rest of the text refers to the gist of this footnote, I think
> it'd be better to put the note's text here instead of as a footnote.

Hmm, I'll try to see how well it reads after moving the text here. Thanks.

>> +
>> +------------
>> + $ git checkout work
>> + $ ... "git pull" from sublieutenants, "git commit" your own work ...
>> + $ git tag -s -m "Completed frotz feature" frotz-for-xyzzy work
>> +------------
>> +
>> +and pushes the tag out to her publishing repository [*2*]. There is no
>
> This footnote speaks of the example using a +, but the example does no such
> thing.
>
>> +need to push the `work` branch or anything else:
>> +
>> +------------
>> + $ git push example.com:/git/froboz.git/ +frotz-for-xyzzy
>> +------------

Do you not see the plus in front of +'frotz-for-xyzzy' above, or am I
missing something?

>> +In the editor, the integrator will see something like this:
>> +
>> +------------
>> + Merge tag 'frotz-for-xyzzy' of example.com:/git/froboz.git/
>> +
>> + Completed frotz feature
>> + # gpg: Signature made Fri 02 Dec 2011 10:03:01 AM PST using RSA key ID 96AFE6CB
>> + # gpg: Good signature from "Con Tributor <nitfol@example.com>"
>> +------------
>> +
>> +provided if the signature in the signed tag verifies correctly. Notice
>
> s/if //

Noted.

>> +repository (i.e. `git tag -l` won't list frotz-for-xyzzy tag in the above
>
> s/list/list the/

Noted.

>> +There is no need to fetch and keep a signed tag like `frotz-for-xyzzy`
>> +that is used for frequent "pull" exchange in the long term just for such
>> +auditing purposes, as the signature is recorded as part of the merge
>> +commit.
>
> I had trouble parsing this sentence.  I think part of the problem is that
> it's comparing the actual implementation to an earlier proposed design that
> was rejected.  So it's trying to sell the reader on a feature of the
> implemented design, but the reader doesn't care.
>
> How about this instead:
>
> There is no need for the auditor to explicitly fetch the contributor's
> signature, or to even be aware of what tag(s) the contributor and integrator
> used to communicate the signature.  All the required information is recorded
> as part of the merge commit.

Ok, that is much easier to read.

>> +
>> +
>> +Footnotes
>> +---------
>> +
>> +*1* This example uses the `-m` option to create a signed tag with just a
>> +single liner message, but this is for illustration purposes only. It is
>
> s/single liner/single-line/

Noted.

Thanks.
