Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9718A20951
	for <e@80x24.org>; Fri, 17 Mar 2017 17:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751156AbdCQRLV (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 13:11:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35609 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdCQRKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 13:10:00 -0400
Received: by mail-wr0-f194.google.com with SMTP id u108so10317805wrb.2
        for <git@vger.kernel.org>; Fri, 17 Mar 2017 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SMWMr9FgY494xKUnc97eb3/fCsvxV8iQCiKJvO5ZZ5s=;
        b=YqeQIyAyBcY//kls/p7/D30D4T0yJwtC+OeVu4b0EtG8zcSIHAXfB23kHLiCvVNUxy
         XovNCN76ei8GDpn+zyLEVgi4BrAJKZAVjI/qkm4dUPiRfXFRwfwNTg/nO+rBQ/Eh4D5q
         2RXbtSD1GClrKPURXhUrASGcqQWIzEeEmhNOnBHDzMHZO0PbCVoAIx4uU6R5m27Q6ru4
         jqwT7xyiNDHrhAR/AXlYRwYChNrycy2f6zNksogjgVyZTFWGdttAW7kE0tUfY2NiLBg8
         w/88dQtCvxDJv4f2dOXpZ61B/j10XaX/lMlE/3M1SHhnHBWrArOxXrvungTh1FQSzwyt
         LH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SMWMr9FgY494xKUnc97eb3/fCsvxV8iQCiKJvO5ZZ5s=;
        b=S0/IYtZrjTUbg92ede5V/iq3697MXjhNUtVbGe2+Xu0QVvIwyfbAVldsKrnfkD18Lg
         z6bRGnDDOZwN0anC4BlWijs014CuBdhziC7y6ORZpkIzA7yO+uFjufUtuJTg+D3CgHGM
         PCwkgg4DMaxQagLD1Bdyw+IOAt0P1Q+7UOhnZMW0lY/JHOqnuahPzzMcYZlgvqpiO136
         0UvMLXSYWnL9z3f48QsgCkBZVrN0nBrpWJ5Jf7eoZJc7hzoDDi+ykU1djlTNIQKcSddV
         Y2KT6u+yPjF5FJ6j72xHykhuM1mCwiD3mg6NbDOG50Bhh8V2l0c9E9P/BlJkMqYli9XF
         ZNYw==
X-Gm-Message-State: AFeK/H1NRbmJ4vHGYd9IHawebl1lPzp+NpP/y27560M1sahp0Tqt7ob+dt8gABTulXpRMA==
X-Received: by 10.223.149.66 with SMTP id 60mr13640595wrs.29.1489770598175;
        Fri, 17 Mar 2017 10:09:58 -0700 (PDT)
Received: from sin73tkty1.ads.autodesk.com ([132.188.112.190])
        by smtp.gmail.com with ESMTPSA id u11sm10675072wrb.45.2017.03.17.10.09.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Mar 2017 10:09:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use committer date to tiebreak
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqshmc8n09.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 18 Mar 2017 01:09:50 +0800
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Luke Diamand <luke@diamand.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <015A7026-960F-450C-9276-AAC3A0B11207@gmail.com>
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com> <20170315225045.15788-1-gitster@pobox.com> <20170315225045.15788-3-gitster@pobox.com> <9AE7ADCA-97F9-4857-AC55-76C4BD822C25@gmail.com> <xmqqy3w48nif.fsf@gitster.mtv.corp.google.com> <xmqqshmc8n09.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 17 Mar 2017, at 13:56, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>=20
>>> A quick bisect indicates that this patch might break=20
>>> t9807-git-p4-submit.sh 8 and 13. I haven't looked into
>>> it further, yet.
>>=20
>> As I do not do P4, help in diagnosing why it breaks is appreciated.
>> If the test script expects...
>> On the other hand, if git-p4 command internally uses name-rev and it
>> is not prepared to properly handle commits that can be named in more
>> than one way, the problem would be deeper, as it would mean it can
>> misbehave even without the change to name-rev when multiple branches
>> point at the same commit.
>=20
> Yikes.  Perhaps something along this line? =20
>=20
> This function seems to want to learn which branch we are on, and
> running "name-rev HEAD" is *NEVER* the right way to do so.  If you
> are on branch B which happens to point at the same commit as branch
> A, "name-rev HEAD" can say either A or B (and it is likely it would
> say A simply because it sorts earlier, and the logic seems to favor
> the one that was discovered earlier when all else being equal).
>=20
> git-p4.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/git-p4.py b/git-p4.py
> index eab319d76e..351d1ab58e 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -582,7 +582,7 @@ def currentGitBranch():
>         # on a detached head
>         return None
>     else:
> -        return read_pipe(["git", "name-rev", "HEAD"]).split(" =
")[1].strip()
> +        return read_pipe(["git", "symbolic-ref", =
"HEAD"]).strip()[11:]
>=20
> def isValidGitDir(path):
>     return git_dir(path) !=3D None

Following your explanation this patch looks good to me and this fixes =
the
test failure. TBH I never thought about the difference of these commands
before. "rev" and "ref" sound so similar although they denote completely=20=

different things.

Thanks,
Lars=
