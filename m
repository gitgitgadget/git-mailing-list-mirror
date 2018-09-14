Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBFB71F404
	for <e@80x24.org>; Fri, 14 Sep 2018 17:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeINWS5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 18:18:57 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:37934 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINWS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 18:18:57 -0400
Received: by mail-wr1-f54.google.com with SMTP id w11-v6so11319170wrc.5
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 10:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S46Na0rUqaLzbmuJiHf42c2Hi3o69prj4KcLXZzKRQE=;
        b=lwO/B1OmmCpbm/9SCgVCtGtJ+PKL9tSQl5Z+LoB0F0+l9wy3m442XvT99J0l5sxxpC
         XwJgP2HdYrj/PKbGEgqZbjLNVFlvqNeyVSlONncy4VBRWZg5kwBLQhZE6xthiLOUjNsz
         BzUGWL21TOTrugZ7M63hcnNI7hmjrKe+z5lzkBIVbygUxKWLUCBEJe1cvWqosB08CErB
         t+AbMBQAiXaoOba44f2pNCQRD59iSHhlV0BxqNIuiKI2Oj+/JAF0acTFHCFKHkcN6F5g
         h6Pz1rkiWwJ8l3BFNlAZdt+C0MAySzlKS3+sa7v4t/nZ9mopn2ysIIWfIaUZf1aPdwPb
         QRaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S46Na0rUqaLzbmuJiHf42c2Hi3o69prj4KcLXZzKRQE=;
        b=CCTuU6I0gB5fpyFZ9sh2tHgM4pCuMbO61Gmt3jPXflhUYJv7iHjJ9LE2ZyW2O6XeNP
         Rwgpt/I0+43BbXtlr/vok+/c4JTYjNmtLOBm1U17arJ9cUSIQDMvOwm7sAHiNfFOIlI1
         jgFrMXLCfXf3NX7Ww1ENYJdHnSuq2ELanqigdKQp6jevjHW8Cs3ZqkgmmeuUKPcbh1u7
         nR+0U9Nfp3rjoWnejq4UGkK/++AdUr83nGq2m3mToFbN0aGW3NVyDvbuA2eRwEY9qcsT
         pNazuqR5nFjGjghSohxkjkWQ/uP4jLqnFn6UbRlZvzvbh9x9GjHYvNGC89wQaCYIbXs3
         Ukhg==
X-Gm-Message-State: APzg51D5oQ7gKh+ducwx2gYXDxSXVZdSSRQNV/f71j+jCxrBznuKysfL
        R4McS+d6aiC1bzFg+K+Dw+E=
X-Google-Smtp-Source: ANB0VdZBmicBP6K/HhNyfsoieZeJ55fsrsoyaHM7qK9OrbX3+KgleJwCcXaA+wzVgfYoOt24+XGaYg==
X-Received: by 2002:adf:dcc1:: with SMTP id x1-v6mr10890484wrm.21.1536944613998;
        Fri, 14 Sep 2018 10:03:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t132-v6sm2664691wmf.24.2018.09.14.10.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 10:03:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer\@gmail.com" <t.gummerer@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1 2/4] fsmonitor: update GIT_TEST_FSMONITOR support
References: <20180914143708.63024-1-benpeart@microsoft.com>
        <20180914143708.63024-3-benpeart@microsoft.com>
        <xmqqmuskc8wj.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 14 Sep 2018 10:03:32 -0700
In-Reply-To: <xmqqmuskc8wj.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 14 Sep 2018 09:59:24 -0700")
Message-ID: <xmqqd0tgc8pn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ben Peart <benpeart@microsoft.com> writes:
>
>> +if test -n "$GIT_FSMONITOR_TEST"
>> +then
>> +	if test -n "$GIT_TEST_FSMONITOR"
>> +	then
>> +		echo "warning: the GIT_FSMONITOR_TEST variable has been renamed to GIT_TEST_FSMONITOR"
>> +	else
>> +		echo "error: the GIT_FSMONITOR_TEST variable has been renamed to GIT_TEST_FSMONITOR"
>> +		exit 1
>> +	fi
>> +fi
>
> I would have expected that, because we are now doing multiple pairs
> of variables in a single series, we would add a helper function that
> can be called like so:
>
> 	check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR
>
> in the earliest step.  Perhaps something like this.
>
> check_var_migration () {
> 	old_name=$1 new_name=$2
> 	eval "old_isset=\${${old_name}:+isset}"
> 	eval "new_isset=\${${new_name}:+isset}"
> 	case "$old_isset,$new_isset" in
> 	isset,)
> 		echo >&2 "error: $old_name is now $new_name"
> 		exit 1 ;;
> 	isset,isset)
> 		# enable this, once $old_name no longer is valid anywhere
> 		# echo >&2 "warning: $old_name is now $new_name"
> 		# echo >&2 "hint: remove $old_name"
> 		;;
> 	esac
> }

Alternatively, we could do this, to warn and then migrate the value
given to the old variable automatically to the new variable and let
the test proceed.

check_var_migration () {
	old_name=$1 new_name=$2
	eval "old_isset=\${${old_name}:+isset}"
	eval "new_isset=\${${new_name}:+isset}"
	case "$old_isset,$new_isset" in
	isset,)
		echo >&2 "warning: $old_name is now $new_name"
		echo >&2 "hint: set $new_name too during the transition period"
		eval "$new_name=\$$old_name"
		;;
	isset,isset)
		# do this later
		# echo >&2 "warning: $old_name is now $new_name"
		# echo >&2 "hint: remove $old_name"
		;;
	esac
}
