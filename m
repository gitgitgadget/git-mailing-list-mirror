Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24931F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbeCIRmZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:42:25 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37893 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932261AbeCIRmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:42:24 -0500
Received: by mail-wm0-f68.google.com with SMTP id z9so5269757wmb.3
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 09:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+dluF5BhmYOtl5jsT87BoQh3yQ8W/+I4HG1eL0UQD4U=;
        b=Jfb2CXS2Y5cIETNOv4iXR7IBzG3A9pS40+GwoS8gNcjMsIKZQFVRFRIusyvniWkQ+O
         v8XPSkTc+9pwINtu64rwPI8Nz9y/wm+rOelF+mSGAUIv70zumBZxU9KxoZqoJeeOPlnH
         U/5dxLhLp4FfopCCnj5mQenScJxuBA5Dn41i6Kbbn6zngIQB0hc70TA5RYkGZhtcT7oY
         Q5m7Y1zlan2OS6XJ0zBJzr2qzP/AVvlGO9I4mJzpACgAk0dmd5wFrn8y5WAQ3LA4DpWN
         /dY9zVGx7gEhXNuGqCWJ7IFJ+G2EeTGyylyOlw6GZ03OkvLlFNdyKDnqL1ov5ku0eoqU
         0smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+dluF5BhmYOtl5jsT87BoQh3yQ8W/+I4HG1eL0UQD4U=;
        b=IIE+R8i4fsv9C1bQLnKc5MWpjxIb1oThtKUPIFl6YcuHgjye4P9thQPwz24DfFR0uZ
         caa+wSBKw3qgS7v6apmZ9q+JCtXvnG6s91AJnSfcu2zIF1S+ioXq/nPMozytgm4Rq7tL
         BAfWlEeOgLlM1sSsbRvdzbdbi+BiPPm/R17Q1VAIoftuIxQyQFWGO1UUxvTLTNnQxqcM
         Uw+xfWM2pcokTvQkADOe893Vt8zxpobiOG4yTOk8CHRT3PYzdHW4LhMEh3IW8U+QCKRm
         HKrNCRcaRPX2yZnVRRmziQrH7ycgknbzzDkcSY1Wfwg8dVyoY/oT4Z5mKZ+mkHY2u/fV
         Ddcg==
X-Gm-Message-State: AElRT7E1gPnz9hvjH5AKOrenosp5mGp8tKwvmwTNQCrOHSwryY+7bPXJ
        IgnS7XEgIlS9wuMcU+GmBdw=
X-Google-Smtp-Source: AG47ELvQn43tDUsvBC6XyBntTN/6b08azC8W0z+a5ypOh7tc0ePxJYQ7NhLcza7iRp2EBC6q1iP02Q==
X-Received: by 10.28.194.2 with SMTP id s2mr2656992wmf.55.1520617343214;
        Fri, 09 Mar 2018 09:42:23 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k18sm1977422wmd.4.2018.03.09.09.42.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 09:42:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Robert Dailey <rcdailey.lists@gmail.com>,
        git <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] Support long format for log-based submodule diff
References: <20180307211140.19272-1-rcdailey@gmail.com>
        <CAGZ79kZk7N4zQUS1eMFMPTuPPuo5ViOeLj5hQHV=E+A=OO+D0w@mail.gmail.com>
Date:   Fri, 09 Mar 2018 09:42:22 -0800
In-Reply-To: <CAGZ79kZk7N4zQUS1eMFMPTuPPuo5ViOeLj5hQHV=E+A=OO+D0w@mail.gmail.com>
        (Stefan Beller's message of "Fri, 9 Mar 2018 00:53:22 -0800")
Message-ID: <xmqqina56t8h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> $ git diff --submodule=log --submodule-log-detail=(long|short)
>>
>> I'm not sure what makes sense here. I welcome thoughts/discussion and
>> will provide follow-up patches.
>
> The case of merges is usually configured with --[no-]merges, or
> --min-parents=<n>.

But that is a knob that controls an irrelevant aspect of the detail
in the context of this discussion, isn't it?  This code is about "to
what degree the things that happened between two submodule commits
in an adjacent pair of commits in the superproject are summarized?"
and the current one unilaterally decides that something similar to
what you would see in the output from "log --oneline --first-parent
--left-right" is sufficient, which is a position to heavily favour
projects whose histories are very clean by either being:

 (1) totally linear, each individual commit appearing on the
     first-parent chain; or

 (2) totally topic-branch based, everything appearing as merges of
     a topic branch to the trunk

The hack Robert illustrates below is to change it to stop favouring
such projects with "clean" histories, and show "log --oneline
--no-merges --left-right".  When presented that way, clean histories
of topic-branch based projects will suffer by losing conciseness,
but clean histories of totally linear projects will still be shown
the same way, and messy history that sometimes merges, sometimes
merges mergy histories, and sometimes directly builds on the trunk
will be shown as an enumeration of individual commits in a flat way
by ignoring merges and not restricting the traversal to the first
parent chains, which would appear more uniform than what the current
code shows.

I do not see a point in introducing --min/max-parents as a knob to
control how the history is summarized.

This is a strongly related tangent, but I wonder if we can and/or
want to share more code with the codepath that prepares the log
message for a merge.  It summarizes what happened on the side branch
since it forked from the history it is joining back to (I think it
is merge.c::shortlog() that computes this) and it is quite similar
to what Robert wants to use for submodules here.  On the other hand,
in a project _without_ submodule, if you are pulling history made by
your lieutenant whose history is full of linear merges of topic
branches to the mainline, it may not be a bad idea to allow
fmt-merge-msg to alternatively show something similar to the "diff
--submodule=log" gives us, i.e. summarize the history of the side
branch being merged by just listing the commits on the first-parent
chain.  So I sense some opportunity for cross pollination here.
