Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A705020401
	for <e@80x24.org>; Tue, 27 Jun 2017 19:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbdF0TKO (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 15:10:14 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35133 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbdF0TKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 15:10:13 -0400
Received: by mail-pf0-f180.google.com with SMTP id c73so21051689pfk.2
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 12:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CSobuVS0EePDFBe7adSmh4G4aysUjY4xbhyJLhctKAA=;
        b=D9E8gF+aSTOJAWSNOflD8PTuC+GI06SHtmhm2vzCJ8ft+e5D8otDlg4tAxysJYu00e
         6apJC2XLNHM5KR8SKC6Mf4JSv6/Sz3HoXaf4QOOV/8kVv8IQxi6WBWlhpvU6od5YE0zG
         U6qh2pvRZedyQ9paMYlmXhzntdbpS+mXw3lNNrWCN30WW9QZkBhJrkhFWSRgXHcJlBAi
         JoEsGKxtByCO63jkUPnQleRZwCLqq1GAcbLI9GVp4A0FCshtx7l9EjB49edpwvQGfnHf
         actFKMxFW6SH6my9lmTA4oGg6oeArdfxWUlmrqp43NDJNuh0oxd44IIXWAah8EuwlsOK
         YMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CSobuVS0EePDFBe7adSmh4G4aysUjY4xbhyJLhctKAA=;
        b=oKrniFgQfNSlvDgVxsL4vJIn1pl4XbjPsTfLf0mptUWhd31Emc5hGEZ8v4fAaRs+AY
         pyqKbRDk83Ua2DHj0qZLbZqUWhzbFqB0PWnJcTqJXyAW+TeyTyOqxtZe/5/HVMooizrO
         8bcO+QsQhrrTA5o/Re/aeTwrFuZTaoQS43d0NmoYlAVRHe4WTp4vpatr0RCqIOsBwztS
         3WBqRwRgHcCPa9UG+KfsQXqJq7M0l2OoY7OC1tWQtWQLbBGzuzu/mLehYnzKou061vl+
         bim836O9IV55jwJYzcF0OL+EYVgSMk+QM/daldv/F+2N5x3Z/Uj9+mTep89/0Sdu74s5
         THBA==
X-Gm-Message-State: AKS2vOxy3cccbwZ52sj0jjF0HAarVY8QoypLMESYnrHS8XN2WeUjHsKc
        dRebOiZqzw0RHA==
X-Received: by 10.98.157.207 with SMTP id a76mr6759611pfk.25.1498590612499;
        Tue, 27 Jun 2017 12:10:12 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id k11sm48626pfk.42.2017.06.27.12.10.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 12:10:11 -0700 (PDT)
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
Date:   Tue, 27 Jun 2017 12:10:10 -0700
In-Reply-To: <87wp7xjo5x.fsf@gmail.com> (=?utf-8?B?IsOGdmFyIEFybmZqw7Zy?=
 =?utf-8?B?w7A=?= Bjarmason"'s message
        of "Tue, 27 Jun 2017 20:11:54 +0200")
Message-ID: <xmqq7ezx1c31.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Because in the current code is, abbreviated:
>
>     #if (defined(_BYTE_ORDER) || defined(__BYTE_ORDER) || defined(__BYTE_ORDER__))
>     #if /* byte order is bendian */
>     #define SHA1DC_BIGENDIAN
>     #endif
>     #else
>     #if /*some processor tests/* || defined(__sparc))
>     #define SHA1DC_BIGENDIAN
>     #endif
>
> And since Solaris defines _BYTE_ORDER we never get to checking __sparc,
> and in fact the "/* byte order is bendian */" test errors out.
>
> This is fixed by my patch, where we first check gcc settings, then
> glibc, then processors, and finally _BYTE_ORDER (but as discussed that
> last bit could be adjusted to sun && _BYTE_ORDER, if we can find what
> "sun" is.

Well, if Solaris defines _BYTE_ORDER, doesn't that mean they define
two constants _BIG_ENDIAN and _LITTLE_ENDIAN to compare it with?  If
that is the case, I suspect that the change to make "comparison
between __BYTE_ORDER and __BIG_ENDIAN for GCC only" is going in a
wrong direction, as it wants to take the same approach as GCC, but
just uses a slightly different symbol.

I wonder if the approach like the following might be cleaner to
extend as we find other oddball platforms.

    #undef __SHA1DC_BYTE_ORDER
    #if defined(_BYTE_ORDER)
    #define __SHA1DC_BYTE_ORDER _BYTE_ORDER
    #elif defined(__BYTE_ORDER)
    #define __SHA1DC_BYTE_ORDER __BYTE_ORDER
    #elif defined(__BYTE_ORDER__))
    #define __SHA1DC_BYTE_ORDER __BYTE_ORDER__
    #endif

    #ifdef __SHA1DC_BYTE_ORDER
     #undef __SHA1DC_BIG_ENDIAN
     /* do the same for variations of BIG_ENDIAN constant */
     #if defined(_BIG_ENDIAN)
	...
     #endif

     #if __SHA1DC_BYTE_ORDER == __SHA1DC_BIG_ENDIAN
     #define SHA1DC_BIGENDIAN
     #endif
    #else
     /* 
      * as the platform does not use "compare BYTE-ORDER with
      * BIG_ENDIAN macro" strategy, defined-ness of BIG_ENDIAN
      * may be usable as a sign that it is a big-endian box.
      */
    #endif

