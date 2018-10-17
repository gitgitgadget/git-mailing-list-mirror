Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF931F453
	for <e@80x24.org>; Wed, 17 Oct 2018 19:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeJRDTU (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 23:19:20 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:32906 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728095AbeJRDTU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 23:19:20 -0400
Received: by mail-lj1-f169.google.com with SMTP id z21-v6so25439695ljz.0
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 12:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=ya4Du1dUH6fnLbpTGSfnpxOg/ad+LrJs0JLqiqZf4UU=;
        b=oShHqI8cQPeUxNNNHfe4XnxpgMnz/DfSdgk29x3mdLx9y1q6q9aqVZuBSXKoeZR8K1
         0SWPTetYlaSpAFyhaE6uC/DpJi9Z0Di/a0lopXQyWqp7quHra6AkGiJ1sq/wykp4ugQ/
         KHpEVQw8ZtFCQon3N6KOFHMljAsQSs+uyRjjN1BXG0s8GNAzw0w+PsXZrjHcX113x1El
         Jn6ONWTaTUum46Ua9W0rzKDJvKuw7SETMU4Fkjtw1+FQrKBaVdVVQixBKhxp6JtP0Fwl
         mPr3H/IVIjzDJUktajyjrEjZKEGLxOLT/UMvQBuwL4iZ2AeKwycejf+dXYivs6FZQJ7t
         YTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=ya4Du1dUH6fnLbpTGSfnpxOg/ad+LrJs0JLqiqZf4UU=;
        b=WaKb9FMGgT5S1Borp2g656y/7vNjDYP7Ao22jGoa0RQDQrzj+e4tSc3HNIc0es2kPm
         H3D6Wr3K4xfuYp+fYdG4E4qhm4tzDeh61Syau43jLijs+JhW9sxjGUUPp9LVPy6bsJGf
         Nnw+UOvLTnawymcqeEUii3IyHUQqWLZfII+3FK0+Lh63zUzVgN7u/3PtB/rAcfVl4rsc
         vSRTZWVf8pFkZtz8y6yer4FDFlviDOQlsbNqZSb6gwSu7pcN0HHs47cdntPIEHXbuc6i
         1jpjlCFUBgQCME/vQyeTtG58ruuFgRD5t1txyzBU76A4SjgBdGMbRl5bO4ZKCsLJfAz1
         2uyw==
X-Gm-Message-State: ABuFfogSX+dX/KObt86lm29PPlCTqdH8m0VDp2bFsy5d1a4O2nSUZGry
        p7DMXVtMQjS952ykTU8m9RkgsscCxmwbmai5gf8=
X-Google-Smtp-Source: ACcGV60w+9hKOLWkyLoru/KuExH1+vS+8E0NscXHAxBvlz+VsKoGkNAbwxKjCK5Lxd/ty6h6mSO+yRbwqTAu8t4wfKo=
X-Received: by 2002:a2e:651d:: with SMTP id z29-v6mr19213100ljb.36.1539804130375;
 Wed, 17 Oct 2018 12:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAHd499BSVRytaFKOUhE=A4Zv+MMx=uKrWKUcT13QwzOCZWhEtg@mail.gmail.com>
 <20181017184720.GF28326@sigill.intra.peff.net>
In-Reply-To: <20181017184720.GF28326@sigill.intra.peff.net>
X-Google-Sender-Delegation: rcdailey@gmail.com
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Wed, 17 Oct 2018 14:21:57 -0500
X-Google-Sender-Auth: CsZjnw5kzxh8uiMx8x1_JWYqlaA
Message-ID: <CAHd499Ci-DTtv=zKBY-9N60qS9TxerckHNzkOkeiZmUp4jDq_Q@mail.gmail.com>
Subject: Re: Sort output of diff --stat?
To:     peff@peff.net
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 1:47 PM Jeff King <peff@peff.net> wrote:
> Hmm, I feel like another person asked for this recently, but I can't
> seem to find the thread.

Is it this one?
https://www.mail-archive.com/git@vger.kernel.org/msg159212.html

That's the only one I was able to find, but no one replied. Thanks for
your insight. I didn't get my hopes up, but maybe someday it'll be
added.
