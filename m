Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C1E520193
	for <e@80x24.org>; Sun, 30 Oct 2016 17:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756748AbcJ3R4V (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Oct 2016 13:56:21 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36668 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754179AbcJ3R4U (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2016 13:56:20 -0400
Received: by mail-qk0-f181.google.com with SMTP id o68so140591848qkf.3
        for <git@vger.kernel.org>; Sun, 30 Oct 2016 10:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yOsNFFGTW32a11E3PmaKZGbj0FMm0cQcz2NijrcZrkg=;
        b=SqU7Adj2yeFQgby7pHZtw7tks5pdnLxYTJ8rtcEz4/io2+PzOw3uCD/sPoF0y8B/wu
         ses1sTMFSIS0EUBGmuvTCA9dBDz0UhVBMz1pNPO8fnMtqTcS4sJaT9oVKngAHkoi/8DQ
         EpRLcergmRtDReJ9eDVX7/sCL+jHS4DIt3zJuG5Q/7TCOvVlz7y5uuHPBWYS/eEpDknR
         Z+nPNVPI1mFSy/6A8U/mFkJpT9jbp+alRy7rWcgF5wM8Mjq/UJN/gtCLYnJULUz2qCkp
         rPaMU8TqlvlxKOAW7YUwCJEutKLCvnRGki//0c24yQTawiwelQ73K2zwHKVXAsnUi+EG
         P8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yOsNFFGTW32a11E3PmaKZGbj0FMm0cQcz2NijrcZrkg=;
        b=K8dg1A/yur1AImsb97DG3by1+O9vzKbn124i66x0RXNXSFLFKLZi7QxiAcbX9rlG8U
         e9+vV4SYhRxCKWXGJ2dmP1P+3ZwDnJZkATzF9U6T6Ac6ZTACNPBJXRYnZKkc+Tl/khYw
         ufhc5GN8Zc1f+67OJZsWEBMUzRKe+BcUWDTznuFcLKmCjOIFCFSJsI/ygAGt1B4uzYmG
         acFnZm0/mUqx55rdaWQebogQrJttEQkmvidI35KHbAv/gh8Ij1OR80NhFbAgikFxX5hX
         XtOHSz4mIJNO8AzLYCX19A5pQIUZPYeB2TXij5EFGYliMSPjulGt/GpeulqWi0p/WPot
         SK5w==
X-Gm-Message-State: ABUngvfTSQX/+HWqPnT3HD53+3gmg480zfgMVzecYWZqXQjdKrqyERXKl7QoEM4eJL+YGAdAHJTtFTTXSVEJRQ==
X-Received: by 10.55.182.4 with SMTP id g4mr19384286qkf.120.1477850179514;
 Sun, 30 Oct 2016 10:56:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.210.3 with HTTP; Sun, 30 Oct 2016 10:55:57 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
References: <alpine.DEB.2.10.1610292153300.60842@buzzword-bingo.mit.edu>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 30 Oct 2016 18:55:57 +0100
Message-ID: <CACBZZX4SnJj6ZYK-Ha3EtiWUf_n=+LZ=UeS=7vxgsj8s=bi3Sg@mail.gmail.com>
Subject: Re: [PATCH] git-sh-setup: Restore sourcability from outside scripts
To:     Anders Kaseorg <andersk@mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, 842477@bugs.debian.org,
        Git Mailing List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 30, 2016 at 3:10 AM, Anders Kaseorg <andersk@mit.edu> wrote:
> v2.10.0-rc0~45^2~2 =E2=80=9Ci18n: git-sh-setup.sh: mark strings for
> translation=E2=80=9D broke outside scripts such as guilt that source
> git-sh-setup as described in the documentation:
>
> $ . "$(git --exec-path)/git-sh-setup"
> sh: 6: .: git-sh-i18n: not found

This seems like a reasonable fix for this issue. However as far as I
can tell git-sh-setup was never meant to be used by outside scripts
that didn't ship as part of git itself.

If that's the case any change in the API which AFAICT is now
considered internal might break them, so should some part of that be
made public & documented as such?
