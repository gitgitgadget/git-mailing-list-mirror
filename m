Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FFF21F404
	for <e@80x24.org>; Mon, 12 Feb 2018 22:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932664AbeBLWPJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 17:15:09 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41357 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932612AbeBLWPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 17:15:07 -0500
Received: by mail-pg0-f68.google.com with SMTP id t4so7383903pgp.8
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 14:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NmsFFZug6fZbGbmv9oEK2ifng8RYaXuuuUd9qm9I4kk=;
        b=fxJyAuRYPHIX65HHj8J05VHk9nk+z3FiXz45WMAvgRL55LzVjSoDGXzn1YEvRrDQBj
         8ZVORLG4GJ4JkCiUbZo0dY+oBNigj17C2mQGbQHJ7qZTFGZOmfq9RhAyWpBMzLDybauL
         3W9lMBBKU5Xi+XWmHOiMMktsbN/M/BXSf752fOXxSyNSt/RlNpst/92PBMcFbF+mSsIX
         S9sCXbZVyxqmbdW/NT+mQFf+tHKutcDCtZcJ+YBi0lEsrEPI9JHJve34lpm/cXq4+FG0
         KXHPLR5w/uQoCRb2UnTwYplySdIph734FWDt7Gb3cwdlsIyNhz3Q+A29qIFzUXqj6+Hm
         /N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NmsFFZug6fZbGbmv9oEK2ifng8RYaXuuuUd9qm9I4kk=;
        b=Y/pA0K87SbwoNHBPEpY8C1sjHwjRcQ3PaQm3zeG2AOzbQS4ZdvTmcrG7EqEJsnuMQ4
         IV+pfLtIrC9XiGLsqP2OOSj043PMqAGF+JfCSgCLEkSnT85q1GW2HlERvtNsBMZ4xwee
         lBZ/lH/F9j2UJC7joMRua4C282sRAjaCRwWws9Ry7EqnD7QMAx+LfwrpQpkGxwHQ8ZaI
         6lHacGjqKKIHSYKqfKAbPH/8mHDBSp5KDEnkXjPgb/nPAv/IKTSaHGmBncOzUewpmzpn
         xjZlQSuNngfdOvfwYBsvU0jhtTJwyxKW6Bfg6LX5JErhDWb8o+TaksDCLtKnASiPAGUO
         F8ug==
X-Gm-Message-State: APf1xPCt6ABREyggngR6TzSYSNfNfqRJN8Eip8Ne5VFuf7rhdGAdZhZK
        hgVAnmgMv4eklRMs76vgNvcZ4SFYW6SCXO/0dI0=
X-Google-Smtp-Source: AH8x226s/pCTyAVXwRBwqlC4CbWH/vmAgvN0t23GZ0L9ITf/42jBwVDiMMavExQySkgk8k16tndb0f4CAQP3P2Ygsqg=
X-Received: by 10.98.153.2 with SMTP id d2mr13157039pfe.44.1518473706914; Mon,
 12 Feb 2018 14:15:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.163.48 with HTTP; Mon, 12 Feb 2018 14:15:06 -0800 (PST)
In-Reply-To: <CACsJy8BjFex==2UQV6-k4_rTnBijJOzBAOmtNmZopc87U19Jmg@mail.gmail.com>
References: <20180124095357.19645-1-pclouds@gmail.com> <20180124095357.19645-4-pclouds@gmail.com>
 <CAPig+cQeQRppb2y4YyQnqWWnCO0TXE-PjfTAhxakCJNk45ec1w@mail.gmail.com>
 <CAPig+cRYL6-jEgsQoiQokNSd0zq5zoFkMHBA0Vp9kqa0LvMnsA@mail.gmail.com>
 <CACsJy8A+zMTC2N8Y0Ua-KyLF6Wp2oHL=8mbsSXck6mKZGG=37g@mail.gmail.com>
 <20180206021313.GA26323@sigill.intra.peff.net> <CAN0heSofAfuXEUKcfF00ni_a7nAKJYySF_UEnNTL8+nHiBzw-A@mail.gmail.com>
 <CACsJy8BjFex==2UQV6-k4_rTnBijJOzBAOmtNmZopc87U19Jmg@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 12 Feb 2018 23:15:06 +0100
Message-ID: <CAN0heSpxcm1a9KN3etWAD5Vc_gkabQmEppa_1P4soZSZOnP8pg@mail.gmail.com>
Subject: Re: [PATCH 3/7] worktree move: new command
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12 February 2018 at 10:56, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Feb 7, 2018 at 3:05 AM, Martin =C3=85gren <martin.agren@gmail.com=
> wrote:
>> On 6 February 2018 at 03:13, Jeff King <peff@peff.net> wrote:
>>> On Mon, Feb 05, 2018 at 08:28:10PM +0700, Duy Nguyen wrote:
>>>> I learned SANITIZE=3Dleak today! It not only catches this but also "ds=
t".
>>>>
>>>> Jeff is there any ongoing effort to make the test suite pass with
>>>> SANITIZE=3Dleak? My t2038 passed, so I went ahead with the full test
>>>> suite and saw so many failures. I did see in your original mails that
>>>> you focused on t0000 and t0001 only..
>>>
>>> Yeah, I did those two scripts to try to prove to myself that the
>>> approach was good. But I haven't really pushed it any further.
>>>
>>> Martin =C3=85gren (cc'd) did some follow-up work, but I think we still =
have a
>>> long way to go.
>>
>> Agreed. :-)
>
> Should we mark the test files that pass SANITIZE=3Dleak and run as a sub
> testsuite? This way we can start growing it until it covers everything
> (unlikely) and make sure people don't break what's already passed.
>
> Of course I don't expect everybody to run this new make target with
> SANITIZE=3Dleak. Travis can do that for us and hopefully have some way
> to tell git@vger about new breakages.

Makes sense to try to make sure that we don't regress leak-free tests. I
don't know what our Travis-budget looks like, but I would volunteer to
run something like this periodically using my own cycles.

My experience with the innards of our Makefiles and test-lib.sh is
non-existant, but from a very cursory look it seems like something as
simple as loading GIT_SKIP_TESTS from a blacklist-file might do the
trick. I could try to look into it in the next couple of days.

Martin
