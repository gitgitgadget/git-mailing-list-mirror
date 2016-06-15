From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 3/3] merge-recursive: When we detect we can skip an
 update, actually skip it
Date: Wed, 02 Mar 2011 15:23:53 -0800
Message-ID: <7v1v2payye.fsf@alter.siamese.dyndns.org>
References: <1298941732-19763-1-git-send-email-newren@gmail.com>
 <1298941732-19763-4-git-send-email-newren@gmail.com>
 <7vwrkhb7ig.fsf@alter.siamese.dyndns.org>
 <AANLkTin1EDUMRY7T+Jx64eG6R4mOZOeOukJWQHpFX+j5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
	Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 00:24:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuvOt-0004zE-OG
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 00:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240Ab1CBXYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 18:24:06 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752442Ab1CBXYE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 18:24:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADF673293;
	Wed,  2 Mar 2011 18:25:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=47ODSt7K2lGSuPIk7epnofWVdDI=; b=mIwfTg
	l0IYnYqxb6uNbxnnnL0cEA7S7S+4FAY878ReX+WRsBbOUZNs6HD1HskfmZGVfUYb
	UkjN0b3pinry7nDPQcR9JbVrzyMBBcEb2grSuXuYGkd4Qlj5PKp534BWfDEFshyn
	HzFz+tUl8vgPD67v0JDQKaMjXu+r2tqFUgOqw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EJyzWNKrqYYB+qIz9YAqBu+5oOgxelfL
	lyczJ88uUI8joas3Hbm8CiIbHYvgSPf5/pEJmA6aOsNvijhJxkNYVFlU052Sgkv0
	ROzTkHHgLwuRhtTe9Dx8SmImQUKPYDgw9pfHydOWeXzQWOosjk8v1JsIwNaikYsC
	DMX+KXlSdF4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CB3B3292;
	Wed,  2 Mar 2011 18:25:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2BCD4328F; Wed,  2 Mar 2011
 18:25:15 -0500 (EST)
In-Reply-To: <AANLkTin1EDUMRY7T+Jx64eG6R4mOZOeOukJWQHpFX+j5@mail.gmail.com>
 (Elijah Newren's message of "Wed\, 2 Mar 2011 15\:22\:49 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57BA28C0-4524-11E0-8A74-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168362>

Elijah Newren <newren@gmail.com> writes:

> Suggestions?

Other than not doing the remove way before the code knows that it is
necessary to get rid of the path because there needs to be a directory?
No.

Personally, I've long given up on d/f conflict codepath in merge-recursive
as unsalvageable, short of a total rewrite.  As I said in the other
message, the patch you sent in is a good enough fix within the context of
the current code.
