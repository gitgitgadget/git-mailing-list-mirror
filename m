From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Make git more user-friendly during a merge conflict
Date: Mon, 17 Mar 2014 16:04:20 -0700
Message-ID: <xmqqha6wa0ln.fsf@gitster.dls.corp.google.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 00:04:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPga4-0000Ww-HX
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 00:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbaCQXEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 19:04:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbaCQXEX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 19:04:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D49C75634;
	Mon, 17 Mar 2014 19:04:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=aDanLX57It+yPVRXsMFMJjPBPPo=; b=ObOF7NLv2do6Yx/VYH+o
	9HdekAnfU5JBuxdaNVyXQBcNLJamT0mN/H0kg+n1Yiprf+5HwWxpF3FRrLHw+B6l
	UTinHuWyf0OZGyu0MclX0TiMM+1HsfvyLNEp6ShP/YLr1PSxQnvPZmFbXwfR1hT7
	pFGljMiFdqFN+VMB8PeYqJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Tkx5S8zDf7WJXRj/DfamyRYV7md8mvd1KeJRuH+TerSZ8I
	gthpv1amwUwu9rsj8rjt3CkeO/bUGMU4iOqYokbS0QrdF3uBCxy9peIlWAscBiNP
	HQzS378ykLTNjLAkjpfMM0xzQ49+Me6gyOPE8hZuLhJs4tI9agfWDGtUy9qnI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A95F75633;
	Mon, 17 Mar 2014 19:04:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A985C75631;
	Mon, 17 Mar 2014 19:04:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 79D2B150-AE28-11E3-BC73-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244308>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> 2/3: I've added advice.mergeHints to silent the messages that suggests "git
> merge--abort".
>
> 3/3: I've added a warning message when users used "git reset" during a merge.
> This warning will be printed if the user is in the middle of a merge. In future
> releases, we'll change this into an error to prevent work tree from becoming a
> mess.
>
> Andrew Wong (3):
>   wt-status: Make status messages more consistent with others
>   merge: Advise user to use "git merge --abort" to abort merges
>   reset: Print a warning when user uses "git reset" during a merge
>
>  Documentation/config.txt |  3 +++
>  advice.c                 |  2 ++
>  advice.h                 |  1 +
>  builtin/merge.c          |  6 ++++++
>  builtin/reset.c          | 21 +++++++++++++++++++++
>  wt-status.c              | 23 +++++++++++++----------
>  6 files changed, 46 insertions(+), 10 deletions(-)

Has this series been tested with existing test suite?  I tentatively
queued it to 'pu' but then had to revert because many tests started
failing, causing me to redo the today's integration cycle for 'pu'
once again.
