Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC471F403
	for <e@80x24.org>; Tue, 12 Jun 2018 17:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933700AbeFLRzt (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 13:55:49 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:39299 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753979AbeFLRzs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 13:55:48 -0400
Received: by mail-yw0-f193.google.com with SMTP id 81-v6so7807686ywb.6
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 10:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yXveOFflqfcS5A4VgsHMJd6u8uB3qD4ChzX1DRBGQrQ=;
        b=PMYs7wTspQlbS3757e0yR9Sjq6g6odVK41KW8e4faeNqD4Yq3cnH+BMhCLU9TlRQFV
         k5xdlssqpQlOUausiVFnXKXPnfEBgovFPDp+Cg0mYh2CmJOz8c4rp2AjXna3vCpCcZbX
         soPQjHHNEpWsS9itW3Dk9OL6oV6oowgAM/O2emRt4NrXaL6K0EpBo8vrKqLU+PFW+w4e
         sPPKtQJcR7H66WrKtUlEfAFATUgIJs7q65MZAraavIIVyUtf+SLJR1mPPDQ1wS9dmXgw
         dm7SxgSosvIwxT/H8X9P6J+8p9GrRndOoHlTrX7iTpA2WmjRvdtERMzQpJE2pgnccs7x
         zFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yXveOFflqfcS5A4VgsHMJd6u8uB3qD4ChzX1DRBGQrQ=;
        b=uAKqo1YN6ypOgBRl2O50H0QqiiCGR/0FxwC3yWLLccZ4VEXneO7ckmLrNrw0+EjsEo
         oDSAZGXvRAl59m/VLDPjTgHVG2e+UrBt0RoEWKutdaGW0M5XCn1MtZmE61HKITFbv3A5
         Eb9/HE0sk0I7QjbbdnF2uLWz8s1Gbhf5yFoKvwYuTYnRnmUWOW8EVW+3se07CfZwiUvW
         xrdKI2YRq0t88yZZswhalBnkMXagkGk5/WYI4PHj7SPoTQ8kf4eIThXUiY6id8rYCf9G
         jtUuGSR8gFL0yTmRLtoXEOCDyfvu3+I/TJdT0o64uDhRwB0vlfqhXiU9hFbxci7phoO3
         sHdw==
X-Gm-Message-State: APt69E1FQsemFuT6oBZVEv0yM2tJcdsUPtzTKWSh7Klr/+zpCoZD9vb6
        PqCF5EMsioq5N9jKV9hwGDyCESt9cTcG75eM3X4=
X-Google-Smtp-Source: ADUXVKK93d9RWd1/SiSI6yE9xkfBnYU83kmksJnsI16BpsiYhBiiTx5o4anLGKGee9vDPG2mzQiadpsJdTD6jhICShQ=
X-Received: by 2002:a81:7b0a:: with SMTP id w10-v6mr700792ywc.70.1528826148069;
 Tue, 12 Jun 2018 10:55:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 10:55:47
 -0700 (PDT)
In-Reply-To: <20180612175344.65466-1-sbeller@google.com>
References: <xmqqk1r3aorh.fsf@gitster-ct.c.googlers.com> <20180612175344.65466-1-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 13:55:47 -0400
X-Google-Sender-Auth: PKnIQhK6RtQ5_mXDyCyEc2dSF9k
Message-ID: <CAPig+cTfWqd+kZUFdS4jT4yKnttvsB3ENwVNd5zCo8ew-HrqaQ@mail.gmail.com>
Subject: Re: [PATCH] builtin/send-pack: report gpg config errors
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        masayasuzuki@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 1:53 PM, Stefan Beller <sbeller@google.com> wrote:
> Any caller except of git_gpg_config() except the one in send_pack_config()

Drop the first "except"?

Also: s/Any caller/All callers/

> handles the return value of git_gpg_config(). Also handle the return value
> there.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
