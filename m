Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 732AC1FE4E
	for <e@80x24.org>; Fri, 18 Nov 2016 20:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752576AbcKRUKM (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Nov 2016 15:10:12 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35786 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbcKRUKL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2016 15:10:11 -0500
Received: by mail-qk0-f178.google.com with SMTP id n204so278027641qke.2
        for <git@vger.kernel.org>; Fri, 18 Nov 2016 12:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tPdBN6Tnk//jnrq18QYe7lhUJXi73rxRdJUVVakPyqw=;
        b=VYTmvkCy0QmphJmf8mHwRgjlgfxTPh98pUqZot83NfKiT4b8Qbq628T6nV7eKBkPAb
         I5k+xMOTUq+HOjYmBxbE2yfUQu/w3e32HhMCUjOghnjyTGa+bYPdRkmexlJ1gQtfTiQ8
         LSToAu+GRsCth7O1mUrPc8iHBggzCMDhcPIOU17DRBY8UGOvXLbkLUP3+WUbuz4EY9Mc
         hChpTq9HgmJmWOMENTsefFX+GqBm9M89Ri5mAbfyDLo63syxw16rDDIkDCqXdJdHSjhF
         liOCUtCr72Q8p9eIPRETeTMgpd4hjCZtjk1/xoMS/m0LYqdIAvcWPIsgV4utFUFdfPdI
         NReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tPdBN6Tnk//jnrq18QYe7lhUJXi73rxRdJUVVakPyqw=;
        b=fYYu38gl5tsd/+QcKY+XAgzwGQvvI3CR9e8wj6tsEYU7PAvhQt2iTVfCSAeyzvzWHM
         9pIEd85vlDSEnWLTHYO7WqsyNVXAxNEzqjxh+Rcb5n9pLCHJR6O+FgHZNdoEV91MghQO
         gx0UJTdiWBzwelhNZ4NxBZewa/3rXL1j0koMR3sDBp3/owqrSQrp1ERtNmgWUKq1t5i1
         VbwFkfvXb3xnKmeygAwe3/yplCMLnBnigV3oOSjiSdDU7162n2beyKJwzfFaemgrqyTS
         PQ67nLJKCjgS4EsheU5gUcaKEgF/fmzJov1sraX/7wlpWpIeJGu0/m2kaT8OlBfCIA9N
         OyeQ==
X-Gm-Message-State: AKaTC02WsUez9/2SlSBCKhNeC+hgohIbaEvawyHexAXgQ3Dkrh8Pm7LeWQsFW+/aOipPVbgx3T8FXY3HM1+bjgWp
X-Received: by 10.55.191.134 with SMTP id p128mr1931754qkf.58.1479499810362;
 Fri, 18 Nov 2016 12:10:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Fri, 18 Nov 2016 12:10:09 -0800 (PST)
In-Reply-To: <1479499135-64269-1-git-send-email-bmwill@google.com>
References: <1478908273-190166-1-git-send-email-bmwill@google.com> <1479499135-64269-1-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 18 Nov 2016 12:10:09 -0800
Message-ID: <CAGZ79kY_OfpXpuFfHYQmJJeuthu5P699V4LPytj90XtETmiW_Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] recursively grep across submodules
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2016 at 11:58 AM, Brandon Williams <bmwill@google.com> wrote:
> This revision of this series should address all of the problems brought up with
> v3.
>
> * indent output example in patch 5/6.
> * fix ':' in submodule names and add a test to verify.
> * cleanup some comments.
> * fixed tests to test the case where a submodule isn't at the root of a
>   repository.
> * always pass --threads=%d in order to limit threads to child proccess.
>
>
> -- interdiff based on 'bw/grep-recurse-submodules'

Thanks for interdiff!

I only skimmed the patches, but rather reviewed this interdiff in detail.
The series looks good to me, no nits!

Thanks,
Stefan
