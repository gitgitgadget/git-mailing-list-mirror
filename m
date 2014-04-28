From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 11:15:10 -0700
Message-ID: <xmqq1twhs4lt.fsf@gitster.dls.corp.google.com>
References: <20140427233635.96eec638b311907e2368f42b42021fd8.fa0e4193ea.wbe@email02.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johan Herland" <johan@herland.net>,
	"Git mailing list" <git@vger.kernel.org>,
	"Jeremy Morton" <admin@game-point.net>
To: "Max Kirillov" <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:11:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Weqy2-00085L-If
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbaD1TKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:10:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43264 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbaD1TKM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:10:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6637F81476;
	Mon, 28 Apr 2014 14:15:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/mU6Bz/qxoBEsT6rOac3javh2Lk=; b=dygn8i
	vhPnv5gxdoej4guDxjgE+0nKXhN2C2nSbFXQXfa0fsNHObadNZP5Dp7moIpSVTeB
	Xdv4SocCr8qTTceXnRXi8/X7bWohMfAWr4Rn0O0VHI+5KLFzWfLp6kCUNEzULJj/
	xhTlJ8taVcMAyY45VmnMEIJ1W0/zIwdXcZq6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E2H3tzxgGFAU4tX019QjpRiQxWH1JPrl
	z0mXceDgwovGnoiTdICUxB8ee5F1VYWXB1wQELhnipUeXq6a/U4R4rwOVzPm69ta
	Z+7hMtBgfgKRR2M4f6i9zpsTZNw0XQ/Wy7fbNAca/CW33Y3oI2Y1WPy1jsV4Cre2
	TenlfiEXqv8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E9AD81475;
	Mon, 28 Apr 2014 14:15:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E457481469;
	Mon, 28 Apr 2014 14:15:11 -0400 (EDT)
In-Reply-To: <20140427233635.96eec638b311907e2368f42b42021fd8.fa0e4193ea.wbe@email02.secureserver.net>
	(Max Kirillov's message of "Sun, 27 Apr 2014 23:36:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 09FE5BA0-CF01-11E3-95B5-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247387>

"Max Kirillov" <max@max630.net> writes:

>> Obviously, the feature would necessarily have to be optional, simply
>> because Git would have to keep understanding the old commit object
>> format for a LONG time (probably indefinitely), and there's nothing
>> you can do to prevent others from creating old-style commit objects.
>
> Doesn't git ignores unknown headers? I has been investigating this issue
> and it looked like it does.
>
> Could the API to add commit headers (which exists in sources) be added
> to cli, so users can create the branches, phases or whatever they feel
> useful?

We had lengthy discussions in early 2010 [*1*].  The whole thread,
at least the whole sub-thread that contains the focused message, is
a required reading to understand where we stand with respect to
"extra headers in commit objects".

"Any additional information about the commit can be added" you
suggest is exactly the kind of thing we want to avoid, which made
Linus say in an even older discussion [*2*]:

    No "this random field could be used this random way" crud,
    please.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/138848/focus=138892
*2* http://thread.gmane.org/gmane.comp.version-control.git/19126/focus=19149
