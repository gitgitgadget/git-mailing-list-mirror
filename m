Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234CD20D11
	for <e@80x24.org>; Tue,  6 Jun 2017 01:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbdFFBAV (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:00:21 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34142 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbdFFBAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 21:00:20 -0400
Received: by mail-pg0-f52.google.com with SMTP id v18so17961035pgb.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DNOeTqz+fVt6BDG7e0ENBDqbg+Jnx2UJ1lupsLLcuSg=;
        b=EMeIv4Ax+mgZP2m0Mf00908rz7+AIMabZ7EC+54cqMm/DjQsgRPoFMGiuw1E4gTTqI
         FR5JAAiqI/lGPXEXLIFMlyVSNB04+ykyPA7z8zkRpOosbo02nraQMms4RMlOJTVYy6lH
         aTy02mlaL5D8eSACdKSWWgU1CaPTJ+Dyjh1clq7r3U8wn51CU2HS07+r75tA0ZZezP99
         j7CDyQZqM0FebExp9vVieK/8VheN2BhCA2LEMO9kh/LvfAKp3wAkmJkoD6+sta59oXYq
         Rb+3Bir5oJ5ikK0JTL0VoVY6Q4DkZBjPTGeGDxHJ4fXykG7NtynMqenTucDCp4CkmnjY
         RWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DNOeTqz+fVt6BDG7e0ENBDqbg+Jnx2UJ1lupsLLcuSg=;
        b=ogXgFFvH+1kakHecQk41Xf/XoW1x/CalGpLsGsXGm0EjojR97GnQY/D8eHjh8ENcq/
         bKNRNeWFa0+lg62+VOibl+GZ/PG2WBe0QhWkRWkCvMD2uEKJwuX9r9eghHqwrtZ+DB38
         0K+JUuPul8G5OtcUo3Tf9nvhA+QurKDeCkQXFSg1Ia1eieiz+xrpvhMP99Uas+P6PdQB
         s1WBENCthZbSscLo8Ijch4B5MwZ96DM1DOMrSWyqpG+IBJj0IfgEO0seDY+nYK1VKWgz
         N02T6Ev9CyV/SzlljcaXfXsgUwe1wBQw/vJ8rObew97zMWdvjIIj4ew+iFYHv3G9NbA/
         eltQ==
X-Gm-Message-State: AODbwcDNpNiKjn4tI/CtRIu5uO2i2vNSAV5JWvJ5LZW1gAqaOoKOLxQ+
        7IYS8Pt97wgPWw==
X-Received: by 10.99.218.69 with SMTP id l5mr24472260pgj.88.1496710814308;
        Mon, 05 Jun 2017 18:00:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:5d03:f5d1:882a:10e])
        by smtp.gmail.com with ESMTPSA id a3sm56456462pfc.26.2017.06.05.18.00.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 18:00:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What does this output of git supposed to mean ?
References: <1496671452.4809.2.camel@gmail.com>
        <20170605231058.pgb4fgfb4z45bzmk@genre.crustytoothpaste.net>
        <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
Date:   Tue, 06 Jun 2017 10:00:12 +0900
In-Reply-To: <CAGZ79kYp6GepJxZjaXhosX=vCh0vwa57+zFHK2gHFociiyTnDg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 5 Jun 2017 16:18:22 -0700")
Message-ID: <xmqqd1ai9bhf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On the subject: maybe we want to rename initial commit
> to root commit? (evil-me also thinks we could name it
> "parent-less commit", to reinforce what the lovely git man
> page generator tries to point at.)

Is "initial" harder to understand than "root" or "parent-less"?
