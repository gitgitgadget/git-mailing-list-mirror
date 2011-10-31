From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document 'T' status from git-status
Date: Sun, 30 Oct 2011 21:18:19 -0700
Message-ID: <7vpqhdrdys.fsf@alter.siamese.dyndns.org>
References: <1319933204-21587-1-git-send-email-mjd@plover.com>
 <7vmxcjro5t.fsf@alter.siamese.dyndns.org> <4EADB4DB.5020004@icgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mark Dominus <mjd@plover.com>
To: Mark Dominus <mjd@icgroup.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 05:18:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RKjKi-0008RH-1T
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 05:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016Ab1JaESW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 00:18:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750921Ab1JaESW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 00:18:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EF826937;
	Mon, 31 Oct 2011 00:18:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OB7VWeriZ2xLKfyxx6eflOA/jIc=; b=v0E5un
	ckkY4LhYYG+CJHDUdwKI0PEwuX00ucP24MyICCG25T947QX0sfceXh8ZugaTUIks
	RyOPHFKLKPCV3CyPNCYA1fYEvxr+FI0JDUp/PdHopUUaqQtIqhDYbRW7Z0Q4+whh
	y7Pe7WnMigTlMiudndctHunBOt1RbE7SgUwjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PElG1OAyp7/DJbfmFiju+6SmGhYkN5MO
	VJecedUTMHq7VbeAi62QUPTpoeNRzlkQmcAWQUQNnqE0iyaNuzaB8GmQbz/211ws
	EOd/ZSp1IIwwjf2p3ELGId6MPrXlzAA3AEE+UoYJ75DupoYrSPQTV9iRcb5kQ/IR
	C50o41SgtJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 262176936;
	Mon, 31 Oct 2011 00:18:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACAB26934; Mon, 31 Oct 2011
 00:18:20 -0400 (EDT)
In-Reply-To: <4EADB4DB.5020004@icgroup.com> (Mark Dominus's message of "Sun,
 30 Oct 2011 16:34:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5DC7A37A-0377-11E1-9970-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184492>

Mark Dominus <mjd@icgroup.com> writes:

>> The current organization of this table may need to be rethought, but if we
>> were to keep it, then this change is far from sufficient. For example, you
>> do not explain what XY = TT means.
> Thanks for your response.
>
> I did not try to document that because in my experimenting I was not
> able to produce that situation.

It is trivial if you realize that X is the change between the HEAD and the
index, and Y is the change between the index and the working tree. Most
importantly, no direct comparison between the HEAD and the working tree
gets in the picture.

    $ mv COPYING RENAMING
    $ ln -s RENAMING COPYING
    $ git add COPYING
    $ mv RENAMING COPYING
    $ git status -suno
    TT COPYING

> Will you be applying the alternative patch you suggested, or would you
> prefer that I try to produce one along those lines?

I dunno.

An obvious alternative is to add T next to all occurrences of M in the
table where we say "M is possible", but unless it is accompanied by an
explanation "T is just a special case of M", I suspect the resulting
description would be harder to understand than currently is, and as long
as the reader understands "T is just a special case of M", then there
isn't much point adding T everywhere M appears in the table anyway, so...
