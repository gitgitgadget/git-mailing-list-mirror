Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 541F520248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfCEMjO (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:39:14 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:38465 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfCEMjN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:39:13 -0500
Received: by mail-ed1-f45.google.com with SMTP id h58so7100601edb.5
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HF2Cmu2SluRpa1V7IjoqBOS29WmdM3yQDfC+P28w+0c=;
        b=noWQvk6mz6t+PUm1+sWEQDBTrzj5Rs4OGArzlQrfaUxlxonW+mgGDQN+9gYGSH6GDK
         ZtzljqfdvU/VUTMZ/NdbX1MrgNmfvSxF6ROq0A/k6J3y5hsSvPOGvHaWyvItXiLryxOo
         myKNmnM5LlNpNb1VkJYE2fQvqbiEDvc+OrwwDZ6nzjksLEK5gr+I3tNM1MTRwg72nLTx
         REKtg9dCWIcIpMY6prKKC1qJWSjEv9WuSCt0eV3SMbCOsRjmwSegT6j7n37bDWP7bG4v
         eZzxB8LHIcEwdK3mM9CNQm2W2yeTkXPGTftHITJ7D9snTiceuEK58FuSaYvxeD4I9YCK
         V/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HF2Cmu2SluRpa1V7IjoqBOS29WmdM3yQDfC+P28w+0c=;
        b=HqBmwMVdpFMNcM/cbebdayWu26Jy6ld7zmTf29MsoHq79RyYkKYu0/bFrsRP1Ws+g7
         /lik8U8e0F5aGkAri7PVBr0egoMR35TfMJsA58W5NRjwJQzdfazYWJMf2gEtPMSv41W1
         NNTiBzrN5hMu4TuLtKMXfZ8bnS2L1fo4eVE5RJPmnvpGdp7ARLouw7TESqe8GNXTyWpq
         JKbix+2/3jLMI0rEXFN/l0D2Mf+1+pYoccxu9x33lldfwoXKoXxMYlnRQgSlvXSkoqtO
         xZeQ5g5+1AkIQlaDQsHfzHab6TF5ROcL3h+za46NIshZhruHYNdic9Ew/jq9meAvOFRb
         FcOw==
X-Gm-Message-State: APjAAAVFsKDCY5sHrVusVlrQBGTh5CCyYwjv7R/RBRKbrNSnq1JHfqSf
        LCjTjzRR8dstLvz3cenZtCjBkrXHvVr/VLzEm20=
X-Google-Smtp-Source: APXvYqwyH97rLGJvvz1OKFxcMLlapD5nw65dO/NfhKxy7ywUhXMn7SNpsA5uuIlINLocMRTcjV2z29Nl/wVYrC+s/3Q=
X-Received: by 2002:a17:906:a402:: with SMTP id l2mr124110ejz.158.1551789551731;
 Tue, 05 Mar 2019 04:39:11 -0800 (PST)
MIME-Version: 1.0
References: <40f11dda.1d424.1694d0cd42b.Coremail.wuzhouhui14@mails.ucas.ac.cn>
In-Reply-To: <40f11dda.1d424.1694d0cd42b.Coremail.wuzhouhui14@mails.ucas.ac.cn>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 5 Mar 2019 13:39:00 +0100
Message-ID: <CAP8UFD21SaWUSqpKjTYVQkbQxLpFEhvjJW8019i6tAS9agnWGg@mail.gmail.com>
Subject: Re: How to determine the order of commit
To:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Mar 5, 2019 at 10:00 AM wuzhouhui <wuzhouhui14@mails.ucas.ac.cn> wrote:
>
> Suppose I have "git format-patch" two commit from a repository like
> following:
>
>   git format-patch -1 cf1c9ccba730
>   git format-patch -1 d1a2930d8a99
>
> Now, how to determine the commit order of these two patch in repository?

Do you mean something like:

$ git merge-base --is-ancestor cf1c9ccba730 d1a2930d8a99

and:

$ git merge-base --is-ancestor d1a2930d8a99 cf1c9ccba730

?
