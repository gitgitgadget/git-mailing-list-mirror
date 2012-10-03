From: Junio C Hamano <gitster@pobox.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 13:49:23 -0700
Message-ID: <7vvcer2sdo.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
 <506AA51E.9010209@viscovery.net> <7vzk449449.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
 <7vhaqc7in6.fsf@alter.siamese.dyndns.org>
 <CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
 <506BCF19.7020800@viscovery.net>
 <CAB9Jk9DH4Gx-8oJzb8H=ytohhZnMbA92pwj5P25AehmZ3PMmcg@mail.gmail.com>
 <506BDADE.4010803@viscovery.net>
 <CAB9Jk9AgtNQfWDr31CWbXf2ag=11du-aruu-0+nOZ3KaaG9=og@mail.gmail.com>
 <506BE577.900@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:51:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtJT-0001DP-DI
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754396Ab2JCUt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 16:49:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52722 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754312Ab2JCUtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 16:49:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0558897D9;
	Wed,  3 Oct 2012 16:49:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m9yTz6oB7kJhvFsptVlmoo9OTAc=; b=DIRymL
	srMtUqJho80kLiHvWUKn71C914QjwHQ5ouVzD2pPTe6OtU3fVJ7fnu0JaqAwrvKZ
	PkHTcvssqySgOY3m11idTCbdb5ks4VqdgyYlyqK+tFg5MDMZjuqm/2sJoB9vEd/k
	rU7JGmCVbCvMtymupU0GCIoERcLz/Ecdtm/4w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r+lTNU2EwIjlZSzjI0ojfqzzuOj3NA/h
	TS1M0Jw+5UCHBt8Z8+MffhGxKvKc5zkYekEi6e4Bq03hxLv0Wqq/j/RdTkWyCXm5
	kmAC5Smwlf5MufrEiY7tCmZdEcyvXJKbi+e15+z+wLfv9LKFRaKicghUN399E41W
	KeCvGhbM2Kw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E57D597D8;
	Wed,  3 Oct 2012 16:49:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61E3697D7; Wed,  3 Oct 2012
 16:49:24 -0400 (EDT)
In-Reply-To: <506BE577.900@viscovery.net> (Johannes Sixt's message of "Wed,
 03 Oct 2012 09:12:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D0863F96-0D9B-11E2-B473-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206929>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Why don't you use a different commit message to ensure that there is a
> difference between the commits?

That sounds like a workaround, and unnecessary one at that, as it is
entirely unclear why there _needs_ to be a different commit.

Perhaps OP fears that the orphan branch "foo" in his example,
because it happens to point at the same commit object as the
"master", will not stay the same and follow along the advancement of
"master" if some new commits are added to it, and that is the reason
he wants a different commit?

Of course, starting from "master" and "foo" pointing at the same
commit (or different commit, for that matter), "foo" won't change if
you commit on "master", so that fear is unnecessary.
