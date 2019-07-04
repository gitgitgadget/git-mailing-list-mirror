Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303EF1F461
	for <e@80x24.org>; Thu,  4 Jul 2019 23:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfGDXzR (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 19:55:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43684 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727313AbfGDXzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 19:55:16 -0400
Received: by mail-io1-f68.google.com with SMTP id k20so15568415ios.10
        for <git@vger.kernel.org>; Thu, 04 Jul 2019 16:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lVlAepB8vAj5dqsrFG6W6Gfryx9UxdAvYHyjY68Yxe8=;
        b=IapnS6E4jbRRzNeSvA1KVX9DPh6zEPXOh4xmBtoPKnf9ZkbAOxqYVI5JtQLYMNvdHC
         wQ8+u0vFjYJHSqLQzB1JPkNBo/8GMFpe7nhvrDBhlQ5KXGQ8pBGTW/QS2woXI+O+Dhyw
         RV21qsiuuLZikBUeOcrBc9XJ+R/1R/yKvJdJvZW2BQOGFMJYL4dit5APyxUiOxHtOoEn
         xOP9tYf3+Xw8AffflG0DEQNVdA5vI2Tmei9qGa3tHElaxaMDgQhJF8YyAESYAaPWJ0mm
         C56qXl5BcLbYKonVzVmOPTCob0IFWHha5Wkls0q8SIVRGUO8FUbwHFKizhOxeH0C9tyn
         qCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lVlAepB8vAj5dqsrFG6W6Gfryx9UxdAvYHyjY68Yxe8=;
        b=mOtLLvWXDMKkqcmmWWgVRhfDItztOAp+vXYfpUxfoJhgbgmEgMAYBGo23a/kWNO1MO
         sTSk4aKP/fO0XBhoCRcIBBaRoIIMheijUP+VwIx6MNnd8MExgrX0k7UtqXYHBjKMPtBD
         yQh5xG2cX1PtgyOYuEiyWOBlyZtaK3iVFE1fmeVsBJSZtTYtDK8epTc2j9enH29+NMrd
         R0k7urV/3Sns6bgNar9sMREI4BYjNRdCme0y5dGN/Dgz3ibYfaUYowh8rcD2gdDeKmfx
         B2v0gvLfMCAg+tuc9SfmcqKdTdg0WKEZUtkYpfkTBiyp6Vw+INUhEceCGaxwebEYjkmt
         yaYw==
X-Gm-Message-State: APjAAAW2wpzuLzChGyl/oej/bmHopptyoIr7PcKGrM5wR3mRiA8y3a9L
        T2aYhPz1UQE+oXAc1Nn7fEtfYIkPEUgWcclkuvI=
X-Google-Smtp-Source: APXvYqyvkImM/CeBtnz1DclgTpK0hsi8ESwZfU/YzuW3HmFULzUARzSvFyiK655wv8Pagr9QpzjR2JchYtrWbYYKbOk=
X-Received: by 2002:a6b:7f0b:: with SMTP id l11mr923607ioq.282.1562284515718;
 Thu, 04 Jul 2019 16:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190624130226.17293-1-pclouds@gmail.com> <20190624130226.17293-6-pclouds@gmail.com>
 <20190704200133.GD20404@szeder.dev>
In-Reply-To: <20190704200133.GD20404@szeder.dev>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 5 Jul 2019 06:54:49 +0700
Message-ID: <CACsJy8CZZAkcuN_hqp6YmMkhKs0ON6b-+Cyo+Q+Jk4zFh0Ve7w@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 5, 2019 at 3:01 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Mon, Jun 24, 2019 at 08:02:21PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> > diff --git a/t/t3011-ls-files-json.sh b/t/t3011-ls-files-json.sh
> > index 082fe8e966..dbb572ce9d 100755
> > --- a/t/t3011-ls-files-json.sh
> > +++ b/t/t3011-ls-files-json.sh
> > @@ -44,4 +44,18 @@ test_expect_success 'ls-files --json, main entries, =
UNTR and TREE' '
> >       compare_json basic
> >  '
> >
> > +test_expect_success 'ls-files --json, split index' '
> > +     git init split &&
> > +     (
> > +             cd split &&
> > +             echo one >one &&
> > +             git add one &&
> > +             git update-index --split-index &&
> > +             echo updated >>one &&
> > +             test_must_fail git -c splitIndex.maxPercentChange=3D100 u=
pdate-index --refresh &&
> > +             cp ../filter.sed . &&
> > +             compare_json split-index
> > +     )
> > +'
> > +
> >  test_done
> > diff --git a/t/t3011/split-index b/t/t3011/split-index
> > new file mode 100644
> > index 0000000000..cdcc4ddded
> > --- /dev/null
> > +++ b/t/t3011/split-index
> > @@ -0,0 +1,39 @@
> > +{
> > +  "version": 2,
> > +  "oid": <string>,
> > +  "mtime_sec": <number>,
> > +  "mtime_nsec": <number>,
> > +  "entries": [
> > +    {
> > +      "id": 0,
> > +      "name": "",
> > +      "mode": "100644",
> > +      "flags": 0,
> > +      "oid": <string>,
> > +      "stat": {
> > +        "ctime_sec": <number>,
> > +        "ctime_nsec": <number>,
> > +        "mtime_sec": <number>,
> > +        "mtime_nsec": <number>,
> > +        "device": <number>,
> > +        "inode": <number>,
> > +        "uid": <number>,
> > +        "gid": <number>,
> > +        "size": 4
> > +      },
> > +      "file_offset": <number>
> > +    }
> > +  ],
> > +  "extensions": {
> > +    "link": {
> > +      "file_offset": <number>,
> > +      "ext_size": <number>,
> > +      "oid": <string>,
> > +      "delete_bitmap": [
> > +      ],
> > +      "replace_bitmap": [
> > +        0
> > +      ]
> > +    }
> > +  }
> > +}
>
> This test is flaky, as reported in:
>
>   https://public-inbox.org/git/xmqqftno2mku.fsf@gitster-ct.c.googlers.com=
/
>
> This is because it relies on racy behaviour, namely that the following
> three commands
>
>     echo one >one &&
>     git add one &&
>     git update-index --split-index &&
>
> are executed within the same second, leaving 'one' racily clean.  To
> deal with the racily clean file, 5581a019ba (split-index: smudge and
> add racily clean cache entries to split index, 2018-10-11) kicks in,
> and 'one's smudged index entry is stored both in the shared index and
> in the split index.  That's why this test expects the offset 0 in the
> "replace_bitmap" array.
>
> However, it's possible that a second boundary is crossed between
> writing to 'one' and splitting the index, and then 'one' is not racily
> clean, and its index entry is only stored in the shared index.
> Consequently, there are no index entries in the split index, so the
> "replace_bitmap" array ends up being empty, ultimately failing the
> test.

Yep. I came up with the same conclusion. But I still have a couple
other things to update before resending.

> A 'test-tool chmtime' invocation or two could make the test
> deterministic (i.e it could make sure that 'one' is either always
> racily clean or it never is, whichever is preferred).
>
> What I still don't understand, however, is that when the test fails
> this way, then the "entries" array ends up being empty as well.  It
> looks as if the JSON dump included only index entries that were
> actually stored in '.git/index', but omitted entries that were only
> present in the shared index.  I think this is wrong, and it should
> dump the unified view of the split and shared indexes.  Or include all
> entries from the shared index as well.  Or perhaps I'm completely
> missing something...

The command is to dump .git/index, not the shared one. And since this
is not a split index test, rather a (quite low-level) json dump test,
I did not bother to also dump the shared index, which should look like
a regular one. Producing a unified view in json might not be easy with
the current code because it's tied to file reading code, nearly stream
out json as we read the file, and split-index requires a post
processing step. I could contribute a python script or something to
combine shared/main index together. That way you can still see the
combined one, but we don't have to add/maintain more C code.
--=20
Duy
