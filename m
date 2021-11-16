Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E0DC433EF
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCEE6140A
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 20:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhKPUlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 15:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhKPUls (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 15:41:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DBBC061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:38:51 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 207so1080825ljf.10
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 12:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=C6GKo/pUGIMl9bf8iF4r/DXtv2vF9JG9CECkckUlhuQ=;
        b=hvVj9iwtbXrchGHNNWcffRJOc7RIanOjV912GVSRV3PrbN1Hle6ael2+fiD69ydfIv
         zmh5TmVLsJaq5gO3OXxE+Hn1qMj8mMohfvZb7vuPFnMM7aw90dBGEpTlG3otLx1spYnD
         IQq3EAcTaJHlXe5UEiiZxyz9gCojkjnKde53nMHz2Q4ibkT4Fdb9fm2aNJTceQ7Ymehh
         Wzyoh/U8BlvQtqqMFC3qJzIWKuF1Q0GrzrEpPbujt8VWbo4sIPFBBTPcRIAMnKB1+LZt
         kG1kkmDNDzmFpX4ZmjWxXyGCKeKxKJ+FuJBEz0Sjd6uwJ/VX2KbjJHxQgf7eA9AWTKGE
         IxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=C6GKo/pUGIMl9bf8iF4r/DXtv2vF9JG9CECkckUlhuQ=;
        b=O8UXZRIRdO6zrJ7D5UcKmQeYnTh2B4dIE+59MaPKBa15gZKTQ15nISfWY5+nJAanw4
         7qHCgpYNvo+LB4iU35Pmp21jnNw59OAhHmJW9gBXnrGRrkq1UIwbaK467R1qw52PrHWX
         s/eLCV0XOrSHT1N4b7ca9NKVMWZYTdDJIXc0Jj7XRhHUH8WiZ1l5CjT1GpaqEomz8aV5
         ByGIGK+of9IA33edZQVI/A6ubdTsqsHGqEMVyTpBtCn9dqbZLGohlxfxLIHKjHXwnBBw
         BCfhl5hbZXw8VN8O6nvr69z+lW/ZW1GdkbjAnyIaVhjxa/BAeK9IRA41P7Xg4V9CAGtO
         L5Yw==
X-Gm-Message-State: AOAM530u1NbDmy3o/UfQ9JsRvg6OU6ZTEhqDQd0kWocp8x/fj9TLEGjH
        N/WWAdgeg4gV4iSxNCbg1+ODx0vb+ygZnIQZz/s=
X-Google-Smtp-Source: ABdhPJwjzvrK7bKXW3cD5+Vd8dnNHs0xtnatOhzbetGLTqCi6zTmIMzlWvVDEmW3FSewPoLyeTgoBzWIX5YgB+UN2e4=
X-Received: by 2002:a2e:a305:: with SMTP id l5mr2123603lje.73.1637095128726;
 Tue, 16 Nov 2021 12:38:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
 <pull.1076.v9.git.git.1637020263.gitgitgadget@gmail.com> <71817cccfb9573929723a34fe9fb0db72498d4b9.1637020263.git.gitgitgadget@gmail.com>
 <211116.867dd8r2b1.gmgdl@evledraar.gmail.com>
In-Reply-To: <211116.867dd8r2b1.gmgdl@evledraar.gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 16 Nov 2021 12:38:38 -0800
Message-ID: <CANQDOddCC7+gGUy1VBxxwvN7ieP+N8mQhbxK2xx6ySqZc6U7-g@mail.gmail.com>
Subject: Re: [PATCH v9 2/9] tmp-objdir: disable ref updates when replacing the
 primary odb
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 11:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Nov 15 2021, Neeraj Singh via GitGitGadget wrote:
>
> >       /*
> >        * This object store is ephemeral, so there is no need to fsync.
> >        */
> > -     int will_destroy;
> > +     unsigned int will_destroy : 1;
> >
> >       /*
> >        * Path to the alternative object store. If this is a relative pa=
th,
>
> Why add this as an int in the preceding commit and turn it "unsigned :
> 1" here?

Good catch.  I'll fix this. This was an artifact of a previous version
where there was another variable here as well.

Thanks,
Neeraj
