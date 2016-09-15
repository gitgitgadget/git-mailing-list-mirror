Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4742070F
	for <e@80x24.org>; Thu, 15 Sep 2016 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754876AbcIOUOI (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 16:14:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60662 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754781AbcIOUOH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 16:14:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB20D3D097;
        Thu, 15 Sep 2016 16:14:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fks2+cJYhr71r3LO/4NW0X4ugAk=; b=WbwPDy
        poeDveEPtOo4HcHNaTnP0Md5Vj+st7iCZzZXEGD9pfe7TLCUHgbOvpdkv6Y5g7Y6
        Mdkcs1PayE+T0WvhW2D8XmPCfmLADTD1Uqidrz63PsLsqPcVHCLEYqrQPXE+SdFR
        /pvAfcBkdud9kb/FDxxZYvuECjfOTc85jKQUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SbCPO4pbpvUq+mh4gEtu4WKP7OJ1XY3F
        la4ZKwk+2/arNnj/mUA+EIpbTl7heKTGSWgWT/+eGb0UoWWbeZBKlH+oTd5OKGlJ
        y1fnnOVdJFSLN99VMX2nZTaAkA8QViJGkLFCeXVIahk854pSIH/FZlGn1aHsczhl
        tWpIwvdv2kw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E4D053D096;
        Thu, 15 Sep 2016 16:14:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B9C53D095;
        Thu, 15 Sep 2016 16:14:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v3 04/14] i18n: blame: mark error messages for translation
References: <1473951548-31733-1-git-send-email-vascomalmeida@sapo.pt>
        <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
        <1473951548-31733-4-git-send-email-vascomalmeida@sapo.pt>
Date:   Thu, 15 Sep 2016 13:14:03 -0700
In-Reply-To: <1473951548-31733-4-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Thu, 15 Sep 2016 14:58:58 +0000")
Message-ID: <xmqqy42sncok.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F3A69D20-7B80-11E6-B2D0-46717A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> @@ -2790,7 +2790,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
>  	else {
>  		o = get_origin(&sb, sb.final, path);
>  		if (fill_blob_sha1_and_mode(o))
> -			die("no such path %s in %s", path, final_commit_name);
> +			die(_("no such path %s in %s"), path, final_commit_name);

This was missing in the earlier round, which is good to make it translated.

> -			die("file %s has only %lu lines", path, lno);
> +			die(Q_("file %s has only %lu line",
> +			       "file %s has only %lu lines",
> +			       lno), path, lno);

Looks good here, too.  I would have moved "lno)," at the beginning
of the third line to the end of the second line to make it easier to
read, but this is OK.

