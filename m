Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB7F20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 20:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLLUFh (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 15:05:37 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35644 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLUFh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 15:05:37 -0500
Received: by mail-ed1-f54.google.com with SMTP id x30so106604edx.2
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAoYLnDU/QmFjakD+3rQN2qGuoXg3yPUfeVxpTGMbBk=;
        b=V6bLJiyK/793mekLiajakHJKenyKI/Do8XkDZj/omEMEhNgxi47p+npLdPCiZchdy+
         nRMiS5X7L+UmkABOEAPHja6fVBzBr5ZVeMRKpWspU/UrgR3h5zvNSE3b+0rd/mSM/UNv
         8HNbTab5dOPFzhKPXmeT8dxLC+TEHHrP8f9expKUJ4gISKxsRQ15DU/7EYtYMTWkI/JK
         K1m3cgnYeKrJGc1XaLPaFmRMp6O1iqIo0n2jx+hGmJxhrZC64+eoPHKBeLEWpDwks6pS
         tQBZzTnfByrJq4tp1bSry6J/Qv/FeVke+5nk8fkDS33+pFM1SVbkFcFlqTnCYwyhJ4rN
         OhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAoYLnDU/QmFjakD+3rQN2qGuoXg3yPUfeVxpTGMbBk=;
        b=iJuoTeOgcl28HTeQkH14S19HobyyuuWKOrf0Y6SeFtQdqXqos9PMkAO/t1KCElONtG
         7htHPsydsunvhq/UKHDiol8y+ezRX+tZKX8xRRkutdDCBRuLdE1+PEiPYSO1s81NR6jN
         /lwYSJa16KtHf8OuPBve32oCwoKna2R0WBeBt8BCG7M69Fq8f7nD7eQPaFFYqyDth08d
         Uk39ILCp9bnaDIociI0mD5OSw/T70sFnSE1XfW/bdE/Zi1PRBscovy7YCcUFkWLNkhBT
         KE/21txnw65tRVN29eoHolgiUPB3WOCcx4TXyGmSVwx/NXtAeh4HSuZtcQ9YRwbZ6BvZ
         2BmQ==
X-Gm-Message-State: AA+aEWYSazlQtvL2dgKJl6XHAWQ/89Xas0kAS8m5QkoQ6W24bfLWv9GQ
        MTGsshVQ3bqgURJGwdJsQ8CYVGeK9lf7gZa6T80kf7syDoU=
X-Google-Smtp-Source: AFSGD/WyHbYCN3avm5YcOgNRsVy/VEs/T416FHITl090lldwbCuUvJ8OQrA44mCqdlvIDeIDrs8DrC+jA+hhxJVvgkk=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr19890822edc.76.1544645135429;
 Wed, 12 Dec 2018 12:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20181212194658.GA25117@duynguyen.home>
In-Reply-To: <20181212194658.GA25117@duynguyen.home>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Dec 2018 12:05:24 -0800
Message-ID: <CAGZ79kZwS4J_bOd+2iTbVTJqMW_+P5Lzt1Zs92JBtfkBnj3juw@mail.gmail.com>
Subject: Re: review "git range-diff -h" output
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 11:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> I'm not going to bother you with patches (yet) but I could use a few
> eyeballs to check the help usage (and perhaps the option grouping) for
> commands that take diff options.

The grouping looks good from a cursory view, but ...

> Forget about hiding irrelevant options for this particular command for
> now. This is something we can do later.

.. this seems relevant: range-diff is a diff of diffs,
so for that particular command, I'd want to know if the option
(e.g. --stat) is applied to the inner or outer diff.

Now back to your topic: Are you planning to send patches that
autogenerate these helps based on our source code?
Should I pay attention to some specific part of the output?
