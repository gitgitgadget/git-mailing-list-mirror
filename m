Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9151FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755355AbcLPTBR (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 14:01:17 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35321 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbcLPTBP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2016 14:01:15 -0500
Received: by mail-io0-f193.google.com with SMTP id f73so12831834ioe.2
        for <git@vger.kernel.org>; Fri, 16 Dec 2016 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yG0hgp0vyWR6Ok8sfjNvudRIyWQT/78MPQG6NgHeQG4=;
        b=jzFCtzD8xayYak37UozQkA8Ao0E3P+sfJHgdNEo2+y9f6oPEt73ZOSIzgs9WV0jMuT
         s6DwzFXeAgug1VbuB0qlzj5dKqEy+x7NEcFSQll6ypyt8pHGIZhpAcVceqEp/SWGjuQC
         9U0M5oRGMjpMLhLH6wd5UOyzxUj4D8OX7vcCqR5OeuXVvDW9qPbaVmvU+4dBM12pAY5W
         CXUmUE6aL9DeOKEwN/JqDSW420tdAiRRSXq7558+27HFhMidsbXCle/1qPNdozThksja
         Ps1OsMyqMq4nNIdb5gK0P6YPYHmVpp99NQzJ67RngWcTc7l3dRjnO4Dmul7KormMFcld
         Wj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yG0hgp0vyWR6Ok8sfjNvudRIyWQT/78MPQG6NgHeQG4=;
        b=LA/cGtaPOPjQLgZJXM5+oWHbqIIJhg5B0r/blcHLoSXkhwBYIF3GcenJgCF1wnpk5X
         i7LjigcgDs5gJxkG6q8PnicRErUexychFeHiJkrbJQ6FXGjPGCkHSnUU1TbUo7lec0IN
         Pgwh3RF0GhOTNeXvfbWMqDCCdhjxeOABdiP4x0J5gUwy8elVpSGEiHOtzgw05A/NYd4C
         LLXZA8boXXH0xJjhPgBhS5dAK9xkiTkPs0K1hQRfDdmjdAQRUG5Ka7BanLZlW9QASOQj
         36aFLP31EfWcLHDAz/aa5VtgnAsWvRP1oGqIhSf7fTVKn06yZ4UU8vQGkGMj5MS0pToT
         eggg==
X-Gm-Message-State: AIkVDXKBiOOYmcmBYLBKH8KWRTwB1zryMG1SxUTQ42nJ9hW47zXwHv7DlJGHTIRlgN1C3OGq6iHU+48yyoV3pg==
X-Received: by 10.107.53.165 with SMTP id k37mr4426852ioo.74.1481914833958;
 Fri, 16 Dec 2016 11:00:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Fri, 16 Dec 2016 11:00:33 -0800 (PST)
In-Reply-To: <CAFZEwPOZhO=sXLVwh03C8QN0uVXBUfb=xZ-JS003tgCNLgVOjg@mail.gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ab6-bda8420e-9a63-47d7-9b99-47465b6333d9-000000@eu-west-1.amazonses.com>
 <a4c7fec8-0e84-eb53-ca22-c369ce3facfa@gmx.net> <CAFZEwPOZhO=sXLVwh03C8QN0uVXBUfb=xZ-JS003tgCNLgVOjg@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sat, 17 Dec 2016 00:30:33 +0530
Message-ID: <CAFZEwPO2WgBjOnmvu1VOiz3PMYYx2mxircCWk+BWxmuunC=VQA@mail.gmail.com>
Subject: Re: [PATCH v15 08/27] bisect--helper: `is_expected_rev` &
 `check_expected_revs` shell function in C
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Stephan,

On Wed, Dec 7, 2016 at 1:03 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:

>> I don't understand why the return value is int and not void. To avoid a
>> "return 0;" line when calling this function?
>
> Initially I thought I would be using the return value but now I
> realize that it is meaningless to do so. Using void seems better. :)

I just recollected when I was creating the next iteration of this
series that I will need that int.

>>> +     case CHECK_EXPECTED_REVS:
>>> +             return check_expected_revs(argv, argc);

See this.

Regards,
Pranit Bauva
