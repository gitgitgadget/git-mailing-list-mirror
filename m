From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] mingw: rename WIN32 cpp macro to GIT_NATIVE_WINDOWS
Date: Sun, 28 Apr 2013 22:46:07 -0700
Message-ID: <7v38u9opnk.fsf@alter.siamese.dyndns.org>
References: <517C29BE.6050002@ramsay1.demon.co.uk>
	<20130429051059.GC8031@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 07:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWgul-0006xy-Lj
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 07:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab3D2FqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 01:46:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53916 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710Ab3D2FqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 01:46:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEC22139BB;
	Mon, 29 Apr 2013 05:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=baC5EjPMmnRed+IX26YWCDMrA7U=; b=wJYo1d
	7/LDjYs/o46lyWzajk5tFAAbC9xVQgwrbja+qKyY6ydC6q4MpwhjmPfjYc9LHB7K
	6QOMIxCaYbRr8fdwkn7qUlGHtmzRTSqsgjwfEa1pZ/0eSXyTcHit4kWxoJ2vw8mh
	w2BupTQjpx/1ElLTFn9vvbdhiV8mQJ4IdMWtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WBXjmo/6iSzDvp6WEQe8B61DnfJj2rP+
	1TACi+2EUAMvXgWwfPzP4ofV1hm7GmP9Ub8HOihLfAxq31YWX+E4x7Qotlas0BNJ
	A4i1nf01bhg32+ZIDZ5htUsVXKcwOwV3tW8kzSUma77h4BZa9DZ0Qo+zkhO+QZtR
	DmXuCn+l7hg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3541139B9;
	Mon, 29 Apr 2013 05:46:09 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35DF6139B7;
	Mon, 29 Apr 2013 05:46:09 +0000 (UTC)
In-Reply-To: <20130429051059.GC8031@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 28 Apr 2013 22:11:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 179AA29A-B090-11E2-87A1-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222775>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ramsay Jones wrote:
>
>> After this change, it should be possible to drop the
>> CYGWIN_V15_WIN32API setting without any negative effect.
>>
>> [rj: %s/NATIVE_WINDOWS/GIT_NATIVE_WINDOWS/g ]
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>
> Yay!  Thanks for finishing it.
>
> For what it's worth,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Wait.  The proposed commit log message talks about native-windows
but throughout the code it is windows-native [I'll reword when I
rebase-i to add your reviewed-by].

While I really like seeing an unfinished topic completed by tying
its loose ends like this patch does, it feels a bit too late for the
cycle, especially given that we _know_ the changes still need to be
tested on a platform that the series is expected to affect.

Could somebody who builds regularly on Cygwin 1.7 try to see if
these two patches are OK?

Reports from people without previous experience with Git on Cygwin
who freshly install Cygwin 1.7 only to test these two patches do not
count, because they do not know what is expected and cannot tell
regressions from know limitations.

Thanks.
