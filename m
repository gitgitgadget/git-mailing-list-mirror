Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9B91F404
	for <e@80x24.org>; Fri, 14 Sep 2018 16:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeINWOt (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 18:14:49 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:52480 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINWOt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 18:14:49 -0400
Received: by mail-wm1-f46.google.com with SMTP id y139-v6so2629252wmc.2
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zk0CiYZ3JHkJ4H4Pg6+W3th0qf8zHW/81+I1VVvkK0I=;
        b=fUOXm0YHqPcKNBe7J+4jfmkvvFWpFX8RS/AXgiq/mc9fPzHubBHkQJGmfP8bhhdLZk
         z8GmhuAj0Il+sS0vvCOszoZgFOSTe8GWJSK7qaHvyF3+7W4+DvL/q9nn3Nyu0v1IMQ55
         M3j/vT+xhvIYgjZUqtCH8mfa8I4XF8tbrYyfaBwjWMFFxNUCtpPuFGe73l22cOJZ3zlL
         3q+vv4jGLpnkD3Cb5Cn6ifIBRjg1IRuVcUnfilpYjip3GEYxhfTxqd8THRlTA2ZO1ANP
         IOeBXixCcbTzmMuJaw/1/AL627nlgqrZaK8Y95ckPgAalG78VzfO58+WroqSGx9gTkTa
         4AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zk0CiYZ3JHkJ4H4Pg6+W3th0qf8zHW/81+I1VVvkK0I=;
        b=BeOrpQKkYC08Rs2ELZFTvmEXTyY6SbNLpQOS/cnZKbW49IETHFlHsMqcSaVIuu83eV
         zCy/mrQ933ZqiFRa05rPGMx2ZhTHE+4H6BDq/q1e3fef3zbaD4g074WI5VFitJX88vww
         QUSkFdFcPUqWHyEiTGi/qfN6WpQB+PQ6Rq3KinhStyrdbv/uZMvYz4RVARBNxDiURk9Q
         zNpsfG3B47HPgMEmV4bsuaWg5h5Z2xKGK3pbw81Xw24yMhF4gMDp7eZOMXuEIPW5Bt0d
         2onK4SQayWWYlxTkCOU3BVFLVw9XMQ5F7FEM6swtvSwDgncQdeBMGFxm6MNrdh+tsRQt
         znVA==
X-Gm-Message-State: APzg51DwwNmTRSkn3qt/Sg0usvms53KW+UZKzYsjXv/ncF6FLGm5n4ab
        u3dgLymw9wtv/9XUEvdCehxskXX6
X-Google-Smtp-Source: ANB0VdZMmhImyfgZdFNdiub8KhNN2G/uU4GA0KMgKoyzkXibRP9zsUL3yrOfaDkVGwfIfrHf5VGwxg==
X-Received: by 2002:a1c:f60c:: with SMTP id w12-v6mr3273574wmc.80.1536944366912;
        Fri, 14 Sep 2018 09:59:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a6-v6sm1714076wmf.22.2018.09.14.09.59.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 09:59:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer\@gmail.com" <t.gummerer@gmail.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1 2/4] fsmonitor: update GIT_TEST_FSMONITOR support
References: <20180914143708.63024-1-benpeart@microsoft.com>
        <20180914143708.63024-3-benpeart@microsoft.com>
Date:   Fri, 14 Sep 2018 09:59:24 -0700
In-Reply-To: <20180914143708.63024-3-benpeart@microsoft.com> (Ben Peart's
        message of "Fri, 14 Sep 2018 14:37:27 +0000")
Message-ID: <xmqqmuskc8wj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> +if test -n "$GIT_FSMONITOR_TEST"
> +then
> +	if test -n "$GIT_TEST_FSMONITOR"
> +	then
> +		echo "warning: the GIT_FSMONITOR_TEST variable has been renamed to GIT_TEST_FSMONITOR"
> +	else
> +		echo "error: the GIT_FSMONITOR_TEST variable has been renamed to GIT_TEST_FSMONITOR"
> +		exit 1
> +	fi
> +fi

I would have expected that, because we are now doing multiple pairs
of variables in a single series, we would add a helper function that
can be called like so:

	check_var_migration GIT_FSMONITOR_TEST GIT_TEST_FSMONITOR

in the earliest step.  Perhaps something like this.

check_var_migration () {
	old_name=$1 new_name=$2
	eval "old_isset=\${${old_name}:+isset}"
	eval "new_isset=\${${new_name}:+isset}"
	case "$old_isset,$new_isset" in
	isset,)
		echo >&2 "error: $old_name is now $new_name"
		exit 1 ;;
	isset,isset)
		# enable this, once $old_name no longer is valid anywhere
		# echo >&2 "warning: $old_name is now $new_name"
		# echo >&2 "hint: remove $old_name"
		;;
	esac
}

