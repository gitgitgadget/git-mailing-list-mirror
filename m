From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-svn and mergeinfo
Date: Thu, 01 Sep 2011 09:00:05 -0700
Message-ID: <7vfwkgxnga.fsf@alter.siamese.dyndns.org>
References: <20110829132052.0ad7a088@robyn.woti.com>
 <4E5F4987.5040205@alum.mit.edu> <20110901104327.14d4dba6@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 18:00:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz9gh-00037C-JR
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 18:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529Ab1IAQAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 12:00:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56652 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932452Ab1IAQAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 12:00:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CF34417A;
	Thu,  1 Sep 2011 12:00:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fxpA2o5UmprPUf7d8YC245EnXPM=; b=hqgypZ
	TVjEtjr07GyEwBsSfB2COnE5MjvlJPnukFYSgnlDh8yIg0XNzJ5fowxBqr6/l/gr
	TqlhHFxXpsVSd/e8ypR/zuriEaJK07K6Y9SF1SfgGup11HZliD6Cr8c8QOnWDAIc
	GNy5Wj5C7kZEppsWNYrXpNOHp+1Gzus8Yl4PA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AhGVZGhGpdxaIsfZpFTeuJoV33ZLvmKl
	Xi1mb2mEyeBH/0BDN5S/oe4yS6G1PZu7KGIyf2DOH7pexduzl0geai15T6/FSRSq
	CGjRiojmkeYNqe0EeFoldIxhP1wbRIL+iyCyhWcxSTp71RLu9aTRauzjxe5xCqLS
	FMdzs+f/Ndg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84F184179;
	Thu,  1 Sep 2011 12:00:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78E8D416B; Thu,  1 Sep 2011
 12:00:07 -0400 (EDT)
In-Reply-To: <20110901104327.14d4dba6@robyn.woti.com> (Bryan Jacobs's message
 of "Thu, 1 Sep 2011 10:43:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76E2D8F4-D4B3-11E0-9365-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180536>

Bryan Jacobs <bjacobs@woti.com> writes:

>> Naive question: why can't you pass a newline (properly quoted, of
>> course) directly within the string argument to the --mergeinfo option?
>
> The only way I know of to do that in bash is to assign the
> newline-bearing string to a variable, and then use the variable in a
> command line option. Extremely awkward.

Hmm, I think Michael meant by "properly quoted" something like this:

    $ git commit -s -m 'Fix blorb
    > 
    > As it stands, blorb feature is totally broken for such and
    > such reasons. Fix it by restructuring frotz and nitfol to
    > use the same xyzzy helper function.'

which is not all that awkward, even for a free-form text argument like
commit log. In this case, you are talking about svn merge-info that is a
lot more structured (it is much less likely to see a single-quote in there
than my commit log message example above, for example) so...
