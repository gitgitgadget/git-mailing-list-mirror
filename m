Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C5FC4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbiKVSVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiKVSVv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:21:51 -0500
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0C582BE0
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:21:49 -0800 (PST)
Received: by mail-pl1-f179.google.com with SMTP id p12so14463394plq.4
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puaGcoQ49RrKndF4tvGqRMr6VmQJ2RtwTM+CIKD6qho=;
        b=DeusKO7PQh0pkWUpCSBDRu2PMzuw1koTZ+ohw46GW0KeCEpP/MQfbLRwAitBcokf1O
         DHFJE4uXB/axwh7qL69PCdfkaSEyaHNM4QLPd/HRp0rf71wcZXcJ2Q+xwJtf30AxkT7c
         x68alMmJvNPwLZqVd4ZdYAx3Jd3tVf+1uDl3qO45Nh6feRpYJih+Ji2ZnLwmTHxeMoUs
         DDHfpN6klcMWL6apnMQlYcipL/Xmd6N6bmaGv5TXVxfPtSFTe+xreuhjNeFpArJ/j3JT
         lNEwPuER8fPxPYYXrvU1iGcKtgscyuRpPfR5/DodT/6CQ8lu3iou2mnh2obLOyToZgk+
         9v+g==
X-Gm-Message-State: ANoB5pkocsuuZZh5j4HfJvpg7Ws8p++RifActIJQD3MZKXxxoFroFN/U
        to/VFQlfwaO7k0Q8CoLlp7YZHCZdSTPXFp/R7Q8=
X-Google-Smtp-Source: AA0mqf6INH5dVRVmQrb4RhHO7qlbNK+3KkJAGJLZ+8QsTQ9y1yIxxZFDoaNWuB8XioZW0r++Kv6nezBztBzeVykvLYY=
X-Received: by 2002:a17:902:868b:b0:186:8c19:d472 with SMTP id
 g11-20020a170902868b00b001868c19d472mr5770494plo.12.1669141308640; Tue, 22
 Nov 2022 10:21:48 -0800 (PST)
MIME-Version: 1.0
References: <64b10e7e-2807-8ae5-88c7-3df7f6f1f3bd@opensuse.org> <15a2baf8-53f6-de75-a6bf-ecb4a83d78c4@opensuse.org>
In-Reply-To: <15a2baf8-53f6-de75-a6bf-ecb4a83d78c4@opensuse.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 22 Nov 2022 13:21:37 -0500
Message-ID: <CAPig+cQMqwzGvzr-+6KH00QLY67Dj4qsKniLuPMrXf6pt-zmSg@mail.gmail.com>
Subject: Re: git can not be built for s390x since update to git-2.38.0
To:     Sarah Julia Kriesch <sarah.kriesch@opensuse.org>
Cc:     git@vger.kernel.org, andreas.stieger@gmx.de, tmz@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 6, 2022 at 2:18 PM Sarah Julia Kriesch
<sarah.kriesch@opensuse.org> wrote:
> I have seen, that Fedora is excluding many tests additionnally for
> s390x. That is another difference in the spec file:
> https://src.fedoraproject.org/rpms/git/blob/rawhide/f/git.spec
>
> We have also identified this week, that chainlint.pl --stats says "0
> tests". That can explain the empty output.
>
> ~/rpmbuild/BUILD/git-2.38.1/t> /usr/bin/perl chainlint.pl --stats
> --emit-all chainlinttmp/tests
> total: 0 workers, 0 scripts, 0 tests, 0 errors, 0.01s/0.01s (wall/user)

This sounds like the same issue as reported here[1].

[1]: https://lore.kernel.org/git/CANYNYEHXU8ivgAOa8EO5e9kOcbu6XF7rj+9EcSrbDQE+Rvyw_Q@mail.gmail.com/
