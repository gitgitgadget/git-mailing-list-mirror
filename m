Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D93071F856
	for <e@80x24.org>; Thu,  8 Sep 2016 22:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941158AbcIHWFc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 18:05:32 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35385 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbcIHWFa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 18:05:30 -0400
Received: by mail-oi0-f47.google.com with SMTP id s131so93130735oie.2
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DJHS7rmRJLfpikAyXnJPhgttrrxJ1Q5MCgosuGX0yeg=;
        b=RpU69RdmQA8wqttERxsmMhRi+NTTjy2VDmXbT6ltRK1QMPNTr10ImlfigqLiSyRHbJ
         4Dm20wdGRFRk9m+PBpJ3ZKdxWstxuyZfgLtWYH1PzxdEWQp2KC96mVIyPX7Huty2VlSo
         XJEjEJlid/Kz7Z1SQWlc/yuiTH1OEOV1Xp45e0gvY3YOwUnYyqjOMfnWu02ehOxMkW38
         nbzm+YyD0o5vF5sUDe0Op0WkBzf1qa6wSohOlSoW7bhSglsEPrQ53RWbsRdsIC2SVrzw
         v5iRSHYAWsYUA8EtzcBsWCNER4BSDQf2JaXFp7vpqsDEv8CbaZ7Xtv26seUegcqZ1LEg
         PxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DJHS7rmRJLfpikAyXnJPhgttrrxJ1Q5MCgosuGX0yeg=;
        b=Sn5dwSh5b3i5xavJQpAVn4/beSN3ffSKtpPXeAiNtFxve/8BlMwCWM/gZ8gJafQMbx
         SMaUGzrmqUz3lRTAI42+DbTo03kzv3WssHKy6LmG9rG1JUhd+drFuRVtZQi39wpHm4nk
         k6RS9nSSJ7tumfgG9URFQ3hILMeAd8m1Bc8zGoJFuBR+zB6T4zsiI3S4ZHuYVHpUCJhx
         1c2iGWclBbhD6pqFl6FBjpV01S9qV4bG/0LZnHCUbJyDad/dfd6CBrE7mR6j+0kS4NhU
         Pi15OqkQbLQzz31UM4l2IJ/osNzagfmK/5qJXdAZHWfpJ1kH8iLRCuH6uSExew42rvu9
         dsrw==
X-Gm-Message-State: AE9vXwNsIqtkSAfWwXydmgJERiDwOidUjT+7WpYviLWFeIppBJngJE89MTDUkBarWFXBGDsiiBhoOJIf4RRfwJo3
X-Received: by 10.202.182.134 with SMTP id g128mr355141oif.148.1473372327733;
 Thu, 08 Sep 2016 15:05:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 8 Sep 2016 15:05:27 -0700 (PDT)
In-Reply-To: <20160908182132.50788-9-larsxschneider@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-9-larsxschneider@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Sep 2016 15:05:27 -0700
Message-ID: <CAGZ79kbG3Zza0e_kKhz5sBZcippwjewEBasYCioJF9drEov_Aw@mail.gmail.com>
Subject: Re: [PATCH v7 08/10] convert: modernize tests
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 8, 2016 at 11:21 AM,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> Use `test_config` to set the config, check that files are empty with
> `test_must_be_empty`, compare files with `test_cmp`, and remove spaces
> after ">" and "<".
>
> Please note that the "rot13" filter configured in "setup" keeps using
> `git config` instead of `test_config` because subsequent tests might
> depend on it.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---

Makes sense & Reviewed-by "Stefan Beller <sbeller@google.com>"

Thanks,
Stefan
