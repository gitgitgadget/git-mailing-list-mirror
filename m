Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474C520248
	for <e@80x24.org>; Fri,  5 Apr 2019 01:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfDEB1C (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 21:27:02 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59766 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfDEB1B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 21:27:01 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CD2704FC47;
        Thu,  4 Apr 2019 21:26:56 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=qPgmW5mRl7+f2wU6KxpIdjzWMwc=; b=RHGxoX+
        C7bdJITAS2Hio4JNzODphDGQnrNPYc18fbhDrDu4JhGRgNAjmVCtalm370C6cdyN
        03pdPHipZ4SpkYFLrZjVqwY5xAsVV4qZhbvuU1wEv9p04XcRgiV7ANQ/K2oibvZ9
        AaOH2hFUtFcWWhqdaW9m5NQCHcA2w+h76MGw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=f6pkxnyDgYpEUUHhJVEXEejCcvO86pXRs
        B/VYwMtCIV1OJ2Ct8wtHbIYwst7Yuxk4aEMR+t9AeZhMnf5uZNwg0952mwZqL+QS
        Wu9KwNFMGXfemrvB4+/mpHSTt5SVLGzHG3v6SaJw/IL4tZS0j8Zpl9t7aqd2ObvF
        bSSxxHHIzg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C53054FC46;
        Thu,  4 Apr 2019 21:26:56 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C4424FC40;
        Thu,  4 Apr 2019 21:26:53 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 4 Apr 2019 21:26:50 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 2/2] Documentation/git-status: fix titles in porcelain
 v2 section
Message-ID: <20190405012650.GP4047@pobox.com>
References: <20190330183001.16624-1-tmz@pobox.com>
 <20190330183001.16624-3-tmz@pobox.com>
 <20190401131831.GA12254@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401131831.GA12254@sigill.intra.peff.net>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: E50208B4-5741-11E9-8CD5-EE24A11ADF13-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Sat, Mar 30, 2019 at 02:30:01PM -0400, Todd Zullinger wrote:
> 
>> Asciidoc uses either one-line or two-line syntax for document/section
>> titles[1].  The two-line form is used in git-status.  Fix a few section
>> titles in the porcelain v2 section which were inadvertently using
>> markdown syntax.
> 
> Yep, makes sense. One observation:
> 
>> -### Branch Headers
>> +Branch Headers
>> +^^^^^^^^^^^^^^
> 
> The one-line equivalent in asciidoc would be something like:
> 
>   === Branch Headers
> 
> but that's actually a "level 2" header (because it counts from zero),
> whereas "^" underlining is a "level 3" header. But I think "^" is right
> here, because this is under level 2 "~" header.

Yeah, since there were a number of existing two-line headers
in the document, I thought it would be better to simply
update these to that form than convert the others.  We have
far more of the two-line form too, so it's more consistent
with the existing docs.

>> As an aside, while I was reading the Asciidoc/tor manuals, I notice the
>> two-line title syntax was not mentioned in Asciidoctor.  That seems to
>> be because Asciidoctor has suggested the two-line title format should be
>> deprecated, as discussed at:
>> 
>>     https://github.com/asciidoctor/asciidoctor/issues/418
>> 
>> I'm not sure how likely that is to occur.  With the 2.0 release,
>> asciidoctor plans to use semantic versioning, so I would not expect any
>> deprecation to happen before at least 2.1.  It would only affect use
>> without compat-mode.
> 
> I think it's probably fine to punt on this until we see some actual
> movement upstream on the deprecation / removal.

No doubt.  I'm sure that would be a long deprecation period.

> One side note. The original asciidoc user guide says one-line headers
> have equals on either side, like:
> 
>   === Branch Headers ===
> 
> but that one can omit the trailing delimiter. The asciidoctor reference
> just suggests using the one-sided:
> 
>   === Branch Headers

Interesting.  I didn't notice the matching right hand side
while I was looking at the original asciidoc manual.

> So presumably if we do want to convert, we would just go with the
> one-sided version.

Seems like a good rule.  I presume that when in doubt, we
should look to the Asciidoctor reference for the current
best practice.

Thanks,

-- 
Todd
