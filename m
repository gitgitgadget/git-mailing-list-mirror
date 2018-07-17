Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ECA61F597
	for <e@80x24.org>; Tue, 17 Jul 2018 18:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbeGQSk7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:40:59 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40264 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbeGQSk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:40:59 -0400
Received: by mail-io0-f194.google.com with SMTP id l14-v6so1774533iob.7
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 11:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WC/sQptDu7RzC3gAvKPQ79kH/4kxbOEIJN3bD7Na8Ac=;
        b=QiM0TgEQZo8U1dwRfGA5vu1aRxnFDM2miNt0lvhpqEkWdenNVzxe39Fzqb3wehFeaS
         rdJVVoKe0B/IKstwwjr10isYKfz6o56iTdrLvCTzFA4EkFgQ8DMWk9gY1/dK99pILZT4
         xbgWu3uyYTDaFo617Fssw9VIJTZZGxKQmKLsLWdzzf5dmkqMosgD5EEjKecgBbpaf1LD
         0FwFNvfa8c7rVWFZHL3TioidJbZPDKHEdmVOJphbzwFuXr7JFNdDskfrwaSCWL4Wepzf
         6RXtIGgxDU8CjINo7AtjoxjVFlOWPl5yJjj0y01jNbZYA0bWVCZAq1gvs+A6FXbZb4YR
         A9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WC/sQptDu7RzC3gAvKPQ79kH/4kxbOEIJN3bD7Na8Ac=;
        b=FqFnB8yWYJ+Kpty9KHhywG5WPIZXIbOLdvSjAxMOx3CJc8U1ViTvkWtMHD0Hztt96V
         n2/7O2bS9MO1v/KTaZuZ962lRQSlw/Sde24DY6ogBpYkc5ThX7+5FombT3fGME6KlwRE
         wUMt2LBE4UbV9Tc/rohGO7sBCoaiIy9ZQuGnBoIVyB9PdHcSWsjMfFYF3hiHaigCcsfR
         iN6oigT9zRTyPw7a+iwBjR5qyGwQW+mGgu1BVU0RytYgieAH1hh2F+JwZZ0s9iHvI7x/
         4FKFUGNeYPEtA6MMbyRE4yx3CZx/yFJProhamrw74fpLVsZlwHXYfQv5m3Op4+C+Y4Qu
         XGDA==
X-Gm-Message-State: AOUpUlF7tXSHPEbHJ77NAc746yyPfjwc/E5WnSKD+AsHV7vE9ALILEAc
        WomihDdJy8DZtkA0zhWF1rvKKApuSIEMk7hM9dTWAA==
X-Google-Smtp-Source: AA+uWPx5Cvde+mF5iOjOnqzvOzpU9+v0nbq5ItcFtelLRc3g0SPNHD8Y3C4PWA0lBLsABSHSJkRD6tElA4+HQL+/L3w=
X-Received: by 2002:a6b:825e:: with SMTP id e91-v6mr2369603iod.118.1531850831015;
 Tue, 17 Jul 2018 11:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180717091429.GA31043@sigkill.com> <87bmb6chvm.fsf@evledraar.gmail.com>
In-Reply-To: <87bmb6chvm.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 17 Jul 2018 20:06:44 +0200
Message-ID: <CACsJy8A0KUyxK_2NAMh+da9yithZM5d68rhqEVZe3NcMxinAjA@mail.gmail.com>
Subject: Re: Are clone/checkout operations deterministic?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     preed@sigkill.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 11:50 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> In practice I think clone, checkout, reset etc. always work in the same
> order you see with `git ls-tree -r --name-only HEAD`, but as far as I
> know this has never been guaranteed or documented, and shouldn't be
> relied on.
>
> E.g. there's probably cases where writing files in parallel is going to
> be faster than writing them sequentially. We don't have such a mode just
> because nobody's written a patch for it, but having that patch would

Well I did have some patches [1] but as usually I did not follow
through. Interestingly there's actually concern about timestamp order
[2] even back then

[1] https://public-inbox.org/git/20160415095139.GA3985@lanh/
[2] https://public-inbox.org/git/CAP8UFD0WZHriY340eh3K6ygzb0tXnoT+XaY8+c2k+=
N2x9UBYxA@mail.gmail.com/

> break any assumptions of our current order.
--=20
Duy
