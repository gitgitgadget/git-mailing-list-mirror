Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CBAB20193
	for <e@80x24.org>; Thu, 27 Oct 2016 22:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S943169AbcJ0Wsv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 18:48:51 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35736 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S943002AbcJ0Wst (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 18:48:49 -0400
Received: by mail-vk0-f53.google.com with SMTP id q126so41136843vkd.2
        for <git@vger.kernel.org>; Thu, 27 Oct 2016 15:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gmtaOLl5oV4CSpv63oHP7EARkV2Vnr/R1HXesEKAY0I=;
        b=JDZCrOqGcA2JSHPLsN4yelSwru0lk+GjEm2BRPrBDGzWJsNTShyZnnDWWxV0YciEyT
         YIIk7N8FgBmZzWy9nRdr8FuAPrXfBs8qMzh3XoFQ0Hpq+TE/sKEejg+lu6VDasws6BO0
         IaHhCOZppeccILTApFx5OPdjSKOhIN2/O0xhpKYMWRwugeiAVCQisATDr9i2bpa5xOxq
         SNBhGuKXGGMIEMcmzrhCnE6DpU6Bt0J7NhydpTAfHhga4G3a9a6xJ9VncRfMeyZoI2zb
         gg/xd9jPop1N4l6D9jUIQkqCvPaK8eCA56/ixDCjWwgM4M4CvUl2TBMcl7cm6So7aHer
         uCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gmtaOLl5oV4CSpv63oHP7EARkV2Vnr/R1HXesEKAY0I=;
        b=L7atqJzb5JrvlYSjTMHw5fF4swhqL7UtbJgUhRvUuBTM0gH/ubMdQjgcijGS5pQdsK
         cyxVebXwkzIinT79EUqk7jfl2Us7/oT8xU0wSWVCx81rY+6fi+C6FDxCO0giYfrKglE6
         6sSJTb7eiW7fMo/iOPbfMOrHDuEBGxL5mKu70oTylXPmBELvpnszOE+WWubX7nrhZ3RS
         VQjNP4v1iwyBevnH9qfRFK9jsI7sWkEkgI3q1IacltzYXw2GZUij+aaApXtnpg8adrBc
         WMYQ7y01MRsFWUcQnsy8Odvk4/6HxK3yg1ug2mICquFCSD0dWWF84EV/U8eSjIshlmh/
         rOUA==
X-Gm-Message-State: ABUngvfnt9kbGfRrE763KHjFd/luGDM7jgDrqfM1CNSbwgkpttwccjxEqIXYdHI9YPb+CThwjd57MdIR1gJgKA==
X-Received: by 10.31.209.6 with SMTP id i6mr5179892vkg.144.1477608527837; Thu,
 27 Oct 2016 15:48:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.205.131 with HTTP; Thu, 27 Oct 2016 15:48:47 -0700 (PDT)
In-Reply-To: <xmqq1sz15swv.fsf@gitster.mtv.corp.google.com>
References: <CALj-rGeoT_mpmuw8Put=6eRhzf-r2WUohu_Kd-wnpc=BvO5joA@mail.gmail.com>
 <CAGZ79kZAfqxB699MOs6A6RL==Ku-qF7ABiW=eA+TSrqK+8e_sA@mail.gmail.com>
 <CALj-rGeMHyN6Xhc0_KCChmWL4BDyF-ZJYdipbe1_yNvznrYPVA@mail.gmail.com>
 <CALj-rGfsy+KA=dsd+wobMiVOWHK1GU=dZRcQWtMoXwtBrMYPLg@mail.gmail.com> <xmqq1sz15swv.fsf@gitster.mtv.corp.google.com>
From:   John Rood <mr.john.rood@gmail.com>
Date:   Thu, 27 Oct 2016 17:48:47 -0500
Message-ID: <CALj-rGdTfYYn1Nnksh=WijkJxknBUeqci3i3uujH8yzcE1z_8g@mail.gmail.com>
Subject: Re: feature request
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What I'm really seeking is not a make-shift solution for myself, but
an intuitive solution for the novice user-base at large.

On Thu, Oct 27, 2016 at 5:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Rood <mr.john.rood@gmail.com> writes:
>
>> I suppose I can do git config --global core.editor notepad
>> However, this really only addresses my second concern.
>>
>> My first concern is that using a text editor at all seems like
>> overkill in many scenarios.
>
> Nobody stops you from writing a "type whatever you want; I won't let
> you edit any mistakes as I am not even a text editor; just hit
> RETURN when you are done, as you can only write a single line"
> program and set it as your GIT_EDITOR.
>
> I do not know what would happen when you need "git commit --amend",
> though.
