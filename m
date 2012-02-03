From: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to determine oldest supported version of git
Date: Thu, 02 Feb 2012 20:52:05 -0800
Message-ID: <7v8vkktt6y.fsf@alter.siamese.dyndns.org>
References: <jgeekn$of2$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 05:52:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtB8B-0006VO-3N
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 05:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab2BCEwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 23:52:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754427Ab2BCEwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 23:52:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 254736E1D;
	Thu,  2 Feb 2012 23:52:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GxhLqZBzB9wWzAIa76Zq3o7+PDY=; b=njdoBI
	bUno5AvXIXyoUSShLWFsAHW50N7rcN4YjdAd8zqM+//ZtVS4kkvTEUfNj+fRN1Ig
	Mr33Q2WQFVzO6Vyja/0Hc75P0TJb7Dstho5fdeWv7Kyt82A5l13cZXdUJPYG9oKE
	km9BHq69tGSQuWZSOHC8bxH6JPUNLIRsgLeR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tuzuHw6ZoFwTYRX/d159u87McMtQ0ojI
	wYEgqhf4WDjow7DrUZXgxSJ9RmeuMNTGh4gnaje47TgudsYeB5r2wCjlyxOOeLou
	Mma9fQT4xk7Wb7WO4lT8lv2DvUg/t+woTN+GSQ8h2hRN7WLFX6DObSC/PsJEdaQn
	E/nHMOhCJ5A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 067AA6E1C;
	Thu,  2 Feb 2012 23:52:07 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 843A86E1B; Thu,  2 Feb 2012
 23:52:06 -0500 (EST)
In-Reply-To: <jgeekn$of2$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Thu, 2 Feb 2012 10:46:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D283B366-4E22-11E1-B1C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189736>

"Neal Kreitzinger" <neal@rsss.com> writes:

> What is the best way for me (a git user) to determine what is currently
> the oldest supported version of git (the oldest version still getting
> bugfixes)?  IOW, when can I tell that my version of git is no longer
> supported?

"A note from the maintainer" only promises that the latest major release
(as of this writing, 1.7.9) gets regular maintenance releases until the
next major release happens.

When queuing a fix to an old bug, however, I try to build a topic branch
for that fix from as old an release as practical, in order to make sure
that older maintenance tracks could benefit, and I do give updates for
older maintenance tracks when able (but no promises).

For example, during the last cycle leading to 1.7.9, in other words, back
when 1.7.8 was the latest major release, in addition to the maintenance
releases 1.7.8.1, 1.7.8.2, 1.7.8.3 and 1.7.8.4, maintenance releases for
older version of Git were tagged (1.7.6.5, 1.7.7.5, and 1.7.7.6).  Note
that 1.7.6 was originally released on June 26th, 2011.

One cycle of major release development is expected to last between 8 to 10
weeks, so keeping two stale maintenance tracks in addition to the latest
maintenance track alive would roughly translate to 6 months shelf life for
an ancient release.

As other people mentioned, if you are on a (probably paid) support plan
from a(n enterprise) distro, asking them would be the best way, and if you
are running Git supplied as part of a distro, the distro would dictate the
version it supplies to you, so asking here would not help very much.
