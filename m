Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2345A1F406
	for <e@80x24.org>; Sat, 23 Dec 2017 03:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757267AbdLWDP1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 22:15:27 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:42974 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756885AbdLWDP0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 22:15:26 -0500
Received: by mail-it0-f44.google.com with SMTP id p139so16216558itb.1
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 19:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=93R96vOjUtmWy2ScnMkBYWMOcdqmgKD04FEKXSEJV38=;
        b=G8emjB3oRe6yip+y3dVc/3zocaQN/hFApn6W55bfRzyAFlGlsaJCHIFRH6TCqIThJz
         QSvbf99EkT/mUCslo1zeyiHoaezgTQktfa8mc6xtYyXBe4aiSZTFMEmXLkL4tBuUv/kD
         v53rzUnQvsCbFyuCH47gkepUuS0wMznA+8NLqOIEuq2ZQGnvkCh0Fkz1AkJjnDRCKRB8
         62d5+l2P9O5chge4CQkYjK5kFLXy8B+yHzkagZle3t9OADiuNlUWJYb+Qo6HIPrlRKCC
         QvqofZmwNbbBGTcgvx94kvoaj8C1YUaY54qTsGFGakc+hEtVd/gBFSu5QBG5cgQaK7at
         AD9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=93R96vOjUtmWy2ScnMkBYWMOcdqmgKD04FEKXSEJV38=;
        b=tmODgKiDCgJXOSzlHaZC1oSepfia7I5+ZbcX8YyTwFMVOj4hQKFX2Ey0ruFr81mmSf
         N4R4ymFPQZ0AtfqPk26u6cXWxFe44jPvfVSQMQ3I3lgwNBW7ljXdH8934INQ0jl51TjE
         JbJBK6l/5JxAuvUXeaggV8Ve1WPEuv/lfjNqxU+ITofQkO8+/Ku1XUxmZ78pB1ntgmKb
         WEu4qTgen+tNJVGWc8i87x4RP76n3ThtrPXFxHNQnh2tsjTCXdMiEP8DVLyACYZ3e4i+
         Dgmov414S3NYQLdZ4Iohyk9WLQrbzVxqS7hKTqzEg7mlQNnPlZK2fQCnNsKtQFYuXUPj
         VfLQ==
X-Gm-Message-State: AKGB3mLV4o51zSlkxoJ15SRMp/aB0r8fFfUJsdq0GDohT6lzW5JSEWkL
        Ls5GrUmuQe44y8Kun/kfFTuOPB8VWn5aa1i5m9Y=
X-Google-Smtp-Source: ACJfBotGe+oKaVKUgjuxDc4v4uNb0CQ4Ya+idfuHEmQKRhypVXH5mDeetLw/dOJHHgHQTcdv0xll7J9ZnpLyvf+1Psw=
X-Received: by 10.36.84.143 with SMTP id t137mr19948969ita.94.1513998925537;
 Fri, 22 Dec 2017 19:15:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.107.150 with HTTP; Fri, 22 Dec 2017 19:15:05 -0800 (PST)
In-Reply-To: <CA+P7+xpt1cW-uokayYFJ5cr88FKBcn_RT3v7iLHyu7kZaS=wbg@mail.gmail.com>
References: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
 <CA+P7+xojknncFrP5qCB4EKG0MAoTUqFWS5g3Bj+Jq2_RO0fA3A@mail.gmail.com>
 <CAEW+b66pCqTBz6o_aTK0byyKsDc8HRfHuqKf64Ob6pBtL9w2Lw@mail.gmail.com> <CA+P7+xpt1cW-uokayYFJ5cr88FKBcn_RT3v7iLHyu7kZaS=wbg@mail.gmail.com>
From:   Anatolii Borodin <anatoly.borodin@gmail.com>
Date:   Sat, 23 Dec 2017 04:15:05 +0100
X-Google-Sender-Auth: AiR6is0TdHeAW3TedqHo3TPD9lM
Message-ID: <CACNzp2mdEmAj_6an-4is6_1LnqAZs=huakJhUQrJ+DxyJWY0mA@mail.gmail.com>
Subject: Re: Usability outrage as far as I am concerned
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Cristian Achim <brancoliticus@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob,

On Sat, Dec 23, 2017 at 12:05 AM, Jacob Keller <jacob.keller@gmail.com> wro=
te:
> If you wish to update it later, you can mount hte usb stick, and then
> just run git pull from inside the new subfolder. Note that you do
> *not* run "git pull home_subfolder", as git pull expects the name of a
> remote, which in this case is just origin (since the default remote
> name you clone from is origin)

From git-fetch(8):

       <repository>
           The "remote" repository that is the source of a fetch or
pull operation.
           This parameter can be either a URL (see the section GIT URLS bel=
ow)
           or the name of a remote (see the section REMOTES below).

You can run git fetch / git pull with a URL or a local path to a
repository, not only origin etc.


--=20
Mit freundlichen Gr=C3=BC=C3=9Fen,
Anatolii Borodin
