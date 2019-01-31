Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368631F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfAaSqQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 13:46:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36799 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfAaSqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 13:46:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so3694833wmc.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 10:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ExR0kkfcb+5XXHIryChTa7chWJ/OF3CYPjLBDeolugA=;
        b=bMuaj13I44Y8q4Jp3mVEeAdLw8xVUGav+y7Yhl61a1J3kvVayFXf0gMSxXggfD7MqB
         7RE4gQ4IjrrTfDIqUqx/SFxtuxDejjk/3KdnqQ0ynKT4f8O2c+UsehqbQysCVkLkOQGg
         nlEroOOWLXXok+bJ+73J4n6iJaxgtXbnR9x2VBQOcYfLFqw+9939j1HERxZm2Nss4vzp
         AQPMMJQ3pDMAUjnvyU6XryDZ4Ka9ZYj/sYh8W6ZL2jxUkb5LnYj6+BTvx/8GDRhly9Jr
         tdvSYFcZsqK1igAarYg+XQSZuSHOiJZvd8oo/9pYHvtjRpjEBahkCZCtXMunSzZeB0cN
         cPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ExR0kkfcb+5XXHIryChTa7chWJ/OF3CYPjLBDeolugA=;
        b=iB3yY+HvNP92Ns+T4sw23n4irw2IvtniNLzy2lXiI2PcapPdP0mPINtTv+4K+TOB21
         px9xqMsVKGl5BDnbBMYwm+ha//RyHmlADyu1oJU4UN6zOXmyN9TVdc8+gMJFOHqEkeop
         UxMIqLwd8YUegHOmFuWkdSiNRk8WttPpF3iWpa/QthbTdaTMDSPGsXSyYP8tkK+iN/5P
         qA2ELZXmISn+jsQLkNw+i0BpIIILPWtLt01RuSBwnbs26EHBvUPnSotwr/uxeUKCKsel
         aYOykFP9Expjn6L6Ql9Rbm6NKKEXA1Bg7qayuNHgfn8xUHDuehHp1lvMyvJWzylGj2kM
         eMqg==
X-Gm-Message-State: AJcUukc/PVYEYH2Ccn8jKfnrKI9gryXo5NbSUvrr52kX6Zb33W/CzN2M
        akvBlhdzX2gRZPVaJo96N50=
X-Google-Smtp-Source: ALg8bN7lO0yNdKZSqvBIEfkCB5VaZy3sKfeg6vOu1mBWIuWp8XrNJ6PaEE35M2ZJj9Nc4FhIeWGgPg==
X-Received: by 2002:a1c:760c:: with SMTP id r12mr28628345wmc.127.1548960373466;
        Thu, 31 Jan 2019 10:46:13 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f199sm81562wmd.25.2019.01.31.10.46.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:46:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH v4 00/14] Trace2 tracing facility
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
Date:   Thu, 31 Jan 2019 10:46:10 -0800
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com> (Jeff Hostetler via
        GitGitGadget's message of "Wed, 30 Jan 2019 12:56:20 -0800 (PST)")
Message-ID: <xmqqftt83bt9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Sorry to spam the list, but here is V4. After building V3 on 3 platforms
> without error and submitting, the compilers on platforms 4 and 5 complained
> about a variable declaration. (sigh) [] fix declaration after first
> statement [] add -DNO_UNIX_SOCKETS to BASIC_CFLAGS when NO_UNIX_SOCKETS is
> defined in the Makefile.

OK.

By the way, if somebody can teach gitgitgadget the same Date: header
trick that is used by git-send-email, so that the messages sort
well, it would be very much appreciated.  Here is how I see this
thread in my MUA:

 .   [1366: Jeff Hostetler via GitG] [PATCH v4 01/14] trace2: Documentat...
R.    [  43: SZEDER Gábor           ] 
 .   [4459: Jeff Hostetler via GitG] [PATCH v4 02/14] trace2: create new...
 .   [  69: Jeff Hostetler via GitG] [PATCH v4 04/14] trace2:data: add t...
 .   [ 186: Jeff Hostetler via GitG] [PATCH v4 03/14] trace2: collect pl...
 .   [  38: Jeff Hostetler via GitG] [PATCH v4 05/14] trace2:data: add e...
 .   [  25: Jeff Hostetler via GitG] [PATCH v4 06/14] trace2:data: add t...
 .   [  50: Jeff Hostetler via GitG] [PATCH v4 07/14] trace2:data: add t...
 .   [ 101: Jeff Hostetler via GitG] [PATCH v4 08/14] trace2:data: add t...
 .   [ 114: Jeff Hostetler via GitG] [PATCH v4 09/14] trace2:data: add t...
 .   [  68: Derrick Stolee via GitG] [PATCH v4 10/14] pack-objects: add ...
 .   [  42: Jeff Hostetler via GitG] [PATCH v4 11/14] trace2:data: add s...
 .   [  34: Jeff Hostetler via GitG] [PATCH v4 12/14] trace2:data: add s...
 .   [  45: Jeff Hostetler via GitG] [PATCH v4 13/14] trace2:data: add s...
 .   [1276: Jeff Hostetler via GitG] [PATCH v4 14/14] trace2: t/helper/t...

and all but 4 and 3 appear in the right order owes mostly because
they have Date: header that increases by 1 second interval, but 3
and 4 share the same timestamp.

I can obviously cope with it, but if a tool at the sending end can
eliminate the need to cope with it in the first place, that would
help not just me but others ;-)

