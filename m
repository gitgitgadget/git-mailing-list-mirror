From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Display change history as a diff between two dirs
Date: Sun, 26 Feb 2012 16:13:00 -0800
Message-ID: <7vlinpcewj.fsf@alter.siamese.dyndns.org>
References: <4F495703.10401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Roland Kaufmann <rlndkfmn+git@gmail.com>,
	Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 01:13:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1oDj-00024t-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 01:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909Ab2B0ANH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 19:13:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48489 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752568Ab2B0ANF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 19:13:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1AAE7DBC;
	Sun, 26 Feb 2012 19:13:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CD/Ku5k/lZszcm//NQX9CEsLY/A=; b=VMKi8y
	6uUgJTEbhvbJg90FUa/Aqy3Sv5Xm4m4VnoGXXYfbYlgHUZ5UL2sEqm0i5VJH9SUi
	h0bgNyMc2Y/tce7nU/X4GfjTlIwjIcXDEMjxyF7ntR67YLdxsVpeCbuUayJIlxWL
	myje7Q4vJejyHxCyM+eAzxb2LfzYoj8uYix1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ff7eTGjMoNInkArMN1vskVfh93QMNR8X
	YBIdUFV0NPt56SsFUTDFOuBdEpEIWrorZ8q01QzBwU+CbVT7srrpaXXxGfgsd1Xe
	oLtuyK2rDu5DsftUjnI+NwUkHxW6wzaQYlBXXHkmdNMo9SzzmIksye7iHFUM0eI4
	NDaPYJJHRKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8C197DBB;
	Sun, 26 Feb 2012 19:13:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A7957DB6; Sun, 26 Feb 2012
 19:13:04 -0500 (EST)
In-Reply-To: <4F495703.10401@gmail.com> (Roland Kaufmann's message of "Sat,
 25 Feb 2012 22:47:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1651548-60D7-11E1-9477-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191586>

Roland Kaufmann <rlndkfmn+git@gmail.com> writes:

> Watching patches serially it can be difficult to get an overview of how
> a pervasive change is distributed through-out different modules. Thus;
>
> Extract snapshots of the files that have changed between two revisions
> into temporary directories and launch a graphical tool to show the diff
> between them.
>
> Use existing functionality in git-diff to get the files themselves, and
> git-difftool to launch the diff viewer.
>
> Based on a script called 'git-diffc' by Nitin Gupta.
>
> Signed-off-by: Roland Kaufmann <rlndkfmn+git@gmail.com>
> ---

Sorry, but I completely forgot about this three-month old topic (the last
discussion was early November last year).

How does this compare with Tim Henigan's "diffall"?  I think the problem
these two topics try to address is the same, and their approach may be
similar enough that having one consolidated effort might be worth it.

I seem to have suggested during the previous review round of this series
the same thing I suggested to Tim, that we _might_ want to instead have
the logic to populate the two temporary trees on the core side with a new
external diff interface.

http://thread.gmane.org/gmane.comp.version-control.git/184458/focus=184462
