From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] format-patch: Add config option format.coverbodytext to change the cover letter body
Date: Tue, 06 Jan 2015 02:37:57 -0800
Message-ID: <xmqqzj9wp52y.fsf@gitster.dls.corp.google.com>
References: <1420486105-30242-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8RWX-0002ms-4Y
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbbAFKiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:38:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753313AbbAFKh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:37:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ECC1127072;
	Tue,  6 Jan 2015 05:37:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AD91e8n8kXHZGi+Ey5OiPH6Od/A=; b=DlHuRF
	CmVgkwUQ8AbeWJ+qWkAkDWXkkXgB8Yq0KqpR6sSqv1vvIzdz/VzgWzyfSTNCPaBG
	Eh35bC2yTVar/WXfQ6lTLcntpLxSxfHmHwI0wb1L2IL6gi036eD3ksfnObb/F0a3
	GSQTGrxFm936GLDz30uT5x9Z+NrO4CMV8vy/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rdi3KXLLPBpGemxbdSICRRCkXXhwCiiU
	NhZNO86bYGkhLymmAtXF6Miovn39V/hbjMMRiFmWKDgwIvxv4CJJngTWBkFLzroH
	nuuzFGII3znMHXetAigi97Zcd7P3eyguYLgyGQ4uOfOu6gEsY/Yf6T0V7MPtI+Ua
	9c1JlWeiTgs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E2ECE27071;
	Tue,  6 Jan 2015 05:37:58 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69CAE27070;
	Tue,  6 Jan 2015 05:37:58 -0500 (EST)
In-Reply-To: <1420486105-30242-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 5 Jan 2015 11:28:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14C7B58A-9590-11E4-851D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262054>

Stefan Beller <sbeller@google.com> writes:

> When sending out patch series one of the last things doing is writing
> the cover letter. The cover letter would be a good place to remind
> people to check the todo list for sending patches.

I do not quite understand.  Wouldn't a check-list be useful _before_
you start series of things (I am assuming that you meant a list like
1. run spell check; 2. run checkpatch; 3. run full test suite;
4. format the docs for HTML and manpage)?  Time to write cover
letter (or running format-patch in general) is way too late for
many of these things.

There may be a check-list that is still useful after commits to be
sent are perfect and ready to be formatted.  "Describe change since
the last round after three-dash line." would be one of them
("Sign-off the patch" is not---without one, the commits would not
have been perfect yet).  But for such a check-list, wouldn't we want
remainder not only on the cover but on each individual patch?

Perhaps --add-header="x-reminder: what changed since the last?"
would be sufficient for your purpose instead?
