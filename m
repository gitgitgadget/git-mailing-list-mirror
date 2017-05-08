Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5172E1FDEA
	for <e@80x24.org>; Mon,  8 May 2017 09:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdEHJpF (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 05:45:05 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33656 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751707AbdEHJpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 05:45:04 -0400
Received: by mail-qk0-f195.google.com with SMTP id o85so9271615qkh.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0ecM2ysX48q67YYsl9cNtegmTSuF7QQE8xureWgE2j0=;
        b=QCzM3ZnUbTAB1AgLPSSNQEkaQEin5xjmOWIt2ALg0qAoS3w/99t7EovZB+49Vp1qjc
         jOMuU+48NWY6bMorBgzsj38JrFJcNwkARCI4A3GUcjnvz1UdeieQOH8+81F/VnFe8pwg
         uFwiqp+TXewFi4OavUNP9MUxteI4J/NbRBRFV0wzuFaV924xQYHgHYCuNLN52C0pD+WE
         39eclFiMMNvgXBhE+imbtI4nPdb/K8P6fnvuvS6IsLzjqSSRmy8vPvg99ACvmWgWN2my
         bs6Flj0BNsAxCj3h1sCrs7u/ce5bRI+XhKc/aAe+bCty4RYFLVDWKsE8PkjcP2V0urWd
         iUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0ecM2ysX48q67YYsl9cNtegmTSuF7QQE8xureWgE2j0=;
        b=VnN3NdcrLIR0IkdjNCqwDVLM2C+HOCmAb/DkYZI8Cbz+h4XHFwpxMT2bcm6aYBoRSb
         ZPGdjJBmsoVrAkXy/uq8ZUO1ezBustJbR5JklpYlohUXfhV/s81GOC+HrdwrhCXKM9De
         hWvmbt4YwqHTlC24sqFaGOTstI1mtWjGahD/Qk08Krf3EMrj8eV/E8QdEebmz6Osxwze
         OtB3Q+mnD6/91Qaj1z6TPQe4sLKSuW+fZ1qU/p1o4a/BnRPyKCXJu9w/hiTaupfDkS/+
         JENWd3OZ1tS8QFAufA4cPMwualauoxvclOC/ZbNNe7kWq415wtHoQajwrwwLpyPHRz+g
         qQeQ==
X-Gm-Message-State: AN3rC/7JREnuKgBE53ZM3IbI6PsQ7CKJuA5EteLFOmUTpX3dzNbhdpUY
        OQJZjma/GzYrpV71w1etcCTPNiVhYg==
X-Received: by 10.55.186.134 with SMTP id k128mr23248483qkf.40.1494236703480;
 Mon, 08 May 2017 02:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.78.212 with HTTP; Mon, 8 May 2017 02:45:02 -0700 (PDT)
In-Reply-To: <20170414203221.43015-2-git@jeffhostetler.com>
References: <20170414203221.43015-1-git@jeffhostetler.com> <20170414203221.43015-2-git@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 8 May 2017 11:45:02 +0200
Message-ID: <CAP8UFD2v8R8bSjUi8+1271fJ=jR5JbbGfgO_fdeYpzE=EGx_Pw@mail.gmail.com>
Subject: Re: [PATCH v7] read-cache: force_verify_index_checksum
To:     git@jeffhostetler.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 10:32 PM,  <git@jeffhostetler.com> wrote:
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index 33a51c9..677e15a 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -689,4 +689,17 @@ test_expect_success 'bogus head does not fallback to all heads' '
>         ! grep $blob out
>  '
>
> +test_expect_success 'detect corrupt index file in fsck' '
> +       cp .git/index .git/index.backup &&
> +       test_when_finished "mv .git/index.backup .git/index" &&
> +       echo zzzzzzzz >zzzzzzzz &&
> +       git add zzzzzzzz &&
> +       sed -e "s/zzzzzzzz/yyyyyyyy/" .git/index >.git/index.yyy &&
> +       mv .git/index.yyy .git/index &&
> +       # Confirm that fsck detects invalid checksum
> +       test_must_fail git fsck --cache &&
> +       # Confirm that status no longer complains about invalid checksum
> +       git status
> +'

This test does not pass when the GIT_TEST_SPLIT_INDEX env variable is
set on my Linux machine.

Also it looks like you sent a v8 of this patch series with a different
test, but what is in master looks like the above test instead of the
test in your v8.
