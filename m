Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5806520899
	for <e@80x24.org>; Thu, 17 Aug 2017 21:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753570AbdHQVms (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 17:42:48 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:37603 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753246AbdHQVmr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 17:42:47 -0400
Received: by mail-wr0-f175.google.com with SMTP id z91so46310185wrc.4
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 14:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=iDdDoaPqdx4QvZn4kEEEFtMFY7slI0p2/gqgdCDvv9U=;
        b=Ck/Er0fs5nY5t7jQ9c7+QiGVP3bLp4A9gR8RZramy5MW4Alo68+1XFg3PaN568X3Fm
         XE3omUMW63t7F9rnQ6UmPVxxlhL2B0oDwKHWc4kcSkovy0jh9v75Z4pfCdkY8djlSE7H
         8ALneT7ByGspZUsFjJChZb4II19HtSal4N81M+V+wCpKw9DFyLUT0cnZUcnotKDgMyZv
         L0oYgw4rC03ZjKUweuazF1BkSiMTdSiDmFiVaBfvf0gW5QNwERM4ApPWk2CpHTpaB00B
         J4wOiSZPtkhOTBl9k3pXmJvVNqSzsuIV7BnjLSHEyV3X5Tak+MLWaNUCLmpLqlhhB95R
         0iqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=iDdDoaPqdx4QvZn4kEEEFtMFY7slI0p2/gqgdCDvv9U=;
        b=r0wve/FJkohv875lcQIvNVi0pzmv4J3AUsW2KW46zMjE+opy6mHZ7WH3eNtLibWVqy
         QSF5R8zdDYsnesTq52fRpMOyuxwC60OHzg4Qrjz2o+cg2+jj6VDPwDctDwkgJKUbYUZS
         tjO/I+nSI1jnkk6ArVvAZy3ZOu1yoFiWDPRnLbB7kSi1+bWn87KSfyNiwwvYFJUfp9/R
         /NgFL39YHDDKKLkqdFYaw8JzI9NKM5D2ElXKNURiO3rEThlQ7iUJ8Gn002lkdrBhPpB8
         o7MxuPHlRIg601C2JIR834f/qZ3FvrY+xxuP2Eq4DDJoFgo1TrVenkJErwjmPm5ezVY9
         bEzQ==
X-Gm-Message-State: AHYfb5gWWRbH1DqfFfUOzGpfGmGn8fqFLu5bUs903bjtBr3/ELksyv9W
        4/nklHWx8GuOOWA2k9qgs1/0pLk12Q==
X-Received: by 10.223.138.167 with SMTP id y36mr4441388wry.176.1503006166303;
 Thu, 17 Aug 2017 14:42:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.24.130 with HTTP; Thu, 17 Aug 2017 14:42:15 -0700 (PDT)
In-Reply-To: <xmqq378pgac1.fsf@gitster.mtv.corp.google.com>
References: <cover.1502796628.git.patryk.obara@gmail.com> <cover.1502905085.git.patryk.obara@gmail.com>
 <b63b2148b7d79ebe5c57b876c7077a9ac42d2869.1502905085.git.patryk.obara@gmail.com>
 <xmqq378pgac1.fsf@gitster.mtv.corp.google.com>
From:   Patryk Obara <patryk.obara@gmail.com>
Date:   Thu, 17 Aug 2017 23:42:15 +0200
X-Google-Sender-Auth: V9kZwlq86lY4GDwRHEdRQmVZ-KQ
Message-ID: <CAJfL8+SMHQTH4Y9TFYww2WRgSfag5+sXvKniA40Qb0UEwUkrLw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] commit: rewrite read_graft_line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Understood :) - yes, oid_array is not completely necessary here - and it
gives the wrong impression about usage of this struct.

FLEX_ARRAY will be brought back in v3.

On Thu, Aug 17, 2017 at 11:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Patryk Obara <patryk.obara@gmail.com> writes:
>
>> The previous implementation of read_graft_line used calculations based
>> on GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ to determine the number of commit
>> ids in a single graft line.  New implementation does not depend on these
>> constants, so it adapts to any object_id buffer size.
>>
>> To make this possible, FLEX_ARRAY of object_id in struct was replaced
>> by an oid_array.
>
> There is a leap in logic between the two paragraphs.  Your use of
> parse_oid_hex() is good.  But I do not think moving the array body
> to outside commit_graft structure and forcing it to be separately
> allocated is necessary or beneficial.  When we got a single line, we
> know how many fake parents a child described by that graft line has,
> and you can still use of FLEX_ARRAY to avoid separate allocation
> and need for separate freeing of it.



--=20
| =E2=86=90 Ceci n'est pas une pipe
Patryk Obara
