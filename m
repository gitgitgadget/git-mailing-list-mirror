Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B4A01F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJCXfX (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:35:23 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35328 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:35:23 -0400
Received: by mail-it1-f195.google.com with SMTP id p64-v6so9897282itp.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lmxkjve6VspQvl7s/dR61vycqDJ7pcdX+Qg6Mg1oNmU=;
        b=kvMJiy6ye69iHRoNIrxtzjEIxsd/O1YPbibE8DrlNNiDtWC+VKjjDDTyGdvYC9cgPH
         9PKCUhmomOra7ItPSO1QGuaipP+h114gIu4rsJaZcpJDhXeBwLQwrXjv92AaiQjRjRxT
         9R2Il09S/Ak3TMNe1YaBxYZEpNdqTNKBSKnHhtAwr6bAlQDrbT+BcVA/7TMYZnLYVG84
         bw4xmgYbPoRcWMC+e0Yp1wg7YCqNn+EP4VD8nCd/VVAokH5uViW5QRmO1IqZsCycliKB
         AMmZcDJex0h1cgC+b5SkVKbFBE14Rp0f951gwEV4eRd4IK7tP+bGUaFIP/G18yQvxXLA
         dkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lmxkjve6VspQvl7s/dR61vycqDJ7pcdX+Qg6Mg1oNmU=;
        b=P/a/yQKIBOdJfKLtqYW3HFCdhdFxhzfoItSonvBSdK0cPV2VvVDKYYnCtVJgGMH1S7
         QnxZCE6JilpAK1sioUkpA0T9uk2C8Ycf8FLPhQZIctm7y3RfDa69A/ZYdsTX4qz2Qh1G
         u/HGjvSTbobk5D4W77lMCMZRhzr9kySZNwwc7Ri5oWn7fQ5HhLccATceVu2IsneKP3gv
         huFbKEZNCe1iocXE+vz+C5Z7x0AjUdPb7roiUE28lnF8ecwZ0+r9t/n9D0mR63ErN9cR
         kmWETppnr6/A3yjoEWbr2My7dxnMJZPiTtuAYC67KOed8GLnCCQzlVQ7AfbgrKgXLQ+R
         ikKw==
X-Gm-Message-State: ABuFfoizvd2f61RkXy8xMGDqIpRnG9zRVzkQzQ+a72Emb1GAhm9+thF3
        8IMzuim/TsFSOlPwdiJ5JS0cnUyteoStSpzCw14=
X-Google-Smtp-Source: ACcGV63LAlwKB+5crTNbMwF91gcndSdhDS0zstQW6atCoV9cMHNve/QwODjPl6s059zF72fR0o8oJzgE5+q+WGAYJ6w=
X-Received: by 2002:a02:6f58:: with SMTP id b24-v6mr1885655jae.130.1538585172415;
 Wed, 03 Oct 2018 09:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <87tvm3go42.fsf@evledraar.gmail.com>
In-Reply-To: <87tvm3go42.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 3 Oct 2018 18:45:46 +0200
Message-ID: <CACsJy8Ap0s-8NSM3MW9TtRifUUod0bDhGnzaeJuTSzXjmJA=pQ@mail.gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 3, 2018 at 3:23 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Don't have time to patch this now, but thought I'd send a note / RFC
> about this.
>
> Now that we have the commit graph it's nice to be able to set
> e.g. core.commitGraph=3Dtrue & gc.writeCommitGraph=3Dtrue in ~/.gitconfig=
 or
> /etc/gitconfig to apply them to all repos.
>
> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
> until whenever my first "gc" kicks in, which may be quite some time if
> I'm just using it passively.

Since you have core.hooksPath, you can already force gc (even in
detached mode) in post-checkout hook. I'm adding a new
"post-init-repo" hook to allow more customization right after clone or
init-db which may also be useful for other things than gc.
--=20
Duy
