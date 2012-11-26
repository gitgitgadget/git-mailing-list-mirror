From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Fixes shortstat number of files
Date: Sun, 25 Nov 2012 19:28:17 -0800
Message-ID: <7vhaodxctq.fsf@alter.siamese.dyndns.org>
References: <1353533210-29684-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 04:28:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcpN7-0005aA-3b
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 04:28:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab2KZD2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2012 22:28:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42129 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753816Ab2KZD2U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2012 22:28:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A91878F60;
	Sun, 25 Nov 2012 22:28:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8VKYQGY9lOnBrOtxrAUT5qXBEnk=; b=YVd0gv
	2PFXA9k6DEV94zz/kDOUt4ovJ3iTqWTb7WSJPkk/Dfl2zMv8txQEMzBbjFicgOf8
	8tOyhoC81p6xmS/uNi0XJ+Lq4knSFlxX2/a2vOVBKBQmiPFzEnpLI72SU8BuuKeQ
	Sqb1H2XYS2Bo9yQ1B2mPbpWl3cJ9xXXTFYQxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ln1A1RTbGdyVmZtKU5f/ibJgmjnZ95Vp
	nOueDApZ+S74AA36bNVJc4G8pxhmamioiQ5E6PVOG3KyRZRBLe25JhOuOVtriUby
	igZNOiG7OYTtvh6acVgtR36qY5brL6xpS9BOq+aJPT/WXmfpL6wJhmukfIclQmHV
	PhmoKYMSk6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 972FF8F5E;
	Sun, 25 Nov 2012 22:28:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEA508F5C; Sun, 25 Nov 2012
 22:28:18 -0500 (EST)
In-Reply-To: <1353533210-29684-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Wed, 21 Nov 2012 22:26:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5289805A-3779-11E2-8523-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210404>

Antoine Pelisse <apelisse@gmail.com> writes:

> Subject: Re: [PATCH] diff: Fixes shortstat number of files

Please replace "Fixes" with "Fix at least (because our log messages
are written as if a patch is giving an order to the codebase, iow,
in imperative mood), but we would prefer to see a concrete
description on what is fixed, when we can.  And in this case, I
think we can, perhaps:

    diff: do not count unmerged paths twice in --shortstat/--numstat

or something.

> There is a discrepancy between the last line of `git diff --stat`
> and `git diff --shortstat` in case of a merge.
> The unmerged files are actually counted twice, thus doubling the
> value of "file changed".

I think the current 'master' and upward is broken with respect to
this; I am consistently getting two entries for unmerged paths
across --stat, --shortstat and --numstat options (iow, not just
shortstat and numstat but the '--stat' seems to be broken as well).

Thanks.
