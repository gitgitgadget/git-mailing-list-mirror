Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A126E1F859
	for <e@80x24.org>; Tue,  9 Aug 2016 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbcHITfz (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 15:35:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932305AbcHITfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 15:35:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87857330E9;
	Tue,  9 Aug 2016 15:35:53 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PxWHVtdil4HzCJbfIT2MTyh5dkk=; b=ttnrih
	FUteNDYDHkqSI+O4eI1dUAvFkTQgM9uaFwpV3DV0bwA0FyG3BTlUfyqKqqxkGwIr
	0//vH578/BAX3VOZRP2Hq3pVOLuB7MRTOJUo+oQhezDaHenKYSYN+XEwvlbY0rl0
	C3Fu8ZEVrcLTXyC1b3lEXUjdTGG93meFjBpS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xqPbxtU0L4H3Eikq9KSNub6ie41SJt0p
	xwkmvoSad2kjeCa5h7ApyDIAu76KLAiyV4jSrhqdt+J3HnxVr/3S+ll34YkNm/Aw
	K7yJAP9WV2WqOaJ4vSY03gyVhMjNVuSbHHXcenyvemLeTpS+NVdsY0LEBWU+fw0P
	iS01AdY6/2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7EA0C330E8;
	Tue,  9 Aug 2016 15:35:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 02EC0330E7;
	Tue,  9 Aug 2016 15:35:52 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Vasco Almeida <vascomalmeida@sapo.pt>
Cc:	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/3] i18n: archive: mark errors for translation
References: <1470654961-2842-1-git-send-email-vascomalmeida@sapo.pt>
	<1470654961-2842-2-git-send-email-vascomalmeida@sapo.pt>
Date:	Tue, 09 Aug 2016 12:35:51 -0700
In-Reply-To: <1470654961-2842-2-git-send-email-vascomalmeida@sapo.pt> (Vasco
	Almeida's message of "Mon, 8 Aug 2016 11:16:00 +0000")
Message-ID: <xmqqvaz991m0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BEEDD86-5E68-11E6-AF63-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
> ---
>  archive.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 42df974..dde1ab4 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -458,11 +458,11 @@ static int parse_archive_args(int argc, const char **argv,
>  	argc = parse_options(argc, argv, NULL, opts, archive_usage, 0);
>  
>  	if (remote)
> -		die("Unexpected option --remote");
> +		die(_("Unexpected option --remote"));
>  	if (exec)
> -		die("Option --exec can only be used together with --remote");
> +		die(_("Option --exec can only be used together with --remote"));
>  	if (output)
> -		die("Unexpected option --output");
> +		die(_("Unexpected option --output"));
> ...
> -		die("Unknown archive format '%s'", format);
> +		die(_("Unknown archive format '%s'"), format);
> ...
> -			die("Argument not supported for format '%s': -%d",
> +			die(_("Argument not supported for format '%s': -%d"),
>  					format, compression_level);

Hmm, this function is called by write_archive(), which can be called
by the upload-archive process running on the remote end, whose
locale certainly is different from that of your local environment.

If I do not read English and got one of these messages from the
remote end, I can copy that into a search engine to read more about
the error, but if I got it translated into, say, Portuguese, I'd
have a (slightly) harder time dealing with the error, I would think.

Having said that, I expect that sites that expect internatinal
audience to come would run these services in C locale, and other
sites that target audiences in a single locale would choose to use
their favourite single locale, so probably we do not have to worry
about it.

Thanks.
