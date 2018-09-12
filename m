Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A45F1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeIMDUG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 23:20:06 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38103 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeIMDUG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 23:20:06 -0400
Received: by mail-wm0-f42.google.com with SMTP id t25-v6so4013722wmi.3
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mcYwanmSyyYwwqJzsWC4LPLAKOn80HiJMuVggtIy8jM=;
        b=Rd0ETt5O0kJf3whNSiAUBfTgmmjweCF4XxR+rrz1Q5fQI5AZ5uRaJof9HIeqTOoGiS
         H2PNDj6t1RCcrZTwm0ZAOuNac7jtodv+Cns5j+i6SfPL9tlodr6skeaaEjHIf9m7S4ky
         m2HMNM1HEIuafGDMqGzJ3855eXaOYTxEVrKIgBa78qC+pQWwPJQYt7CfZzsHtU96kGJo
         97DdlCx4rFrszlfB5iVwenXf1d/LCW08DHHFhmSOia2lm5PtBYm5Du6Sce3Bid/c0IfA
         P7s51Oy0A+n0S9hXqcUA3VYciw7IuNytdwydu/Ow82ZY2HQ9+ELjw6abWdoJgUPItc2S
         yYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mcYwanmSyyYwwqJzsWC4LPLAKOn80HiJMuVggtIy8jM=;
        b=MMfRogSdfRXielUuWpEFuk7xek14hiczkaNyhziqWmHKK9vXrzeKaKT5URx/OzGgH7
         5ejrwH893sdED4DflI4hURLzsGVIHHqR643tIW7zgpd0cGTJaPcQREuPVlpbBLTImYKx
         iXRQpgiXwEHgjLqWFkd+zdDV/cVFsZ7qvNRh4cI1TkyaDQg0ROrqy01MXjyXqSG1sKUB
         Es8TbqCHaXIW30/RngSyxdXC0uusUJxpQYjIKYmkJW9LJ/U2lhqjNMuwCVCqYKhu83Lj
         D6KYI2qiEvzpaLjx5p4tA8GAR/1lMN5R67skCxlgZUUksLVsK24rI83Pt7r7seNaRtxO
         L6Lg==
X-Gm-Message-State: APzg51A3xsFOYiVT9RHU2YcX2Gv4CezFhslHWhW1kKOOu3mQ03sYhPLO
        9XPKbT5lrYSw6pmwXOa2vZw=
X-Google-Smtp-Source: ANB0Vdaz8W/9+o81kW4SRsrCj8dNiTmkVshi4AZvlT9k14UhOzQ7qZIvvpi9K0/tEjNaBNMNLQxqoA==
X-Received: by 2002:a1c:7305:: with SMTP id d5-v6mr3125496wmb.53.1536790412095;
        Wed, 12 Sep 2018 15:13:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k34-v6sm3679123wre.18.2018.09.12.15.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:13:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] contrib: add coverage-diff script
References: <pull.40.git.gitgitgadget@gmail.com>
        <e4124471e5494b737d99eceed25fb03e787d0b96.1536770746.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Sep 2018 15:13:30 -0700
In-Reply-To: <e4124471e5494b737d99eceed25fb03e787d0b96.1536770746.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 12 Sep 2018
        09:45:49 -0700 (PDT)")
Message-ID: <xmqqa7omjred.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  contrib/coverage-diff.sh | 70 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100755 contrib/coverage-diff.sh

I fully appreciate the motivation.  But it is a bit sad that this
begins with "#!/bin/bash" but it seems that the script is full of
bash-isms.  I haven't gone through the script to see if these are
inevitable or gratuitous yet, but I'd assume it made it easier for
you to write it to step outside the pure POSIX shell?

> +V1=$1
> +V2=$2
> +
> +diff-lines() {

Being able to use '-' in identifier is probably a bash-ism that you
did not have to use.

> +    local path=
> +    local line=
> +    while read; do

Being able to omit variable to be read into and can use the implicit
variable $REPLY also is.

> +	esc=$'\033'
> +	if [[ $REPLY =~ ---\ (a/)?.* ]]; then
> +	    continue
> +	elif [[ $REPLY =~ \+\+\+\ (b/)?([^[:blank:]$esc]+).* ]]; then
> +	    path=${BASH_REMATCH[2]}

OK, it probably is easier to write in bash than using expr if you
want to do regexp.  Where do these escape code come from in "git
diff" output, by the way?

> +	elif [[ $REPLY =~ @@\ -[0-9]+(,[0-9]+)?\ \+([0-9]+)(,[0-9]+)?\ @@.* ]]; then
> +	    line=${BASH_REMATCH[2]}
> +	elif [[ $REPLY =~ ^($esc\[[0-9;]+m)*([\ +-]) ]]; then
> +	    echo "$path:$line:$REPLY"
> +	    if [[ ${BASH_REMATCH[2]} != - ]]; then
> +		((line++))
> +	    fi
> +	fi
> +    done
> +}
> +
> +git diff --raw $V1 $V2 | grep \.c$ | awk 'NF>1{print $NF}' >files.txt

Hmph, not 

	git diff --name-only "$V1" "$V2" -- "*.c"

Do we (or do we not) want "--no-renames"?

> +for file in $(cat files.txt)
> +do
> +	hash_file=${file//\//\#}
> +
> +	git diff $V1 $V2 -- $file \
> +		| diff-lines \
> +		| grep ":+" \
> +		>"diff_file.txt"

Style:

	cmd1 |
	cmd2 |
	cmd3 >output

is easier to read without backslashes.

> +	cat diff_file.txt \
> +		| sed -E 's/:/ /g' \
> +		| awk '{print $2}' \
> +		| sort \
> +		>new_lines.txt
> +
> +	cat "$hash_file.gcov" \
> +		| grep \#\#\#\#\# \
> +		| sed 's/    #####: //g' \
> +		| sed 's/\:/ /g' \
> +		| awk '{print $1}' \
> +		| sort \
> +		>uncovered_lines.txt

OK, so we assume that we have run coverage in $V2 checkout so that
we can pick up the postimage line numbers in "diff $V1 $V2" and find
corresponding record in .gcov file in the filesystem.  I did not
realize the significance of 'topic' being the later argument to the
script in this part

    After creating the coverage statistics at a version (say,
    'topic') you can then run

        contrib/coverage-diff.sh base topic

of your description before I see this implementation.  Also the
comment at the beginning

    # Usage: 'contrib/coverage-diff.sh <version1> <version2>
    # Outputs a list of new lines in version2 compared to version1 that are
    # not covered by the test suite. Assumes you ran
    # 'make coverage-test coverage-report' from root first, so .gcov files exist.

would want to make it clear that we want coverage run from root
for version2 before using this script.

> +	comm -12 uncovered_lines.txt new_lines.txt \
> +		| sed -e 's/$/\)/' \
> +		| sed -e 's/^/\t/' \
> +		>uncovered_new_lines.txt
> +
> +	grep -q '[^[:space:]]' < uncovered_new_lines.txt && \

Style: when you end a line with && (or || or | for that matter), the
shell knows that you have not finished speaking, and will wait to
listen to you to finish the sentence.  No need for backslash there.

> +		echo $file && \
> +		git blame -c $file \
> +			| grep -f uncovered_new_lines.txt
> +
> +	rm -f diff_file.txt new_lines.txt \
> +		uncovered_lines.txt uncovered_new_lines.txt
> +done
> +
> +rm -rf files.txt
