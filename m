Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEB531F453
	for <e@80x24.org>; Thu, 18 Oct 2018 07:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbeJRPae (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 11:30:34 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36099 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbeJRPae (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 11:30:34 -0400
Received: by mail-wr1-f51.google.com with SMTP id y16so32436679wrw.3
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 00:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lDBbc8bMhaK0bVSiv6PTGfZXJW2jBYnyYvEp31h0Bvg=;
        b=Pr99RI3vnuwsOE8mVoZr8HVwekIKRFxrAwu2LnUpUCNHp3AIhRSsC/5RuYS9RqUdA2
         +s4oGUSs3tWQDO/w1u3TTTjIsCXxPe4gnqkgxUOTR05XPcqhvrrxq4VQK4e38qTuDGCt
         MD7q0Ghxz16QXkkJDjRsEm0uPZcp4pyczjh02LurAlsWsgBeo3CGLI5pjrXMnIr3alFk
         oFZLrcLfDpQPrvztLuaTv5+SlLboxbH/FL+2ciqd+ampyiwaHDU/BmD6vDTQq3dxhDiW
         qzKSS2cMf7OywEyHvsQNoK5dxQbPkjjG+8/6scucAQtecwoeHIlMPQ/J7Xvc+N008q07
         fSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lDBbc8bMhaK0bVSiv6PTGfZXJW2jBYnyYvEp31h0Bvg=;
        b=VKCATIO4WAiRVXBc54DF2BM1qYWWAxMJX9JOSSdtsHzqMonIDOIhIEzLiLgupLT5XU
         b3S2eiSe/pyKlfsIG2eGjUd14Dd3nC8rBDrWmNGWvR4B4QFwKq/GknYfFPNVR0NAak80
         NBhKVMX92rZQf/OvTxYI/Ef1E26AUQxNUCTr2fW6lft/v5CFqV1FzBH6Es/C8nXGPA71
         dhe3XIt36cu7DUfB3CI2IijV1HNFK5jEtJKg+pdxFbzJHvDLWdzu571aobBc+iNkKR9G
         3UwouzTHkcFTnzmRUB168jA1isjOcrwz+b/vldN2fm+7cRmCLusTEtZoYhQRkoyCNVqW
         d/Gw==
X-Gm-Message-State: ABuFfojCGKL+GqiObHlwWfl3Larzoo8scPeD0cUhgfRqqiO8LSSR1sKB
        sqpXP0rzcTV8jQvAjHMvRcuOTtG2fTjgFvPnYdY=
X-Google-Smtp-Source: ACcGV63V4iKCU/8mfyCyOeEh1TJ0007BEA99dkIrirBKEiVB4nAQb7PVIVdlYTqx/mNaifFQX1goxzfAol3Kgf7UpdI=
X-Received: by 2002:adf:f404:: with SMTP id g4-v6mr6231099wro.198.1539847853213;
 Thu, 18 Oct 2018 00:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAL21BmkdUiNgr4NqpwTdi9f47i85s8oXCZMmVx5VyNKotL78uA@mail.gmail.com>
 <0102016657e7cfee-f1343b1e-9a85-4cae-990a-cc7177ea8487-000000@eu-west-1.amazonses.com>
 <xmqq5zy9jnv1.fsf@gitster-ct.c.googlers.com> <xmqqa7njevu2.fsf@gitster-ct.c.googlers.com>
 <20181018063306.GA23497@sigill.intra.peff.net> <xmqqr2gnu4sb.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2gnu4sb.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Date:   Thu, 18 Oct 2018 10:26:58 +0300
Message-ID: <CAL21BmkK+xtFPn7zdBY7VF2Fb_=92MEwAHh4HSrNa4VKjf-b3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] ref-filter: free memory from used_atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D1=87=D1=82, 18 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 9:51, Junio C Hama=
no <gitster@pobox.com>:
>
> Jeff King <peff@peff.net> writes:
>
> > Presumably it came from the manual comment-style fixup.
>
> Wow, that was embarrassing.  Thanks for catching it.

Jeff, thanks a lot!
I just sent new version where I fixed all known issues including that comme=
nt.
>
> >
> > With that fix, the tests run fine for me under ASan/UBSan (with the
> > exception of t5310, but that's fixed already in a parallel topic).
> >
> > -Peff
