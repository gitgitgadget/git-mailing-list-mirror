From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 26/27] t/*svn*: fix moderate &&-chain breakage
Date: Fri, 20 Mar 2015 11:04:42 -0700
Message-ID: <xmqqy4mree9x.fsf@gitster.dls.corp.google.com>
References: <550C2E7B.3030203@drmicha.warpmail.net>
	<317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:05:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1Hz-0001cd-7d
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbbCTSEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:04:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50016 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751163AbbCTSEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:04:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4207B40E96;
	Fri, 20 Mar 2015 14:04:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pTqSPojboEO5vo/dqMFAybGR9V0=; b=uqAAzE
	lT0n6D+DSA7WvL4XbDybAUlpxGkgC74R+vXTuyAEp8DOFq6MWKWCei8CN33gE2kz
	wb0zzBxMMpzo75pjx3e6IztNnOEW8yDyJmGeJwsSIhDtSHPj426JuPTTGTsVICcv
	veRG1eMbS6J6ZB7eSNjnygzXUuZbCKBsGw7a4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HVp/VajZs3CxMuxXFEbFYyj9Fq2XN+h4
	oC4Q8elWHFwWQ1bqDzo88GCjrviQ84EwmTcOXNsfhR5PlX/DXTf8SWuHnysADpCA
	DsEtm36Gc1QDovtQGF1W50aMqS2mMs5dmjPODBrgNeJ1ONhGOSn0JY2+q4NQUjfr
	v5KrjqpZThM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A3CD40E95;
	Fri, 20 Mar 2015 14:04:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8570240E8D;
	Fri, 20 Mar 2015 14:04:43 -0400 (EDT)
In-Reply-To: <317e6b1e70f3e1c50d62207c53f4d038ad027c9d.1426861743.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Fri, 20 Mar 2015 15:32:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 960B0A28-CF2B-11E4-8415-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265927>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> All of these cases are moderate since they would most probably not
> lead to missed failing tests: Either they would fail otherwise,
> or fail a rm in test_when_finished only.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t2026-prune-linked-checkouts.sh |  4 ++--
>  t/t9158-git-svn-mergeinfo.sh      |  4 ++--
>  t/t9161-git-svn-mergeinfo-push.sh | 10 +++++-----
>  3 files changed, 9 insertions(+), 9 deletions(-)

Ahh, it seems that I should have read everything in my inbox before
starting my day X-<.  I already queued an identical patch for 2026
on nd/multiple-work-trees, and its new tip is in 'next' now.

Which branches are the git-svn ones meant to apply?  Are they meant
to fix an existing bug already in master, or are they new ones added
by still-in-flight topics?  Can you split if necessary and mark them
for individual topios in flight if that is the case, so that we can
apply them independently from GIT_TEST_CHAIN_LINT series?

Thanks.
