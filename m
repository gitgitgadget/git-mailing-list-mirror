Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6E520248
	for <e@80x24.org>; Wed, 13 Mar 2019 22:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfCMW6L (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 18:58:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36076 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfCMW6L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 18:58:11 -0400
Received: by mail-wr1-f67.google.com with SMTP id g18so3808349wru.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 15:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=41SdW84Vq42VXnQRXhteJZT0vOil+i++cmBqe/eOaBw=;
        b=V8vqrFZGH+xhGdwpfxi4HkZyIrqTwEwNTy6H0DzIoaWCd/8j2h4Gj81kIxGE2MoHm7
         KIo22sXoeBc7S2GUKrASb8rGLjZuLNT5uF3OTgRlbRjaIq46qvXEQTTg5lf8X+weHfEt
         /ihNoKAOXjQwgjd/Wbzkm042RwJ6p91AVfNU13puePSwTYadJnz0Qr8oepMz4TS4AD3Q
         IRI2eqnH9UlanEOB8p4xtkB0DkxRswp98zhd49QcEOD5s/JR8LaEQqSq1mhogDSy8z2H
         MtvCxRswJAKj/kFhWbWgqj0a2Ts5SO/KX3qrIO2cNE25TcPABCiZJ9Uf8CNIi3OQEUuL
         K24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=41SdW84Vq42VXnQRXhteJZT0vOil+i++cmBqe/eOaBw=;
        b=KTS+LeDA/0OcekHljkMDeYsymk1eUGExEf0MhSW2jJ8Hlz2LIhidUt2aU5QIMxqbqz
         xuTJlYVhe/XCjT5gvF6oUCFu/QOg7orOzrVwmwrJioQjqhvKo5ZX0eYvaifc0zEu2dWR
         XC2AoabpQ3BDQ6nWVGGSAC9ii+pl2ltK7gl94TOZIXkkbn4PkDR7by1N9Cw7pBgyYvY9
         FhpQJhXV8abvzMMq2sOlbq4AzxCmof0yeTmcEC0whonK83fcywefEvSH3UKAeMq4hnZM
         n2d4gNVAJwYS/0u6n1qe6AKmk6OF90nZb8Pr7sS2rT2n9GigHd11qxMlFS0et51ThP5C
         9heA==
X-Gm-Message-State: APjAAAUzv6E9MQts6X4zr1OvyAYKH6DJruici2aTZNAXqgXdkZ2BTsXV
        O44Df5EYwdE9GXX5bdtLkIU=
X-Google-Smtp-Source: APXvYqyRE2yWhku3LFZV0pLLA2cUp9fW9cKpSUrq5ktMTrJa1kAAegKFU5oSJXbauuycukEgUZeSzw==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr30058587wrn.45.1552517889160;
        Wed, 13 Mar 2019 15:58:09 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 132sm626763wmd.27.2019.03.13.15.58.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 15:58:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v1 00/11] And new command "restore"
References: <20190308101655.9767-1-pclouds@gmail.com>
        <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
Date:   Thu, 14 Mar 2019 07:58:08 +0900
In-Reply-To: <CACsJy8BB1GAaBX=YcmNf1fLj5chc5hcvHLTwvzwJgvSWWKNFdQ@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 10 Mar 2019 18:19:28 +0700")
Message-ID: <xmqqr2bacrgf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Mar 8, 2019 at 5:17 PM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>> - --index has a different meaning in git-apply. I don't have a good
>>   suggestion except "yeah we have two different worlds now, the old
>>   and the new one"
>
> I will rename --index to --staged to avoid this. It is already used as
> synonym for --cached in git-diff. I will also add --staged as synonym
> to "git rm" so that "git status" can consistently advise "git <verb>
> --staged" where verb is either restore or rm.

Does "restore --index" (now "--staged") work the same way as
"--cached" aka "--staged" in git-diff?  "--cached" is about
affecting only what is in the index (as opposed to "--index"
affecting both the index and the working tree).

If it does, then calling it "--cached" aka "--staged" does make more
sense than calling it "--index", I would think.  Otherwise, such a
rename does not buy us much.
