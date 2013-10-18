From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My patches
Date: Fri, 18 Oct 2013 09:59:41 -0700
Message-ID: <xmqqtxgewm4i.fsf@gitster.dls.corp.google.com>
References: <20131012072450.GA21165@nysa>
	<xmqqtxgjg35a.fsf@gitster.dls.corp.google.com>
	<525c64ebe2390_197a905e84c@nysa.notmuch>
	<xmqq8uxrzn9h.fsf@gitster.dls.corp.google.com>
	<52605a36eef0f_448145fe7466@nysa.notmuch>
	<9A62D872-0FCF-41B9-B185-7061B25F1CBC@quendi.de>
	<52611e75bdc8d_2b6dcb7e7459@nysa.notmuch>
	<20131018153009.GA23704@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Max Horn <max@quendi.de>, git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Oct 18 18:59:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXDOv-0007KS-E6
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 18:59:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747Ab3JRQ7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 12:59:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33575 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756409Ab3JRQ7o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 12:59:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C709149A08;
	Fri, 18 Oct 2013 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hFsqvuQN3egx2l/3TMSPTPZd04E=; b=FX5ePH
	SGtUFMXEpqlaxdG7p3kirvcbWX0m5MHmI7vx7HxFpFupBo9mciYQCXHdKp9pQm0v
	PleNs8bOn4CBHu04MVFMXHfG4DtzfBwYbFDtiw5EMz7eLVZD301tbAW0Uc9QNxgy
	crr5YDsEA5Zh7dcQXjNSS2z/D6t3UgL0UGLQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NeRPy+Uo2cV0Qmq94hh7M74jQ72UukO7
	WepNt37IM20yaf8D5l3OqhXEhzy4ZBvKL6L7b0tQnxnwqrIiN6XRcLPrtMx3P7Fm
	nn7+Bj4M6G/QPhkkYJtwvEWZuIXs3jew43DcOkKyHzQfhS5lv34EuSY/i9r8B1/g
	52O+6oQ2I2Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9F5D49A06;
	Fri, 18 Oct 2013 16:59:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27B5649A04;
	Fri, 18 Oct 2013 16:59:43 +0000 (UTC)
In-Reply-To: <20131018153009.GA23704@thunk.org> (Theodore Ts'o's message of
	"Fri, 18 Oct 2013 11:30:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AF3D8BCC-3816-11E3-B8E2-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236359>

Theodore Ts'o <tytso@mit.edu> writes:

> Over the past 5+ years, I've observed that I
> think the way commit selection in "git format-patch" is inconsistent
> with how we handle commit selection for other commands, e.g., "git log
> <commit>" vs and "git format-patch <commit>".  Even if you think that
> this is a matter of self-inherent "truth", versus just a matter of
> taste, there is also the consideration of backwards compatibility, and
> the question of how important consistency and easy of learning gets
> traded off against backwards compatibility and invalidating
> potentially huge numbers of shell scripts and documentation.  So it's
> not something where I've made a nuisance of myself, because it's a
> settled issue.

The original syntax to select of commits by format-patch is very
inconsistent from the log family because it was done way before the
log family's way has been established as the best practice. It has
annoyed enough people that we spent effort to teach recent Git
to accept

	$ git format-patch master..next

as well.

So it indeed is a settled issue, but you are correct to point out
that we had to find a way to do so while still keeping the original
syntax working for people who have scripts and people who work from
random and stale documents we have not much control over updating.
