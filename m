Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 851791F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 07:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbcI0HWW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 03:22:22 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35218 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751468AbcI0HWU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 03:22:20 -0400
Received: by mail-qk0-f172.google.com with SMTP id t7so6351008qkh.2
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 00:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yAbpjWqZ0gPFARM8DNTk2qs2HVJCTCEE4Rhl+KRVQtw=;
        b=mfoQfu5X4TCGFuajKKttvHql4dtj5zSt+IVICbKbyRISz/c1U42uj4AhuI51TD6YcF
         nvzfM1K9ULhRgGVX5t2yMdgVEc520OYYQcwOcPyp4q+JLUXPTkWVItSTeodmGWQkfPWn
         bHS5s5jbMt0aL6lEnm0ZYp6bXV3YMYr9dahjwc+YN1rtvkg1co6rdXopupR5xGovPrZG
         uNzobsi/Mp1Tc4r0+l5zIe+vUz8aQ+GooElYdvILjLyu6fx+/QaK9RGTPvjmTkR0wLXF
         s5i4vcySRi8AJ08XL5Xmww/pv/V4marurA1fHVWEtbA74NoVtpmcioRO4X+1VFRk6HDT
         uKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yAbpjWqZ0gPFARM8DNTk2qs2HVJCTCEE4Rhl+KRVQtw=;
        b=jr2l19QQyrG41hvGTJlFrJKPnr27VG+FiOyicmiM969uA+cZT31zStLS4XjpME5rKU
         ZGiFixAEZ85SfyDDYZdMKwwmnXIKsCTY6oLLyInB4CX0qOIzTUhzD6V4KP84JdYuFuvh
         E/oJ4/BEU7pc81kSiZHYWbd6AYPCDu8aDPhXJnIihkAZ6Rz4/8nHHcry76/K+bkltchU
         DcIi1XnpIeplDnMY2744KUKUpiYEtY8bPtBlIr3F7m5PbS8inM+L/PVsvTN61xaiMuhX
         +UJLQ7tqCCrthxO14yilFy1ocwZBUuB9hJ0CquUsSG/OFvf0tTBl78ieUPnuaAyzSuaH
         3F7w==
X-Gm-Message-State: AE9vXwPS83TJbsgeN4MdgrZbLVlzOBlTL70WBOLpHAmqvaP7SHMMAT+MQwsPtcgoZBI8jghrY3khDcaZ1NE1Rg==
X-Received: by 10.194.216.233 with SMTP id ot9mr21626697wjc.166.1474960939866;
 Tue, 27 Sep 2016 00:22:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.148.198 with HTTP; Tue, 27 Sep 2016 00:22:19 -0700 (PDT)
In-Reply-To: <xmqqmviupcpx.fsf@gitster.mtv.corp.google.com>
References: <1462458182-4488-1-git-send-email-orgads@gmail.com>
 <xmqqwpn8bes0.fsf@gitster.mtv.corp.google.com> <CAGHpTBLdy9R7xvfcFWoMkvGNJjY-wM5=HfWxs8XF_yh-+2Rc3w@mail.gmail.com>
 <CAGHpTBLgwyw_iYK927Yed+XG9ti+tKboz07-FVYWox9WoQkjOg@mail.gmail.com>
 <CAGHpTB+Fnu4x1bV9TSNo8pYdOzJzRsXA9r3CwxVz64mjW_qsGw@mail.gmail.com> <xmqqmviupcpx.fsf@gitster.mtv.corp.google.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Tue, 27 Sep 2016 10:22:19 +0300
Message-ID: <CAGHpTBLPvQDD4hhMKiOFdhxug-joi-38mNozuzm3=EJCnS9UEA@mail.gmail.com>
Subject: Re: [PATCH] git-gui: Do not reset author details on amend
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2016 at 12:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Orgad Shaneh <orgads@gmail.com> writes:
>
>> On Sun, Jul 10, 2016 at 7:36 AM, Orgad Shaneh <orgads@gmail.com> wrote:
>>
>>> On Wed, May 18, 2016 at 9:12 AM, Orgad Shaneh <orgads@gmail.com> wrote:
>>>> ping?
>>>>
>>> It's been over 2 months. Can anyone please review and merge it?
>>>
>> 4.5 months and counting... :(
>>>
>>>> On Thu, May 5, 2016 at 8:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Pat, we haven't heard from you for a long time.  Are you still
>>>>> around and interested in helping us by maintaining git-gui?
>>>>>
>>>>> Otherwise we may have to start recruiting a volunteer or two to take
>>>>> this over.
>
> Sorry about that.  No volunteers materialized yet X-<, and I really
> really do not want to apply anything other than trivial patches to
> it myself, as I am not a git-gui user.
>

This patch has been in use in Git for Windows for a decent period of time.

I actually see that there is a problem with it:
https://github.com/git-for-windows/git/issues/761

I'll try to revise it and resubmit.

- Orgad
