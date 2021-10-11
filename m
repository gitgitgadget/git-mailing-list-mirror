Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3646EC433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1357460EE2
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 20:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhJKUGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:06:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53109 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhJKUGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 16:06:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A708F1633B3;
        Mon, 11 Oct 2021 16:04:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=30LK+DqrEyQFDvWqedMlUJ/enqHkbON/4+aT6i
        kzCio=; b=Pzl9lKPPuG96K2fXBBJAJfXVp8Qg5NdDnSevBMzSRv0F+W1mXLl6KI
        f2z+amUoJNe63qv+GH9gy//CmdtwIugeuPidlw+KDHD5eO7wuLI1Mcar1nhy+zMX
        uoDq0XAzWKpKZbMXq9y0OByEA7g1dQS5Xu/blRAppPzgMuatl+cqE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FF621633B2;
        Mon, 11 Oct 2021 16:04:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0C2FC16335B;
        Mon, 11 Oct 2021 16:04:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rob Browning <rlb@defaultvalue.org>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] signature-format.txt: add space to fix gpgsig
 continuation line
References: <20211009163338.2175170-1-rlb@defaultvalue.org>
        <YWRpPw4eTwTmgVvC@coredump.intra.peff.net>
Date:   Mon, 11 Oct 2021 13:04:48 -0700
In-Reply-To: <YWRpPw4eTwTmgVvC@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 11 Oct 2021 12:41:35 -0400")
Message-ID: <xmqq4k9ncopr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D9C20D4-2ACE-11EC-A0D3-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Oct 09, 2021 at 11:33:38AM -0500, Rob Browning wrote:
>
>> Add a space to the blank line after the version header in the example
>> gpgsig commit header.
>
> Thanks, this is a good catch. The space is important for the header
> continuation.
>
>> diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
>> index 2c9406a56a..6acc0b1247 100644
>> --- a/Documentation/technical/signature-format.txt
>> +++ b/Documentation/technical/signature-format.txt
>> @@ -78,7 +78,7 @@ author A U Thor <author@example.com> 1465981137 +0000
>>  committer C O Mitter <committer@example.com> 1465981137 +0000
>>  gpgsig -----BEGIN PGP SIGNATURE-----
>>   Version: GnuPG v1
>> -
>> + 
>>   iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
>>   HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
>>   DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA
>
> The patch is quite subtle to read, of course. :) But more importantly,
> it is subtle for somebody reading the documentation to notice. Perhaps
> it's worth calling it out explicitly? E.g., squashing in something like:
> ...
> -  (content is preceded by a space)
> +  (content is preceded by a space; note that this includes the
> +   "empty" line between the GnuPG header and signature, which
> +   consists of a single space).
>  - example: commit with subject `signed commit`

To those who are reading on paper or on terminal, the difference
will not be even seen.  It only can be _found_ if you are in an
editor or a pager and explicitly look for a trailing whitespace (or
told your tool to highlight such for you).

I wonder if we can have some typesetting convention for this part of
the documentation.  Perhaps something like

    In the following example, the end of line that ends with a
    whitespace letter is highlighted with a "$" sign; if you are
    trying to recreate these example by hand, do not cut and paste
    them---they are there primarily to highlight extra whitespace at
    the end of some lines.

before a displayed material like this:

  committer C O Mitter <committer@example.com> 1465981137 +0000
  gpgsig -----BEGIN PGP SIGNATURE-----
   Version: GnuPG v1
   $
   iQEcBAABAgAGBQJXYRjRAAoJEGEJLoW3InGJ3IwIAIY4SA6GxY3BjL60YyvsJPh/
   HRCJwH+w7wt3Yc/9/bW2F+gF72kdHOOs2jfv+OZhq0q4OAN6fvVSczISY/82LpS7
   DVdMQj2/YcHDT4xrDNBnXnviDO9G7am/9OE77kEbXrp7QPxvhjkicHNwy2rEflAA

perhaps?

I am reasonably sure that running "git am" on Rob's patch will by
default end up as a no-op patch, because auto-correcting whitespace
breakage is the default setting I use, and a change like the one
suggested above would help avoid such a problem, too.

Thanks.

