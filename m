From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Wed, 19 Mar 2014 18:22:40 +0100
Message-ID: <871txygl27.fsf@fencepost.gnu.org>
References: <20140314235735.GA6959@ibr.ch> <20140315001855.GK15625@google.com>
	<xmqq61nceidp.fsf@gitster.dls.corp.google.com>
	<20140318221844.GA828@google.com>
	<xmqqfvme5cql.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, Uwe Storbeck <uwe@ibr.ch>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:23:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKD3-0004ZO-Il
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759456AbaCSRXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 13:23:17 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:57533 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759453AbaCSRXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:23:16 -0400
Received: from localhost ([127.0.0.1]:56572 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WQKCw-0001NF-JH; Wed, 19 Mar 2014 13:23:14 -0400
Received: by lola (Postfix, from userid 1000)
	id 66377EAD49; Wed, 19 Mar 2014 18:22:40 +0100 (CET)
In-Reply-To: <xmqqfvme5cql.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 19 Mar 2014 10:17:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244465>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Junio C Hamano wrote:
>>>> Uwe Storbeck wrote:
>>
>>>>> +	printf '%s\n' "$@" | sed -e 's/^/#	/'
>>>
>>> This is wrong, isn't it?  Why do we want one line per item here?
>>
>> Yes, Hannes caught the same, too.  Sorry for the sloppiness.
>>
>> We currently use "echo" all over the place (e.g., 'echo "$path"' in
>> git-sh-setup), and every time we fix it there is a chance of making
>> mistakes.  I wonder if it would make sense to add a helper to make the
>> echo calls easier to replace:
>
> I agree that we would benefit from having a helper to print a single
> line, which we very often do, without having to worry about the
> boilerplate '%s\n' of printf or the portability gotcha of echo.
>
> I am a bit reluctant to name the helper "sane_echo" to declare "echo
> that interprets backslashes in the string is insane", though.

raw_echo

-- 
David Kastrup
