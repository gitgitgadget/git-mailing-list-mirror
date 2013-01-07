From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #03; Sun, 6)
Date: Sun, 06 Jan 2013 21:13:02 -0800
Message-ID: <7v6239lgo1.fsf@alter.siamese.dyndns.org>
References: <7vip79lnnb.fsf@alter.siamese.dyndns.org>
 <7vehhxllvz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Jan 07 06:13:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts51b-0003vD-5p
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 06:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab3AGFNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 00:13:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753674Ab3AGFNF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 00:13:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FA6FA80D;
	Mon,  7 Jan 2013 00:13:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w8wYWj0Z8r0TCd3pz8b7hMWI40A=; b=hqiFFR
	WxeeNiNu23IJzSWflHHyRkdqbGCkhbaNXYyveYlL5xfVKSuNqAGGHkxcdcLQsNse
	BSYuD5LQ5e3IACzB7/ZWkdL+X9MngGMmCab2V9XVSPDqdmF1tZmJ8Rv0TO8TvFSb
	Uiyt45JZp9KL7nyacx0khcn+42ML135fzPQ5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZpwFyOMxZfOQ9ODIM3zothBh1+obLELW
	yPOlIe43LtAGy7wNW4S8AfVmN/Xgwdw66RixIHo0PbFIFPAcJjRK2hUPlK8cDK53
	aO5nIxYwTRrIZ88om7qgvipyEOmXzYHbpJeQXQGOsTNHRQjDenXmvubQAGGxAcyd
	yaEPPymsnpc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7187FA80C;
	Mon,  7 Jan 2013 00:13:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D762DA80B; Mon,  7 Jan 2013
 00:13:03 -0500 (EST)
In-Reply-To: <7vehhxllvz.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 06 Jan 2013 19:20:16 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E9FB48B2-5888-11E2-9D35-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212876>

Junio C Hamano <gitster@pobox.com> writes:

> I forgot to say that tonight's 'pu' seems to break t0008 and does
> not pass the self-test. I didn't try figuring out if this is the
> result of some mismerge, or one (or more) of the topics are broken.

An addendum.  This comes from the check-ignore patch and seems to
manifest itself when the test is run under /bin/dash (not bash).

Due to the mini-harness the test introduces, the output from running
the script with "-v -i" was not very helpful, and I stopped digging
at that point.

$ dash t0008-ignores.sh -i -v
...
expecting success:
                expect "$expect" &&
                eval "$code"

not ok - 64 existing tracked file at top-level not ignored
#
#                       expect "$expect" &&
#                       eval "$code"
#
