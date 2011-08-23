From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Looking for a way to turn off/modify ref disambiguation
Date: Tue, 23 Aug 2011 15:03:57 -0700
Message-ID: <7vei0brdiq.fsf@alter.siamese.dyndns.org>
References: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 00:04:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvz4o-0001h1-PJ
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 00:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1HWWEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 18:04:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62203 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab1HWWEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 18:04:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 960B54E81;
	Tue, 23 Aug 2011 18:03:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1smOgeVPjN/O54ML5obBratfAj8=; b=j7XKn7
	p4gjCJXCKRqM2kWT2OpEC+aPE44Byh9hL8GA19n8Oa4M+cuC/F2qrS6lKTYChO33
	Bqfk722SWLJ2PK6lINv/FL8EV/59OkXhO+lE1+BBtDFfbCsWIVUFqZ2CuHKPWhf1
	4v9l8zf/fPQ/mu+I5uHSUnyRFj8M9Y2ezC+Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=en7tIZKliqAyWAj9tRpOFL9PiN+BVP5K
	Yl9vBquWH8VFJzuzKym6eCTsb6QvFxgcUeOQqiKjOZJo1yyqBaqhDG1fHI8H7cKJ
	s1qdMtciw0GysZJH3ZLiejljs2BnFnCgAtOl1L++oVpJM1sFJFnc4lL07Hvj3Xcx
	JHLkSk7F4eQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D4454E80;
	Tue, 23 Aug 2011 18:03:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 227E74E7C; Tue, 23 Aug 2011
 18:03:59 -0400 (EDT)
In-Reply-To: <CAPRoxBXjL3Y3KRd8R2guX9Ar374sw-pBhz1bCzNZxn1vC6XNPw@mail.gmail.com> (Nathan
 W. Panike's message of "Tue, 23 Aug 2011 14:26:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD8D8F50-CDD3-11E0-8DB5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179976>

"Nathan W. Panike" <nathan.panike@gmail.com> writes:

>        1.          If $GIT_DIR/<name> exists, that is what you mean
> (this is usually useful only for HEAD, FETCH_HEAD, ORIG_HEAD,
> MERGE_HEAD and CHERRY_PICK_HEAD);
>        2.          otherwise, refs/<name> if it exists;
>        3.          otherwise, refs/tags/<refname> if it exists;
>        4.          otherwise, refs/heads/<name> if it exists;
>        5.          otherwise, refs/remotes/<name> if it exists;
>        6.          otherwise, refs/remotes/<name>/HEAD if it exists.
> ...
>
> Is there any way to change this behavior, e.g., so that rule 6 becomes
> an error?

You will force people to say "git log origin/master..master" to measure
their progress if you did so, when "git log origin..master" has been the
way described in many git books and documentation pages floating on the
web.

I think it is _very_ unlikely that such a change is going to happen.
