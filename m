Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF561F78F
	for <e@80x24.org>; Mon,  1 May 2017 19:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbdEATAw (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 15:00:52 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33548 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdEATAu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 15:00:50 -0400
Received: by mail-pf0-f175.google.com with SMTP id q20so24402833pfg.0
        for <git@vger.kernel.org>; Mon, 01 May 2017 12:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NbsZX5UIvsmMSxSJYBVmRfodzFY7jZy5fV/3H/K2HpA=;
        b=fW0Ui/QjwMvAg+I4NYyEUz6fDVPHOZfZiHo5GhrmOIR82eX2KajJ0qW9AEOTJ/cwDE
         Je45try43bdCwsms4R7NwqecLQL4ygypQq8Tdhwrw2RyuZElgg52g5JIU4Vt6nWrKkZg
         LSAW6rVFAv84YJSMRms9Z3WFy2HmhgEP9RObIY6qbFHeU54VpxBYcIpc7DvpYSnD/8y8
         8tEZdvrSPmpK8prxevk7g+gIFcMYX8mjHFTpQ7smx9Zy89gnGdSJtcki1maD8xiujuNR
         hcmgNLf0bqZ23MiroC/Sl/sycMagCpydhTmDyGOAb4pCZgO0QrfbHn6iKM5gsCMQe0in
         xYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NbsZX5UIvsmMSxSJYBVmRfodzFY7jZy5fV/3H/K2HpA=;
        b=cTaFHJ6+N9wvo8PLo8ll7w4fw63SYaiNIzWZ5iyasJWiqGqvXfIg69AExZoqZa31Me
         h6M+jmktT0dA9Xe51DfK9qHjNMvnqneZbcHQuQDZFuFCFcmcVZCrl/TDLQ2g0QHQIeBp
         58I+JiSa+fOPJ/gMPLwPzcwdHiqejMY0nBwDatbPII45gIv3jhEZiGIvfw30yONT4EoM
         XOhYkjtzXmR9KnchPp2lYQzteW4bmuBoUjcHPdMRquMQaaTxxbTHSe0ZjN+x/+2ACoVv
         f2N1DaoSgIwiZ0TcVaBbKgtv1UNdbGPJxn9hzYUR0COo66rgWdgylobV/4IeQanwh8HN
         uIqA==
X-Gm-Message-State: AN3rC/6bG1zIVblELihExjyKKz12T+fK/rGuzQ67lfQQV+KYTjZf/HbW
        MVf+mmlMlssgyuID3gdGgDW+RM7AbNVg
X-Received: by 10.84.231.136 with SMTP id g8mr35480385plk.12.1493665250107;
 Mon, 01 May 2017 12:00:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Mon, 1 May 2017 12:00:49 -0700 (PDT)
In-Reply-To: <20170501183656.GH39135@google.com>
References: <20170501180058.8063-1-sbeller@google.com> <20170501180058.8063-5-sbeller@google.com>
 <20170501183656.GH39135@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 1 May 2017 12:00:49 -0700
Message-ID: <CAGZ79kb-J6W4XSWoD7LBFB_o4Dp86o1oK5ReBmeqV7WB0h5VgA@mail.gmail.com>
Subject: Re: [RFC PATCH 4/5] submodule--helper: reattach-HEAD
To:     Brandon Williams <bmwill@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 11:36 AM, Brandon Williams <bmwill@google.com> wrote:
>   if (flags & REATTACH_HEAD_DIE_ON_ERROR)
>     die(...);
>
>   return -1;
>
> It just feels weird to me to have the inverted logic, that's my opinion
> though.

Yeah, me too. But my feelings were not as important as staying
under 80 characters a line. And as the error message is longer than
the "return -1", I wanted to have it not indented yet another level.

>
>> +     }
>> +
>> +     if (!sub->branch) {
>> +             if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
>> +                     return -1;
>> +             die(_("no branch configured to follow for submodule '%s'"),
>> +                     sub->path);
>> +     }
>> +
>> +     /* lookup branch value in .gitmodules */
>> +     if (strcmp(".", sub->branch)) {
>> +             branch = sub->branch;
>> +     } else {
>> +             /* special care for '.': Is the superproject on a branch? */
>> +             struct object_id oid;
>> +             branch = resolve_refdup("HEAD", 0, oid.hash, NULL);
>> +             if (!branch) {
>> +                     if (!(flags & REATTACH_HEAD_DIE_ON_ERROR))
>> +                             return -1;
>> +                     die(_("Not on any branch, but submodule configured to follow superprojects branch"));
>> +             }
>> +     }
>> +
>> +     if (!strcmp("HEAD", branch))
>> +             return 0;
>
> So this is the case where the superproject is in a detached-HEAD state?

and the submodule config is branch='.'

> In that case then we don't need to continue because if the superproject
> isn't on a branch, then there isn't a reason the submodule should be on
> a branch.

agreed.
