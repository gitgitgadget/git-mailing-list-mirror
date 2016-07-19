Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71C31FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 19:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbcGSTYj (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 15:24:39 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:36477 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654AbcGSTYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2016 15:24:38 -0400
Received: by mail-io0-f172.google.com with SMTP id b62so28033697iod.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 12:24:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B/+DEQZJuUefwaqJ33nOLsrj0Tpofnev2pUoN+JJqDQ=;
        b=pyzXvUereK46AoQwodW3OeEbQ9TKWhxCsiRWtCw6T1IS5fJn+0zl7/fCRT9uiIuofW
         YANEeGev4QLFInOYd6Ax3WjQqFUkEh30YuZxoeqaFKDsMEATfHz7ePmyLA/+DGIMPRkL
         HrjzSSA1PJwLi9Kw5ZTA2N4Yf1XSuI3+OYPeFKuYDBsLLepS+cyanpBY8dVFO+fAzGSJ
         6tVVwxUvEZtc0rxZvIyN9NGaIFRoYGMSKUORG+349Z8t+sXzdmEplT7JlkcnzKfPy2fk
         YIrK7GUSC5qziZpzMxXJ4Yft457leerOrZC/9rL77RD0Anqyb81u4o26IXiWQbgdHxDp
         H+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B/+DEQZJuUefwaqJ33nOLsrj0Tpofnev2pUoN+JJqDQ=;
        b=SuXNxMovEuaaV8LqhnGmSR6ONAxtW+EyHiDcbM3v+ap9IeXzqyxQPaqPpqiwy1i8q5
         tlJOv+d5Ww16Mg3WnuNN9Fy4rU4K2MZZFSEVjUmumOOt0wN5xHpqcOTvIdEBG5sAlj8k
         o9lSFNAH0JFKcf42SWoD/Nb/oKyQzG4wQ4cLQ7Y/XXkSFA416JNNrKw1hPMWIAvPjolT
         604CxgwetBpYaXP9eDxtriajCXj1ILQc6H8ajnIhLwOTrKOeiQMI58kEir+6ZBZ/XvyT
         4+s4yL87BoVBMbmTUWYam2wCXU5G6xsLZSMgH78rQzxBtUKAZUfiOHOZ0fjJOf3JdLXx
         kCxg==
X-Gm-Message-State: ALyK8tI6hXsbSlPqHNZI2ZnGC+G/pxM1NsT8HRRW1BmFQRaEzRoiLAItMh20kEjtbzgKDqy40Sey9326UzxyFZxs
X-Received: by 10.107.144.10 with SMTP id s10mr39357371iod.165.1468956277166;
 Tue, 19 Jul 2016 12:24:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 19 Jul 2016 12:24:36 -0700 (PDT)
In-Reply-To: <xmqqd1m9fnhj.fsf@gitster.mtv.corp.google.com>
References: <578E7A07.8080006@web.de> <xmqqd1m9fnhj.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 19 Jul 2016 12:24:36 -0700
Message-ID: <CAGZ79kYAH2GtpmXfUrFd5s-g=-=n0CPSa7EKFvABtVz5GXX-aw@mail.gmail.com>
Subject: Re: [PATCH] submodule-config: use explicit empty string instead of
 strbuf in config_from()
To:	Junio C Hamano <gitster@pobox.com>
Cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 12:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> René Scharfe <l.s.r@web.de> writes:
>
>> Use a string constant instead of an empty strbuf to shorten the code
>> and make it easier to read.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> ... unless someone can come up with a suitable non-empty string to feed
>> to git_config_from_mem() as its name parameter.

Thanks!

> I wondered if we used to do something useful with rev and later that
> useful thing was removed leaving an always-empty strbuf, but it
> appears that this strbuf was introduced to always hold an empty
> string and nothing else, which shows the (lack of) quality of
> reviews in this area X-<.

I am to blame for this. :(

>
> Will apply.  Thanks.
