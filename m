Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2B5620248
	for <e@80x24.org>; Sun, 17 Mar 2019 16:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfCQQsH (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 12:48:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35461 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfCQQsH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 12:48:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id d6so10971164eds.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 09:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=C8Qa75LiBlqgyxzfvigKa/+DifA09iOyb1LIWI4hM9g=;
        b=RwPp4184v8zri2k8G9RqMI57ytpE2vjfXRFJzGlljJohSBRzWgGZN2xAkk/yAEYvY+
         ZJYdljIQlAwxiG8FiJC+SIauuFwWlUGSJZm503u7Mynr1knrb0pXkY61vY00mRP2RKl0
         cFGhZPZ8HQhPTvGx3KeTY+yeE2mk0frXdqhhHzceGT2XeSQbHHTEkfepF5CrjEi94cYG
         AtTK5r6hrKhFyZsvdWjrQtkepUGOE1MdRECaefAVc5OGmWFouK7YqJnX5JIdY6ZBgBRS
         lNEoZmSQSNovZFKHRajJmRn6WAucOQxlIDW9iAq639D3GIjwtu7aY1OOTEyyTiNnI3r6
         GkwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=C8Qa75LiBlqgyxzfvigKa/+DifA09iOyb1LIWI4hM9g=;
        b=D/cXncCwJB26PqeRTjepJJlNmgIowBwdMuIvHYlFPoa11hkAWPECX8CJYtkDlbGOa1
         6Y2hg8hkzFnAHuv0ChEu/RzYdaaZx9Hun1H9Xmup7FvW42JMA5ULUxg4aE8OQPfpPYqo
         G93NBfk7l3iJngwPLu6gzloR5uzvKqxI4REjbha1XSMzbbulnpCMB9lncKX9ikTLqljw
         FsbICuXx4UV2g1oVBYR6qUnFYsnDX/WjQr6HwwzQX05s3wPcKLxNxNDEkkrCuvzIdINR
         S6pzfUPjDDgkJVPN3Wo0Ns/VbGiqRUrGAQ5UG6elx2DGqczCBM1+k4XHOeQmrhC0P/3L
         EgSQ==
X-Gm-Message-State: APjAAAU3MS7yXM6MCIFjdD2HNvOnBReob1GTdEAigqyr//kPXkkjEua7
        vPqxhpogldll4VIFJ4Le7waICck/
X-Google-Smtp-Source: APXvYqy9/d8xrjwiuTNVxZ6ZDtanuwG/EdhZw7uiFnNnrlmiwUq8HXlTfJJMDeilMwhcYKp4WyndhA==
X-Received: by 2002:a17:906:482:: with SMTP id f2mr8502204eja.68.1552841285465;
        Sun, 17 Mar 2019 09:48:05 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id m30sm2660839eda.84.2019.03.17.09.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 09:48:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Chang <ttjtftx@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [GSoC][PATCH v3 3/3] t0000: use test_line_count instead of wc -l
References: <cover.1552835153.git.ttjtftx@gmail.com> <bc3dee82a91592e50fd39c5a332b13b76fefa009.1552835153.git.ttjtftx@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <bc3dee82a91592e50fd39c5a332b13b76fefa009.1552835153.git.ttjtftx@gmail.com>
Date:   Sun, 17 Mar 2019 17:48:05 +0100
Message-ID: <87h8c1a1mi.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 17 2019, Jonathan Chang wrote:

> Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
> ---
>  t/t0000-basic.sh | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> index 47666b013e..3de13daabe 100755
> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits duplicated parent in a commit' '
>  	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
>  	test "z$commit0" = "z$parent" &&
>  	git show --pretty=raw $commit2 >actual &&
> -	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
> -	test $numparent = 1
> +	sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
> +	test_line_count = 1 parents
>  '
>
>  test_expect_success 'update-index D/F conflict' '
> @@ -1146,8 +1146,7 @@ test_expect_success 'update-index D/F conflict' '
>  	mv tmp path2 &&
>  	git update-index --add --replace path2 path0/file2 &&
>  	git ls-files path0 >actual &&
> -	numpath0=$(wc -l <actual) &&
> -	test $numpath0 = 1
> +	test_line_count = 1 actual
>  '

...of course reading this series in sequence I find that 50% of my
suggestions for 2/3 are then done in this patch... :)
