Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D66DE1F403
	for <e@80x24.org>; Sun,  3 Jun 2018 18:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeFCS17 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 14:27:59 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45613 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCS16 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 14:27:58 -0400
Received: by mail-yw0-f196.google.com with SMTP id v190-v6so7456529ywa.12
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=h0DvTGsxD7nQjzpaTpyaDdnNPTVGJEOAe8nt0tWkVAc=;
        b=ltoXwKqZae/zfN3yqm1mNJDZce89FoW/HFh1aAgrhOHmKZAf1Prw8pYZccG5w02hqL
         ger/CdgZQgLnowjXSVm0P25Cv0c7WWLbV87LxmEhJ6bhDAABsLrg30iEWGQdCNMCxJKr
         boROoL/qVcAO6RKyExOftSZd9TBS4lqqKIw6iJelhv2PeMCrxbszEfYxyCgall7/LqFw
         SSS0AFeDe+uAegXciV9g6G1L2HihBTpmnyBPx/VDMocrq+5Po5beeoEO30g3Z0zqmKNg
         +tmZ9zp7Kq0XCJoWtkyvDw00jjnGZzwy+xHcSbIlAUIAfsO54yglFuYEIHbzNY0TGj7T
         POLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=h0DvTGsxD7nQjzpaTpyaDdnNPTVGJEOAe8nt0tWkVAc=;
        b=uMhT+OQw4MM85izU1k6GJk/iTUp9HPHAcTNCYJlRcE5Y1K9uSUB+UDGco2Od/dX4QQ
         lWUyu4LmKcFZT4ElqGehLTueKh2z6bVh46jPFIv7brAYj/uw4b8ZN1MYGW/hJhKP/a3r
         rFpL/gID7DF7JOzcJbFsE4y5Z3OMDN24cO7X1C0e924ogQXx6DdujcKO4yrA7Lwxd2wA
         bwD9j/bpKA8hqrjrZwPzEgPpFdGIzw4c/82U07J4b68UPZgsvMivj/vBd4I4aRBM6v+g
         ZkN3qRMkwW1h9WPvmi7QUxMcDgq9jst9MnD/zsHP5jmn5OeQ5sYHbF4lYEFrpCO1KGiY
         H8ig==
X-Gm-Message-State: ALKqPwcCkTnlp3huAmWV931lpwX8+N8Q5tRJoHPFAmXWkdof3LjdM0Iu
        RUoNcEtXG20hvgKkDET7phEsqhrt/QWSPt2Tyws=
X-Google-Smtp-Source: ADUXVKLEaKd/9l9F9fV5VbhT8iB5bXH+pRy2P+adJjS59m0d6g2TGabpV/f4Hh+xjfADzy1VjGXRzJ+CBxoiuFXr6Sk=
X-Received: by 2002:a81:8203:: with SMTP id s3-v6mr9682167ywf.131.1528050477617;
 Sun, 03 Jun 2018 11:27:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 11:27:57 -0700 (PDT)
In-Reply-To: <CACsJy8BXHDK8s-tSVkMG8sSu+DXwKxSkGqN+7ME8Lm9CjOx9GQ@mail.gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-20-pclouds@gmail.com>
 <CAPig+cRCJbZxaO6vmt+8D7aOLZDGrDVDMB97zfRAfwmtRPP_Zg@mail.gmail.com> <CACsJy8BXHDK8s-tSVkMG8sSu+DXwKxSkGqN+7ME8Lm9CjOx9GQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 14:27:57 -0400
X-Google-Sender-Auth: ZT86UQ3-hJoK0-Gt7NiyJDhRAm8
Message-ID: <CAPig+cQUC64j6RUZG3LWP+dm9HrvCBi+ayO0w5pmCkBU=vO_1A@mail.gmail.com>
Subject: Re: [PATCH 19/22] sequencer.c: mark more strings for translation
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 3, 2018 at 11:14 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Jun 3, 2018 at 10:16 AM, Eric Sunshine <sunshine@sunshineco.com> =
wrote:
>> On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
>>> -               fprintf(stderr, "Could not apply %s... %.*s\n",
>>> +               fprintf_ln(stderr, _("Could not apply %s... %.*s"),
>>
>> Did you want to downcase "Could" for consistency with other error
>> messages, or was this left as-is intentionally?
>
> I'm not sure. Others start with a prefix (like "error:",
> "warning:"....). This is a bit different and makes me hesitate.

Yep, I realized after hitting Send that this wasn't an error/warning
message so probably shouldn't be changed.
