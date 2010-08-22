From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] optionally disable overwriting of ignored files
Date: Sun, 22 Aug 2010 00:25:31 -0700
Message-ID: <7viq335ct0.fsf@alter.siamese.dyndns.org>
References: <4C6A1C5B.4030304@workspacewhiz.com>
 <7viq39avay.fsf@alter.siamese.dyndns.org> <20100818233900.GA27531@localhost>
 <7v4oepaup7.fsf@alter.siamese.dyndns.org> <20100821080512.GA30141@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Aug 22 09:27:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On4xr-0004hz-5A
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 09:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954Ab0HVHZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 03:25:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939Ab0HVHZk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 03:25:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82A2BCD876;
	Sun, 22 Aug 2010 03:25:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Fy2frj9mxIGqFt0VETpWOsOhFqs=; b=PA/7f3/vWxrGYVHKvfoc0vf
	ra+l7rSu31GaCnqG49K+V2PgthAmkDS7WVnp1yS2chVyacJ4kUgHFpoeU1XIS5Jc
	dmW52tNUXYxUPoskcbNbl0j5x7hou1+QAr5jDhYygnYfGjM0l+H/SIZFZ8XfeFR8
	i+uKLPIQgvvQ0PZTo6nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=GaDEVaEVCFZIXH9VFQhm6VwTkhq3m1YOIaoYHsxvE4rajB9kF
	qxwe8HNMWI/t1jEnQkTIwT0Nl2GqrwvYnmQEAhwk4qO32Uqb5EN1z/HsNUHBN+fx
	KtXqrzb0sUPEZe8m4Vpl+ofa2H6oti/jBI8o+t+xZsLTne/qn40rpW6EIM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D99CCD875;
	Sun, 22 Aug 2010 03:25:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9187FCD874; Sun, 22 Aug
 2010 03:25:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 759B4EF8-ADBE-11DF-8AC4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154175>

Clemens Buchacher <drizzd@aon.at> writes:

> I understand your point. But this is actually a great example. I
> have a bunch of such tests, which are not in shape for upstream,
> but I want to keep them around anyways (and run them). Do you
> really think that an untracked test which was added to
> .git/info/exclude should be considered trashable? If it were a
> generated file, it would have been added to .gitignore.

I agree that in such a workflow to keep untracked tests around, they
should not be considered trashable. But more importantly, as I have
already said, adding your untracked tests to exclude is a wrong thing to
do.

Traditionally (think "git status" output without "-s") the way to remind
oneself that some day these paths need to be added when they are ready has
been to keep them untracked but _not_ ignored, so that they will be listed
in the output.

Quite contrary to what you earlier said in another message, adding
such a path that is not trashable does defeat the point of the "ignore"
mechanism.
