Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E181920248
	for <e@80x24.org>; Fri, 12 Apr 2019 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfDLUMj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 16:12:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53985 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfDLUMj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 16:12:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so12692385wmj.3
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 13:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bPw1Z7loFRrcgYH0lUrcq2zN0gAnAE+gJP4VSLnbBd8=;
        b=DYsZTqbRHargb8Qxf+fBGLPVlpRgkSgcJmrjOEWONFHqAMGrQJOEfg4LhOxy9x9Yzh
         bp1we+9eSIkEg/nqEfS/sTDmdqVZcNMl9/CvhIJUXEJMM+NnWi3WYdcwyQwLJsZH0XHl
         LIRACTcsHfZakgZwYYYeFwma2ky9wkjYDLgLt050nMdg6PjM0ElExKpbH/d5f3K4tFXc
         1ZbxgHoiRcKxRPCLSwK+REaM5Raozxq04tovYXWNq7W/+r95HlrM2bdnDomc+r2YWgiI
         06HwpBiyKMuripLYVw8f0cpHgf1FyazBv4BjBoS6Dh61y/Kp9XhlARC0ewtqmeS04mIr
         fomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bPw1Z7loFRrcgYH0lUrcq2zN0gAnAE+gJP4VSLnbBd8=;
        b=qM9CUneylScxaaOcmAn/m/OPrLB9jAJ4/F+fSzpyq4E0YyG/x8tbrmm9kavaVXQeg1
         oHu767Q7THX6yY2F79aJ1gE8XjaB7QKLdhu3NAqG9sjot04C+qX3/Yl5yO25wNscJvuh
         X7Sh9DuuQameUtHTVmDTTF2OajHCDiV4l3lBJ+3XvsIKnUG7O0MZ1B3yCvXyxeK5FhZF
         Kg8p62U2cs4CExEpLkIAtpmS2zFmRJK47W4dhCBiRDTMqDVNYAZ942dSmaIuaEbVM9Aq
         76i01Z2jRncSi6j0k+TsIiycGbip0VcfFTG0Zs5QBf7a1mQ12Aqu6YqHSXyeF91H/FeH
         No3w==
X-Gm-Message-State: APjAAAWwaABwpcTsT1MEiQMWX1RNtrIYTqEBqIEdhH+lrDxvkH98TxCp
        z/tWX0gCWxE4PCbwdkoigK0=
X-Google-Smtp-Source: APXvYqxFbOUNBoOrIygEPhxhXsxgH8R57+WqkOGzhSv6CvtbeLpKBiqKQWrZBSuMg3hVp3eyYFWaFQ==
X-Received: by 2002:a1c:c101:: with SMTP id r1mr13013800wmf.123.1555099957618;
        Fri, 12 Apr 2019 13:12:37 -0700 (PDT)
Received: from szeder.dev (x4dbe3614.dyn.telefonica.de. [77.190.54.20])
        by smtp.gmail.com with ESMTPSA id d6sm52921168wrx.62.2019.04.12.13.12.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 13:12:36 -0700 (PDT)
Date:   Fri, 12 Apr 2019 22:12:28 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] transport: die if server options are unsupported
Message-ID: <20190412201228.GA15936@szeder.dev>
References: <20190405204413.93900-1-jonathantanmy@google.com>
 <cover.1555098572.git.jonathantanmy@google.com>
 <598b2de0162e240521f04d40d41eb11843be7198.1555098572.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <598b2de0162e240521f04d40d41eb11843be7198.1555098572.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 12:51:21PM -0700, Jonathan Tan wrote:

[Reordering the diffs...]

> diff --git a/transport.c b/transport.c
> index e078812897..77446119da 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -252,6 +252,14 @@ static int connect_setup(struct transport *transport, int for_push)
>  	return 0;
>  }
>  
> +static void die_if_server_options(struct transport *transport)
> +{
> +	if (!transport->server_options || !transport->server_options->nr)
> +		return;
> +	advise(_("see protocol.version in 'git help config' for more details"));
> +	die(_("server options require protocol version 2 or later"));

These two messages are translated ...


> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index db4ae09f2f..1e8357a4c7 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -182,6 +182,13 @@ test_expect_success 'server-options are sent when using ls-remote' '
>  	grep "server-option=world" log
>  '
>  
> +test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
> +	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
> +		ls-remote -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
> +
> +	grep "see protocol.version in" err &&
> +	grep "server options require protocol version 2 or later" err

... therefore these should be 'test_i18ngrep'.  This applies to the
other tests in this patch series as well.

> +'
>  
>  test_expect_success 'clone with file:// using protocol v2' '
>  	test_when_finished "rm -f log" &&
> @@ -251,6 +258,18 @@ test_expect_success 'server-options are sent when fetching' '
>  	grep "server-option=world" log
>  '
>  
> +test_expect_success 'warn if using server-option with fetch with legacy protocol' '
> +	test_when_finished "rm -rf temp_child" &&
> +
> +	git init temp_child &&
> +
> +	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -C temp_child -c protocol.version=0 \
> +		fetch -o hello -o world "file://$(pwd)/file_parent" master 2>err &&
> +
> +	grep "see protocol.version in" err &&
> +	grep "server options require protocol version 2 or later" err
> +'
> +
>  test_expect_success 'upload-pack respects config using protocol v2' '
>  	git init server &&
>  	write_script server/.git/hook <<-\EOF &&
