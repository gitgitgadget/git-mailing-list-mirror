From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Pull is Evil (was: Re: A failing attempt to use Git in a centralized environment)
Date: Wed, 30 Apr 2014 07:55:21 -0700
Message-ID: <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>
	<536106EA.5090204@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 16:56:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfVvV-0005e7-86
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 16:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759183AbaD3Oz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 10:55:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52077 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759179AbaD3Oz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 10:55:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECDB882BF8;
	Wed, 30 Apr 2014 10:55:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rsvAmyJgFPg6MOotIgZKysijrGI=; b=XY282N
	t1X+xR7NAq2LjatGxgGLyysAu2c0mCZIa+XwoyKSBhSeVsIefvZSa5W7t2AIlxJg
	obcvaItwZq4KcHEhoA6Wuo96fbjcSQCi1xhzMNY0+gVqg96zVoK6tqg8UJqPuNP3
	UyWXrUBFyxmcGX5nX+ztbXI8PYda9tRHKLZfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PEbGahOR5IctGeJY+r5lpUakFIxSUCHo
	YKDuzEtvMLyPt0xCeTYYlLLAw0CMi9Xz3rQKSyP64Fts25ztlZpUFQX7O6j/uJ7c
	xHHYHBu3564RaV1vTEzcClvKsuK/AH+bdOHfNCaChklHsiokp6W5Cz1b5B19fOSZ
	CxreYOcj7AQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D176382BF7;
	Wed, 30 Apr 2014 10:55:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54C5482BBF;
	Wed, 30 Apr 2014 10:55:23 -0400 (EDT)
In-Reply-To: <536106EA.5090204@xiplink.com> (Marc Branchaud's message of "Wed,
	30 Apr 2014 10:21:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74FEFA46-D077-11E3-902C-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247717>

Marc Branchaud <marcnarc@xiplink.com> writes:

> But I'm definitely biased because I think pull is pretty much broken:
>
> * New users are encouraged to use pull, but all too often the default
> fetch-then-merge behaviour doesn't match their expectations and they end up
> starting threads like this one on the mailing list.
>
> * If we change pull's default behaviour, we'll just be shifting the
> mismatched expectations onto the other half of the new users who would be
> happy with fetch-then-merge.
>
> * I'm not sure why new users are taught to use pull.  I suspect it's because
> it tries to hide the idea of local-vs-remote branches, and people writing git
> tutorials don't want to overwhelm new users with what seems to be an internal
> detail.  But these notions are really fundamental to using git effectively,
> and I think pull does everyone a disservice by trying to gloss them over.
>
> Anyway, rather than ranting on I'll just suggest that there's not enough
> commonality between the ways people use git to make it worthwhile trying to
> teach pull how to deal with a significant number of them.  I think the pull
> command should be deprecated and quietly retired as a failed experiment.

I almost agree with the first sentence in the last paragraph, and
your bulletted list above supports it.

I am not sure how the second sentence can follow as its consequence.

If the conclusion were "maybe adding a 'git update' to match the
expectation of those who build on top of the work of others (aka
CVS/SVN style) more  closely and teaching new users to use that
instead of 'git pull' may be a good way forward", I can sort of
understand (if I may not be able to immediately agree with, until I
can regurgitate the ramifications of such a change) it.
