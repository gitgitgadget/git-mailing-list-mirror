From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] coverity mixed bag
Date: Thu, 24 Jul 2014 13:33:03 -0700
Message-ID: <xmqqd2cu8pkw.fsf@gitster.dls.corp.google.com>
References: <20140724043940.GA31282@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 24 22:33:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAPhY-0001wv-2a
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 22:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934553AbaGXUdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 16:33:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52223 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934382AbaGXUdP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 16:33:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6DD352A860;
	Thu, 24 Jul 2014 16:33:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2G2AtoAmFI/G3ksl3vTxwUJQQkQ=; b=spxVlx
	X3xRhuM/FUhiubfiMwW9ycVsWq+w9lBM48E0oOjUDBQHVjeMX91Fl8ZTusG6LnCF
	EklYUUgCErh6/UBnpfbCxgZnmMkUZkOI4I/XzwTOLWTpQjsinGPzkhuTkpqoq5Vu
	T8heyKeuq4T9KzLeHjOzwBLV+52e/N19rLhEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hcK1aaw6V6fKA2GyYToEZ0TnA1NhyCKB
	Coa/wo1f5Usxea2U6wqtU4OoECvb5GjBkqXcoq/EWaufilsgfu0HEtjKAj37H4lX
	ch6bUYZST1BIIHLHY0iUNkrybBKxMDjBRbL5X+AtzHS8u01NU0Lb7Fto5EiLuHEV
	bD/hzNPwqNE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 181512A85F;
	Thu, 24 Jul 2014 16:33:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 89A902A84C;
	Thu, 24 Jul 2014 16:33:04 -0400 (EDT)
In-Reply-To: <20140724043940.GA31282@peff.net> (Jeff King's message of "Thu,
	24 Jul 2014 00:39:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B6BA91E2-1371-11E4-B837-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254185>

Jeff King <peff@peff.net> writes:

> Since Stefan has recently started feeding git builds to coverity, I
> spent a few minutes poking through the results. There are tons of false
> positives, so there is some work to be done there with tweaking our
> coverity models. But there are some real issues, too. Here are fixes for
> the handful that I looked at.
>
>   [1/5]: receive-pack: don't copy "dir" parameter
>   [2/5]: free ref string returned by dwim_ref
>   [3/5]: transport: fix leaks in refs_from_alternate_cb
>   [4/5]: fix memory leak parsing core.commentchar
>   [5/5]: apply: avoid possible bogus pointer
>
> -Peff

Thanks, they all make sense to me.  I'd probably have to wiggle 4/5
a bit to port the fix over to both maint and master, though.
