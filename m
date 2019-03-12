Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A0C20248
	for <e@80x24.org>; Tue, 12 Mar 2019 01:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCLBDj (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 21:03:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38378 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfCLBDi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 21:03:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so832136wrm.5
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 18:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ukRl3OLnptJwm/pCh0HvuM54pJ0COej6R+/+Htmbgz8=;
        b=jeRi6NvdNhBLKHLaxpp6IQGqL98vZOBKNf58KNPfzAbZTApk7ky8DQWITQw+el+1dC
         R96U5UE9+Cya8ggIAn3QlY4rwF87w+LAcuaUPfQmc722G3BK89kW2rBVT/fxg1v89YCu
         OOcvsdgSvV4Zsc5QHlJmsB882d7WphDlesA6bSTaN8MrMEKekeASbTCPLnr2ad/jKYoD
         mKVszsbcQpvbcQqSaXWss2799+pmRbsuZqN98yObB5r3vH+uDy771SIeeq2gW8EMMLPD
         T4WsgFTtK1pSg+FpV5bKrwM030hZ9sXqwhaqLolknA2ra17A3aJyrGkW8QcXDr32SEK/
         Aing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ukRl3OLnptJwm/pCh0HvuM54pJ0COej6R+/+Htmbgz8=;
        b=lL1KvP0az2NwIkxHeOK5+h4xRB9c6Vr/cFEVBraa41c6x7YSOpe+anyN4kQ11cqd/d
         dm4SjRTfF8UZhY5gjJkQOK3WBtMkvlKONmtt/8HZpkI5PDnlq2KhutYj97Tuv12IE1Az
         bC3xCSZ+7AIIp9NDRhJiGIX0ZYimLBuGr8Au+VaV4zfM4BUznvx5Yl3CUqlf16FMdOUP
         fZYvj7JN/CV42Qbt+XbOGoIPeZBSFv3f/fV08/CKvg7rY4ZNAgapllKYa/RvYzpRV/i6
         uLu+gXbzXLwq6v9vG97TnpbATidTsB3YOXHzaeQyiZM1IEXqyh948XK6a1MxW1Z7+Ihg
         vVGQ==
X-Gm-Message-State: APjAAAX0sbTa+jq2TQB/wIcZQGVrMHFFFa3aqgIJxkmg1sZL7dGH7mSO
        6AQ+XFERX8LCpQFLfmx4RGU=
X-Google-Smtp-Source: APXvYqzj+KC8n1QvSAFeBI14vC+cSOO6ps+izYEVI3yZu7kfNVA/7BRjLpwo3S2yA7nCIOi8/r9smQ==
X-Received: by 2002:a5d:6ace:: with SMTP id u14mr17866789wrw.240.1552352616544;
        Mon, 11 Mar 2019 18:03:36 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t16sm550759wmj.47.2019.03.11.18.03.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 18:03:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 1/8] t7600: clean up 'merge --squash c3 with c7' test
References: <cover.1548219737.git.liu.denton@gmail.com>
        <cover.1552275703.git.liu.denton@gmail.com>
        <6716d28a5187c44c1d90f5ce840c44441f62352c.1552275703.git.liu.denton@gmail.com>
Date:   Tue, 12 Mar 2019 10:03:34 +0900
In-Reply-To: <6716d28a5187c44c1d90f5ce840c44441f62352c.1552275703.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 10 Mar 2019 20:42:30 -0700")
Message-ID: <xmqqzhq0j449.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> -	{
> -		cat <<-EOF
> +	cat >expect <<-EOF &&
>  		Squashed commit of the following:
>  
>  		$(git show -s c7)
> @@ -242,8 +241,8 @@ test_expect_success 'merge --squash c3 with c7' '
>  		# Conflicts:
>  		#	file
>  		EOF
> -	} >expect &&

As you are dedenting the "cat <<-EOF", the body and closing EOF
should also be dedented one level, i.e.

	cat >expect <<-EOF &&
	Squashed commit of the following:
	...
	# Conflicts:
	#	file
	EOF

> -	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
> +	git cat-file commit HEAD >tmp &&
> +	sed -e '1,/^$/d' <tmp >actual &&

The intermediary file may want a name better than 'tmp', if it is to
be left behind, but this will do for now.

>  	test_cmp expect actual
>  '

Thanks for the clean-up.
