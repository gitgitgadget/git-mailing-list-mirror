Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A40751F453
	for <e@80x24.org>; Tue, 25 Sep 2018 18:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeIZApj (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:45:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35511 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbeIZApj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:45:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id o16so11087416wrx.2
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FcQYlPK8sYRTlV2t3J0hSxLvXXv6q2mXWxI137UP82E=;
        b=OiqJ9oxj7K5F4muOdJ5HQhezuw3chhtUz6P0nYzZqMRrELNZfXISo+EvDAPOJL1Xi3
         hot4V4IpKk8ct6YqpD7jL9wVe0o/3w8LGPV6ZFWRIqoqlDqkJpZYaFEFxpyO5klY4A6Q
         2jbYUczUzF0EpOq8ehslevicfYuzu9SsVRNmdv5HWAUTOTkEF9E+eN1s9ZaTKXDqCeMt
         90AwLZJomVC+TkYficHDdoLq6YJz55JDigBUndRSubg/zCdeoJUk7T3Kta8pA6aKb2dY
         qRTk8IsAGAapcrwCMCciewg7NgUuB4FXbYe4HkMFvnDVyCGy7sSnSdWPznlopl9Koglr
         teUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FcQYlPK8sYRTlV2t3J0hSxLvXXv6q2mXWxI137UP82E=;
        b=KzYqaIwi+16K2ox/N1umEs8nl+UzC0WC3pvrDAk+sLRlnC8OpQXZP4JuouqaTL0Z7A
         XcYZ5gyWE4uynSbZXlkr/tbGcc7DKwwMs3R1l+c2+glq4ogi04cwWkzRqms2xeW+ftT+
         RmOORvgW/hDh90dREq5plFLK0H9hX6GOyOpRLuSsS1myQrNI2EWz6q6jw6/sP3uutzDT
         iqCIe7FlTqM6TZ+9UEGDrZbiZptzEyZNUG6fQoebvF4PELluP6aqdK6XlRxCoq5UUa2U
         eNpYTqIgPBS6dbbq08QYhRzMMqzEYZB4MstN4C4iREQQDRwnY/V0NipzGgZlgROXSl1z
         oHpA==
X-Gm-Message-State: ABuFfoido9DCW40mFeIRf32Q5yHaIyoLBbgS0jHnzCfG3Apu7jJUcWs7
        /eCYeYuihD/uQkPMHyUE5Zc=
X-Google-Smtp-Source: ACcGV610OZPqU/oAMtgAXnS5VMdo4cWFbCXL/X64+9js+NLs+7aljWOuxz4RP5y7QmbkA7ywzClmSQ==
X-Received: by 2002:adf:a41c:: with SMTP id d28-v6mr2154406wra.121.1537900608036;
        Tue, 25 Sep 2018 11:36:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q8sm1869446wrx.94.2018.09.25.11.36.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:36:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] contrib: add coverage-diff script
References: <pull.40.v2.git.gitgitgadget@gmail.com>
        <pull.40.v3.git.gitgitgadget@gmail.com>
        <21214cc321f80cf2e9eb0cdb1ec3ebb869ea496d.1537542952.git.gitgitgadget@gmail.com>
Date:   Tue, 25 Sep 2018 11:36:46 -0700
In-Reply-To: <21214cc321f80cf2e9eb0cdb1ec3ebb869ea496d.1537542952.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 21 Sep 2018
        08:15:55 -0700 (PDT)")
Message-ID: <xmqqo9clpgox.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +files=$(git diff --name-only $V1 $V2 -- *.c)

You'd want to quote that *.c from the shell, i.e. either one of
these

	files=$(git diff --name-only $V1 $V2 -- \*.c)
	files=$(git diff --name-only $V1 $V2 -- '*.c')

otherwise you'd lose things like "builtin/am.c", I'd think.

> +
> +for file in $files
> +do

I know this is only for running in _our_ source tree, and we do not
have a source with $IFS in it, so I'd declare that this is OK.  It
would be good to document that assumption in red capital letters at
the beginning of this loop, though ;-)

	# Note: this script is only for our codebase and we rely on
	# the fact that the pathnames of our source files do not
	# have any funny characters---letting the shell split $files
	# list at $IFS boundary is very much intentional, and not
	# quoting "$file" in the code below also is.  Don't imitate
	# this in scripts that are meant to handle random end-user
	# repositories!
	for file in $files
	do
		...

> +	git diff $V1 $V2 -- $file \
> +		| diff_lines \
> +		| sort >new_lines.txt

I do not see a strong reason why we would want to limit $V1 and $V2
to branch names and raw commit object names, and quoting them in dq
pair is a cheap fix to allow things like

	$ contrib/coverage-diff.sh master 'pu^{/^### match next}'

so let's do so.

Could you cut lines _after_ typing a pipe and omit backslashes, i.e.

	git diff "$V1" "$V2" -- $file |
	diff_lines |
	sort >new_lines.txt

It seems to be personal taste whether to indent the second and
subsequent lines; I do not care if you indent or if you align too
much either way (but I have moderate perference to align).  

But I do not want to see people type unnecessary backslashes.  This
is not limited to just this pipeline but elsewhere in the script.

> +	if ! test -s new_lines.txt
> +	then
> +		continue
> +	fi
> +
> +	hash_file=$(echo $file | sed "s/\//\#/")
> +	sed -ne '/#####:/{
> +			s/    #####://
> +			s/:.*//
> +			s/ //g
> +			p
> +		}' "$hash_file.gcov" \
> +		| sort >uncovered_lines.txt
> +
> +	comm -12 uncovered_lines.txt new_lines.txt \
> +		| sed -e 's/$/\)/' \
> +		| sed -e 's/^/\t/' \

Do you need two sed invocations for this, or would

	sed -e 's/$/\)/' -e '/^/	/'

work as well?  By the way """The meaning of an unescaped <backslash>
immediately followed by any character other than '&', <backslash>, a
digit, <newline>, or the delimiter character used for this command,
is unspecified."""[*1*] so '\t' on the replacement side is a no-no
in the portability department.

	Reference. *1*
	http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sed.html


> +		>uncovered_new_lines.txt
> +
> +	grep -q '[^[:space:]]' < uncovered_new_lines.txt && \

Lose the backslash at the end.  The shell knows that you haven't
finished your sentence when it sees a line that ends with &&, || or
a pipe |, so there is no need to tell it redundantly that you have
more things to say with the backslash.

> +		echo $file && \
> +		git blame -c $file \
> +			| grep -f uncovered_new_lines.txt
> +
> +	rm -f new_lines.txt uncovered_lines.txt uncovered_new_lines.txt
> +done

Near the begininng (like just before the "for file in $files" loop),
you can probably have a trap to make sure these are removed upon
exit, e.g.

    trap 'rm -f new_lines.txt uncovered_lines.txt uncovered_new_lines.txt' 0

