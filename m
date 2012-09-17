From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: indent-with-non-tab uses tabwidth
 setting, not just 8
Date: Sun, 16 Sep 2012 23:03:29 -0700
Message-ID: <7v8vc9w5hq.fsf@alter.siamese.dyndns.org>
References: <1347815548-19305-1-git-send-email-wjl@icecavern.net>
 <7v392hxm94.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 08:03:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDUQp-0002Sa-Ce
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 08:03:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab2IQGDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 02:03:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50973 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab2IQGDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 02:03:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 568C166A3;
	Mon, 17 Sep 2012 02:03:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3yGH2mvax61WWSocUzV0ipC4Y5o=; b=CupKTx
	5zms6+5yt/5x38+8kw6xVxsOCE/ww9vWS5RRXyvPStmxoLZpFpPwhpQ0z2Im5gmD
	P9RO5sdigmwCJafw/zX18wbUZLtjUPRFOTNpMmpvgFLERfLXR/fvKsrb2N5DjrDy
	aZPOPjL1PijnNXQOeJllJezfVKFjmV7YMdG8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NvKXWKU6Obk9YkSOEw1oZ2pNc2BsA/On
	Ayx0IQkbnOaAhUIQTfhIOEkC0rqfImmKf9PNDo3V8U5Fy9N4HJQUktij+ZSilrrV
	7mCYzVYaOqIs+H2hDAtEOYa78OZYydTAnqBLqYPjnxQ6tZjWr1KuziLM6jyrny58
	WUPUU4lRcKY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 455E566A2;
	Mon, 17 Sep 2012 02:03:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A071B66A1; Mon, 17 Sep 2012
 02:03:31 -0400 (EDT)
In-Reply-To: <7v392hxm94.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 16 Sep 2012 22:16:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6869196C-008D-11E2-82B8-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205654>

Junio C Hamano <gitster@pobox.com> writes:

>> @@ -559,8 +559,8 @@ core.whitespace::
>>  * `space-before-tab` treats a space character that appears immediately
>>    before a tab character in the initial indent part of the line as an
>>    error (enabled by default).
>> -* `indent-with-non-tab` treats a line that is indented with 8 or more
>> -  space characters as an error (not enabled by default).
>> +* `indent-with-non-tab` treats a line that is indented with `tabwidth` space
>> +  characters or more as an error (not enabled by default).
>
> I would rather see this part left untouched.
>
> Your new text will force people who are not interested in using
> non-standard tab width to read through the bulletted list, only to
> find "The default tab width is 8".  I think that is a regression in
> the documentation for more common readers.
>
> When somebody wants to use `indent-with-non-tab` and gets offended
> by the seemingly hardcoded "8" in the description, the reader has
> incentive to find out if there is a way to change that 8, and will
> find `tabwidth=<n>` in the same bulletted list described, with the
> effect it has on both `indent-with-non-tab` and `tab-in-indent`.
>
> I think that should be sufficient for people who do use non-standard
> tab width using tabwidth=<n>.

An alternative would be to lose the "8" (or `tabwidth`) from that
description.  I've always thought that the description of `tabwidth`
is clear enough that "8" in the patch is not a hardcoded non-overridable
value but is merely a default, but after reading that section a few
more times, I no longer think that is the case.

I originally wrote "8 or more space" but that wasn't because I
thought it was important to stress "8 is the default", but because I
didn't think of a better way to say what I wanted to say, which was
"if you are filling the indentation with spaces when you could have
just typed a tab with a few spaces, this error triggers", in other
words "use of this is to encourage indenting with tabs".
