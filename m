From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC v2 00/19] Enable options --signoff, --reset-author for pick, reword
Date: Tue, 08 Jul 2014 13:45:11 -0700
Message-ID: <xmqqha2r8trc.fsf@gitster.dls.corp.google.com>
References: <53A258D2.7080806@gmail.com>
	<cover.1404323078.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>, Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4cGc-0008Tn-9a
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 22:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbaGHUp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 16:45:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64740 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137AbaGHUp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 16:45:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28A5D266CC;
	Tue,  8 Jul 2014 16:45:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l27BMpZb9AyZnYlpswIjd112ZgY=; b=sAcDeR
	usl9NKy8uGU/+z8uPtuhbQHxuz+I9mkU7OdFwrA+6TyeoieBGT6XfKx1VATIjgjV
	MCEEX1ifNpSw4qGJj93t9xnMDVzwSACYOCM/NVH8w02G5CWY9Pev32P+UrHjB2tR
	TcuQ/dY6IHjNPqKATAOTJ/BRv0O6vE1mNACeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FMPljJRJ5frjkhKIUKQGnGNWvTn7wK3M
	b7wVNI2ZhqbJ4Tj95dE6WLBrhdWrUUOWknh3AEKu6m83Tv+SBROjcczTCMRLLmpK
	7mMYUsphO7/o8/V3B1ExR4kY/gnb5JFk7EQEhLAQv9AWKHNIwFMgjD9o9BMUpiNs
	mAbt8VWInQQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 01750266CA;
	Tue,  8 Jul 2014 16:45:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2E5D8266A4;
	Tue,  8 Jul 2014 16:44:58 -0400 (EDT)
In-Reply-To: <cover.1404323078.git.bafain@gmail.com> (Fabian Ruch's message of
	"Wed, 2 Jul 2014 19:47:52 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B977297E-06E0-11E4-BADD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253047>

Fabian Ruch <bafain@gmail.com> writes:

> Fabian Ruch (19):
>   rebase -i: Failed reword prints redundant error message
>   rebase -i: reword complains about empty commit despite --keep-empty
>   rebase -i: reword executes pre-commit hook on interim commit
>   rebase -i: Teach do_pick the option --edit
>   rebase -i: Implement reword in terms of do_pick
>   rebase -i: Stop on root commits with empty log messages
>   rebase -i: The replay of root commits is not shown with --verbose
>   rebase -i: Root commits are replayed with an unnecessary option
>   rebase -i: Commit only once when rewriting picks
>   rebase -i: Do not die in do_pick
>   rebase -i: Teach do_pick the option --amend
>   rebase -i: Teach do_pick the option --file
>   rebase -i: Prepare for squash in terms of do_pick --amend
>   rebase -i: Implement squash in terms of do_pick
>   rebase -i: Explicitly distinguish replay commands and exec tasks
>   rebase -i: Parse to-do list command line options
>   rebase -i: Teach do_pick the option --reset-author
>   rebase -i: Teach do_pick the option --signoff
>   rebase -i: Enable options --signoff, --reset-author for pick, reword

After "rebase -i:", some begin with lowercase and many begin with
capital, which makes the short-log output look distracting.
