From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/2] is_url: Remove redundant assignment
Date: Mon, 26 Sep 2011 09:52:54 -0700
Message-ID: <7vsjnj455l.fsf@alter.siamese.dyndns.org>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
 <1316927182-14212-2-git-send-email-pangyanhan@gmail.com>
 <CALUzUxp-++A7azzimE1mjvPVoGxRM4rzYt9z66CmFb0B3vi7dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pang Yan Han <pangyanhan@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:53:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8EQX-0001Db-Qe
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523Ab1IZQw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 12:52:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33798 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab1IZQw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 12:52:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BFB5891;
	Mon, 26 Sep 2011 12:52:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6VHdwPhX/DBO3GjMbp3xmhR5aDU=; b=vGbZ/R
	CbI4pWXn/k1Wo6xHD1JzUobBqUtihIR0cUhzxgE7r/0rWPfD6m5CG6mYplbZGX0j
	rszN+Zxh/AAgQpprNWu8Id1ZwU5MmDKw5ckv0pSKFaGFpa7ODkGnO4olQjv+Rf5d
	Q5FIlHCC86p02cdr91vMYW9i6GXKBf8XW+doo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NqWwP2U6f33HkUKnpM32oWFM/AVnAZfv
	EV6C/N18oy5qJqSbsQQH4wGwD0ZUSCfNXyT47qM59NxJgmfkVM+chOeJQknx1oxW
	TPVtTRIAU4kznsauSKWodEQaUM7RE6bk+Y86jsHYrX0GGOMtkgUsMPkZCyhtDXGI
	DnmTMuJ84lY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB1185890;
	Mon, 26 Sep 2011 12:52:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 75BF4588F; Mon, 26 Sep 2011
 12:52:56 -0400 (EDT)
In-Reply-To: <CALUzUxp-++A7azzimE1mjvPVoGxRM4rzYt9z66CmFb0B3vi7dQ@mail.gmail.com> (Tay Ray
 Chuan's message of "Sun, 25 Sep 2011 17:26:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FBCCC3E4-E85F-11E0-9B40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182133>

Tay Ray Chuan <rctay89@gmail.com> writes:

> On Sun, Sep 25, 2011 at 1:06 PM, Pang Yan Han <pangyanhan@gmail.com> wrote:
>> Signed-off-by: Pang Yan Han <pangyanhan@gmail.com>
>> ---
>>  url.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/url.c b/url.c
>> index 3e06fd3..d2e17e6 100644
>> --- a/url.c
>> +++ b/url.c
>> @@ -22,7 +22,6 @@ int is_url(const char *url)
>>
>>        if (!url)
>>                return 0;
>> -       url2 = url;
>>        first_slash = strchr(url, '/');
>>
>>        /* Input with no slash at all or slash first can't be URL. */
>
> Looks correct. Perhaps you could mention in the patch message that
>
>   There are no operations on url2 until another assignment to it later
> at line 41.

The looks correct, so I'll queue it, but it looks like that the function
is implemented in an overly complicated way.

Why aren't we checking from left to right in a single pass, perhaps like
this?

	/* Make sure it is of form "scheme://something" */
	int is_url(const char *url)
	{
		/* Is "scheme" part reasonable? */
		if (!url || !is_urlschemechar(1, *url++))
	        	return 0;
		while (*url && *url != ':') {
			if (!is_urlschemechar(0, *url++))
				return 0;
		}
		/* We've seen "scheme"; we want colon-slash-slash */
		return (url[0] == ':' && url[1] == '/' && url[2] == '/');
	}
