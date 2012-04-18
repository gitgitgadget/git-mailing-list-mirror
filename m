From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/4] t4052: Test diff-stat output with minimum columns
Date: Wed, 18 Apr 2012 13:15:17 -0700
Message-ID: <7v4nsglru2.fsf@alter.siamese.dyndns.org>
References: <1334716196-9870-1-git-send-email-lucian.poston@gmail.com>
 <1334716196-9870-3-git-send-email-lucian.poston@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Lucian Poston <lucian.poston@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 22:15:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKbHj-0002Ek-8v
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 22:15:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab2DRUPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 16:15:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38304 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125Ab2DRUPW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 16:15:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E9EF632C;
	Wed, 18 Apr 2012 16:15:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WTJaU+TZeh1UcAZGXK7yObvV9gQ=; b=cbhkQ6
	Su07tDmbSA98ih/KQSdLScWrYYlN88EQG2SfpXQTwZ6ab2WkrkIP2Mz7z6FgYrZp
	InAuHARza98bs+DOJ7KLeothtywb0wMP/zYYOqOui8tINqIpQgTKfFzwRqh1jCJN
	Gcy40HO4BHm9+Hfe/My+xfJCju0B9XMNX0zMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ipLkvma243oWPOwUaK8KVuYXSBxkkln0
	aVqiHaADBCa1a3lWGj1twf1JIPOhN1Rmm4iRh0kOCZGYTJ04ck/M2sJCLfS8vl+N
	rvF48ISoWMKX+E+X7I6gVKevptaQYVBnj+W1P2nukNbtK7fbEAaItCIA0kbK8DfD
	pMDyalk7xwg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A205632B;
	Wed, 18 Apr 2012 16:15:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7447D631B; Wed, 18 Apr 2012
 16:15:18 -0400 (EDT)
In-Reply-To: <1334716196-9870-3-git-send-email-lucian.poston@gmail.com>
 (Lucian Poston's message of "Tue, 17 Apr 2012 19:29:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 380A2840-8993-11E1-8CCD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195896>

Lucian Poston <lucian.poston@gmail.com> writes:

> When COLUMNS or --stat-width restricts the diff-stat width to near the
> minimum, 26 columns, the graph_width value becomes negative. Consequently, the
> graph part of diff-stat is not resized properly.
>
> Signed-off-by: Lucian Poston <lucian.poston@gmail.com>
> ---
>  t/t4052-stat-output.sh |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)

Running t4052 with this patch applied reports

# fixed 2 known breakage(s)
# still have 5 known breakage(s)
# passed all remaining 81 test(s)

Please mark the ones that already pass as "test_expect_success", leaving
the only broken ones as "test_expect_failure".  Otherwise the patch to the
test that contains the fix would not illustrate what it fixed.

Thanks.
