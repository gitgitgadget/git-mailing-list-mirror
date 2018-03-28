Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3748F1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 18:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbeC1SCh (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 14:02:37 -0400
Received: from mail-yb0-f169.google.com ([209.85.213.169]:43060 "EHLO
        mail-yb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751166AbeC1SCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 14:02:36 -0400
Received: by mail-yb0-f169.google.com with SMTP id z5-v6so1099628ybo.10
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3lJK6aOFOO2zSIKSnPP/BBuvilNtMavige08Crh/ZIw=;
        b=ZWrbszabUKrGW4auke0dik+UjEd9W1y3zKX/rZWnfFaDV/Fb4pJLzhwf39NBh2n+/t
         WZs0UtR9+QqtqpXD7SZbqIVpus3NpzZD5iTffnGdF4JVhg85r6rJiZpNr5wE/uXYl+Hv
         u/YJ/fAuBE3rKKpCSZZlF1YfL2dZnlemN96syUPonZbUzANQ22VG2xmCCING+W7Hw5is
         sdHak3oGLgE1j3FGRKiQj3qYgF3NK6su+VzeSV0FuQ60VQExCw9Wi4P8DbzRCOLwGSTA
         MXYLBqzVGgZaZJEIIrMXAxvSJ8Q5UBBpmi/dOIjw7HVDW0Up7t/IPs1TjRAEGeYFwCwM
         Zz8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3lJK6aOFOO2zSIKSnPP/BBuvilNtMavige08Crh/ZIw=;
        b=KS77r7oZnmoisJ/LX/DVRNIMIktxVJR4VoTc8stGJ6srPad3219QKNy7+OpLBdAMvb
         dGkZO2pYEKzDISi7ssay7jDrQyTF+AoYZbVZhRMRN+kQUcCXFDjGgKrOuN+wuW+5jHT1
         qZmrQHfKNgUOSkGCRDt1C+IV+0gO44wcAcfspEV+FoscM/8pewy0WWsbGUimhp7LORp+
         jyMHV4fIUXMktZrA+CuInsxj/54LGmvecDmhmZb0nhfrsMrIq339FtPjC6t8DXnZOOgu
         ZVuEnRsQ+Cy5VpTmq2PHRB3L0iWnb1Ct9JiIqsPPs4K564Y7qJrIFcT1gWlBHD53ISaw
         ePrg==
X-Gm-Message-State: AElRT7HcTNxL+3moeeWIHr423qV/UpIDM4VJGoNrAZawSNktxv+iaGz1
        uFLVtyiM31/Jlo0fk71xfOWc38AZDdGKbm+OY6lLQQ==
X-Google-Smtp-Source: AIpwx4/P8tAolQcwt4epSXS3Nw9C/4/ptstwExEguW+AUNVO5Hd4Py4mjb3ddtbDOoKlE+FRYjWxOiMf/8sDSXO2xRs=
X-Received: by 2002:a25:5605:: with SMTP id k5-v6mr2934169ybb.292.1522260155114;
 Wed, 28 Mar 2018 11:02:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Wed, 28 Mar 2018 11:02:34
 -0700 (PDT)
In-Reply-To: <20180328175537.17450-3-pclouds@gmail.com>
References: <20180328094733.GA1523@sigill.intra.peff.net> <20180328175537.17450-1-pclouds@gmail.com>
 <20180328175537.17450-3-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 28 Mar 2018 11:02:34 -0700
Message-ID: <CAGZ79kbofCd+8iscOFUNHTfQ2Y1cUDUjp5kOQQr_b1uPgPC2Eg@mail.gmail.com>
Subject: Re: [PATCH 2/8] strbuf.c: reintroduce get_pwd_cwd() (with strbuf_ prefix)
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Rafael Ascensao <rafa.almas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 10:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
<pclouds@gmail.com> wrote:
> +/**
> + * Return the current directory, fall back to $PWD if the
> + * current directory does not exist.
> + */
> +extern void strbuf_get_pwd_cwd(struct strbuf *sb);

Please see 89a9f2c862 (CodingGuidelines: mention "static" and "extern",
2018-02-08) and drop the extern if you need to reroll.

Thanks,
Stefan
