Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1811F609
	for <e@80x24.org>; Wed, 28 Nov 2018 19:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeK2GK5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 01:10:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:47039 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeK2GK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 01:10:57 -0500
Received: by mail-ed1-f67.google.com with SMTP id o10so22987702edt.13
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 11:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PRlkxrKgmxLR8GcShgboTHKfE2WvZGOLN0ahyQeLz24=;
        b=MgwHTmrzyBRyR892Gy3iXplvcGXBtH/PteKBoZHTB/9NwDQhE8eRRg6B5h7CzxGqdB
         EKUfc/sASbGHU54TRTvOsExvMk1m6GM7wccNKcRD1gdEsRAOPYn7bIbziMITKV6BHaZ+
         vrpNyqs4L2e0xk4H/t0ng7DR34pyjADU+b7Q5MtB5dyrU0r1dbSOUZOQqSHAZBe7FXOP
         CY0RyIGLxpByrnS2+ePzV8Nd5YHKeV/t8+M97+aCwAAz4VMUNENZ/Lm683jdTD+jJELC
         rTc/aAy3HfotbmnQU0IbxMxBn9IsToAOy89Ge09twaGC9rCC5Sbm/jy0QDN3kvVND1f7
         qPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PRlkxrKgmxLR8GcShgboTHKfE2WvZGOLN0ahyQeLz24=;
        b=Mk8W4bIIJuwBDsr2JHEMFfmburqBIZJXlKc9pRfyhbk5X39w7PqZktE0TO+YsH69fH
         QPLR4EEUtlMua5nJsrP1d1i/J9rQPIUbx94hyGrYbaD/tvqT3xUNbfVfzpmK449VjMr2
         k+AKAX/jioOm/Qi06sQqHxKZqO5UHktN+22U2tElN6qjr2Oa2reIoMBpPmHrrmfX81TB
         qu4023kdAm92fwOJgDFp+D/aDp9U5eI0jrPG0DUhqp2rvEH6kcc7oRIjiVjZZ/MFqhhN
         le0sIftAT6kxEwOwbut2sMGFAElMOxyjMxTpNtBRXOwv3JdAqNoFOXyIGjSPIBUt/qel
         dt6g==
X-Gm-Message-State: AA+aEWaZsQBo/O3GC3zxCHdRqjEgQOfmsUYVONcVQoJ5ajTYgUDEePmP
        1NAFqF0HSjdHUTT2lh3eDiRse2vj32aJIA/63TmWlg==
X-Google-Smtp-Source: AFSGD/UeNFc/PHKvvMHrm2o5nP+31ar1OashcQXd5EyTWxniddEvqcNG+An1DL5bZGz+VjdUOSZWk8uh+W7lAFB8z0k=
X-Received: by 2002:a50:addd:: with SMTP id b29mr19485739edd.215.1543432095945;
 Wed, 28 Nov 2018 11:08:15 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
In-Reply-To: <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Nov 2018 11:08:04 -0800
Message-ID: <CAGZ79kbWqfMHZeYFXNh00N5xSSkW0_Mzja1EtuzxQxrhESoZxQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 7:31 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 7:03 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
> >
> > > The good old "git checkout" command is still here and will be until
> > > all (or most of users) are sick of it.
> >
> > Two comments on the goal (the implementation looked reasonable
> > assuming the reader agrees with the gaol).
> >
> > At least to me, the verb "switch" needs two things to switch
> > between, i.e. "switch A and B", unless it is "switch to X".
> > Either "switch-to-branch" or simply "switch-to", perhaps?
> >
> > As I already hinted in my response to Stefan (?) about
> > checkout-from-tree vs checkout-from-index, a command with multiple
> > modes of operation is not confusing to people with the right mental
> > model, and I suspect that having two separate commands for "checking
> > out a branch" and "checking out paths" that is done by this step
> > would help users to form the right mental model.
>
> Since the other one is already "checkout-files", maybe this one could
> just be "checkout-branch".

I dislike the checkout-* names, as we already have checkout-index
as plumbing, so it would be confusing as to which checkout-* command
should be used when and why as it seems the co-index moves
content *from index* to the working tree, but the co-files moves content
*to files*, whereas checkout-branch is neither 'moving' to or from a branch
but rather 'switching' to that branch.
