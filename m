Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE391F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeH1Xav (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:30:51 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:40681 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbeH1Xau (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:30:50 -0400
Received: by mail-wm0-f44.google.com with SMTP id 207-v6so3134419wme.5
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QL84X1NZ43GMb2ylgotXaOE0uGbDsNbT3bEsBRvGHds=;
        b=oAffmcq6aZjVO1S6Zq/corj/G6NUMABxU2DgUTOAesL1567bo+yVqYX4bL5f6raYuP
         e5od6iYxa6+jAAiNEZKRINimXs86OINEYLwtzihqd/Rs46GNXSmrCmmJ4ImemUaS+LIc
         VRcLYJMV3/4YrfSjm1MgrE3CS3dwQ9ZAQXh+CgB3bRpePvohikKWLK54Bj6qr4yp5F7s
         kdiVrxy1g1eWgXZZ2YtFl7jeJd52jXSGMFmUl4oYsLiQ3csOE/zICLsQO82EAm04rPHP
         yE2uxZQWv5V66ZWRfB8upPySMlXiM12pVc296CMNw0QBD/aoBMK9EXj+xNP56fIes3Pz
         0COQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QL84X1NZ43GMb2ylgotXaOE0uGbDsNbT3bEsBRvGHds=;
        b=uT2yQN/eoAnC9kqXyApIxqZgEFHJmB6Qign+QYcu4XP1t34OmTjhZjac24a2izs499
         UEfr8nsF4vlukcL2j6+eYY0iKBQBVtuuQ1bUnABHpDJ9vTrYJJzRp5Mp1uFWAPSfrVto
         kpmld3gEEhrjvQUy/uLvc1WYNXyfG3T7btUoeKXKv1l9+f0A4PURv0u8SsP+9ptUsKss
         +OGurBoPQX2WMJYTvwVJr7oM1k9FKBGBFVmYK3/LucWJKeBolE7W/LTtoPuvsoVytatx
         1HEYrTNVI8rFM6wp+xcVBXs4qrHP6wFQYjMMM9vqTJNMm7IJzeOG7F9srkHBJycZzsfR
         Cygw==
X-Gm-Message-State: APzg51BBozQrDbQuEpW6JowJc2by832emibC0Okt+XUjeCu3zX1Am0IL
        eCMYebDErTrBSflxAVJ0NDM=
X-Google-Smtp-Source: ANB0VdYj5IQ27AmxLUPn9utvyNN+TvwljeH7AGisrgL1e8WQ5ipsk2bcLv2mhOxPQHEb+e2CvJuj1Q==
X-Received: by 2002:a1c:7f93:: with SMTP id a141-v6mr2245444wmd.45.1535485061966;
        Tue, 28 Aug 2018 12:37:41 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m68-v6sm4371026wmb.10.2018.08.28.12.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 12:37:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "H.Merijn Brand" <h.m.brand@xs4all.nl>
Cc:     git@vger.kernel.org
Subject: Re: Feature request: be able to pass arguments to difftool command
References: <20180828175711.3a0aeacc@pc09.procura.nl>
Date:   Tue, 28 Aug 2018 12:37:40 -0700
In-Reply-To: <20180828175711.3a0aeacc@pc09.procura.nl> (H. Merijn Brand's
        message of "Tue, 28 Aug 2018 17:57:11 +0200")
Message-ID: <xmqqpny2ffjv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"H.Merijn Brand" <h.m.brand@xs4all.nl> writes:

> So, my wish would be to have an option, possibly using -- to pass
> additional command line arguments to git difftool, so that
>
>  $ git difftool $commit~1..$commit -- -m -v2
>
> would pass the arguments after -- transparantly to ccdiff (in my case)

At the syntax level passing any option after "--" would be a no
starter, as I would imagine that "git difftool $revs -- $paths"
should still be supported.

At the concept level, however, I can see why such a feature would be
useful.  Perhaps

    $ git difftool --backend-option=-m --backend-option=-v2 HEAD
    $ git mergetool --backend-option=--foo

with appropriate way(s) [*1*] to make it easier to type (and
implement) would be an acceptable avenue to pursue, I wonder?


[Footnote]

*1* There are various possible ways, not all of them are mutually
    incompatible.

    a. Give a short-form synonym, e.g. -X, to "--backend-option";

    b. Assume that backend option always begins with a dash and add
       one when missing, e.g. -Xm becomes --backend-option=-m

    c. Allow giving multiple backend options on a single option and
       split at whitespace, e.g. --backend-option="-m -v2"

    d. Allow difftool.$toolname.opts configuration variable that is
       multi-valued, so you can say

	git -c difftool.ccdiff.opts=-v2 -c difftool.ccdiff.opts=-m difftool

       (of course, not necessarily from the command line but the
       point is you could configure it)

    Some of these (e.g. b, c) may not be desirable, though.

