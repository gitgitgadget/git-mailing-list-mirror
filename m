From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 15:04:41 -0800
Message-ID: <xmqq61djf6nq.fsf@gitster.dls.corp.google.com>
References: <20141206020458.GR16345@google.com>
	<xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
	<20141209201713.GY16345@google.com> <20141209202738.GC12001@peff.net>
	<20141209222337.GA16345@google.com> <20141210084351.GA29776@peff.net>
	<5488A87C.4030505@alum.mit.edu> <20141210215154.GF16345@google.com>
	<xmqqlhmff8cs.fsf@gitster.dls.corp.google.com>
	<20141210223721.GG16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 00:04:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyqJN-0008QV-Nj
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 00:04:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756980AbaLJXEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 18:04:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62193 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752164AbaLJXEo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 18:04:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D169525480;
	Wed, 10 Dec 2014 18:04:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WXrO3BmQ4osTzYgn/00IDPeI0kM=; b=SAbBBE
	+K8Vh6b96jzc4CF9aLtY4ZPwWfwVeyftpfZC6Idka39dndw5E83cfcH8FNYBYrSU
	FHDZdDWvRUshqhyLeK287Tu0Ou0kd797qPz3++nbtprMq4zgkHnzhitVhat8SKSx
	JlOydi7FO5eO5gwk4iB5MydwIo9L6/1AA2oow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=trJLs/uqTDqSCy1RfJFigl1aMZJPwuZo
	RB/+fiJ5qeBkDZySzxRNoZiAXNWy7e3uJSFnPlz0KHZFmGq7fvJKK1wG16FdmzOi
	v29+5j8uL/nsSgjz7xivRdtlhQLPOIfrXo3heBJjRUtGC79rdGOFfHH3U5ctnduZ
	0CnXA4NJl0A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C18982547D;
	Wed, 10 Dec 2014 18:04:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3743B2547A;
	Wed, 10 Dec 2014 18:04:42 -0500 (EST)
In-Reply-To: <20141210223721.GG16345@google.com> (Jonathan Nieder's message of
	"Wed, 10 Dec 2014 14:37:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ECCF8852-80C0-11E4-AE12-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261255>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Some possibilities, in order of my preference (earlier items are better):
>
>  1. Move documentation to header and provide a program to generate a nice
>     standalone document.
>
>  2. Move documentation to header, being careful enough that the header
>     sort of works as a standalone document.
>
>  3. Move documentation to Documentation/technical/ and keep the header
>     bare-bones.
>
>  4. Status quo (comprehensive documentation for some functions in both
>     places, for others in only one place, no reliable way for someone
>     to find the information they need in one place).
>
> Since (3) is better than (4), I wrote simple patches to do that for
> strbuf.h and string-list.h.  I meant them in earnest --- I hope they
> get applied.
>
> I think peff was working on (2), which is an admirable goal.  The
> patch seemed to be incomplete.

Yeah, I agree with the above preferred ordering, and also think once
we get to (2) it would be "usable" by the intended audience.  Those
who prefer (1) over (2) are the ones who somehow want to read hard
copies ;-) and are likely to be different audiences and are better
served by people with different skill-set and inclination.

I am not sure if (2) and (3) are that incompatible, though.  If you
had an acceptable version of (3), wouldn't it be just the matter of
indenting the whole thing with "s/^/ */", sprinkle "/**" and "*/" at
strategic paragraph breaks, and move them back to the corresponding
header?
