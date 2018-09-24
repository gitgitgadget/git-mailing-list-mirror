Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21DA41F453
	for <e@80x24.org>; Mon, 24 Sep 2018 23:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeIYFKv (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 01:10:51 -0400
Received: from mail-yb1-f181.google.com ([209.85.219.181]:46141 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeIYFKv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 01:10:51 -0400
Received: by mail-yb1-f181.google.com with SMTP id o8-v6so803599ybk.13
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 16:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tQ/VCxD6Smekeew8Lc+F6qLrvTnX1QE99wUvU3g9pI=;
        b=tmOIBRM7iu5vd4Hcs68OXJTIXaxINELLpWJINYHoruwqwHuPyazcOB6xvIWPT+R2Xf
         Pk1s2kyl7L86qRgVjCyjxmk+i9BdwbfT+kA5dR4v0cJ8TTyxiLxABY7H5se3f69JjbSv
         v9qxsEQhe2oJYGJDX3rASzfYNza7GhF+X44AEnaYBpBI4DBn2SwedvP+nO/YT5NL3q1f
         nhxgXi0b4zbIXmChEx0uODwnboRhSYfjfAXzwn78HEAjvBFdRVTXK+nCzK+Tt0GwoDJM
         Y+ZZ2GMnL+EghZpZnra6BJduA9qONirf3TnJrvDgjnFB4yjwbchE8sEuu2G8bIZsmq02
         N1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tQ/VCxD6Smekeew8Lc+F6qLrvTnX1QE99wUvU3g9pI=;
        b=lVYIlrAT06muSY1riZV6j5u71Brw5E3S3vtOxaM3KJ2/YHOXwju+Psb1mg3f51q+/a
         R5gsotDGgh4TK5pPuHP7rVlc2dVAHVWanu+9RlI7uRu9GKm2Qpv3VaXap4A/vHROxqzM
         5ZjvdIZ2RArVNWRjfS4KDWWUpP/simBZolVUnf+iWcLJHux8f0PwgpzpO0WJj55alTq6
         gXuCIH9rI5ZzuVSYtrFtA21UfuLc5AeZgFR88j1LmFsFsiA1NrE3h6r2vrzA/1sEZU97
         3zd7A6PmOVj1IasCxsQyJhNqg9qPtLz3XcgZjhwh1/cq2skPkm3etN9Zbx2W9pF0lgn5
         7qmA==
X-Gm-Message-State: ABuFfoiwg5Itzpak4wgo8UZwF4ct0+gVkF85CMKNES0M8eAlkKXFhpHB
        nJqkJl+T8jPa9ZYHne67L45k3JyOwXFU7r6BLdTf+g==
X-Google-Smtp-Source: ACcGV63w7jV8pXSree3ILb8yPs1JZD/MnWkjsYFpJjgaQqt770D3+4D8cmRAXGObJ1xYbeV7auTqA5bZ0Zj2syDDFXE=
X-Received: by 2002:a25:db02:: with SMTP id g2-v6mr489307ybf.493.1537830377654;
 Mon, 24 Sep 2018 16:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180917140940.3839-1-ao2@ao2.it> <20180917140940.3839-2-ao2@ao2.it>
 <20180924122502.f932da9d6b71c1f81341040a@ao2.it>
In-Reply-To: <20180924122502.f932da9d6b71c1f81341040a@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 16:06:06 -0700
Message-ID: <CAGZ79kaKSZeZwbcaRd810mk5wW6C0ewZWv8EX_KUB82=R1MYaQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] submodule: add a print_config_from_gitmodules() helper
To:     Antonio Ospite <ao2@ao2.it>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +int print_config_from_gitmodules(const char *key)
>
> I am thinking about adding  a "struct repository" argument to this
> function

Sounds like a good idea.
