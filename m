Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC3BA20954
	for <e@80x24.org>; Wed, 22 Nov 2017 17:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751669AbdKVR7E (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 12:59:04 -0500
Received: from mail-pl0-f44.google.com ([209.85.160.44]:43377 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdKVR7D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 12:59:03 -0500
Received: by mail-pl0-f44.google.com with SMTP id h3so1159410pln.10
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 09:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cKgg9edvGtmOKysspurqKjz+AQTa5qiu0LDAO5AM1iw=;
        b=jZZANgmWu9ZgkPMVmAPKvDCuJ6vHCeRA025Jt5Xg/b0cl62785qa8oYlRV0+nHIcWL
         nfbJLXV7p0OWU9IKjo2zyELJ/eSmpmLAHB2g0xaYLanY/TCg9Ww4CgtzPd4OuA/DFPf9
         u3r1e6gQy+x02SyLpL8KW6k+u+CtuVNah8XyCxULxnH6XqZfHXfHqPIsjJ14mrQONTgU
         33lmXP/ddlPZxhyynaZbMNizxJYj3A7T2+3nrSsX/m+6F9fk2e6XtjwEZu1nt5NcviBH
         OINLMAayhkCKeNN98mUwJa7JjajKFcGw+Q0SVQJgMZFX+xMzN7lCHzQ4cs5Ya1txnGpR
         bvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cKgg9edvGtmOKysspurqKjz+AQTa5qiu0LDAO5AM1iw=;
        b=PGoOhQgFmcd+Eo5iRLg2i36Rujt5y80mXturVwE7az/KnEAIPSMJWpYzFRtoIuUgZR
         FfRzCLR5pd6smatwgUc/QTtUyfAQ7MC50yLtIUu8zSjGQs9sWiNoIcm8YIi7WHguT2xY
         45MpVJvoW2JrtrTFwJ2MK3tl8bOzF9dK+8kvvCGSOsMjj35yRjwgCC7X9h/1RhoL/Gca
         Xwk6vP3DFCHo237wpg0kQYUbCR8OM+VYDJxw51fN4/+R2xHCAeN5guPbfXdjouj2hqry
         kWQ4VOp18+XUilkeN9FA6er0sSg64zT/dI6w97GVZ/eujr20EGswoAxel1GMuE9912ye
         NwJg==
X-Gm-Message-State: AJaThX7aIyAsYnZCXfO6rgy9VM+zCqjWErG6K5hBSfMRlbyf38honkOn
        FjDWTcwBhHRX2yQaYGtacOk=
X-Google-Smtp-Source: AGs4zMapguf/axaaSJJyK3vbRmhTK8hfv3C8bNuMUdc+Djuziq9BtFYVpIF9IgwyPGZjavUvUDnuqg==
X-Received: by 10.84.168.227 with SMTP id f90mr21863764plb.320.1511373543484;
        Wed, 22 Nov 2017 09:59:03 -0800 (PST)
Received: from ?IPv6:2405:204:73cd:cf11:6767:b6f6:4b9c:e3f? ([2405:204:73cd:cf11:6767:b6f6:4b9c:e3f])
        by smtp.gmail.com with ESMTPSA id p189sm28169237pfp.127.2017.11.22.09.58.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 09:59:01 -0800 (PST)
Subject: Re: [PATCH v2] launch_editor(): indicate that Git waits for user
 input
To:     Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
References: <20171117135109.18071-1-lars.schneider@autodesk.com>
 <CAPig+cQ3a0guJUhnbktrjs6fL6mSrUXmPqR0BafEAOhVr7Sy-w@mail.gmail.com>
 <xmqqh8tsqs83.fsf@gitster.mtv.corp.google.com>
 <d53a655b-f51e-3f44-23db-581071010fd2@gmail.com>
 <xmqqvai5ollx.fsf@gitster.mtv.corp.google.com>
 <998E3A52-C710-447A-82A3-50C58354CC31@gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <96f9c87c-d2c3-ebf3-bcca-da538c946733@gmail.com>
Date:   Wed, 22 Nov 2017 23:28:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <998E3A52-C710-447A-82A3-50C58354CC31@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 22 November 2017 10:25 PM, Lars Schneider wrote:
> 
>> On 20 Nov 2017, at 01:11, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
>>> It might be a good thing to keep the notice but I think it would be
>>> better to have that error message in a "new line". I'm not sure if
>>> it's possible or not.
>>
>> Of course it is possible, if you really wanted to.  The code knows
>> if it gave the "we launched and waiting for you" notice, so it can
>> maintain not just one (i.e. "how I close the notice?") but another
>> one (i.e. "how I do so upon an error?") and use it in the error
>> codepath.
> 
> I think a newline makes sense. I'll look into this for v3.
>

If I remember correctly, I don't think it's as simple as printing a 
newline character in case of an error.  That's because the error message 
that shows up in the same line as "Launched your ..." comes from a 
different function (possibly finish_command() though I'm not sure)

> Thanks,
> Lars
> 

