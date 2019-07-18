Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD7FB1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 02:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfGRCdJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 22:33:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35106 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbfGRCdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 22:33:09 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so11843515pfn.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2019 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksG26A+GEJVxnICtIU0hXtCRihitn4+b/+Wun0meVe0=;
        b=AN05XNu9vELS6Rznp+6uZqeU8T0DyL5X3rQZwcFyDiiSKIxiHx0Px32HiLxtSD5gv0
         XJW7diAPMn6LZ5iwmr6K4msFc8gwQDnRMbFEEksovfoefyFrrvGErjFE4HpOYOlQ1ZGN
         N3407j5BTx4EyVuK8UWMRbbe/E14+nGb99aePwi3H9Cl7fuhUjBuU315lMa+2YgVYhER
         bmrwuSsg/HknP1jfPzkOv2gUhmpbJdpt879KmO1J1vUuzUMa59haveZ8eq72piHIC6Y8
         Bq1q2PHLJbdfFqNBNZTqV03RNueoxNoTMeGcGMaeBsczhFeXEVwfNYs6P40aB4Dlj7dv
         jIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksG26A+GEJVxnICtIU0hXtCRihitn4+b/+Wun0meVe0=;
        b=EUed2WAUuxLpj6oMDOTyEzj3fNk8IyPWCATA5ulAb5yQq7cOvWEPaooxr79wBkZq5B
         Ol7cLVfMbXCDZNwY5f2QCtA71dLqfA5bDBdJPpncQtzD4GcUz8z6u6Hz95bkhl4lH/Uz
         G502x2J5ZCR8Nu0fFh5oUIVH7AJJmDJSPi0Z4HzUPvrK/6BybtZirCH4vpp6gKbVTYza
         9rDdVBvOl4td6AGbofQCoHj+UIc0OodS5x8CTw1HWRYIGXZ1QYodl79w0E9wcwZO3OPg
         lXOAXNR4/4c+1x1m2xq+Ai/CuNLnNXNVUNWnN8V5klZpuk/iwnn79qB3zSwZc8XIHYYD
         vA1A==
X-Gm-Message-State: APjAAAU1LKZWfvfXrCYzkB0r8W0+LKqzh2QWDa2EMwvtF+7S0iBwdnXI
        8rJgSm49w3k81ytV59iy4q15E3s3nsQhkJ58JY4=
X-Google-Smtp-Source: APXvYqwXRXBuP+yY8MHPFs0VOXYxL96r664WiwRrviHip/Ofp53BtfyJ2bYD4h2JgFE+yaDiqXAKMEwG3vxqu/UXPiA=
X-Received: by 2002:a63:2252:: with SMTP id t18mr45103645pgm.5.1563417188204;
 Wed, 17 Jul 2019 19:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190713051804.12893-1-eantoranz@gmail.com> <CAOc6eta-jX93k6twcrJOeRt+JHtLk4mUs7YD_bG=Ggvw4thAZQ@mail.gmail.com>
 <xmqq5zo01qnv.fsf@gitster-ct.c.googlers.com> <CAOc6etYM6DSDQ_H=eJs1xuGU9a83kTe2-vEy9+FEgHobT77_Eg@mail.gmail.com>
In-Reply-To: <CAOc6etYM6DSDQ_H=eJs1xuGU9a83kTe2-vEy9+FEgHobT77_Eg@mail.gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 17 Jul 2019 20:32:56 -0600
Message-ID: <CAOc6etY0tGNeekO7n5pqE_emtRytuSE77o1-fPetpzZPpkfMtA@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/merge: allow --squash to commit if there are
 no conflicts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 17, 2019 at 6:41 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
>
> Does it make sense to keep this file in those two situations?

yes it does. disregard the question.
