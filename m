Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2085220323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdCVVuM (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:50:12 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35242 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdCVVuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:50:10 -0400
Received: by mail-lf0-f65.google.com with SMTP id v2so15080968lfi.2
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=hHdCNCPzxTGFulE38t+ez0Tu8H+zwOkQ+IGdjxVXD5w=;
        b=m6UV8vbDtVeSFJAGr70LQyzsIAVMEFbbTFI3oRiwrams/XKq8+m2IkzekKJxne8a7s
         fd2cZ8/phhOJXbWmVCt+TpPyB1fz54vXb91rCRiI+AQy1dVE0Mdb0r/XG2muQQAwr7wk
         M00nnVFAUaq2+gTk7RdoIyUGwTvlj/A4bPSxzxb7LRVPmJR2muTHrLJ1YiYidf3hqYEw
         Ievn4abEK+1PY0RjVVKD5V80+eL+H+Y7CeKIrKuj6n24lIeKwWRDLeBcNy3B4zFjjuAt
         KUYb9KdkgsaGeGjVtAJaB8bhWKKE1vcN8XMIh0jibWYOZmr+CgFOw9h/wNSdOizCzx3X
         WEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=hHdCNCPzxTGFulE38t+ez0Tu8H+zwOkQ+IGdjxVXD5w=;
        b=YYmpHqRydgSbv/w3fpGPSUo7YyvRjnQSivyTbE5aPwFw1wErCec+889oGOEioHoEzq
         KFnf8kPsmfBJcGlJCFy0co66O/jTbEL4WsIZ/mT9cajerNS08r+9uGXe2090SuwYpsYO
         PTQUTocCNZZH+JoNDaOvgZaS/k60SE5JpZ+puE0VJj6Sl9/P8PAeuLNpCRHaL5dL7DYm
         yt3HU8WfhSylDtyjBWjJKeJUcfNH20FljDhvvEX1wsqve9T+XS/PeN7G4Figckn7UgeO
         sTbyYs1FtLJgS+aNPHXLXmMccrwiRgLH1BWW0QCQWKvP9MsNw0QeZiRf1fXVtSlB+I9T
         ZAJw==
X-Gm-Message-State: AFeK/H060tBtm31wAJUnXY6o8CcknKmnICV28WANfZuXswu7pOcgNPc7awTtgQnAkN4vKg==
X-Received: by 10.25.67.16 with SMTP id q16mr11205960lfa.120.1490219408607;
        Wed, 22 Mar 2017 14:50:08 -0700 (PDT)
Received: from [192.168.1.26] (abrf170.neoplus.adsl.tpnet.pl. [83.8.99.170])
        by smtp.googlemail.com with ESMTPSA id 3sm181815ljj.16.2017.03.22.14.50.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 14:50:07 -0700 (PDT)
Subject: Re: [PATCH v2] builtin/describe: introduce --broken flag
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <CAGZ79kYfrKRbs40UH73VCgMsJgFyh1aG5ZrYMj3O_wGdu6rSUA@mail.gmail.com>
 <20170321225718.18633-1-sbeller@google.com>
Cc:     git@vger.kernel.org, mfick@codeaurora.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <b418a7ec-a8e5-1702-1a1f-3e9c8b8a2f7e@gmail.com>
Date:   Wed, 22 Mar 2017 22:50:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170321225718.18633-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.03.2017 o 23:57, Stefan Beller pisze:

> --- a/Documentation/git-describe.txt
> +++ b/Documentation/git-describe.txt
> @@ -30,9 +30,14 @@ OPTIONS
>  	Commit-ish object names to describe.  Defaults to HEAD if omitted.
>  
>  --dirty[=<mark>]::
> -	Describe the working tree.
> -	It means describe HEAD and appends <mark> (`-dirty` by
> -	default) if the working tree is dirty.
> +--broken[=<mark>]::
> +	Describe the state of the working tree.  When the working
> +	tree matches HEAD, the output is the same as "git describe
> +	HEAD".  If the working tree has local modification "-dirty"
> +	is appended to it.  If a repository is corrupt and Git
> +	cannot determine if there is local modification, Git will
> +	error out, unless `--broken' is given, which appends
> +	the suffix "-broken" instead.

The common description reads better... but unfortunately it lost
information about the optional parameter, namely <mark>.  The
'-dirty' is just the default for <dirty-mark>, and '-broken' is
the default for <broken-mark>.

Maybe /the suffix "-broken"/<broken-mark> suffix ('-broken' by default)/
and similarly for "-dirty"?

Best,
-- 
Jakub Narębski

