Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6411F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 16:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbeKMCJC (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 21:09:02 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40251 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbeKMCJB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 21:09:01 -0500
Received: by mail-it1-f194.google.com with SMTP id e11so13932674itl.5
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 08:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uZGuqYBVw2IcNCpLkI6QmB11QTJiookjQ5fCkH3RapM=;
        b=cJ8frQwL/8JAbjfIIz6sQvH0FTAPVMlT/LTHUs6IhRr9OqFsUHtd631d4gvWquMggA
         nMV0+H+MVxAAZTBX6d1UMvevtracKezicIDh1j0T00uxiO4faX66mKlt8OA3Xu+K9Fok
         QN79lP3vl/eG2nryArmehqWEEmNsp01MxArrWOq1mpgeWK32hNw6PUZ7UU4hLf92CeCV
         s0pTyU0ccCVmzFqFdfoOd9dt7sYZTFn1cl7pIDlTRyKiqt8kdLrVogfkOChCqYoOLNBl
         0Oa8mbO8vjcAOP+tralCh2k/E9Mzkr9x0JGIaLAETXilFSbvXnI1KFHMtnnAY0qxfXd9
         NHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZGuqYBVw2IcNCpLkI6QmB11QTJiookjQ5fCkH3RapM=;
        b=Jjz2whwnUiZbfaPRTLrWgJDu6MyIsO45HHffRXASrmJKVS5NvICK9yxQdbDFEBGT+7
         /wgL6q49vMas4e47qXEZ7H/CQlMPoO7luQ7lUIxj+fIV5lnE/SXVZW/rGUTCY/8sWiML
         ZQznscrZ3xRqnWqboWHmJVTfkokGLjssg0GD5F4hkBC8N+1Q0mVnUF98S+qPhmWwlhU4
         a+hpuR+DM21mIg79DKgBZ5BujcnFa8d3GTII62/nKp+4wBYkXdgEBJcr9XmQMJ6MKdF6
         NYCV50tAm+TWvpK+5J4sd0g1FRrHCxa1C5refw4io0HDoPBjvyxvcAEBKtNd2kjGVTTd
         03dQ==
X-Gm-Message-State: AGRZ1gLOpLnk2EVAMVZZ5vmZlYQe1hzFZ3xTNyIqw1nbVeLA6yQbkXi6
        cOKOWCYGQ7uN6sfqexUsg6eVYux5IEg4HSK946o=
X-Google-Smtp-Source: AJdET5cH0Y65QYMEik0IgE8OELKtKrHlsYpKLp1Ah6v6oN5XOwLjkFDFoomETRA2nCK4wAw99XMYAZY3TU1Rj19Tg4A=
X-Received: by 2002:a02:9d27:: with SMTP id n36mr1276045jak.30.1542039306676;
 Mon, 12 Nov 2018 08:15:06 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <87zhuf3gs0.fsf@evledraar.gmail.com>
In-Reply-To: <87zhuf3gs0.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 12 Nov 2018 17:14:40 +0100
Message-ID: <CACsJy8BDjNW-eGMDiwpm0WKKe69dmQLDf=sO6-bC4zuC+hPURQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        per.lundberg@hibox.tv, Junio C Hamano <gitster@pobox.com>,
        git@matthieu-moy.fr, Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 2:06 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> +Trashable files
> +~~~~~~~~~~~~~~~
> +
> +`trashable`
> +^^^^^^^^^^
> +
> +Provides an escape hatch for re-enabling a potentially data destroying
> +feature which was enabled by default between Git versions 1.5.2 and
> +2.20. See the `NOTES` section of linkgit:gitignore[5] for details.

How does this interact with "git clean -x"? Most ignored files will
not have trashable attribute, so we don't remove any of them? Making
"git clean" completely ignore this attribute is also possible, I
guess, if we rename it somehow to avoid confusion.
--=20
Duy
