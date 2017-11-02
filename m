Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2F120450
	for <e@80x24.org>; Thu,  2 Nov 2017 08:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbdKBIjj (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 04:39:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45633 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdKBIjh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 04:39:37 -0400
Received: by mail-pg0-f67.google.com with SMTP id b192so4459864pga.2
        for <git@vger.kernel.org>; Thu, 02 Nov 2017 01:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1GCVa0M+b9S7L72bkd4a8c5JoV8EXR1KXxn8EHXAHU8=;
        b=VL6z9Y9gvJ2Z+tggK2FRZH1ihKW3x24rhvA3dDunOrYakPrQW7I9NiPs/Mv703MxcH
         8qe8MFeg/GCn4F2K1q64I/dSkJgIu9WQms2i7ulxHG7dorMAiU7FVQUDyru7fqm4xM7v
         0tydSVSo9+koCCR7mtNh8mMCidWFAXRTVtLJ7MPutFxsdIS7bnzv/FLophby0psAZ2s8
         pZ0pcJm+vZ3DB7KETufJUfc+1MG3bsz8ydc/oX1TPfdjLWZbcui9M2wDwGEKntFwFgFu
         4gLOEdNmmvWp/qTH9vpjkwodGIzEFunUXfRe4ADcggzIoOu/k80PeUTFZiIH6Ha3Uw+t
         s32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1GCVa0M+b9S7L72bkd4a8c5JoV8EXR1KXxn8EHXAHU8=;
        b=AvjnOr+bonp1JQagvokD5bXpNdkphkk3w9dypUnAw4yQttsZb4YGufn1OybQjvG7D6
         +iLJkc5xZuT6+0FjM6kprhA9I+d5zuXR1R8nX2fjyEq0WrLBf8+wbcngHcKMD4yfOtiF
         6qFzVaESd4Qg7y+ajM1IIqjaF2OIr3WCBGcdrn6o68LLkAJKVPqS8E+s1kSG4VH11meT
         t2ibd1EJLsbRoDOzpAlneDHxCnCr8+hvu1jVt2vqjzsFxaY6oZ8PD8Jeq+lGb+QGCgVh
         f+T1XUeef/GxKkVi3OGTYGS0yexUHFEhaN9KbY+1gH69QwYM1/tH+r0FvoV1BwdeTNwx
         rxAA==
X-Gm-Message-State: AMCzsaV4aq0EzRhWGEFrPvvInY7vivHuqlq5+6IPv/quwPUBiiRUYEDK
        AvNxijWPXJmPEDzj8T13cbI=
X-Google-Smtp-Source: ABhQp+Rs1j1TSHpiw/k2cLT5IeluTbGbJZx+RJAV6qG043aUqeXWG8nnTDW1K7ibNbzdL82VvOblOQ==
X-Received: by 10.99.96.86 with SMTP id u83mr2837312pgb.322.1509611977010;
        Thu, 02 Nov 2017 01:39:37 -0700 (PDT)
Received: from [192.168.43.71] ([117.251.224.246])
        by smtp.gmail.com with ESMTPSA id u9sm7004145pfa.40.2017.11.02.01.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Nov 2017 01:39:35 -0700 (PDT)
Subject: Re: [RFC PATCH v3 3/4] branch: introduce dont_fail parameter for
 branchname validation
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
 <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20171102065407.25404-4-kaartic.sivaraam@gmail.com>
Message-ID: <e8a600d4-880b-4fb8-6901-78acbd720261@gmail.com>
Date:   Thu, 2 Nov 2017 14:09:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171102065407.25404-4-kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday 02 November 2017 12:24 PM, Kaartic Sivaraam wrote:
> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>

I just now saw this small glitch as a consequence of recently
changing my email address. I would prefer to keep the second one
but as the other patches have the first one it's better to keep
the first one for now.

But wait, it seems that this commit also has a different author
identity (the email adress part). If this is a big enough issue,
I'll fix that and send a v4 (possibly with any other suggested
changes) else I'll leave it as it is.

BTW, I added the Ccs to this mail which I forgot to do when
sending the patches, hope it's not an issue.

---
Kaartic

