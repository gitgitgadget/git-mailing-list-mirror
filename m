Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8247E20248
	for <e@80x24.org>; Mon,  4 Mar 2019 03:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbfCDDp3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 22:45:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37813 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbfCDDp3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 22:45:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id w6so3884023wrs.4
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 19:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=X7wPcxRdDtHjG/B9mCCd/sAaw7xoSA7xrU1x/3ijPwg=;
        b=rxNiTyZDszLF4HVhmCRrA4LdKL71N9OfHGH9ChLTnv27GMkP48exF/Ro6HbncG5ktU
         HzAHQ6sq8Raua/MXp4XWBa8N8MbBF5faeQpFYAqk8WbS70ZI08es6OZt0NCJmqRNfYXG
         RqCZIGrRkpq2e4JktlNrM3ODcM3sokZzwmuudrkV3Roh/soK5iTXL100g7OlD91rnwCM
         sR6sBDPAkFmsoPxBiNBMd73h7+0mQ/v4y7HSEV9F3L9BL8HxkoKH5s2wzZIfR2NsaNI7
         /Ui11vHdl37CH5revn0dHGUUuFMqH0tqfzssjPjwb7XYIE3V8EMf5z4+nx1nhJZt2zoa
         OYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=X7wPcxRdDtHjG/B9mCCd/sAaw7xoSA7xrU1x/3ijPwg=;
        b=DvMNqesqsnVZZo2O8UqKH5luigbEiWfu5rx0gxIzpgCIbI6ySsq3g/Jz1Hr6m6NJoM
         2kLTi+SwiXf4AcCkd3FCW/l2xclygh4otFuOMzLyPhgR8rLM0mG8+TjGnkVuwngPAXco
         Ohx/mqwyav1uFopX+OX3n6N45nVl+cwhwnK2dUs9a3jqfJ3HL8EiUFqSEYVnz8h9G80q
         97CpjVYvRvfosIZ1XtalFdkN+sGtJN3LgvjlvK89bpmS9KS2Cy+nQL+TrE4XDQDGSPfb
         czXSBeP4BuT03oHaY4SxiEqPM0iyf0gorjsudwdsfj8ZhUyW0CiYpoRdWEYA/JsBNSQO
         B+tg==
X-Gm-Message-State: APjAAAX+D0/irKqukZk25LENyStGt5WMvu2AeGuzrxpxKCZVwGVUb0xK
        CdKwHG1FupsswGvtOpyAVFA=
X-Google-Smtp-Source: APXvYqwqWf6AjYFmSMUxGP8EcFTVsn+dHSAUospT/jh4ahI6546KVwHto4hjFe4J3uy6koT6eFKnqQ==
X-Received: by 2002:adf:eb85:: with SMTP id t5mr11240636wrn.168.1551671127232;
        Sun, 03 Mar 2019 19:45:27 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l129sm3880285wml.42.2019.03.03.19.45.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Mar 2019 19:45:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v2 1/3] test functions: add function `test_file_not_empty`
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
        <20190303233750.6500-1-rohit.ashiwal265@gmail.com>
        <20190303233750.6500-2-rohit.ashiwal265@gmail.com>
Date:   Mon, 04 Mar 2019 12:45:25 +0900
Message-ID: <xmqqo96rxpyi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:

> test-lib-functions: add a helper function that checks for a file and that
> the file is not empty. The helper function will provide better error message
> in case of failure and improve readability

Avoid making the log message into an enumerated list, when there
aren't that many things to enumerate to begin with (specifically,
the "test-lib-functions:" label is unsightly here).   Finish the
sentence with a full stop.

	Add a helper function to ensure that a given path is a
	non-empty file, and give an error message when it is not.

	Give separate messages for the case when the path is missing
	or a non-file, and for the case when the path is a file but
	is empty.

should be sufficient.

I still do not see why the posted code is better than this

	if ! test -s "$1"
	then
		echo "'$1' is not a non-empty file.'
	fi
 
which is more to the point.  After all, if we are truly aiming for
finer-grained diagnosis, there is no good reason to accept a single
error message "does not exist or not a file" for these two cases,
but you'd be writing more like

	if ! test -e "$1"
	then
		echo "'$1' does not exist"
	elif ! test -f "$1"
	then
		echo "'$1' is not a file"
	elif ! test -s "$1"
	then
		echo "'$1' is not empty"
	else
		: happy
		return
	fi
	false

But I do not see much point in doing so, and I do not see much point
in the version that makes an extra check only for "test -f", either.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 80402a428f..f9fcd2e013 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -593,6 +593,21 @@ test_dir_is_empty () {
>  	fi
>  }
>  
> +# Check if the file exists and has a size greater than zero
> +test_file_not_empty () {
> +	if ! test -f "$1"
> +	then
> +		echo "'$1' does not exist or not a file."
> +		false
> +	else
> +		if ! test -s "$1"
> +		then
> +			echo "'$1' is an empty file."
> +			false
> +		fi
> +	fi
> +}


If I were writing this, I'd dedent it by turning this into

	if ! test -f ...
	then
		echo ...
	elif ! test -s ...
	then
		echo ...
	else
		: happy
		return
	fi
	false

But as I said, I do not see much point in the extra "test -f", so
more likely this is what I would write, if I were doing this step
myself:

	if test -s "$1"
	then
		: happy
	else
		echo "'$1' is not a non-empty file"
		false
	fi

> +
>  test_path_is_missing () {
>  	if test -e "$1"
>  	then
