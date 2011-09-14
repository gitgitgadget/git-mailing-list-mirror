From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Survey] Signed push
Date: Wed, 14 Sep 2011 13:40:28 -0700
Message-ID: <7vwrdasvr7.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <4E7101F3.1090204@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Andy Lutomirski <luto@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Sep 14 22:40:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3wG4-0007WX-DY
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 22:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291Ab1INUkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 16:40:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933235Ab1INUkb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 16:40:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE7E4499D;
	Wed, 14 Sep 2011 16:40:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ywcM/Et7xEWDysgpEN/1JsMT2N4=; b=lKPqEQ
	UGh1q4t3Co39P5YMtktFCQNz77GB44zn3s2aUZrdCv74nVjqORCOV/XiVhISKP+O
	pVOV17wx/S+i33+5OO5LLClek0KQmXzN2Ez7fD1gmqVbw2FnB2XCLjXI6gceW3MK
	hZEd6lL0f6vcLLpnIXzjnQU8CwAJeF0VCumOg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BzGvoVeOFyzzRM6mFAJrNKvosqIarug0
	qD4JkcW9z5BjZNMJPXE4pEj2WqDZhPYZ4m4GHla7b40MjZrDu4tSo7NRMtlP8Pt9
	4ao6BJeXhXbpa0DI5v+8JRdEqhSa7/7+ecCWOwSpIg3OP1PFZ2VpkV4aQxBH8Ovq
	upmrYjgk3yQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D5830499C;
	Wed, 14 Sep 2011 16:40:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3549B4996; Wed, 14 Sep 2011
 16:40:30 -0400 (EDT)
In-Reply-To: <4E7101F3.1090204@mit.edu> (Andy Lutomirski's message of "Wed,
 14 Sep 2011 12:35:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C9173BAC-DF11-11E0-9B1C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181397>

Andy Lutomirski <luto@MIT.EDU> writes:

>> An alternative that I am considering is to let the requester say this
>> instead:
>> 
>>     are available in the git repository at:
>>       git://git.kernel.org/pub/flobar.git/ 5738c9c21e53356ab5020912116e7f82fd2d428f
>> 
>> without adding the extra line.
>> 
>> That is, to allow fetching the history up to an explicitly named commit
>> object. This would only involve a change to fetch-pack at the receiving
>> end; just match the commit object name given from the command line against
>> the ls-remote response and ask upload-pack to give the history leading to
>> it....
>
> I would love this feature on the pull/fetch interface, but for a
> completely different reason.  Sometimes I want to pull a particular
> object (usually a commit, but sometimes just a tree or blob) from
> *myself*, and having to stick it on a branch is annoying.

I am afraind that it is not going to happen; see

    http://article.gmane.org/gmane.comp.version-control.git/181317

for a rationale.
