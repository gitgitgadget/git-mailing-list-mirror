Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B171F4F8
	for <e@80x24.org>; Tue, 18 Oct 2016 00:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935399AbcJRA4A (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 20:56:00 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33877 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbcJRAz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 20:55:58 -0400
Received: by mail-qk0-f180.google.com with SMTP id f128so253987590qkb.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 17:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=n8zLGtunuf8qv9LQHmaGte163mrKbHonZUasOhYZsIE=;
        b=LhXo+oaj+RBVF45tsgTU6tda/W6hvvzE8ZgdkTQk5bf1/jzcfi4LUKklonRoJ4G6xb
         /UcfD+JraBS8ykNcpLjz8/Y4TxJ1IN5WpzT9JGpdUe9d/FynM/MVcHBoHlfhmm/AAl/g
         n0LjTkSgONvVAZyQwJB5+t8vXC84EB9io7GdiGxE6686kXXbCSkBqcS4JVNPQo9xc08r
         m4wD/eJX6rXAmnSR0tGP5Z96j8nod4IT+cam/bzuQezE4VGxUOEFbFzk6Wbbf2azNawU
         oo4hTI79JIIqwnkduJ9yU64L0iitO8+pJABtXCoCJFLj0W0749E+H6UU6AAS2WxZQOHi
         RnxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=n8zLGtunuf8qv9LQHmaGte163mrKbHonZUasOhYZsIE=;
        b=TTExEpkO09Olp9cK7MBj+dfSj477+1SAxyTeoCJoM0Lkx7yJBEP4QW5Ipu983wY3Qz
         Z5vS6O9LjudKoMC063r7k3dUM26aGFbokTcVGsOZVJQjj/aXrFfIi9C1yWIGi1YDqclA
         mTVMjkAvF7wtjglm8ZbsvgEUV/O33i466yA9Kwctf+3Ff/LmSILbsubMDlkrFJfl7TCN
         vFAHRQIDY37HpWDSc2mh7vAYe0rUSEtWkt9Kgjdd8LHBFxnDz1TvkrxoDvWnVDcE+UYR
         vFK4ZphFapIwoaUpE/6l7/pukf/PsodfZtkWnBF7JDYlpW/YJW4Xh/o46Mx/KtdT8hGV
         mmRQ==
X-Gm-Message-State: AA6/9RkCA2dC+m4Q1evyfnrNrGi7O+qDatHGlTMaX6OMZQoEQOB1JrhM6CeyAaCTzqHztb0hzZqlbFb+4JDT7uRK
X-Received: by 10.55.45.193 with SMTP id t184mr240912qkh.58.1476752157683;
 Mon, 17 Oct 2016 17:55:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 17:55:57 -0700 (PDT)
In-Reply-To: <0a187897454a5bce946d675f6f6c93283b411f31.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476466609.git.jonathantanmy@google.com> <0a187897454a5bce946d675f6f6c93283b411f31.1476466609.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 17:55:57 -0700
Message-ID: <CAGZ79kYiTNVRCzk--97qPLLWq2O4xsLPgGCLwJyKAvjvGMu66A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] trailer: support values folded to multiple lines
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 10:38 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Currently, interpret-trailers requires that a trailer be only on 1 line.
> For example:
>
>   a: first line
>      second line
>
> would be interpreted as one trailer line followed by one non-trailer line.
>
> Make interpret-trailers support RFC 822-style folding, treating those
> lines as one logical trailer.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---

Looks good,

Thanks,
Stefan
