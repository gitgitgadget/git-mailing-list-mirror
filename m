Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63CB51F404
	for <e@80x24.org>; Mon, 10 Sep 2018 18:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbeIJXpg (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 19:45:36 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40915 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIJXpf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 19:45:35 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so8245099ywa.7
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x1lfcuxA6Nr0oDMx1F91WohvSKjRbJpR+uCqx/hAz1Y=;
        b=ckd72IDBxc9JWcXZpJmV4aFUkP3O/XQ/MOTpr4+X3xVVf2QzsIn5f+RBlZo8rE7q7z
         3Zw/CoVuKJ1Rvh2+soTG3oS5t4aI+4cs2QKmTThsfkIYEE3jamaXZGJyLy0be/vo1est
         TShWJvhNfzApA6+SpcGQaDxT85MsOlrM3Lop75ccDTGl2IfAhMKlYBEc1/CREa/x0YiM
         8GE7czRkbCf1ih/itEJiL8kzv1DUN2g40MGRB5KGtGqVplF1RyJTP+VOig+umTS/4qOe
         mImPnzuvj9v04MpgnhhRc1Fz93G2eN1EBTwsPUUxO+GvyMseHv517QNF0D6I6/tWJYpW
         dEAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x1lfcuxA6Nr0oDMx1F91WohvSKjRbJpR+uCqx/hAz1Y=;
        b=TP8ESjUrYas5g/QAV+YbbcgWDKtdLGJM/53rJV9w2u/LOVHNbLBLw4TzzBv33rK6en
         IB9tJ2FbGdT+8XdIVeSmv8si3arzZxq2wstdXTQem5x9vwP5OPfPBhLFMFan1kpFYMil
         GU/1X+M5k6ewcWz7koRANAzwuKVcluBUlgbXqcmuVPmf33LD18C8rp9kuOhkp529KZi5
         XihsKiEsjaKMD5wAWUSItLWBZxj+V21PlnoI7OqLwPFwozoerKEwoJChKvrwdPkh1BWJ
         y1MZz6ftfUHy+j/7+bPJ226lXTjKcJU/PADab0BKMoRIj0dAg/WTximPJYgxQ3UCUh/D
         K4Aw==
X-Gm-Message-State: APzg51Ahy+70+X385sT/Pyb3y/u+02yO+EAS0pBOLbJwhdNurs2L62lk
        IpCBp2MghDEuAfHYFay6YW1omQvQxIggTPEre9hMNWzQ
X-Google-Smtp-Source: ANB0Vda2C19+nYHB4frnKSPV+48OjF7q5fgpI27t15KZQdSDJk0xk5rccMLybIp2iB0bIoPI824ccStz/iqxiJSZxzw=
X-Received: by 2002:a81:5bc6:: with SMTP id p189-v6mr10669568ywb.370.1536605408147;
 Mon, 10 Sep 2018 11:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180903180932.32260-1-pclouds@gmail.com> <20180909085418.31531-1-pclouds@gmail.com>
 <20180909085418.31531-15-pclouds@gmail.com>
In-Reply-To: <20180909085418.31531-15-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 10 Sep 2018 11:49:56 -0700
Message-ID: <CAGZ79kYS2bTFowEYwH6t9sBAAZ=ikMn7eAut8O0-6NdG=eq3dw@mail.gmail.com>
Subject: Re: [PATCH v3 14/23] patch-ids.c: remove implicit dependency on the_index
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 9, 2018 at 1:54 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> ---

Junio would have to forge your Sign off here?
(I just realize this holds true for the whole series,
but it occurred to me in this patch, as I was looking at
the diff_setup[_done] part on the previous round.
