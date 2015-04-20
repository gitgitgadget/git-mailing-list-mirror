From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Mon, 20 Apr 2015 12:28:55 -0700
Message-ID: <xmqq8udmlhu0.fsf@gitster.dls.corp.google.com>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 21:29:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHNS-00051H-Km
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:29:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbbDTT3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:29:00 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50581 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753177AbbDTT26 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:28:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CD1248D58;
	Mon, 20 Apr 2015 15:28:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jD25yf8lOQ6JnQHRsSLVIpeXlMI=; b=imy6mM
	k7p8FGfhoWO+WShfHZWSmqt2nrlPnXFvyB0AR7POoeSGbeyWoDqfl6P9/VK8OlQK
	qkg+e5G6DCTZETqEBVawO/8hG8ZsntMn1rREJ8dyE17RtJR2E/Bs11oWo4IMoLUl
	Cd3KsC6ppatWh1e2FwYkFn30cuSCEM2G1/DHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qy9VIMsUnKylHhTHU+eRXExGIRYosguH
	Y8yL8hpeXXpOpz0snxUG5Dejp1ikM+XFmuE6PRDEnqfsv831FrpFX9yqReL+Z96T
	9Y2eRNnTYuVX10KjCC0j9TMWXsyr6pFu6CrUoeQkCT0mHO6+kKnXzidPXILQ7/Il
	qLN1osMEVs4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 652C448D57;
	Mon, 20 Apr 2015 15:28:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C820848D52;
	Mon, 20 Apr 2015 15:28:56 -0400 (EDT)
In-Reply-To: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 18 Apr 2015 18:39:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7CD2C1C4-E793-11E4-BDA9-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267492>

Junio C Hamano <gitster@pobox.com> writes:

> This is primarily note-to-self; even though I haven't got around
> bisecting yet, I think I know I did some bad change myself.
>
> "git pull $URL $tag" seems to:
>
>  * fail to invoke the editor without "--edit".
>  * show the summary merge log message twice.

We seem to be making a good progress on the discussion on this
specific issue, but a larger tangent of this is that we do not seem
to have test coverage to catch this regression.  As we are planning
to rewrite "git pull", we need to make sure we have enough test
coverage to ensure that nothing will regress before doing so.

Thanks.
