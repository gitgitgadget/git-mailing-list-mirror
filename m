Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A8E1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 10:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbeIZQOr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 12:14:47 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:43851 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZQOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 12:14:47 -0400
Received: by mail-yw1-f45.google.com with SMTP id k66-v6so4969575ywa.10
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pCzu0+FeTO41x+1XT+bVl7MPxyHkwf4FsNs9qkdmuDs=;
        b=KSOTw0LgC5o+/0L0u6y9Y9Kz3+eWR2bsAh9M0B4BzFi2C2pPStpOO/pkq/tzuk39vp
         6ptF10BDDbFc7ozoFqWMtbUj/wRedx7TkRio75+aEEKn030FpxNhkEUI5SWE9LGBbO7c
         qxo1ORi6eI8c47A6pL6RU1cBiAhF2nVZIJ7Ivyet2MxthlM2/tA6gwMvdmfxLDLj5s2f
         DwdGMfPLz9DMiYpG0U+R5mkCTtFlrKWWTSmIO30JNtmY2Ft4MiFC/Mw8VdGARRV+/Waz
         LMtP3kbI/MHNHi3Xeh8uLR8nPygz4jCYlFITsrnCmKFdLSMHGERr6UAaAK/yEBymex3W
         LmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pCzu0+FeTO41x+1XT+bVl7MPxyHkwf4FsNs9qkdmuDs=;
        b=drGG8fi22CKwMvQl/ok7lJpGTizULxY0Ga3eWjjR04H1D5IijL66qhSd+x9u95IPVl
         xhdXIx7e2YPBjPl1GNq4SQkWqkEYrU0ITUW4SeNtwyJ6kmUOfDXlR4X6AdSPNW8XhORW
         t718vOjzN5CTiVzHLgeSwJdvLkgWDCUAId0cbB6y+4gJimjPEHIQ5/pB6Y0gnzeEMwgP
         hetesZOb/6Y0cnVE57axGKiHK4z8pJCh/sDT5E8uMh0KylnSlZqE+MHrxnQaYBm+oODU
         txE6b6KfUvTUHX+nJ4SebZhOZU1mFuogyk9OopKp3rBGwBvMdbHdukw5eyCzHSE+VudU
         Mg5g==
X-Gm-Message-State: ABuFfogyyk0yzYXKW/jbXevgPblrq74Kuro3mtaTcwyNLX+fljpuGE/0
        eB2PVuTGtUOQK7AH68O7kv4VoLbCxP2wLpYx/aI=
X-Google-Smtp-Source: ACcGV61WWlKQmHk65rwkH2iJhhJra2a6JrNCNtRPU98B8J078y5VvpdNckXeGlw3+3J7lqrgnOrnNr3MP+eiQR6A+Gk=
X-Received: by 2002:a81:99c7:: with SMTP id q190-v6mr2695920ywg.106.1537956154813;
 Wed, 26 Sep 2018 03:02:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:248c:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 03:02:34
 -0700 (PDT)
In-Reply-To: <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
References: <CALOYryFX4PPR+=1L+sjEqPsdmNh_+vNxGf0wwuAgoYzau=GShw@mail.gmail.com>
 <CAN0heSrhaaP0ds8K92g9w5DAnbwuq8mM6WLKrTQ7e_a8Fku9KA@mail.gmail.com>
 <CALOYryEMB5HoCXbVKnc49KLkk2ySZjn4DG9RbJjQAvPn1H5K6Q@mail.gmail.com> <CAN0heSpUhzbTjceVhBxk_jjE=vOAVTzXGFQ=UL9Y+muJHe0S6w@mail.gmail.com>
From:   Alexander Pyhalov <apyhalov@gmail.com>
Date:   Wed, 26 Sep 2018 13:02:34 +0300
Message-ID: <CALOYryF8BuU5H+Fn74zejNx=U-UHWoMdHTLrtGNJ355XNRjecQ@mail.gmail.com>
Subject: Re: t7005-editor.sh failure
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-09-26 12:52 GMT+03:00 Martin =C3=85gren <martin.agren@gmail.com>:
> On Wed, 26 Sep 2018 at 11:00, Alexander Pyhalov <apyhalov@gmail.com> wrot=
e:
>> As for sign-off, do I understand correctly that you just want to know
>> that I'm the original author of the code? Yes, it's so.
>
> Right. Plus that you agree that the code (the commit) may be
> redistributed basically forever.

I'm fine with it.


> I came up with the following commit message. What do you think about it?
>
>     t7005-editor: quote filename to fix whitespace-issue
>
>     Commit 4362da078e (t7005-editor: get rid of the SPACES_IN_FILENAMES
>     prereq, 2018-05-14) removed code for detecting whether spaces in
>     filenames work. Since we rely on spaces throughout the test suite
>     ("trash directory.t1234-foo"), testing whether we can use the filenam=
e
>     "e space.sh" was redundant and unnecessary.
>
>     In simplifying the code, though, the commit introduced a regression a=
round
>     how spaces are handled, not in the /name/ of the script, but /in/ the
>     script itself. The editor-script created looks like this:
>
>       echo space >$1
>
>     We will try to execute something like
>
>       echo space >/foo/t/trash directory.t7005-editor/.git/COMMIT_EDITMSG
>
>     Most shells seem to be able to figure out that the filename doesn't e=
nd
>     with "trash" but continues all the way to "COMMIT_EDITMSG", but at le=
ast
>     one shell chokes on this.
>
>     Make sure that the editor-script quotes "$1".
>


Looks fine. Thanks.


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=9F=D1=8B=D1=85=
=D0=B0=D0=BB=D0=BE=D0=B2
