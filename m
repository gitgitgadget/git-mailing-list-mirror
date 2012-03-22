From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0 0/2] git-less: a specialized pager for git-log
Date: Thu, 22 Mar 2012 12:00:02 -0700
Message-ID: <7v1uokxxzh.fsf@alter.siamese.dyndns.org>
References: <1332441744-5142-1-git-send-email-h.mitake@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hitoshi Mitake <h.mitake@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:00:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnF8-0004ob-Bh
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:00:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989Ab2CVTAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:00:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43521 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996Ab2CVTAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:00:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E56376547;
	Thu, 22 Mar 2012 15:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sp8ouYzm0eFGp7/Gmbs0hDPUkUY=; b=N5TZKH
	6mLNFlUSvRrh7TPhns4kUsyzYzbNJS5vepHzZG+xV2VJRhZjYnSFMiavCGGw/mx6
	AoYPGe+NXULNpOWt/fKVJImRe7DEAVlZa4iEalz09EoIbn0ure+YdoKx+cSpKx58
	HVKG8pUs/hfEnK2bNup/UptUb+9/ezCMDuDGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I+Zdbx7mY+/ketGF+tQtr7Z6n6uxsuA5
	TYZx6avg2F/JZWQL/Lc5nOtGSwEJHUY7QTb4E4gAfk1cutGs/tjD6l6PSV+ibZeu
	yAJLpj/Ji4dA5F69VPEzQGyLFrvNWTINsxG2bSE0aGVXmU7wKrO/tD7Cn6XtApBd
	oKKo8sFLNdk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBC896546;
	Thu, 22 Mar 2012 15:00:05 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DC1D6540; Thu, 22 Mar 2012
 15:00:04 -0400 (EDT)
In-Reply-To: <1332441744-5142-1-git-send-email-h.mitake@gmail.com> (Hitoshi
 Mitake's message of "Fri, 23 Mar 2012 03:42:22 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3BF064D0-7451-11E1-A253-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193687>

Hitoshi Mitake <h.mitake@gmail.com> writes:

> If the pager can recognize the end of each commit, more confortable viewing of
> git-log's output will be possible.

I think people just use "/^commit .*<RET>" once and then nagivate with "n"
(and to change direction, "?<RET>") for this.

> For implementing this feature, I had to make modification of git-log

I do not think the change to "log" is necessary nor worth it.  If the
pager is so specialized to be tied to git, it should learn to recognize
the output from "git", namely, "git log" and "git log -p" would never have
a line that begins with "^commit " that is not the beginning of one record
for a commit.

If you are not comfortable using "less", perhaps a program like "tig" that
is very specialized for working with git might help you better.
