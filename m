From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Mon, 13 May 2013 18:08:04 -0700
Message-ID: <7vfvxql66j.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 03:08:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc3iw-0005m7-09
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 03:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301Ab3ENBIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 21:08:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62037 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752067Ab3ENBIH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 21:08:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D5B018A49;
	Tue, 14 May 2013 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3YpiuAiUcsesjrg9QM8GWkDlrc0=; b=xfAyJ0
	7neREL2F1Kh7KtSU7wTIjJyoF8ZB+StYEpbOVOVnIc8rgrBCHeW0YeoogGe8uxev
	+LODoY9L4xCXmRdn6KtWD1XvlRrDpJqaNMc+0ni3vfquw4wzvoNxUWmIif/8+Xkm
	7j2FuZ7ut2VPJgvjEnBnvFQWVElqb1cvUR8Bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uXeJ76aunKvIJBzd4AvrphD/gJW09o7N
	4KjfcMRXnSzeE0Bd2AFadukx3xLO6m0CQB3lVsh9RNFwqafCQ2v78VVz3xvvCMv1
	CHe87qMyu/PDjtBmyxWFfXWT2Ao6m1Xipeq8fzRKfkH/SYdXwFxsO70MGOKiXO6e
	qZhWy+IE1ME=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 608E118A48;
	Tue, 14 May 2013 01:08:06 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A993B18A45;
	Tue, 14 May 2013 01:08:05 +0000 (UTC)
In-Reply-To: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Mon, 13 May 2013 18:11:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BBA4C4F8-BC32-11E2-94E6-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224231>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Since the last series is not merged to master yet, I decided to add more cleanups.

Because nothing new will go to 'master' past -rc1 by default, unless
you are working on fixing or finding 1.8.3 regressions, this is a
good time to polish things that are meant for the next cycle.

Folks interested in working remote-hg, please try it out, so that we
can have a polished one soon after 1.8.3 ships (I am not saying this
round is not polished---I haven't even looked at the patches).

And others, please spend time on testing the 1.8.3-rc2 to make sure
what we are going to ship is free of embarrassing regressions.

Thanks.

>
> Felipe Contreras (10):
>   remote-hg: trivial cleanups
>   remote-hg: get rid of unused exception checks
>   remote-hg: enable track-branches in hg-git mode
>   remote-hg: add new get_config_bool() helper
>   remote-hg: fix new branch creation
>   remote-hg: disable forced push by default
>   remote-hg: don't push fake 'master' bookmark
>   remote-hg: update bookmarks when pulling
>   remote-hg: test: be a little more quiet
>   remote-hg: trivial reorganization
>
>  contrib/remote-helpers/git-remote-hg     | 47 ++++++++++++++++----------------
>  contrib/remote-helpers/test-hg-hg-git.sh |  3 +-
>  contrib/remote-helpers/test-hg.sh        |  4 +--
>  3 files changed, 26 insertions(+), 28 deletions(-)
