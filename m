Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 215E21F403
	for <e@80x24.org>; Tue, 12 Jun 2018 21:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934464AbeFLVyB (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 17:54:01 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:39949 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933793AbeFLVyA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 17:54:00 -0400
Received: by mail-yw0-f178.google.com with SMTP id p129-v6so179410ywg.7
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 14:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=92alqAHVc5KP2b1kX9C9TU5pu4506q4AwCDXu2aKPLo=;
        b=uQDXtujaEyHBqYOL3HNRFCDf6/j0IlFDcvewN2q7REcjABo3kxH10fB9h9XjoEI1JV
         zedZKcBtZE2z7wW4emdPNa4qfzilZYPt0TStcDwmFNuWvhNppqKpgxRE7VHbNVr87kyr
         AfcgI4TFt6aQb3KOXck75H414amXjE9+TRnEF/9BCC0kDYctSvr7sKF/6hDfvDgX0Y6w
         unFomjnEazCT5HVwKnRWpNFm2zELsfLB+UMrjTWp9Q41W+kg5PUkKMkaz1/zooFip1MV
         qJLGfn8TDMD95KDUIaULktl5w2WwPFlXtFHMx+myg4hLixjF2h0zyGkOTUsVg1Wh0uPh
         f6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=92alqAHVc5KP2b1kX9C9TU5pu4506q4AwCDXu2aKPLo=;
        b=sY2G0/1E+cHufjlPFJeFPA2+HuH4hJmsEP+Gc9u5EcSMuicxPapWb2Hr2fBsPnNG4R
         9NyEZqMPqObIyDde1C28tHf9YKR79DGKjIFJCuZWnKYsquwIRl3fskU9h2YWQbQedoJ7
         uaEcVRuebPZ3P7Il1bBQIOmuAoOA005VHzvR08FN3rVtojEdxIxa1KvGQLaLaTsnCWq/
         OiPiHcTTd+nbr/OEOLM30AZ2nvsDLEpHuB0iWm02ST7FAmXa9nYKsrCWRoBvebSd/kt0
         QccCA8f9pyGNngvIecaa50DCV0nsPBzgur/mPmOfruP4jPoqiHo5l8sF4UCFVgIOcKIw
         aU8w==
X-Gm-Message-State: APt69E1GonUXlHO0rvFylVIa330WLbM4Jgts7e8AVKBsNwNTzKbWmYsR
        PNBV6EUw/Af4/xYj/JWVh6EshnJlMmH7bjv9qks=
X-Google-Smtp-Source: ADUXVKK70hCexJRlT7vtgTC0JAkBS9VeCQweYjDqX7t0udl1+Op03uj1zvxVjTX/VohgIcg4/NbwXR09YCeoVVDialI=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr1085037ywa.16.1528840439588;
 Tue, 12 Jun 2018 14:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:3dc7:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 14:53:59
 -0700 (PDT)
In-Reply-To: <CAE5ih79NoTpbkU50tts2GgLJ7Wy9WyBUgJncm3KXPLxuy0P0hQ@mail.gmail.com>
References: <20180608203248.16311-1-luke@diamand.org> <xmqqo9gg9bi3.fsf@gitster-ct.c.googlers.com>
 <CAE5ih7_ZDzg9h8BEGDWyg_jBG1rj=_eW1Kg7JO7oKiF6Q2+37w@mail.gmail.com>
 <xmqq7en38z8o.fsf@gitster-ct.c.googlers.com> <CAE5ih79NoTpbkU50tts2GgLJ7Wy9WyBUgJncm3KXPLxuy0P0hQ@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 12 Jun 2018 17:53:59 -0400
X-Google-Sender-Auth: 4PNv3Cz3P-Hvsls2bn56eh72OvU
Message-ID: <CAPig+cQg5XE7peXDC-q0mkB9y6boK_iiM_55O6Po2PVmyZNLww@mail.gmail.com>
Subject: Re: [PATCHv2 0/6] git-p4: some small fixes updated
To:     Luke Diamand <luke@diamand.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Git Users <git@vger.kernel.org>,
        Eric Scouten <eric@scouten.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 12, 2018 at 5:49 PM, Luke Diamand <luke@diamand.org> wrote:
> Thanks. While on the subject of git-p4, I thought I should mention
> that I've been looking at getting git-p4 to work with Python3.
>
> I've got some low risk easy (mostly automated) changes which get it to
> the point where it compiles. After that I have to figure out how to
> fix the byte-vs-string unicode problem that Python3 brings. [...]

See how reposurgeon handles the problem[1]. It defines polystr() and
polybytes() functions which coerce strings and byte sequences as
needed. It's not pretty, but it works.

[1]: https://gitlab.com/esr/reposurgeon/blob/master/reposurgeon#L100
