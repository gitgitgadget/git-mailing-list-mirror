From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 16:00:34 -0700
Message-ID: <xmqqtx9m70fh.fsf@gitster.dls.corp.google.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
	<5355793A.5020000@gmail.com> <53558476703cb_5c94d452ec4e@nysa.notmuch>
	<53558A54.4060801@gmail.com> <53558ae6f1282_604be1f30cf3@nysa.notmuch>
	<53559020.1050407@gmail.com>
	<xmqqa9be8i4o.fsf@gitster.dls.corp.google.com>
	<53559b0cc066_6c39e772f09d@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilya Bobyr <ilya.bobyr@gmail.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 01:01:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcND4-0005fW-CX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 01:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbaDUXAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 19:00:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56803 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982AbaDUXAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 19:00:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53DC07FB4A;
	Mon, 21 Apr 2014 19:00:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=34T+virdF44X1xuMhGiWeu70hIU=; b=mTNX5c
	t+7ddeZx43jfuuL+epYnV+nKV0DU+UxFZ9bIKAL8P92u3vrTdqVMLyKMRaEl21P9
	3vRnYtFirjGoncnipO4KXsr5I5tGNCpGkd+jwL9kM7e97RCgMCDifLM5XwCvCd+r
	cqu27SqCoJpvZ0lzwnwd0MzpQ4omcl2iJNiLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZxEu9GztxMY2RySTqHlLbdEmwoio4X9i
	yn3GscNJmNSmEq3WLH5vPene6d74bK0lWHvQYpPeh3OLJMxS68qYHTw/Ke7RoTez
	0lf1tQwXBtPiMBNotVK9O2VDC6wEMGwcXNtChWA3cCFERno52WHZQAhvjtt0MBqp
	Rtb7rIfTvfQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38F357FB49;
	Mon, 21 Apr 2014 19:00:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AEF27FB48;
	Mon, 21 Apr 2014 19:00:36 -0400 (EDT)
In-Reply-To: <53559b0cc066_6c39e772f09d@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 21 Apr 2014 17:26:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BFD4744A-C9A8-11E3-A958-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246677>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> ... there are _already_ hooks without pre/post.

Like commit-msg?  Yes, it would have been nicer if it were named
verify-commit-message or something.

Old mistakes are harder to change because of inertia.  It is not a
good excuse to knowingly make a new mistake to add new exceptions
that the users need to check documentations for, is it?

> And it's not confusing,

A simple fact that Ilya asked the question tells us otherwise ;-)

I personally do not see an immediate need for post-update-branch,
but if the new hook is about intervening an operation, it would be a
good idea to name the hook with "pre-" like other "before doing
something, validate the operation and forbid" hooks.  Otherwise it
would be impossible to later add "post-update-branch" for whatever
reason without inviting "why does pre-update-branch hook is misnamed
as just update-branch, when other validation and post-action pair
are named pre-something and post-something?".
