Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3915D1F403
	for <e@80x24.org>; Wed, 13 Jun 2018 16:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935963AbeFMQFh (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 12:05:37 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:40096 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935524AbeFMQFf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 12:05:35 -0400
Received: by mail-yb0-f170.google.com with SMTP id v17-v6so1102306ybe.7
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PMaaZXb4gD2V0LP3+i0/wRr5tBEVwakfIkTISdlV4kI=;
        b=niwJMwJX5NRGN3gdAtHunousz4I+nUrZlR/IggXDquaJPISguBM1Vr5NR/SR/IXPH4
         leRkG4v5HDoPsww+K8ssjxZE7TxPul8rpS6iosGdwyUObD6l20SwwZssftZbi7lUGEA5
         9+WhNbHNwqsDowMLxW1lkUu7HS9DonYQHVer5Bp+MnAbaV3QCVQ2UTINQDJ6cNyYPqSw
         qlKgdOZmgQTxPCiNkQI56LfPPdoZkpZTgKWl/OdX7MRiqq8psWB0Y47pjpw4LyqkJC+r
         phSZIn+D+2WeRDJYYRH23QG2ijGtv8W4x5tumQTu6yDmcNeWg+AcZ3O5wHHR81RmD7sl
         aL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PMaaZXb4gD2V0LP3+i0/wRr5tBEVwakfIkTISdlV4kI=;
        b=PfYUyKV7aUorAt287v89UWLFEPXuZlIMGGmS0R05/JOVSHEGjJwxDWvbuWvqa4KAY4
         RAaP58r+/t7LS1yTZFFJvhLzWCh79t5cm4ps6C2C/Mp5pjRyeQv+iR0PqtxBPdRvXmJr
         EXbP/7jNO6fvgh6BsRvRwFiUk5WjFkK5c1jVZualxpOqFwkKunTQV4quuuxm3LsnbV1R
         4FtECT6QLsOt34NBgTsWs2j9FhZKVgQrU/9qFdLcps5bxuU1Zn+RJlFLLH3lRFzczKOK
         6e2hIX/z78dZwuCAF06uJri6eQOPLLuHKj9ad3B5F7KIDeXWNy2nqoQrGVUjdFPvYJlP
         fDww==
X-Gm-Message-State: APt69E2YQVtujlSLeKPvwh6mDpR4oXDqQPVgvmqwopTaQrKjDET7UF54
        aERTSquab8kabfvvyISBRHFN2NN1qqtb3OxILeYE7w==
X-Google-Smtp-Source: ADUXVKJvAqyhWFj54uHrQvgyewIfOrRNWfTTXQSzD+iwMW3KvE8oUtuodQPdoyQJ56LaT8hTo8ETyL63ZKm+nZx9QGY=
X-Received: by 2002:a5b:307:: with SMTP id j7-v6mr2727454ybp.352.1528905933989;
 Wed, 13 Jun 2018 09:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbmcf90uf.fsf@gitster-ct.c.googlers.com> <CAGZ79kZn_i4=w2fUdCgOjqeEY1SnnP6kqmExZKC3-aKK45x88g@mail.gmail.com>
 <xmqqy3fi7k9i.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy3fi7k9i.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 13 Jun 2018 09:05:22 -0700
Message-ID: <CAGZ79kYjJQ12gwRJMEN_-Ui2ABa=k76LkTeFNT=SsGbfL-NhTQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jun 2018, #03; Tue, 12)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 13, 2018 at 8:56 AM Junio C Hamano <gitster@pobox.com> wrote:

> At this point, only clear fixes to regressions between v2.17.0..master
> would be eligible for the final.  Is the one you are pointing at a
> breakage during that timeframe?

No, it was introduced in v2.15.0..v2.16.0.

Thanks,
Stefan
