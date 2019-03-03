Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D181C20248
	for <e@80x24.org>; Sun,  3 Mar 2019 13:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfCCNUR (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 08:20:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34957 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbfCCNUR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 08:20:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so2171959wma.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kOJ15itRJVLgffHglvqSFNMMFKSk6k3w1x5yFc/wm+s=;
        b=MakCYQC4OjstEFbJoV1wBC00Y4gB4lf4WA9oTobK83wbfYFTrBY07ONvsT2dMO0nU4
         4RwFa1241/mVDvlEobZKJBuBKQ3zbwsB4ZNi+FLVJeCkQl8VS8qoeMpgyE8KF5RpJT5U
         //RIknDBqxNmx8bdIkPDiHoCcothcSzWFMqNfmoyt4v1+ho890ZB0BoqzUyn89NUqH6G
         /51OQwqKi0Qfd2K/Xl4ln3Ns6ykfcCKmXcgRbHlV5lcA6qJEgte85gh/DEAj6xlDl/NM
         /93ekvlCsph+IVu/HsYUcUeNBdSFh9qKXGB8xO9uzx8brByZXJxlYEA+4vYqv/pe4PmA
         uyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kOJ15itRJVLgffHglvqSFNMMFKSk6k3w1x5yFc/wm+s=;
        b=g7QncLHVbY/HWXXJ47QO0PcAhZKtgbt7HiyffW+NapCP1dBKLczgNSIAdQyJ2IKuLw
         b2eGS0MfC6iP20hZFc3TzeaRo/zAqO31uBJcPTjajigONAhain/a/o3RB+mOp+Jr1lWg
         mtoSW/WVCZt1W34c5Siwiy+lzwSBK5ZWQXkyz6It0zsLCNCFVFOtMgv0kZAgaQKzXbC8
         EM7PzLvadyW6ap/EL7DLCqWQ8PJjg4ABg62PTqpvqtyRpO+8KpF2sglJmBgEzFF4sdim
         O0WkBfKYCuiYuPOjPnLbIWWHJ/pmVYh/miMjRXvRDc3ZUP5XikojI2/q605+CqarDrFJ
         DQJQ==
X-Gm-Message-State: APjAAAW69r3AGz2XM//oWzirZlkrxs6bZuqghAVgRUTQGSJ7VcAGUUCx
        pCIE7y2CdBr9PSxWRAUaD0BuDytclZw=
X-Google-Smtp-Source: APXvYqwH+WFpvYfugX+YyvqEiTOE6ltugHTqQyRPnyp+RA20woDB1OXYcuqyIIgNfmQZgQkFh9J/0g==
X-Received: by 2002:a05:600c:224c:: with SMTP id a12mr8313525wmm.103.1551619214557;
        Sun, 03 Mar 2019 05:20:14 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 2sm2792944wrg.89.2019.03.03.05.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 05:20:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        t.gummerer@gmail.com, christian.couder@gmail.com
Subject: Re: [PATCH 1/3] test functions: Add new function `test_file_not_empty`
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
        <20190303122842.30380-2-rohit.ashiwal265@gmail.com>
Date:   Sun, 03 Mar 2019 22:20:13 +0900
In-Reply-To: <20190303122842.30380-2-rohit.ashiwal265@gmail.com> (Rohit
        Ashiwal's message of "Sun, 3 Mar 2019 17:58:40 +0530")
Message-ID: <xmqq5zt014du.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> Subject: Re: [PATCH 1/3] test functions: Add new function `test_file_not_empty`

s/Add/add/.  Strictly speaking, you do not need to say "new", if you
are already saying "add", then that's redundant.

> test-lib-functions: add a helper function that checks for a file and that
> the file is not empty. The helper function will provide better error message
> in case of failure and improve readability
>
> Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
> ---
>  t/test-lib-functions.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 80402a428f..1302df63b6 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -593,6 +593,16 @@ test_dir_is_empty () {
>  	fi
>  }
>  
> +# Check if the file exists and has a size greater than zero
> +test_file_not_empty () {
> +	test_path_is_file "$1" &&
> +	if ! test -s "$1"

"test -s <path>" is true if <path> resolves to an existing directory
entry for a file that has a size greater than zero.  Isn't it
redundant and wasteful to have test_path_is_file before it, or is
there a situation where "test -s" alone won't give us what we want
to check?

> +	then
> +		echo "'$1' is an empty file."
> +		false
> +	fi
> +}
> +
>  test_path_is_missing () {
>  	if test -e "$1"
>  	then
