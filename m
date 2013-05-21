From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Tue, 21 May 2013 12:13:39 -0700
Message-ID: <7v38tgno2k.fsf@alter.siamese.dyndns.org>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 21 21:13:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ues0O-0006lR-W1
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 21:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883Ab3EUTNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 15:13:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47186 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299Ab3EUTNm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 15:13:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00C7D214D5;
	Tue, 21 May 2013 19:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BGif+0fQ1qbLnOR4MDAeN8WWZL8=; b=toQhTe
	+GZQpMBGX9hRHIEn+KWOAlV/x83yI1J3vuK9B1ybKGKQjMMKPhOfyR7ck/Db7kNN
	n2mniMPFciUxOXiAQqloU51pAn+NrSeh/LcFNlPuPb13Jtrpiuu8dVswDyGuIwGm
	gMX+0hBdcwjqpB7LIX0DMT9I0DZumd/nho+H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dcNH5Bk+f9OYOR7I4ZnLynq7qhk7npHI
	4Rd0mj70cjD8vC9zH3HPcVano8ETg0ThDTP3kN3dl9rlj8ZZE4+HsT51k3kOBWA5
	CbZKzma9StwursGQlvVBY3/nMNAAp1BDc+JTXqGcnFjV4LDgDAdrInxjzGwwTYva
	WKEBZDL9SAs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E880E214D3;
	Tue, 21 May 2013 19:13:41 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51F11214D0;
	Tue, 21 May 2013 19:13:41 +0000 (UTC)
In-Reply-To: <1369160600-22337-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 21 May 2013 23:53:17 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C66AF30-C24A-11E2-AD08-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225065>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> There's still a lot to think about.

Is there?  I do not think "volatile" is particularly a good
description for this, but showing what is pushed as a concrete
branch name feels like a good improvement to me, at least in
principle.

I haven't picked them up, and I won't be picking them up today, as I
suspect this series may conflict with the pre-2.0 preparation and
2.0 transition patches and I may end up having to fix conflicts
unnecessarily (resolving is eventually needed before 2.0 happens,
but resolving them, or even having to worry about the possibility
that I may have to do so, do not have to steal time from me today).

Thanks.

> [3/3] is the big itch: [1/2] and [2/2] are just setup patches.
>
> Ramkumar Ramachandra (3):
>   push: factor out the detached HEAD error message
>   push: fail early with detached HEAD and current
>   push: don't push the volatile HEAD with current
>
>  builtin/push.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
