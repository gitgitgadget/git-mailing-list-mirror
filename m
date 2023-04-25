Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE573C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 00:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjDYAC3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDYAC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 20:02:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1481149FD
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:02:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b78b344d5so4166979b3a.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 17:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682380946; x=1684972946;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=M28m1wfB3bBGFqhhCX9fdXpBhZJm+sXna8WeyMCGhr4=;
        b=bhpRV+fG7ci9utyEpKqvCYlYo/G5+y2eiBz+/+5Jl2CPX8mgc2V8Ukdsm97hyotFF6
         stWcWbzVRuC6ymjDk4FruBsh5KAtprvhqfkhXlHTMRcQjsPECqZkmn3UZF5tWFFOw+qj
         zrR90QRPMs4kinS5AMxa3+AVko67xrpZqZXSb0es+DcdR1YgID9yQHVjDGg8b/I3PUT0
         s4TST+sNjmwrIA73efByo/8oO//V4Jh7rh5hOTDllzuOQLWLw+V0chRnzaSbOa4KxFJ4
         XgvfPLbX6RjAA1pBhaRafbSB9i9RlcMUsEA2nKw/wn0irYY7tDucnCWCHRb21AHEkIL4
         m45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682380946; x=1684972946;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M28m1wfB3bBGFqhhCX9fdXpBhZJm+sXna8WeyMCGhr4=;
        b=CXMcUR3iq55fc4sVGyjRMf0q+I+57OhSeptpL2nCH27sJ3T4XTFsQMzerzvD7cUcQR
         RFZX5fTWkdriEXLBDY9/WuHAAONy/TznkCUPsd2KYDtE5I5ux1D2e4sx6zCVw/Gpxd54
         P7V0XGhRPVRPe5GnfpPOmrTcldd8i3ifM4bhC+nvGNW2uIcZh98EWtqEdNv9D7T3KXEs
         4zaeOWl2RXAbulm1EAJd4TGFqfjpalvTERK2FoPQLl8fdFhtp7tYm3d4qzEGPw0lUNiP
         bLOjaR78VRYcTyfdM+CCGspoFwWQjtmWUtXmOK1NHS7LyISvLgs61Jyl8fijGti2ukwU
         3wkw==
X-Gm-Message-State: AC+VfDz91nLLHc0h6f4/U4+j9jEsmDnn8o1UTrqKuIR1hr1NSaSMhvZc
        fEimsxDx4VdiZoV8cmpoKmM=
X-Google-Smtp-Source: ACHHUZ7yCzbwHddQQPOdUZAKZRNNoTQLhIsEE7zizSmXzMcW5F8s7jD67ERt7JicXXw12ZDbwGn8aQ==
X-Received: by 2002:a05:6a00:84b:b0:640:defd:a6bd with SMTP id q11-20020a056a00084b00b00640defda6bdmr4386065pfk.12.1682380946384;
        Mon, 24 Apr 2023 17:02:26 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id k24-20020a6568d8000000b00520b677c645sm6964182pgt.41.2023.04.24.17.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 17:02:26 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
        <20230418070048.2209469-2-felipe.contreras@gmail.com>
        <xmqq8ren8xz1.fsf@gitster.g> <644684018a766_aba29424@chronos.notmuch>
Date:   Mon, 24 Apr 2023 17:02:25 -0700
Message-ID: <xmqq8reg96cu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> No, it's for the formatting machinery.
>
> The fact that both asciidoc and asciidoctor happen to understand our quircky
> formatting in this particualr situation doesn't mean it isn't quirky.
>
> In this particular case the parsers do understand what we are trying to do,
> because we just just pepper list continuations (`+`) everywhere and it happens
> to work.

I'll stop at pointing out that the first "no" sounds much stronger
than the text that tries to substantiate it, which says that the
machinery works fine without the changes.

> This discrepancy confused Jeff in [1].

And this is a good reason to add this change for humans.

> It's simply a good practice to follow the format asciidoctor documentation:

That one I would agree with 100%.

Thanks.
