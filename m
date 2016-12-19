Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582EC1FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 22:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755901AbcLSWFA (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 17:05:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51847 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753270AbcLSWE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 17:04:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A25B5A6C5;
        Mon, 19 Dec 2016 17:04:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D1R1syoZsttoHd11sTmyauic9aI=; b=NtrNxn
        EebBF9tTPWBLlrNDtI9UiC71u+vZb6L7RKB/OeooVLust6H9ZZDeMXA0SVzwNJSd
        CAN2DTp/Yy2Afd6iqTLAfpjqBIipJeTkC8RKr1djhStbRxGyO9lQnbuf0lWXHAW0
        ssKkCUhu5VwwKlK9SM+wXPZFAdW3XX0ABZyaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YnLA+85tp9DVxOPYh83me8TLZFKNDe7J
        KJlS5DqL84QHq3YcwxJcPnsuA1so2CXkjzvuEb7doNFrm4zxBLEgzFDGpOfYtpI1
        ZMVCC1DDdiyOwWNIaQgZcDjO6cMqmYviApO3cATlvYXuo7U5ChsNJVJ/SEV37kI4
        k9eKRNDum2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 425FC5A6C4;
        Mon, 19 Dec 2016 17:04:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B523A5A6C1;
        Mon, 19 Dec 2016 17:04:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Marc Branchaud <marcnarc@xiplink.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Chris Packham <judge.packham@gmail.com>,
        Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Tweak help auto-correct phrasing.
References: <CAFOYHZDnpzdYq9j4-xGSdKZQX9deLBpZZhz209qV7cCtq537SA@mail.gmail.com>
        <20161219170137.5507-1-marcnarc@xiplink.com>
Date:   Mon, 19 Dec 2016 14:04:54 -0800
In-Reply-To: <20161219170137.5507-1-marcnarc@xiplink.com> (Marc Branchaud's
        message of "Mon, 19 Dec 2016 12:01:37 -0500")
Message-ID: <xmqqpoknmv7d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CC8913E-C637-11E6-9AD4-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ---
>
> On 2016-12-18 07:48 PM, Chris Packham wrote:
>>
>> This feature already exists (although it's not interactive). See
>> help.autoCorrect in the git-config man page. "git config
>> help.autoCorrect -1" should to the trick.
>
> Awesome, I was unaware of this feature.  Thanks!
>
> I found the message it prints a bit awkward, so here's a patch to fix it up.
>
> Instead of:
>
>    WARNING: You called a Git command named 'lgo', which does not exist.
>    Continuing under the assumption that you meant 'log'
>    in 1.5 seconds automatically...
>
> it's now:
>
>    WARNING: You called a Git command named 'lgo', which does not exist.
>    Continuing in 1.5 seconds under the assumption that you meant 'log'.
>
> 		M.

Sounds better.

The "Instead of ... we now show ..." description deserves to be in
the log message, not after "---" line.

s/under the assumption/assuming/ would make it even shorter and give
the potentially long corrected command name a chance to still fit on
the line without wrapping, I would think, though.

>
>  help.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/help.c b/help.c
> index 53e2a67e00..55350c0673 100644
> --- a/help.c
> +++ b/help.c
> @@ -381,12 +381,18 @@ const char *help_unknown_cmd(const char *cmd)
>  		clean_cmdnames(&main_cmds);
>  		fprintf_ln(stderr,
>  			   _("WARNING: You called a Git command named '%s', "
> -			     "which does not exist.\n"
> -			     "Continuing under the assumption that you meant '%s'"),
> -			cmd, assumed);
> -		if (autocorrect > 0) {
> -			fprintf_ln(stderr, _("in %0.1f seconds automatically..."),
> -				(float)autocorrect/10.0);
> +			     "which does not exist."),
> +			   cmd);
> +		if (autocorrect < 0)
> +			fprintf_ln(stderr,
> +				   _("Continuing under the assumption that "
> +				     "you meant '%s'."),
> +				   assumed);
> +		else {
> +			fprintf_ln(stderr,
> +				   _("Continuing in %0.1f seconds under the "
> +				     "assumption that you meant '%s'."),
> +				   (float)autocorrect/10.0, assumed);
>  			sleep_millisec(autocorrect * 100);
>  		}
>  		return assumed;
