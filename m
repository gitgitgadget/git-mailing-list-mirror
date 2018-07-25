Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6EEA1F597
	for <e@80x24.org>; Wed, 25 Jul 2018 20:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbeGYVfC (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 17:35:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45559 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730445AbeGYVfC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 17:35:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id t13-v6so8536366wrv.12
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=i922jSq/2vKVk69aC2KOcIX2bg2zRlN3NgkJ9XpGoT8=;
        b=WRUVZXX++fto93YVxw+dHopoWybff0UaavWGEpuyKj9d7v8vLZUXa80MarHT/w/6CK
         uKAmv78hk1XVb5qbeknLakLRuTZ6XaVOjmIAWjUGXps0UtXRH75dE20A7Vbmj04atonZ
         eNiHA75/frWLxNm4Nw6QAImE7JYugC255XL8ld++kQ7hI6aqczycolI+LYvgUOcKhUci
         dGoBdxZHa0UM1bQpI9Y3zbeoJ5naVfLfhsu9JY6LR8Zl39PRhHmBe89a+vaQfkoYmu+2
         uaaLjBGBpwI6cmS1IvvKWDdrLL2Nj5Hg8PtNjvA1I8IF4+oR2yTkcjUuIBAxU7o00+Fz
         idqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=i922jSq/2vKVk69aC2KOcIX2bg2zRlN3NgkJ9XpGoT8=;
        b=cwH7I2GG3FGb0+TSBrXPaYq137n2zzKYAPkTtDnUUVt+5q4CjixFYOrmc7M1K0UWEp
         P2LzcxO8dxFcLyFnZlJooy5Ywxiu5A/+40viAy5vsCAMNZIlGF0EaXEJaCzljgiqaoKB
         WR3Mw1o4T5ocaK3PlgCZNzlVYMyfuU1Qftdtn3fLzKpE/wVLCHKBAMPkvcbRg11kwRXQ
         sXbKVLrvYWiUEnwqlnJ7Q0WPsAQ33ZMQe+WBCmWG2ct/pJTidw7V1XQQ9BtlCXQnkVMV
         sQNzrz1C/X8eALAsMDDA2dm3Dz74lCRDMGOYrNh4NMBdbKaPLFXmhfMDC6TY0u8VIy1m
         WRMA==
X-Gm-Message-State: AOUpUlGxwWXyvUJxc9SfSBnnuxMHHuDjaQMuVJwkGMpVQ9EARtDdye2Z
        JBP83MwNUx5ysZcUe++KTOU=
X-Google-Smtp-Source: AAOMgpfSBKNrAJmFiKeXNfGh6U0Ui4Djadu5fnoO6blD6pSx9T47LTx7uTk/f2vvzAJS5g2lfeDv8w==
X-Received: by 2002:adf:f148:: with SMTP id y8-v6mr15096547wro.134.1532550104551;
        Wed, 25 Jul 2018 13:21:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v1-v6sm38678235wrs.34.2018.07.25.13.21.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 13:21:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     chenbin.sh@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] add hook pre-p4-submit
References: <CAE5ih79ndEbnEeV_muQyZwG+01_8Kg0J74rZtOoK1_V40E0z7g@mail.gmail.com>
        <20180725134345.8631-1-chenbin.sh@gmail.com>
        <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
Date:   Wed, 25 Jul 2018 13:21:43 -0700
In-Reply-To: <CAPig+cR2gYEwOTVBMRde35rn9oVsixeerbm5iJV+FmnOiBWxqQ@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 25 Jul 2018 16:00:23 -0400")
Message-ID: <xmqqin53ukvc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Bikeshedding: Should this be named 'p4-pre-submit'? That way, if
> git-p4 ever grows additional hooks, they can all be grouped under the
> "p4-" prefix.

An excellent suggestion.

> Does the hook receive any arguments? Does it receive anything on its
> standard input? Those questions ought to be answered by the
> documentation.
>
> Also, how is the hook supposed to determine whether the "submit"
> should proceed? How does it know what is being submitted? Perhaps the
> documentation could provide some explanation of how the hook should
> glean such information (especially if the hook does not itself receive
> any input).

Yes, such information in the documentation, or lack thereof, would
mean the distinction between a useful feature and an unusable one.

All other review comments looked quite sensible and an update should
address all of them.

Thanks for being a careful reviewer, as always.
