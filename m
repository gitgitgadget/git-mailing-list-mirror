From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] format-patch: Add a signature option (--signature)
Date: Wed, 16 Jun 2010 09:53:54 -0700
Message-ID: <7vwrtygbq5.fsf@alter.siamese.dyndns.org>
References: <1276578039-25023-1-git-send-email-bebarino@gmail.com>
 <DB1710D5-1699-45C2-8884-5D60C5240ED9@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Jun 16 18:54:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOvsT-0007lh-Iu
	for gcvg-git-2@lo.gmane.org; Wed, 16 Jun 2010 18:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759273Ab0FPQyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jun 2010 12:54:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759262Ab0FPQyF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jun 2010 12:54:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F3D9EBC62A;
	Wed, 16 Jun 2010 12:54:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zoOhmsUVVqeiPnJdQfi/88J53ow=; b=jNSiuq
	7ya8za9YC4OtMn6/L2g9cU87MiRWU+7i9XkyXGHV1JJ1ZkfQYsX8y1NfFmWNx1da
	f9jXG6b/LKdMQM2phQOgu5bwOQ7pPVcembZAVcuHoKTjyBYj9fdNjD/aEiYvexcE
	tJ0TJjhRys2AjJifrBsY8lkVBfVqsKjV19GAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fE6/8n0aiHEDRGuq/eW1OnbKMcpl2AHk
	Dq7e9dzZpP1oF+0qw6tSkoN5ADO6XcaLrA1VDIGpp+vxD6POQif5p1XOPwcwoPCq
	P0sWK6h50TfMZmdL9dQkFGEtL4HdjWur2i5u8KOa1sZZmDWfUPG9qEPDEmO5u6eo
	Xqphu3PM26Q=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEA74BC628;
	Wed, 16 Jun 2010 12:54:00 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEB6DBC61F; Wed, 16 Jun
 2010 12:53:56 -0400 (EDT)
In-Reply-To: <DB1710D5-1699-45C2-8884-5D60C5240ED9@mit.edu> (Theodore Tso's
 message of "Wed\, 16 Jun 2010 09\:13\:09 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C31B65CC-7967-11DF-B617-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149265>

Theodore Tso <tytso@MIT.EDU> writes:

> On Jun 15, 2010, at 1:00 AM, Stephen Boyd wrote:
>> 
>> This does modify the original behavior of format-patch a bit. First
>> off the version string is now placed in the cover letter by default.
>
> I don't know how important people will feel this to be, but I've occasionally
> found it interesting to see how many people are using various different
> versions of git in a particular development community, and having the
> version in the signature is a useful gauge on that.

The original motivation of the version signature was exactly that ;-).

> Putting it in the cover
> letter isn't really a complete substitute for this because many patches
> and short patch series go out without cover letters...

I think you misread Stephen, he misspoke, or I misread the patch.  The
intention of the change as I understand it is to put the signature in the
cover letter, in addition to the patches.

One bad thing about having the "signature" line at the end of patch is
that various third party tools mistake it as one extra deleted line.  One
offender that is most often seen to corrupt patches is Emacs diff mode.
Doing an equivalent of "recountdiff" after it allows the user to edit a
patch is fine, but it doesn't bother to remember what was in the original
and what was added/deleted by the user, and instead seems to just recount
the result from scratch.
