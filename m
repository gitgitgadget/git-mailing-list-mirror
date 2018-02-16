Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4933D1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeBPS4D (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 13:56:03 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38803 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeBPS4C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 13:56:02 -0500
Received: by mail-wr0-f196.google.com with SMTP id n7so3874312wrn.5
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 10:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bQesMw5R9d+F7Jp3nka8JgbATwzFZfgIDoC8zUcQpok=;
        b=ifyi3+7Cwl/EQfAaESKk4O+zkT+8bjBBLSbtOa1xWe6wkS6TRHoDGxr5ET4Du43yxf
         hmil8WJ7ZNG7jv0hiD0DJ6PSMEXlWXhRDfT+OB8yYHiNfMhWMA/EwFdCTrTen+7VWDPg
         7KE9/1ioTyxifDZHjdiyU6z6FrWb9m3c5RKNHYMfNW5L+qPGuakbPFMWNrGCSR6kckuH
         ZFRTM33C53u2ZP+ftBmtepM8A7vGlLMNWyL/sxS0LLS1JU8UHg3lcXDOGCSRX6SLQbk5
         vF0z/lfbVPWO5vy+O8YGmZCfum9vJdo5DJ2qfgPN66V98I/wmfHTsRbUfIks3R8ORosf
         vWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bQesMw5R9d+F7Jp3nka8JgbATwzFZfgIDoC8zUcQpok=;
        b=Nzw4X42Xbm06dkSAikG1uF5uYObz9o5N4lpa5Rkbpo1luZifjrBL2Jp3FP5ls4q+Hp
         uswXr9GxZvpW1lzmgTHi0Se8l31dqy/Ns9w+dJJBtyWxMv1t4LQb172EVIDFVIJNz3vr
         JgOf0ii50YkH4/10Jw1xDr2e8fQNSA81DS2M8I26UjTN3s9H6NwdTbIyyX1sbOs6Y6bO
         P04vir6CYctPq1M0YAzIGpuu9jpcZ4EexOMt9BHUJ8M9IZW77+g4KS90LpYQ8Xw37qWo
         UUrYu/ba7ClhbDcDD01aXwSP6tGvGso22TSpnUqTiqifHcQcza+8Hy52c3ouTJUdfjd2
         YPCg==
X-Gm-Message-State: APf1xPCv+ekZsIzQ6at/c+HC+5wWo43UgCOpwKHYc94Y0f8XAw3n10S2
        MuANG025OiRrS9Zf+Y6cQDc=
X-Google-Smtp-Source: AH8x226fAVSZ++cMe5E9sc5FNUp4ukQNSqYqC+HIgcx8sk0etQVk7Cf1xnOYZQOI8JhRMEzI12Pomg==
X-Received: by 10.223.185.24 with SMTP id k24mr7062830wrf.83.1518807360618;
        Fri, 16 Feb 2018 10:56:00 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c14sm6343449wmh.2.2018.02.16.10.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 10:55:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
References: <20180215152711.158-1-lars.schneider@autodesk.com>
        <xmqqr2pm81hh.fsf@gitster-ct.c.googlers.com>
        <20180215220952.GA23970@sigill.intra.peff.net>
Date:   Fri, 16 Feb 2018 10:55:58 -0800
In-Reply-To: <20180215220952.GA23970@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 15 Feb 2018 17:09:52 -0500")
Message-ID: <xmqq606w7oht.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So a full proposal would support both cases: "check this out in the
> local platform's preferred encoding" and "always check this out in
> _this_ encoding". And Lars's proposal is just the second half of that.

Actually, what you seem to take as a whole is just half of the
story.  The other half that is an ability to say "what is in the
repository for this path is stored in this encoding".  I agree that
"check it out in this encoding" is a useful thing to have, and using
the in-tree .gitattributes as a place to state the project-wide
preference may be OK (and .git/info/attributes should be able to
override it if needed -- this probably deserves to be added to a
test somewhere by this series).

Luckily, lack of 'in-repository-encoding' attribute is not a show
stopper for this series.  A later topic could start with "earlier,
in order to make use of w-t-e attribute, you had to have your
contents in UTF-8.  Teach the codepath to honor a new attribute that
tells in what encoding the blob contents are stored." without having
to be a part of this topic.
