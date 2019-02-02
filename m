Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B3811F453
	for <e@80x24.org>; Sat,  2 Feb 2019 10:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBBKBZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 05:01:25 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39540 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfBBKBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 05:01:25 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so7909121ljh.6
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 02:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0vJGiwUJ1kbgcM60+Ev9VySuGeKDtOXyt+Fc3CUB2E0=;
        b=EOiCjGe76CPwJlh57lkX2BqBXXSGPstYDW2tHP1jJVki1Qff7z/6IjLmpyCO3yFQdp
         2AfUI3E7djy+FNMZPIZzF1ph1+97rD/8g8CwDqlIBQDLQ56uyacAoxJpb/0GqsU+8Byz
         fskLjfFcGe+/5sn5E6rqcYS3Ok3XtaA0bcbP2B/0uR0smDzOM3nD6p6iE/n5UbFoJ8v3
         QC0yCWeevqbQeCb1f8YywYOXlJxUmNv7Z87RoaDOeJ2TxD7b56wMBNBmVCgUriLBQsDq
         lJB6xiSUd1OWNhJ363fA9nH+GUMBeNNOZZNDfe9dPO9eOGscQDq+GcGxon45ccv5x6Av
         oo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0vJGiwUJ1kbgcM60+Ev9VySuGeKDtOXyt+Fc3CUB2E0=;
        b=lACGyA8C2Aw5n4uI098PK99/Ii9XAC5+cEw+9QjeSRZshyM8qaOvOkaF06nBY6Y+yo
         +uXrljFIfJZ9gwaKY22+m6uyJUi/zZWbJVF9JCOK4P2dsss7hNWDyelLymWi2HKRgzsA
         O8/jF4zSKK8mhaz0BorqrGj8xLSznltlqK/rtY9OEovFWFosuDzC7nba43gRiYW0Cy/W
         AVSdSfF2TuigVZPJO831X40MGlA0KyvcfBlsoxdQ5jGde6eTdma+BAjXs+/45BM+nu8A
         ur8nYaX3VdTk81aOiT9FAtq8s7BeJygxIOxy9Wd3GTc3YaQI5E+BgZ3FdN259O1K8FAl
         DHXQ==
X-Gm-Message-State: AJcUukerwou9G+pvBoHII3HMFjFB9kV9U8ewBjj93D1oPeXg+dYREaia
        DjZ3GnTDtGtZP6xf3z8JOCqFeuLY2mGeTauYXeo=
X-Google-Smtp-Source: ALg8bN4Z6yd2aHcZ7Sl04TXZrEDrGJpALpkXxqIPHlL82OW+Bt43WaLPo2Yjarrilu1s8FBZ1oL4zm6TmcDVjqptSU4=
X-Received: by 2002:a2e:1b47:: with SMTP id b68-v6mr34093029ljb.104.1549101683180;
 Sat, 02 Feb 2019 02:01:23 -0800 (PST)
MIME-Version: 1.0
References: <20190201135512.68220-1-koraktor@gmail.com> <20190201135512.68220-2-koraktor@gmail.com>
 <xmqq7eejz6fs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7eejz6fs.fsf@gitster-ct.c.googlers.com>
From:   Sebastian Staudt <koraktor@gmail.com>
Date:   Sat, 2 Feb 2019 11:00:45 +0100
Message-ID: <CA+xP2SZ96XqZbCtub9SkxPUNTUVeNZOcXxYvwhMitLgiCVmchg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] t6120: test for describe with a bare repository
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Fr., 1. Feb. 2019 um 19:53 Uhr schrieb Junio C Hamano <gitster@pobox.com=
>:
>
> Sebastian Staudt <koraktor@gmail.com> writes:
>
> > This ensures that nothing breaks the basic functionality of describe fo=
r
> > bare repositories. Please note that --broken and --dirty need a working
> > tree.
> >
> > Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> > ---
> >  t/t6120-describe.sh | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> > index 7cfed77c52..ea2c3dbe1c 100755
> > --- a/t/t6120-describe.sh
> > +++ b/t/t6120-describe.sh
> > @@ -418,4 +418,9 @@ test_expect_success 'describe complains about missi=
ng object' '
> >       test_must_fail git describe $ZERO_OID
> >  '
> >
> > +test_expect_success 'describe works from outside repo using --git-dir'=
 '
> > +  git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
> > +  git --git-dir "$TRASH_DIRECTORY/bare" describe
> > +'
>
> OK, it demonstrates that the command exits with status 0.  Do we
> want to validate its output, too?

It won=E2=80=98t hurt.
I=E2=80=98ll move this test further up, so it is executed when the working =
tree is still
clean. That way we can use the same regex as for the other checks.

Thanks.
