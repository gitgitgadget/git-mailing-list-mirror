Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E1361F461
	for <e@80x24.org>; Thu, 27 Jun 2019 22:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF0WMJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 18:12:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46486 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfF0WMI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 18:12:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id 81so1883337pfy.13
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 15:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=89ylcwu4f+ddkKRvQEXrSaF4FA7ZjVrHWN8u7H5OpC0=;
        b=fRNbSGFJUf0ssBZovxeKNv2OAoetDHV+/M057dFhNcd6Jbr+dlNpogXuruJhnakqLe
         FumsWVPDdXifCybzgOyDCd7SlqrH3E93m32tpDc4qpcinEd9UbdHCZEcaRMqgyJpoiir
         Tlh2KXuR6ebda/XKEK6NaG8FUF6BXRg2ne64clN/ng50tCkPW5v3Ba4SVdfrxxtGeiB9
         6f2WUCCy+7M9uj1KrH741sXVbZLEEmLRI1aH7ykSlRwGuu1RtPiukBKOKOGYOQNlwj2u
         pkdqS6FwM6T2pNWPmkWS4msaClkdF/uBJTztp8wQkdjfSQDUkZTws1INzZjuTDR6sknI
         kOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=89ylcwu4f+ddkKRvQEXrSaF4FA7ZjVrHWN8u7H5OpC0=;
        b=HXxm/4VzqqqkC1uPvCAcz2/XMb2Va7ZU0qit6g4BCFKDJeXnK2j90bQFaulN+5fiQV
         yJlySWjCm2+fkvalUtUwBmochW0uNfj1lv+ypwZCvoh4Vw8azf54OIzKZj5yRIfjSQg1
         ckxAnQo+zvp5Zm4RJUlXAVOoEvk+GtPPYzmySd3PiZv3JsCUxSIkzgvii17KZORhKvmQ
         pQNYKO38nYuS42mX0sqpMeREebk6ZaPQwQgpdXcKMJQwVcoUjbaFE4JzyMrrG8xTs1e6
         wvsvpYa5pNWfyr8OYf5Tw/kLxwP0KFOtSvyX398jsuVFomkkyDC4YAC6bIWI2SjLO70f
         DnAA==
X-Gm-Message-State: APjAAAXXNHty5nZJunmG3yW72+warD4fl1+axascRmy1uda7VNEg/BTy
        5QBeeJqBjSj2/r9x+94FHtmwjltqc20=
X-Google-Smtp-Source: APXvYqxu2lfUUXAhh18OCc50aAcGGVoYUCrYAZ2pk6txl5uMmR8nCWQH4NVANbXLOX1Vz2jeVnDGXg==
X-Received: by 2002:a63:1f23:: with SMTP id f35mr6058305pgf.160.1561673527559;
        Thu, 27 Jun 2019 15:12:07 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id u75sm119140pgb.92.2019.06.27.15.12.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 15:12:06 -0700 (PDT)
Date:   Thu, 27 Jun 2019 15:12:01 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH v2 08/13] walken: demonstrate various topographical
 sorts
Message-ID: <20190627221201.GF245941@google.com>
References: <20190626235032.177551-1-emilyshaffer@google.com>
 <20190626235032.177551-9-emilyshaffer@google.com>
 <CAPig+cQGcNS476e+eDqyyfeVWDsi4=BGS=aTvYZ3=6BdP-0_Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQGcNS476e+eDqyyfeVWDsi4=BGS=aTvYZ3=6BdP-0_Uw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:22:10AM -0400, Eric Sunshine wrote:
> On Wed, Jun 26, 2019 at 7:51 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> > Order the revision walk by author or commit dates, to demonstrate how to
> 
> s/,//

Done.
