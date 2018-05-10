Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB19D1F406
	for <e@80x24.org>; Thu, 10 May 2018 22:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbeEJWgS (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 18:36:18 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:44082 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbeEJWgR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 18:36:17 -0400
Received: by mail-yw0-f182.google.com with SMTP id l142-v6so1028117ywc.11
        for <git@vger.kernel.org>; Thu, 10 May 2018 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XBGus7amkIcaPBcOAGbBJHtZiitNmVzNuWsx24GgFHw=;
        b=mI8H7Q0p0cQcpLP6hig/rAd9Qj6EyIka93vG2SkH0xRtr4q8seSZwAQl9nDpjLTCD+
         XxNhRdhkKI2TGETFkoGQdBSAZYN/M1dvs0E+YmvHALKBYI8VOAIZys+CCH/rR3aiMMSd
         81QgCn869ZYNjzowiBfzrH0S591FZBaGmNMNDxStltyxHHDlNROBiquXlU4Kn8vF+CEB
         FQqGKNlQhKWFgzAjP/YS5Yj/EaOITPXSGUBYlrMm16PptSUU9NqftmuF9v4+vyyKauSB
         0T6qS/ap4bLca/8/2+A+KC7pOauakgPW7XGjNw5VuHxwFnFyW8X4Aj/7rjhzNNb1Pwvd
         55JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XBGus7amkIcaPBcOAGbBJHtZiitNmVzNuWsx24GgFHw=;
        b=fN5Mp1vr0UUbj449T+3TRmEOVpTMV/YX8c1jQkYtU6nyPLQIKz9+aH1FEZ4Pa7GRlr
         iMumdccwDsuBNfvrRdzqwMCWD1HDlnLweKuAUSn9KPhvn/HOZHGpCOvSaItRUD39x6gc
         peZcRT1aajJe5Iro5Ax31FYWCzX9zeJ9xgQkGTyYWZiLIdqmi9xSYBlbozk2E7X5KzIS
         dllF/ccVvXhhzbWmEaGQlDZnvhxPXA6790EqSEE+RHQINEqO/Otq95Md7/Avq6RWk6mC
         yhSn9s8hRDXU2s9eHg+x7Fo55G1FKuy9iHR2kaxYAu+EC2w7e3hixyJbS92QB9hzf+g+
         NnLg==
X-Gm-Message-State: ALKqPwepbY8Qv73g8/q9s0wuBBx/iHOBrK52IiW+X6d5pWELdXZuFdWi
        3jeYE97uHqdpgFlbswUkal1QDROcMyoXfPlZj5lknA==
X-Google-Smtp-Source: AB8JxZpKyaPBNAbBUNpHN3U3U+getvr6kP8VzchesXa6LD0qTik6+xw5QzUz4MCU4DMfPQArDAgSeBDLRHmmCX2LjqI=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr1604963ywa.340.1525991776358;
 Thu, 10 May 2018 15:36:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Thu, 10 May 2018 15:36:15
 -0700 (PDT)
In-Reply-To: <20180510135615.aee82c0d9720fd6c1be80585@google.com>
References: <20180508193736.14883-1-sbeller@google.com> <20180510004024.93974-1-sbeller@google.com>
 <20180510101615.931eb0d219eac4c84cf8140d@google.com> <CAGZ79kab0RDE1D81-uxrJPRQF7LoWkTfHj=nLntd8v2cz8THHg@mail.gmail.com>
 <20180510135615.aee82c0d9720fd6c1be80585@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 10 May 2018 15:36:15 -0700
Message-ID: <CAGZ79kYWzcGaAOUXTxMV2VmkXgcu8oS9RKkeag3+BnBy3krj5g@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] object store: alloc
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jameson Miller <jamill@microsoft.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 1:56 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Thu, 10 May 2018 10:32:09 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> >  - I would call them release_commit() and release_tag(), to match
>> >    strbuf_release().
>>
>> Why not commit_release and tag_release to also have the same order
>> of words as in strbuf_release ?
>
> At this point in the discussion, either is fine.

ok, please express your opinion in form of a patch. ;)

I do not plan on resending this series unless someone comments
something that they themselves do not consider bikesheddy.

Stefan
