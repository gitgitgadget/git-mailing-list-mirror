Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961F41F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbeCPVVc (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:21:32 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:54949 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeCPVVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:21:31 -0400
Received: by mail-it0-f49.google.com with SMTP id w3-v6so3711862itc.4
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LIH/qfDQPt3TMQpiocwmhooUgS4hEHAQk0bhoiF9vkA=;
        b=0hej2viOEhRhxnRNdA4u/KUoz1tM1rm3pvCEhO40MMqEmwGHbWVA9fwZDEQd10VD7W
         B+9yu4MHQGbMXE5bM94vBAIzd5/ljrLEwNgWGJhfaY03LDOa+BGoYq7s/z7bo59BfUNe
         sVgBwKqvTD9CYJh4HtV7a1iMPt/jPfMeifGjIjhY7/s5Pu4M23LFP+VpDdklfKWjUWn+
         sNN65n8eiS2MiG2VYUrCklpjSpWDxMGk8nw9YZ2eyIZv2K276RGu3m1SsTYUI1zTRgL9
         axQ16izqm7ndHmQmPP3TWPoDH6prD7+11nLmUjvjBnrya3SdiC2hykw1X6+y6y/irFmC
         h9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LIH/qfDQPt3TMQpiocwmhooUgS4hEHAQk0bhoiF9vkA=;
        b=EpPbaAjsb4OZu5N/bizrrBRhtbn7fQXxQ3cUbJtRiHCFPe0uEIPoOsMyMBlOECWa67
         JPZ8R9no4LUADGwBue/3cEdAW80YX+AFCUlb7Z4H7F4appXtgSPyI/kYgn2dlwsz5Y1X
         VkKuJJFfrjhahYCbmc/s7fydQGCY7GU/ZUXqKlYPstjo+G6MDSmP7255QxMQI+L9A5JE
         lw/klPxXedzA7cKxrq68/+wjah8/AYoNv15a9bOM/Vc2Of6O6rBeSCbr8qKAoiK86CXv
         MzTcsEDoANMoC70LlerJ5gc4Ljfffr1DAUQfX8GjzM5w5clQIJHOA151htscnT5PGqqx
         ASjg==
X-Gm-Message-State: AElRT7EtKZZI3bax8n7dSNhJXCNjAxQrNlbJOm69A1fgjgMPFqvWbUvr
        rsAs1KqRkkaT4MtCJqTjJl29pq20xvpMnRvM5UmPFw==
X-Google-Smtp-Source: AG47ELtGRSadujsggOIuFJGfZA2Efwb8iriGJBzg0V1UpohJlH4i+DLnXev4JqtTB4kkpJhwD/azSxehygtQ6xK73ac=
X-Received: by 2002:a24:195:: with SMTP id 143-v6mr3836433itk.111.1521235290788;
 Fri, 16 Mar 2018 14:21:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.83.18 with HTTP; Fri, 16 Mar 2018 14:21:30 -0700 (PDT)
In-Reply-To: <CY4PR02MB2262A382E033B50B3800A69CFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
References: <CY4PR02MB22621DE7751427686029C1B3FFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316195756.GA151588@aiede.svl.corp.google.com> <CY4PR02MB2262A567EE2D2A54316BFE3FFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
 <20180316205243.GB151588@aiede.svl.corp.google.com> <CY4PR02MB2262A382E033B50B3800A69CFFD70@CY4PR02MB2262.namprd02.prod.outlook.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 16 Mar 2018 14:21:30 -0700
Message-ID: <CAGyf7-HmO_URV3kuB2t=PJ7Wf=t9UjAOYbpCLkUNiDPGQ7ca-g@mail.gmail.com>
Subject: Re: getting fatal error trying to open git gui
To:     "Briggs, John" <JOHN.BRIGGS@aei.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "git-for-windows@googlegroups.com" <git-for-windows@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 16, 2018 at 2:01 PM, Briggs, John <JOHN.BRIGGS@aei.com> wrote:
> No, it was a fresh install.  Plus file search reveals only one copy of th=
e file.
>
> I also noticed that I cannot use the file properties to run as administra=
tor. I must right-click on Git GUI and select "More >> Run as administrator=
" in the start menu. Even though I have "run as administrator" checked on b=
oth shortcut and the program (or any combo of).

You definitely shouldn't need to run it as an administrator at all. I
have the same version installed:

$ git version
git version 2.16.2.windows.1

Running Git GUI from the Start menu, it starts without a UAC prompt
(which means it's not running as Administrator) and runs without
issue. Starting it from a non-escalated command prompt via "git gui"
also does not have a UAC prompt and runs without issue.

Seems like there must be something more going on. What options did you
select during installation? What installer did you use?

Bryan
