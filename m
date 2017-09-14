Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D3DD20281
	for <e@80x24.org>; Thu, 14 Sep 2017 07:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbdINHJr (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 03:09:47 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:45762 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbdINHJr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 03:09:47 -0400
Received: by mail-it0-f44.google.com with SMTP id v19so2845837ite.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 00:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oSHjC0Ug2GT0UutUC5FCjqyFTS8QJl44+vpvhG20Hzk=;
        b=W7vMCPjPs5abpXsPy+yIK/Zb0J4IO9IrHHzGszG28m5oWQ6Pw6R6so/ZwWdKU/d3uh
         AeK79DkBzKr4VK7km2q11BAlZ+NtxwyVrHAcdtMo282VlYrN8k39eJZaPpwji6LLAdlK
         0qyPW+dA/MLR91Bi2UYY58bqlLs+t1E4hr7MJLN2UtpV/Z6WIKJ3Z3db4k0PPs6puivz
         adD6oQJERfbtBKklhjKzpCze00oVr7VLmTcySdcHuviLeVRL3l7w6mIM0gG3kXPbq4Xm
         Tzy4xyc5Dc1ILV8nl+4SRkTZK44Yf0/IQfqMnAgmtKJLKDHFFJT0UzIx46M8Cg1CF/xI
         VXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oSHjC0Ug2GT0UutUC5FCjqyFTS8QJl44+vpvhG20Hzk=;
        b=lAie2r+fGa8TMf4PoTx6UkblFt/6/3lbb9Jqqajjx8ObfBiZn0riwJF6vx3i90mRmd
         rgW/psiXbT4lljyBVU0ST4DPg4DPwNxWHxzECd/8HQp7SEU5PPS3UPuFk4iR8Mnv3tEE
         zo/7mOxr0rjD/nOlxEpPQGQ7mxCMANYnVzs9muLwiYQO6a1FPL+JUQWSGnVnobv+NTht
         bEo3DOqvmld+j/0qbY/Q+3WsmSNsHXESaTaNAZ4Yhl4v1cLXphNiJZt7Ley5/6vgbjK3
         yOFfvPlCdSfqMtG4t+gGG9xr7SE8xf5gJvmL6d2cy5DhJQQAeTmenoeXC29/hoY/yvGV
         H2lA==
X-Gm-Message-State: AHPjjUgEtFLGSqnaU6fsOwkt9pssH3XlrwMzA9aGIjlDZNtHPL+hXgeG
        /ajeK7b96g9j5y6w+tEHc/ITbIhcjYEJyziOAA8=
X-Google-Smtp-Source: AOwi7QDmiHiKIPI+/ddonFmvi+vYSLMkw9F/O3QlfOsWXz/HSj5s7TjIo/kwUlaZPGESr3j4Hadckm7IwOy1vJhW1CY=
X-Received: by 10.36.111.4 with SMTP id x4mr1665745itb.144.1505372986223; Thu,
 14 Sep 2017 00:09:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Thu, 14 Sep 2017 00:09:45 -0700 (PDT)
In-Reply-To: <50C9AF15-26DF-48F5-926E-B5D57F492DD1@gmail.com>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
 <20170803091926.1755-13-chriscool@tuxfamily.org> <50C9AF15-26DF-48F5-926E-B5D57F492DD1@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 14 Sep 2017 09:09:45 +0200
Message-ID: <CAP8UFD04cNASyWGURb7wYMX2eyOqKAumVuFvHCQ-nWYoPzzJZw@mail.gmail.com>
Subject: Re: [PATCH v5 12/40] t0400: add 'put_raw_obj' instruction to
 odb-helper script
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 10, 2017 at 2:12 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
>> On 03 Aug 2017, at 10:18, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> To properly test passing objects from Git to an external odb
>> we need an odb-helper script that supports a 'put'
>> capability/instruction.
>>
>> For now we will support only sending raw blobs, so the
>> supported capability/instruction will be 'put_raw_obj'.
>
> What other kind of blobs do you imagine could we send?

As for the get instructions there could be 'put_git_obj' to send blobs
in the Git format and 'put_direct' to have the helper read directly
from the Git object store.

>> +put_raw_obj)
>> +     sha1="$2"
>> +     size="$3"
>> +     kind="$4"
>> +     writen=$(git hash-object -w -t "$kind" --stdin)
>> +     test "$writen" = "$sha1" || die "bad sha1 passed '$sha1' vs writen '$writen'"
>
> Typo? Should it be "written"?

Yeah, thanks. It's fixed in the current version.
