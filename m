Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C931F453
	for <e@80x24.org>; Tue,  5 Feb 2019 01:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBEBgs (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 20:36:48 -0500
Received: from mail-yb1-f179.google.com ([209.85.219.179]:33401 "EHLO
        mail-yb1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfBEBgs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 20:36:48 -0500
Received: by mail-yb1-f179.google.com with SMTP id w2so74077ybi.0
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 17:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xLd2J874IUxDni4MlI6Le5ckvEszhHGn3vWTuV9HPAg=;
        b=SGALvxE22epp4+DuRmB87svMCzbr6vJr9KVdOnc/ZylJXmrvXpKqnhHJBznecE1P6F
         9cT4xBKg9XuIu2oXiws0D7U1ULwC0qmUBCiJatLLf9S1m9sBrv43L3BfhLD/cMYjhLfB
         1nQX4siUKbk5Vv40Aqijv/bprQCvvO/kx6U6OX1aazr6eCDCJgMLDXeCemb9XXJ0WUPv
         UgTDQFg/+lPLZ3+rvjVu/662LUST6OYTMEXjs0rEU9YfxZTzOqOs63wLNHQvuwaTVQ2M
         SzwHHXmW2eX+faDDoPVMgrEIgNeYO2OT+KrM0bUz0DRJ6pSXN9Q3Zl459Si8TpTkfBym
         qmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xLd2J874IUxDni4MlI6Le5ckvEszhHGn3vWTuV9HPAg=;
        b=BH00+0u3ipw68m3gicQKuuAVgE8RjyEvhGKMQmOWmjc23jIJmn+PcidASG7KcomXIE
         SQUwTmCfhkn2JA12p/bNKJjZwDkqDvF/pAXV4sTAAtJq17R0QGT4BFrax1yRqWZCJugi
         80xi4jsxADii0L0GcfbFB5KJ/lEck8NQIVHhykn6fTGf13kQHlPagf2eqCRAjEnP2V++
         dQ7B2IgJ5WjitWFGAquQJVEtADbN0ffK7J9dLAb9yo4fsFQbwv7C0JOL5Xh5jd6CDHh7
         luB2nWN5rhqe5oYz37zYLO1DEzCERACVEtDJ/eUKUVy8jM/CUUqbjzbt/IF5PCiAMcYC
         Z1dw==
X-Gm-Message-State: AHQUAubZpT8uBFHZXkba6LI/cUVy6yBxTIuNPFkdNrk9GcwwamrONgOb
        vF3P1cyCPlsiI87Rv1Uob4B5gI8trO9lwsHBO989Ivc=
X-Google-Smtp-Source: AHgI3IY4pEZ/uaNwo9Vyaos/eFOFZgcI8byYSVtv6j2UjoxUcicjOmWE9+DNwPp+GNwMzIlYgKjQJquUIEwVIuCxRbE=
X-Received: by 2002:a25:2008:: with SMTP id g8mr1900582ybg.167.1549330606885;
 Mon, 04 Feb 2019 17:36:46 -0800 (PST)
MIME-Version: 1.0
From:   Larry Martell <larry.martell@gmail.com>
Date:   Mon, 4 Feb 2019 20:36:10 -0500
Message-ID: <CACwCsY5xU0pUaPZDJMqWNB0dz7DjTx3_b2Lvrft0NjA6cnPvcg@mail.gmail.com>
Subject: hook to get info on commit, and include that in a file that is part
 of the commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is there any way using a git hook to get info on the commit (id,
message), put that in a file, and include that file in the commit?

If I try that in a pre-commit hook I do not get the info on the
current commit. I tried it in pre-receive but it does not seem to get
executed at all.

If I do it in post-receive it's too late to check the file in with the commit.

Os there no way to do this?
