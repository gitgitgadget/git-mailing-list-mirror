Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FAE820401
	for <e@80x24.org>; Tue, 27 Jun 2017 19:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753338AbdF0TiJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 15:38:09 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36745 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753247AbdF0TiH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:38:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id u36so5407715pgn.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 12:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=GlSLm9khiaQSa9NTD1SkE4I+BGqvxEHPw7GFMKnQJFI=;
        b=k/rMu1nujpZiAK0ICXEnu9+Fv7aKV1yXiu4LtcVuYGT3o5o03zRgLqxN8X2pBR3ZsB
         NPMdHq4SGFA3IWiOGN6iXH92o2Nw2/mFitRelGagz28TEoQlyn3MUDi+e0+U0BUK1umt
         WVQf5I2sNiBbiccO2cWvkANMRZL5cSngQUiUiaWi1Si/FhzkKRxzYhETNS9LOzK1XU7W
         cZFp+S9pwnmUv+jWgE/JQTF60aKwJpoMxCmXF3QeiQ/M+FfJQDWmL0h3ln3MM/YAWIGS
         g0muNPKBvlcrlDkG5aDnPK2k5fL+3IV4zOovEhSUvZxTQu5ApeY2coQQpULci0EyhV/W
         lcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=GlSLm9khiaQSa9NTD1SkE4I+BGqvxEHPw7GFMKnQJFI=;
        b=J6+7PeqpaH5hIoUIqjYLHP0dB3vb1q5Pt9+cqcS2C2UrPxuU1Dt10jBzTDMiTHQ2y2
         /C09wT6El4OtsDeR1cbpu1Kp+CV4M1VpB/6Io8wx/F2+oyhx6OXR2Fl7cuQKMdB0zwa7
         oTBI2+WiuQpfQTqH0lbSZPsqto79L9nU8DKxY+2ZlNoHzwHVWk2YPyWTk7+Pp82YvZQU
         wQ7KExBQCQGDxVqghOSPrHFQ0jQx6uT9svaXsZj/SpbFH7FCk1UM8u6kJubK88vWLSNJ
         19GScNZT/+2Ud3zLw4g3LEdsmO+L1pjl5aQ+n3uuJYzWzc2eXOmnB5N7xzgGxlvIeN0s
         Kelg==
X-Gm-Message-State: AKS2vOxCXIKp4VD6SLKvYKroLkW740orrTmyeuuivZXNXYc+KbIasYE7
        Mk31d5YyztoNVg==
X-Received: by 10.98.196.155 with SMTP id h27mr6950350pfk.130.1498592286549;
        Tue, 27 Jun 2017 12:38:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id t5sm106410pgt.19.2017.06.27.12.38.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 12:38:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
        <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
        <xmqqefu52znl.fsf@gitster.mtv.corp.google.com>
        <87wp7xjo5x.fsf@gmail.com>
        <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com>
        <87r2y5jkb6.fsf@gmail.com>
Date:   Tue, 27 Jun 2017 12:38:05 -0700
In-Reply-To: <87r2y5jkb6.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Tue, 27 Jun 2017 21:35:09 +0200")
Message-ID: <xmqqy3sdz0f6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> And since Solaris defines _BYTE_ORDER we never get to checking __sparc,
>>> and in fact the "/* byte order is bendian */" test errors out.
>>> ...
>> Well, if Solaris defines _BYTE_ORDER, doesn't that mean they define
>> two constants _BIG_ENDIAN and _LITTLE_ENDIAN to compare it with?
>
> No, under gcc/clang & glibc you're expected to compare them. Under
> Solaris it's just defined(_BIG_ENDIAN), but as explained in another
> comment this whole thing actually turns out to be not needed, on Solaris
> it's sufficient that we fall through and check __sparc.

Huh.  It makes me wonder what we are expected to use _BYTE_ORDER on
Solaris for, then, if it defines _BIG_ENDIAN and _BYTE_ORDER, and
still wants us to use the definedness of _BIG_ENDIAN.  It does not
make any sense.

But if we can use __sparc and fold it into various arm/mipts bits,
that is much simpler ;-)

