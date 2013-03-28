From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/6] Support triangular workflows
Date: Thu, 28 Mar 2013 08:02:43 -0700
Message-ID: <7vppyjworw.fsf@alter.siamese.dyndns.org>
References: <1364477202-5742-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:03:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULEME-0002Uc-JR
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:03:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756640Ab3C1PCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:02:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756366Ab3C1PCp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 11:02:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59667AB8A;
	Thu, 28 Mar 2013 11:02:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FTWYsTbKi3w6hKII5ZDiVj1bdAQ=; b=ji4nd6
	E1v30dCkFon/7UhMAMgfxlB3Jxt7bm3wAt/UruqCm2QS7bMIw+WmoTR984vrQgRX
	rFhi5J6WqRCrZxQgwXaQI7xjYjENrSGNvhZ3o+t5gDW9T9PEfMszhn4T66N3YhFx
	07Vxat1jwjf7i/oa1/k1qrGcI/5InyYRaZg5U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RTfvL5f7lhDjy/8FlVdlh/+yaXGW9+fo
	8yfbTo7MVQJAMHqLRDLbK5MJ8scau/1lkQEXfybYCTCxlMp1cp22vD5qurZL1ZpD
	kbMj2L/8yK29Dc2Saltqubs/khCUByAbE3xi1Il8PBufCuo07kfu0Qq70MUDsnHu
	bKPha0L/X8Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E98BAB89;
	Thu, 28 Mar 2013 11:02:45 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0847AB85; Thu, 28 Mar 2013
 11:02:44 -0400 (EDT)
In-Reply-To: <1364477202-5742-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 28 Mar 2013 18:56:36 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BB16FA6-97B8-11E2-9FB3-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219405>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The changes in this round are:
>
> 1. Peff submitted a patch to squash into [3/6].  Since his patch
>    essentially reverts mine, I've blamed him for the change.
>
> 2. Peff suggested a code movement in [5/6] to make things flow more
>    naturally.
>
> 3. Jonathan suggested a better test description in [2/6].
>
> 4. Junio suggested a minor documentation update in [6/6].
>
> My build of git has had this feature for two weeks now (since the
> first iteration), and I'm very happy with it.

Will take a look; thanks for a reroll.

We may need a bit of adjustment to the longer term plan for the
push.default topic, as I expect we will have this feature a lot
sooner (e.g. perhaps in 1.8.4) than we will switch the push default
to "simple".  The description of simple and upstream still is
written around the "you push to and pull from the same place", and
may need to be updated to explain "what happens if you are employing
a triangular workflow?"  Or it could turn out that triangular people may be better
served by a push.default different from simple or upstream.

Or it may turn out that we do not need any change to what is queued
on the push-2.0-default-to-simple topic (I haven't thought things
through).

It is not urgent, but please start thinking about how you can help,
now you introduced the triangular stuff.

Thanks.

> Jeff King (1):
>   t5516 (fetch-push): drop implicit arguments from helper functions
>
> Ramkumar Ramachandra (5):
>   remote.c: simplify a bit of code using git_config_string()
>   t5516 (fetch-push): update test description
>   remote.c: introduce a way to have different remotes for fetch/push
>   remote.c: introduce remote.pushdefault
>   remote.c: introduce branch.<name>.pushremote
>
>  Documentation/config.txt |  24 +++-
>  builtin/push.c           |   2 +-
>  remote.c                 |  41 ++++--
>  remote.h                 |   1 +
>  t/t5516-fetch-push.sh    | 316 +++++++++++++++++++++++++++--------------------
>  5 files changed, 238 insertions(+), 146 deletions(-)
