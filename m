From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] difftool: Use symlinks in dir-diff mode
Date: Sun, 22 Jul 2012 22:14:57 -0700
Message-ID: <7vfw8jnjn2.fsf@alter.siamese.dyndns.org>
References: <1343015831-17498-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 07:15:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAz4-0008Mx-SU
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 07:15:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab2GWFPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 01:15:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51068 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974Ab2GWFO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 01:14:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57ACA5BF1;
	Mon, 23 Jul 2012 01:14:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tMPIVRHsxnxA1J6u2ClEj8evAcU=; b=PhWYww
	rjDhYjokowZ35M6CyBzptVkJuBAW1oiS4CDAEiM8LcvTNlPX64ifiN9CBOfSAdQu
	snQ8PUG6ktWjbtxE/K/rrtR1bybRlMzdzkn4mN1ijbqmnzijs5mtniLN5k8GtMxS
	O3ZMjWvvB8vN4yvZpkOYyltnTuRJbPo6oJkRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lBEBQEtU9EDNH9ZA1vKAXRuPkUPBrt5+
	TZezOo2WoRHNKF6H6sAx9bK1p70A8jpfy21U0Markr95C3w62eZni79himFnVKWH
	QZhS3EQGYFbTCOkPZkEHjvDTzp62a3B96g844R+YCeHgB5vMWy4H5W86rzfm7lOJ
	qbown1vsHak=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45A245BF0;
	Mon, 23 Jul 2012 01:14:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 845E55BEF; Mon, 23 Jul 2012
 01:14:58 -0400 (EDT)
In-Reply-To: <1343015831-17498-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Sun, 22 Jul 2012 20:57:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58ED26F6-D485-11E1-B69F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201901>

David Aguilar <davvid@gmail.com> writes:

> Teach the difftool script to use symlinks when doing
> directory diffs in --dir-diff mode.
>
> This is v2 of the patch because I had a typo in one of the
> commit messages and gmail ate 4/5 in the last round.

FWIW, I received all including 4/5 in my inboxes (at pobox and
gmail---I am doubly subscribed).  I still haven't figured out what
in the original 4/5 was so special to be dropped somewhere in
between.

> David Aguilar (5):
>   difftool: Simplify print_tool_help()
>   difftool: Eliminate global variables
>   difftool: Move option values into a hash
>   difftool: Call the temp directory "git-difftool"
>   difftool: Use symlinks when diffing against the worktree
>
>  Documentation/git-difftool.txt |   8 ++
>  git-difftool.perl              | 184 ++++++++++++++++++++++++-----------------
>  2 files changed, 115 insertions(+), 77 deletions(-)
