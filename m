Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91CA11F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754839AbeBWTu4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:50:56 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35498 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeBWTux (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 14:50:53 -0500
Received: by mail-wm0-f67.google.com with SMTP id x7so4291758wmc.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 11:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3OG4gcKwXIfgt9XII8q33tgV7ItPILCDq8EoxR5KbtM=;
        b=GqF/OgP2MMuWOpp3KFam++/NaHO7Fce9iFQ8GyUD/lbpTMFw50bRFBsNIwpHklspHP
         GhlNkwlhpE17fla8Z1xmFTDij35Bv9qR6N//N83as8dpwbSo7lls6x+9T1PdAzqYMDQ3
         cc7/DSsP7VJmnmCOhYGF/UunsfGWU+9V+sxIig/3hJPwyIeYfjhPYVUBfPLgcZFwEs1c
         2dbMZj7jnJjtTMZaLMb91w/AZBhOxWvRYXhs01yqreVyljtm1Rd/biBT52eTgyFdhU1S
         ubaayImxXyf+fKJ95jC4+oPC4OjQoQcq37+VYeeUWwBAyimbn/EZslLUNDW9A8CDOqsP
         c1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3OG4gcKwXIfgt9XII8q33tgV7ItPILCDq8EoxR5KbtM=;
        b=aUlNyUrUTuW5D9gVCQY6zcvYR/sJuv96LezFm0kRIAVbOR8dZglkUTAeqTYRnVe0Dn
         +cwtDOjy0dqGGCg0JXj+0FE/5bi+JyEuIMusg9PY2/2c+erNDzRJIMGh01TePiTj2uNq
         2yy8xmM4hrqyM5bBWeY/Hn0vhMtfTqcfdfyBXQzRd2nsvpGAAxD8ejaIpnwQBwKhey69
         VE0aFjtDLRYXP75nyDqpk5lTO5EVZrK6EYmIWOMFUzXtJGJJo++s968MhIm5prHvvBU8
         YWr6a6Ya/Dr1M8UJNp3Rzno19wS+eHVBqaCGm1+eT7OqtawJm9xZvUrIYh1kxTRgfwkH
         A9vg==
X-Gm-Message-State: APf1xPBNRgGmnoTSLsEBSfRdFujnd0eXRDUgwNp5JlzZbrVYv5+MhQLY
        xb8Q7AZ10w8LJm8qkVS5lTg=
X-Google-Smtp-Source: AG47ELu2bDw9gEBC+VzM615F3Pi79EzVncvRssdooGUOSx3nUTix6xeN9SySFv4v+GUhJHqZ3sPzFA==
X-Received: by 10.28.15.140 with SMTP id 134mr2468046wmp.54.1519415452307;
        Fri, 23 Feb 2018 11:50:52 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c7sm3195097wrh.18.2018.02.23.11.50.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 11:50:51 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] Revert "repository: pre-initialize hash algo pointer"
References: <20180214180814.GA139458@google.com>
        <20180223095640.25876-1-pclouds@gmail.com>
        <20180223095640.25876-3-pclouds@gmail.com>
        <CAGZ79karK7MT_qpFyYfVkioeBsBHidGdC_QfisPmG1a4dQuk5A@mail.gmail.com>
Date:   Fri, 23 Feb 2018 11:50:51 -0800
In-Reply-To: <CAGZ79karK7MT_qpFyYfVkioeBsBHidGdC_QfisPmG1a4dQuk5A@mail.gmail.com>
        (Stefan Beller's message of "Fri, 23 Feb 2018 10:24:39 -0800")
Message-ID: <xmqqfu5rtrhg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I wonder if there is yet another missing case in the enumeration of
> the previous patch:
> Some commands are able to operate on GIT_OBJECT_DIR instead
> of GIT_DIR (git repack?), which may not even explore the full git directory,
> and so doesn't know about the hash value.

... because GIT_DIR/config is not known?  "repack" is not one of
them, though---it needs to at least use refs as the starting point
so a standalone OBJECT_DIR is insufficient.
