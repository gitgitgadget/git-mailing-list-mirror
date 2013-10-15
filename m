From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] inconsistent `git reflog show` output, possibly `git fsck` output
Date: Tue, 15 Oct 2013 15:36:33 -0700
Message-ID: <xmqqtxgib1qm.fsf@gitster.dls.corp.google.com>
References: <871u4hzusr.fsf@gmail.com> <523F749E.5030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keshav Kini <keshav.kini@gmail.com>, git@vger.kernel.org
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 16 00:36:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWDEG-0004ow-Jy
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 00:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933584Ab3JOWgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 18:36:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933522Ab3JOWgg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 18:36:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFD474A63D;
	Tue, 15 Oct 2013 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ltEWAYNXuuKIG2hPfR7AdyIIc7k=; b=I2s/wR
	P0l84Jiw+7WQ6d3kG69fRf3wnS3CeOGCZJwY5ZxingpCzxi8eNL1e4UM5RZW7E/u
	mejTfE5uSxPcTSsppfFF/3/YRn80Igs4ZHfmWYblfP2ZYAPZxURAarMN3xlDEwPa
	otkERSHeE0EbFkEa58Kp7AB9oyt2J2940z0Qk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mfZAq1/b1ySDXDiF8vQhEDBNedBG+gEN
	8RSAANG/bVk490lErgYdY7xskbTTmtKbvTRRCd7opwIlsu/Zo0ecDN0kgnN9Cxa5
	E7Q16rOgT47DkevUFKcigoP7EKWxoks8npJPomuYS+YfLOkA/NCmPyC5LYCuKjdk
	QnawbLVQea4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E0F7C4A63A;
	Tue, 15 Oct 2013 22:36:35 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 550894A633;
	Tue, 15 Oct 2013 22:36:35 +0000 (UTC)
In-Reply-To: <523F749E.5030306@gmail.com> (Roberto Tyley's message of "Sun, 22
	Sep 2013 23:52:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3F66B02C-35EA-11E3-A459-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236208>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> On 21/09/2013 23:16, Keshav Kini wrote:
>> [SNIP]
>> This situation came about because the BFG Repo-Cleaner doesn't write new
>> reflog entries after creating its new objects and moving refs around.
>
> True enough - I don't think the BFG does write new entires to the
> reflog when it does the final ref-update, and it would be nicer if it
> did. I'll get that fixed.

(sorry for replying late)

So this can be closed as "BFG not writing reflog in a consistent
way, and 'git reflog show' is acting GIGO way"?  Or was there
something the core side needs to do?
