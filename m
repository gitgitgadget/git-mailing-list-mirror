Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E8020D09
	for <e@80x24.org>; Mon,  5 Jun 2017 05:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdFEFsw (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 01:48:52 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:36002 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdFEFsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 01:48:51 -0400
Received: by mail-qt0-f170.google.com with SMTP id u19so14673995qta.3
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 22:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hWxZErIHchTpEmoKIz/DJwnxY6Tt766co+Anbd5A+1A=;
        b=BObI+lZ5vaVsHhBQ9Gu0GbSngzOvTNNjvtcN93nBv7tlfKXeHKSyoDPMaNElTLcYdN
         rPml20Ff/vdakN/dmvNR0uviQseY2ZTgPNKTaZKi60smsZjzYYElz285c1SB8kh8hWDI
         8bV6Pozq9J849BqOx4PbMhxxPL3LyQ2K3Zs/9+uA17aIOw7w1z4uvxmw9orS3RbUFSM6
         yuCIxuzj7OGL8djXhPlrd2ql98/LpZOjOimsE7mibzc64xROsC+m7ZNo+c0PXh0OnQAq
         Y8v+uo+cTjOtOMNEwJr6NNOaMQIrMm5WP9oTc1vwa34QXh82650GN3HEcSK0GxhQ0XCd
         2bIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hWxZErIHchTpEmoKIz/DJwnxY6Tt766co+Anbd5A+1A=;
        b=sSuxgFbwL6R3YUQI0/n0EZTxpo4lUvRGN9Mnb1rYcOCQAdjQsHtbR9fQHiXYPbmRJK
         K8h0SHXgLFBlZAlEROOtgf5lgjVIIAWJgPTTiYuW5FnskFQLV3ypcs6yVa2RJ0WbPlYd
         zLtiLIpmJeo78m3ZKpKkp0G5qqr4t8ZIKhYKnCjMZMQeAZWurmAbMqv13zBxsLXrB5Tp
         ykI1Dy2stL71oA797bEhpZCj27qvAw33cI66ICurM2nD2I/2q4rNEOud5gRCW0NSTNCB
         nebnygUbk5jy6UWRGL2wKiR/nHn19R28dBHWgq3Gx1jMYzkVAPT5m+C9KqA88MOvilZ6
         Sc7A==
X-Gm-Message-State: AKS2vOyAsqONRqBuSCxzxCh/cR41bQ5/mf0KDgyqeD+Dqj+4WRUBz871
        Va+PHns13exwgJadTu+PxKOIQugbjw==
X-Received: by 10.55.140.193 with SMTP id o184mr4941036qkd.127.1496641730203;
 Sun, 04 Jun 2017 22:48:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Sun, 4 Jun 2017 22:48:49 -0700 (PDT)
In-Reply-To: <xmqqefuzurj5.fsf@gitster.mtv.corp.google.com>
References: <20170603221335.3038-1-avarab@gmail.com> <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com> <xmqqefuzurj5.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 5 Jun 2017 07:48:49 +0200
Message-ID: <CAP8UFD3-=sDQ2PEExLq_A3v5d8w8PJ1aLgBNP725mGHzocuqqQ@mail.gmail.com>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 3:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Realistically I'm going to submit this patch, I'm not going to take
>> the much bigger project of refactoring the entire test suite so that
>> no test runs under N second, and of course any such refactoring can
>> only aim for a fixed instead of dynamic N.
>
> I do not expect any single person to tackle the splitting.  I just
> wished that a patch inspired by this patch (or better yet, a new
> version of this patch) made the tail end of "make test" output to
> read like this:
>
>    ...
>    [18:32:44] t9400-git-cvsserver-server.sh ...... ok    18331 ms
>    [18:32:49] t9402-git-cvsserver-refs.sh ........ ok    22902 ms
>    [18:32:49] t9200-git-cvsexportcommit.sh ....... ok    25163 ms
>    [18:32:51]
>    All tests successful.
>    Files=3D785, Tests=3D16928, 122 wallclock secs ( ...
>    Result: PASS
>
>    * The following tests took longer than 15 seconds to run.  We
>      may want to look into splitting them into smaller files.
>
>    t3404-rebase-interactive.sh ...    19 secs
>    t9001-send-email.sh ...........    22 secs
>    t9402-git-cvsserver-refs.sh ...    22 secs
>    t9200-git-cvsexportcommit.sh ..    25 secs
>
> when the hidden feature is _not_ used, so that wider set of people
> will be forced to see that some tests take inordinate amount of
> time, and entice at least some of them to look into it.

I wonder if splitting tests would make a good GSoC microproject for next ye=
ar.
