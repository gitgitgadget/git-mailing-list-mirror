Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 010CA1F462
	for <e@80x24.org>; Wed,  5 Jun 2019 16:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfFEQVK (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 12:21:10 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53380 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbfFEQVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 12:21:09 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDF046AE6F;
        Wed,  5 Jun 2019 12:21:07 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=eWXZlfj14MHScVXuZX/dnB45Pmo=; b=DSXR8h1
        ArqPnaoT//z/WIbENGSOmfo+wVtrL/7BEwW7uLKiAij8OpxUdrS+RmBt+2UrKQdu
        7MI3V1J4JOWQqkXBkTYz0JH44A49Y79Zq89iDIgmxT29Y8oQjGp0hTo8JYOJtCCn
        O3BQxNpfmh4sHa6alg7AnoZZO28Y3ZVKbzX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=mDU/z4pyU0r2k9JdUxMbYQOjuk2QuJhm9
        iHDGHF/jD5N5SXuK7IpFBwQJltmJyYjqUSz97KEkAk5U+QIkvx+VHSOH77qTVlzZ
        4z01xhsBV9dpOI5sOs/cRBS+vsD3Ols+NVeriULDPFmkKwhKbVmKACmAyVTO5wWN
        5IWJsrSFks=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C65856AE6E;
        Wed,  5 Jun 2019 12:21:07 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [173.67.141.44])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8E1726AE6C;
        Wed,  5 Jun 2019 12:21:04 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Wed, 5 Jun 2019 12:21:01 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags
 be GPG-signed
Message-ID: <20190605162101.GX3654@pobox.com>
References: <139144069.10140489.1559664262817.JavaMail.zimbra@desy.de>
 <20190605155300.26506-1-tigran.mkrtchyan@desy.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605155300.26506-1-tigran.mkrtchyan@desy.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: EABB495E-87AD-11E9-A58D-8D86F504CC47-09356542!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Tigran Mkrtchyan wrote:
> diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.txt
> index 663663bdec..675483c3c3 100644
> --- a/Documentation/config/tag.txt
> +++ b/Documentation/config/tag.txt
> @@ -8,6 +8,13 @@ tag.sort::
>  	linkgit:git-tag[1]. Without the "--sort=<value>" option provided, the
>  	value of this variable will be used as the default.
>  
> +tag.gpgsign::
> +	A boolean to specify whether all tags should be GPG signed.
> +	Use of this option when running in an automated script can
> +	result in a large number of tags being signed. It is therefore
> +	convenient to use an agent to avoid typing your gpg passphrase
> +	several times.

I think the variable should be camelCased, i.e. tag.gpgSign,
for consistency with other documentation.

-- 
Todd
