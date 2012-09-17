From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add userdiff patterns for Ada
Date: Sun, 16 Sep 2012 21:59:21 -0700
Message-ID: <7vfw6hxn12.fsf@alter.siamese.dyndns.org>
References: <50554D67.1020204@redneon.com>
 <7vboh6zek0.fsf@alter.siamese.dyndns.org> <50557D72.60205@redneon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adrian Johnson <ajohnson@redneon.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 06:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDTQj-0001H2-Bd
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 06:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524Ab2IQE7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 00:59:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59764 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab2IQE7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 00:59:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0992E9A0D;
	Mon, 17 Sep 2012 00:59:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KvYMkH4KstR75YlJ/A7eIm/OlIU=; b=cuDbjS
	xvnm4nVrUKMj+nsBOrntBjFlryudBSoj2YmK8q95xV7hZgWz/WlvW1csFIL3j4aj
	iHmD3Q24k7o0WQ4mTMuSXusEnikf9nFTIxDGyd2wZOLuqkwbdSrCGlCcEbKef5Lj
	NQbkiLsYSqsDn6CD9juk9LBYhdIO0spJ09h50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O62jnOnUB0fflQul7KYoZXAREW/9BzEe
	sFpGZHbaNqYhuOQj8MH0GdUdJl7c2fohdp+YknLpyJYc4bFQB5VxATrtjGrA29nM
	0XPX95valfpLMcJqNMqyf4jf2kgb3HeAqWNxX6CqnP9KyE5gg6eMjK3bcQZSnPpJ
	Wkf1eQq4qF0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E29249A0C;
	Mon, 17 Sep 2012 00:59:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F2159A08; Mon, 17 Sep 2012
 00:59:23 -0400 (EDT)
In-Reply-To: <50557D72.60205@redneon.com> (Adrian Johnson's message of "Sun,
 16 Sep 2012 16:49:14 +0930")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72AA19DE-0084-11E2-97E7-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205642>

Adrian Johnson <ajohnson@redneon.com> writes:

>> I do not seem to find anything interesting after @@, which means
>> that xfuncname is not tested at all even though the log message
>> claims the patch adds some.
>
> I probably misunderstood how the tests work. I thought t4034 tested
> wordRegex while t4018 is for xfuncname. I based the Ada tests on the
> Pascal tests but changed the operators to Ada operators. I'm not really
> sure what else the test needs.

The per-language for-loop you added ada to in t4018 is only to make
sure there is no regexp syntax error in the built-in xfuncname, and
does not check if the patterns make sense for the language at all.

You could add test vectors to check if the built-in xfuncname
catches beginning of functions in Ada correctly if you wanted to,
but I think observing what appears on @@ lines in t4034 test vector
would be a sufficient test.
