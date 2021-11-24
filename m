Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66835C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 01:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhKXBg1 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 23 Nov 2021 20:36:27 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44634 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKXBgW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 20:36:22 -0500
Received: by mail-ed1-f45.google.com with SMTP id l25so2768045eda.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 17:33:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EEjx9jMbkJdP+0Jc0btYcnc8axB9l49/+Pd0sOyBeu4=;
        b=BktrFn0aIuJcQ6+kQfT6qkwsIItrAqejeHl+4F8vZA+rz924GQsEZ6ouMmBJFAN6DH
         CmwPqzZDXo5kdUmsvsKTmZDSZ5jH/JnvBly4OF1xqjxEdFeuaghTCD1QjvbIiCKHo72J
         IYwNwkUzd7JkN6FfgUF0JCxakfN0ht3tnGobaMzyISvbl/2ySjoJmKgEdXKUg+PxiZ+N
         0g/UV2UXJhQu7finibjjkqq7aQBLmklQtKfdhxOnNnisq0R9mFQk3p7YOqSW3Ez6KjSc
         DmtS29ja0uRpnIiVYztU/vYqlASRr1IQjccnkq70qfhIB9AyKafpjJ4Mn5qdjRqariAV
         WpOw==
X-Gm-Message-State: AOAM533ChqQozQeMeM6E5ioyf3lAA/HOPVVskAkDqBmpkqbgXXhMsZET
        aKqRsiSSxNYqYDX32aBDIdE5/DCDS9WbZX2xZd/657RCXjg=
X-Google-Smtp-Source: ABdhPJyCb9BIc1+Qs5mSdmv+8+NXP/fX0G889q/rHQMcYIrGKQpIZg6ij4VX2AbrC6YHOGvi/+wWUUK6mFVp2sT27Tw=
X-Received: by 2002:a05:6402:2043:: with SMTP id bc3mr17683350edb.231.1637717593012;
 Tue, 23 Nov 2021 17:33:13 -0800 (PST)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <cover-v2-0.9-00000000000-20211123T115551Z-avarab@gmail.com> <patch-v2-4.9-a2ee10e214c-20211123T115551Z-avarab@gmail.com>
In-Reply-To: <patch-v2-4.9-a2ee10e214c-20211123T115551Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 23 Nov 2021 20:33:02 -0500
Message-ID: <CAPig+cSybWJ=M7X_qQFWJVVWP-9pVbVcwptky2QUA+jOYKMFng@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] run-command tests: use strvec_pushv(), not argv assignment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Enzo Matsumiya <ematsumiya@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 23, 2021 at 7:08 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> As in the preceding commit change this API user to use strvec_pushv()
> instead of assigning to the "argv" member directly. This leaves is

s/leaves is/leaves us/

> without test coverage of how the "argv" assignment in this API works,
> but we'll be removing it in a subsequent commit.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
