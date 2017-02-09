Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1821FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 21:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752542AbdBIVgx (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 16:36:53 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:33317 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdBIVgw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 16:36:52 -0500
Received: by mail-io0-f170.google.com with SMTP id v96so33094842ioi.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 13:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jps3WBjIj/+1WdMu/ONks3qrj/T9WgQbfMRr9Cd9wb8=;
        b=k6tSlj1xr8bcP7b+/rMZ1GDul1MACpWBhZA07VErEWPEBKtsra4t4Fq6ZpJaNtIQXd
         iDC4cdHSfmuYw5MxcEquwJJ9ShpCAzA2rNB5rFhfwvZ7+7RYAtKJVeqe1axnSAlPOZ+k
         szYF5WJs7OqB/CFHPMNAvW+nvEL1GXx61VDuE3o0r8m9Hlti4iT9cB+JUsexZhbcuE0L
         PV6XFnXSg+/vUT4Fo0OacU6V+kwOP2z5nuEyetnExSIvBjMniOSFi2wvfd0v2+5VT4dK
         2nwLAcopxKoLzguSW/nuO+DtiOpWFlNJsufAS/n9uLqe4NGK+T6K0aSz2YHbQLwUHtsU
         +Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jps3WBjIj/+1WdMu/ONks3qrj/T9WgQbfMRr9Cd9wb8=;
        b=gTK3UJf1cG69bEfG4FbDH09g+bdb17RNjY6ZImSxZzl6wm9dFBEj7W717/j0B4xuKD
         xsV11hZFIEF4NBjUbgXjSJiL0jfjNYNauH1YehaTwZ7aettay66RhJFTrAKDUujaZ8xD
         Mi5gqsFq4yxwpX+y/NwR34DlxxBjE4J8NqqPZH9HhgiDUpvYc64yrDrr6T2YrQw3h993
         18iKj562WLEXCSJItmTJmPgA01IZn23uPmdmhtPj9J3WUi4c3cw9jxL1N7j+Fx5qFcFA
         CnHN5/R9njPu8qfrgdM+sLa9oPpFf2io4mrolgToqWrqHAAKf9fw5TXs15YQDfeBllAY
         7Ngw==
X-Gm-Message-State: AMke39lJL1bX78OqIiB2EVH/cEboVnpXm4iV3hkVqY6VnGwYSKlC97HPppXz71WB1/3831dpSO+7KpCx6kDnP6bk
X-Received: by 10.107.37.148 with SMTP id l142mr5140271iol.159.1486676211726;
 Thu, 09 Feb 2017 13:36:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 13:36:51 -0800 (PST)
In-Reply-To: <xmqq1sv7oyei.fsf@gitster.mtv.corp.google.com>
References: <cover.1486629195.git.mhagger@alum.mit.edu> <111d663c0fd3e9669e7c28537f581833488ca4a6.1486629195.git.mhagger@alum.mit.edu>
 <xmqq1sv7oyei.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 13:36:51 -0800
Message-ID: <CAGZ79kayXRxrZf-meU531QhqDfi9AzN1fmvDFsjgXGZREK2QQg@mail.gmail.com>
Subject: Re: [PATCH 4/5] files_ref_store::submodule: use NULL for the main repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 1:19 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>       if (!submodule || !*submodule)
>> -             return be->init(NULL);
>> +             refs = be->init(NULL);
>>       else
>> -             return be->init(submodule);
>> +             refs = be->init(submodule);
>
> Can't we also lose this "if !*submodule, turn it to NULL"?

That was my suggestion as well, but that did not look nicer per se.
That is because at this point of the series we still handle "" just fine.

>>       refs->submodule = submodule ? xstrdup(submodule) : "";
>
> Also, can't we use xstrdup_or_null(submodule) with this step?
>

That is done in 4/5; here we must keep a "" around instead of NULL IIUC.
