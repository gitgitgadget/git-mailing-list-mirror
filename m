Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2783D1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 02:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeFFCMt (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 22:12:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39205 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeFFCMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 22:12:48 -0400
Received: by mail-wr0-f195.google.com with SMTP id w7-v6so4450363wrn.6
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=erb8C4cHDFFmp4EkBatvyw6TJroj/FWzGQe++/eXOEU=;
        b=C2apBA06MfDr2WMim2xLNoSBi/u3vaSf9Telm1HxlnplqDHZKJ8QYJXRIs7DwSAT7c
         AgOWckVjVygdc75BZBxyTmNaWk0f252zd4gyasTyoxBFw9sczV0zgIc031aVLvLtj8ny
         FkAhrn1fyR2fhMf8hzuppWDyjNjuHBDzoKBDrxkeZYi6ySr6VssgZQCsWvyo4e7FKGMx
         jekbvyq0cPfP2NPEg/FS5iFS/0gpbT3fMs0dMihc1Gq4WI6BQkRj3BTNpQQqh4Fhck1o
         B3xsuCxJBasOUsCcgsxROguzI8zA/eCXyqddoIZmdT3v/LuObQNbz5+47vUmqpYG7meU
         lQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=erb8C4cHDFFmp4EkBatvyw6TJroj/FWzGQe++/eXOEU=;
        b=sMKFdJCOPutRaXhtErR3LcsrfjXhix1Cvv3xBpNsUhu1K7HEs9n9FV7Bxv5r6jE57h
         RUxEJkBoNGDG55qZBh6skDpiuTdL9WMlwzM595BFkns9sp7en/LdtlfxWB5xVG8syZ45
         Zy0cGbmlH5VaejeAY1WuczUzsz2/XQywSLHI3Kaamk6ACltwgIgDv/q7A2fgdMQ5a/Cn
         qItXWucLiFR7NPk97bt06t024upw2joBno+k8fnT2kDEwTa51MyZNZh1jf91Pi68sp3L
         ursz5KN0QcMaeyWH8t4FjyryoDKsJR0ri0AsgHLLQkmg0jDZHVb17TCawsAjt4PeNRxb
         7C2Q==
X-Gm-Message-State: APt69E0de4pVCkQnvfoE1sAkez6l3iU1iUVpMGRlnZlQW6RJJ7Ks56nM
        w14CarBglZzfslOFBeHuDZ+TJ2y8gKR88p8BEWxFuYP/
X-Google-Smtp-Source: ADUXVKLvV5lA9lYuBhX3XDWHzOsaTxHuyg798lazrVbslxeRomhZANDPqsaewUCiEZtdUc0nwAlonOJxpu+Rb6CCH+A=
X-Received: by 2002:adf:a9c1:: with SMTP id b59-v6mr660887wrd.48.1528251167269;
 Tue, 05 Jun 2018 19:12:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:e90d:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 19:12:46 -0700 (PDT)
In-Reply-To: <20180606000146.GH9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <02577402adaf0d109f74e59486d8a23f6ae68663.1527894919.git.jonathantanmy@google.com>
 <20180606000146.GH9266@aiede.svl.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 5 Jun 2018 19:12:46 -0700
Message-ID: <CAGf8dgLsP6MWSd9OTL7tq+92Rh8UA9Kitzn6nCiRj1bM+Eyk4Q@mail.gmail.com>
Subject: Re: [PATCH 5/6] fetch-pack: move common check and marking together
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 5:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> I like it.  I think it should be possible to describe the benefit of
> this patch without reference to the specifics of the subsequent one.
> Maybe something like:
>
>         When receiving 'ACK <object-id> continue' for a common commit,
>         check if the commit was already known to be common and mark it
>         as such if not up front.  This should make future refactoring
>         of how the information about common commits is stored more
>         straightforward.
>
>         No visible change intended.

Thanks, I'll use your suggestion.
