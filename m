Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE89A1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 03:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbeJLKuy (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 06:50:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38916 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbeJLKuy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 06:50:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id 61-v6so11802663wrb.6
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 20:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1yao+W+j832FuT2z0rnMcqdR94U4Isssl6+g6X5QdyY=;
        b=Ez2wpGsXLDFBxpj/ohcyw0hth8KQb8bA0d6yw02lMTIlM8otjRLtHxcw24uIXccod9
         ScjM9btX6XLgvITAqJNW6J6Jr8/4j3rSL7YUkXOrHpJ4WehWI5nWgJ3xG2+QzYULYwmY
         EQKcG+ktuSQDJvn9Js7hZJa7LQKs5J6T8gpnMkQ0yHJv14KaNtUXr66/ZoxOQlXqSMXq
         YQMs9yzX1IrL4ybb7uG4cbh4QqMrfX6HPVhB28YoRkM8/nGe7/0wgOBn5vYxc/1AG3f+
         CwZgJ2aac4lrKZlbQQvBVfO3j95hFVSvHdAvOcLYDxd3iF3MfAKQbxIDmK9xPB+8ad9B
         QUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1yao+W+j832FuT2z0rnMcqdR94U4Isssl6+g6X5QdyY=;
        b=cCdhCF6HL3c1DV3k1XxdSLiq80YQnodBN/Z4GJoxODQ3Sf7JlYU2CDZI+B3UEx16O2
         x+zO+YoJ+0TeqQIpzW7eGWnm3HNBF8EUhecIoGg7QwbiOKZpoEOUdBaUSWz7THTnW1Ux
         isIf1XefNBgiPdI3dtTLCQF3lViNjaxIWtDxh1RzZsR7RJi3g7eMixx+KmspRFWHiTL8
         0uyNcJSQMdMSAMBN5200Jcqqsd0eJASTCDMYsUcm3LXofkhFnZi8cyb0uSegiLEJe/Sy
         +0K9XOkK16DZYyVCa/yY3PVgFlDNRtPRHLMMhzv9/wxXq/MPawQCChmU+9X1A9CePLSy
         Q71g==
X-Gm-Message-State: ABuFfogq9acEFXHKaVehnY2NlGd/dt8REZihHnG3xOxFI1TLh/IY5+8T
        8JIgGImXsrWrxg8m3MCZrMAIIM0GAMA=
X-Google-Smtp-Source: ACcGV62RelMHmQkLg4X4xnt+cKuaP2vjqQ3/UCjusBR0OxDxiek5BLFTxe27BI0JYo0Ncyxnch3SeA==
X-Received: by 2002:a05:6000:114e:: with SMTP id d14mr3598032wrx.301.1539314436856;
        Thu, 11 Oct 2018 20:20:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t66-v6sm128969wmt.5.2018.10.11.20.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 20:20:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v4 0/6] Fix the racy split index problem
References: <20180928162459.17138-1-szeder.dev@gmail.com>
        <20181011094309.18626-1-szeder.dev@gmail.com>
        <87d0sgepmo.fsf@evledraar.gmail.com>
Date:   Fri, 12 Oct 2018 12:20:35 +0900
In-Reply-To: <87d0sgepmo.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 11 Oct 2018 12:36:47 +0200")
Message-ID: <xmqqpnwfdf5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Oct 11 2018, SZEDER Gábor wrote:
>
>> Fourth and hopefully final round of fixing occasional test failures when
>> run with 'GIT_TEST_SPLIT_INDEX=yes'.  The only code change is the
>> extraction of a helper function to compare two cache entries' content,
>> and then a couple of minor log message clarifications.  The range-diff
>> below is rather clear on that.
>
> Looks good. I'm not going to run the stress test I did on v5 on this
> since the changes are just moving existing code into a fuction, unless
> you'd like me to or think there's a reason to that is.

Thanks, both.  Let's merge this round to 'next'; it would be OK to
do any further tweaks incrementally on top.


