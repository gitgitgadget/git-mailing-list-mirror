Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17F41F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 19:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753503AbdARTqA (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 14:46:00 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51036 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753325AbdARTp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 14:45:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6009C5FD3E;
        Wed, 18 Jan 2017 14:45:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z4kGM3zkYjWx6doh0VVAvlLJPfU=; b=JP2uSc
        lvHHknlm8JxCmxCzWJZ9P8uoriP1SCKPwsQ11jLhipRtvhlTtdSEOD5fODweq/DH
        X8xiWjcIJM5Nb26TaDF+9ZQVgOZIhCVadqNtQjtK9Dn1eo9ZTIXs5BXuLoVjKm0E
        nyRWQLj0EzqxiOoXQB+qmku1lqdRUvzz2JSrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lEVlIrdCk4zlFeu3ZaPuZkbGO81uP68H
        uRIFNjJSJfasAOFLel3Ih5SKVtV6jlHJFYIPXO+HEHE8pPsawa/Nu22lfyKSO90t
        bbLHsh3TLm64/qY0eLF800WRB5mkoa8ZRyHRHmER4tkPUc1gCi0TaX8oAUieJwtu
        WlNxELu8E9w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 58C2E5FD3D;
        Wed, 18 Jan 2017 14:45:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA68D5FD3C;
        Wed, 18 Jan 2017 14:45:56 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/5] doc: add documentation for OPT_STRING_LIST
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
        <20170118000930.5431-2-jacob.e.keller@intel.com>
Date:   Wed, 18 Jan 2017 11:45:55 -0800
In-Reply-To: <20170118000930.5431-2-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Tue, 17 Jan 2017 16:09:26 -0800")
Message-ID: <xmqq37gg9moc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAB82FE0-DDB6-11E6-8ECF-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Commit c8ba16391655 ("parse-options: add OPT_STRING_LIST helper",
> 2011-06-09) added the OPT_STRING_LIST as a way to accumulate a repeated
> list of strings. However, this was not documented in the
> api-parse-options documentation. Add documentation now so that future
> developers may learn of its existence.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/technical/api-parse-options.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 27bd701c0d68..6914f54f5f44 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -168,6 +168,11 @@ There are some macros to easily define options:
>  	Introduce an option with string argument.
>  	The string argument is put into `str_var`.
>  
> +`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
> +	Introduce an option with string argument.
> +	The string argument is stored as an element in `&list` which must be a
> +	struct string_list. Reset the list using `--no-option`.
> +

I do not know if it is clear enough that 'option' in the last
sentence is a placeholder.  I then wondered if spelling it as
`--no-<long>` would make it a bit clearer, but that is ugly.

The "Reset the list" is an instruction to the end-users who interact
with a program written by readers of this document using
OPT_STRING_LIST(), and it feels a bit out of place.  Perhaps

	End users can reset the list by negating the option,
	i.e. passing "--no-<long>", on the command line.

I dunno.

Anyway, thanks for adding a missing doc here.

>  `OPT_INTEGER(short, long, &int_var, description)`::
>  	Introduce an option with integer argument.
>  	The integer is put into `int_var`.
