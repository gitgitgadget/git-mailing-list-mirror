Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A6161F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeBTWWN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:22:13 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:45567 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeBTWWM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:22:12 -0500
Received: by mail-qt0-f177.google.com with SMTP id v90so15674647qte.12
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=yAb1gOfdWe79FVzI35e3UBNXZSxFyUBB45a+AGjrK5w=;
        b=brqg5+Lnz0UXmzawOLHr3kcRA/rPpEY0lfYWhKakWZlGNzzMo/doZuj1mb7mro2bGk
         iNA+AW1y3loAHp2dss05EhIxfmFg+pP4UEK2QDtotm2BqnnrDHL4kuEo2ct4IDYQlEXh
         x1c2MbzimEZcc41BhFPKQ5tKI0kBGlnZhKQkMS4RaxYXFiJq3Fywh7nz62OcBtqB2OHo
         SFmTcZxF68xaNk0n1S66G8vzdt+NYS8Ww9/m+yLTFPGjtD5Xk4y/qQUqjg18Nq3qaUF5
         bQQdQIWjRQXnT3+inX/gRSBCshOGMoRMi6uk0YmmnE0Cgx4sbTzUEQ7qr63ALoHH0EjM
         5k8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=yAb1gOfdWe79FVzI35e3UBNXZSxFyUBB45a+AGjrK5w=;
        b=Q6H1zd2qtMilcLSg/7m0BAf+uiwF81ZXjLSLdO3ygljffe03Sd7eERqsVPo04FWB/c
         zaiaz/4GfZapyoWN3M6iAT0TzEcpX+uSI0EsKT1rakJfHPJ8QobxaJuYCCr2tJK9yU/D
         +I+lkWTWSjMCSizdl0VU8F+Uvga5xXVmN4FJH6yFQksHxBumC260wgMoJGGhmeU1TRxE
         uK3S+nF6eKgLxfheHuVN3PdqCDpbiIujbc2i6HVMYP3UHAg1f2uqUHI9gnJQiupdV1tw
         oOHtih+52MeWqYXgxcxHcQFx9Xq6S8ClcPzi5XlNQJQMIEP/pu265I7mcxR+/tdZug+L
         y44w==
X-Gm-Message-State: APf1xPD8w7qrz5RIo7fmu4BsEufQcU971EhvlFFq47BTYFlf4Ax8ppkt
        537txe9trmkNmKCuoz1bFllU2KtOTws+rfzcSnk=
X-Google-Smtp-Source: AH8x225GVuyMhyhxd1NNUkj1OoQPoJfoHK/WkSNCzN5CTzL5xbcMf/lABv9YoN8+Tj8MX+NbzmZZsOxOK6okVjrvbK4=
X-Received: by 10.237.51.38 with SMTP id u35mr1996821qtd.205.1519165332037;
 Tue, 20 Feb 2018 14:22:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.143.26 with HTTP; Tue, 20 Feb 2018 14:22:11 -0800 (PST)
In-Reply-To: <005301d3aa8a$80521c70$80f65550$@nexbridge.com>
References: <005301d3aa8a$80521c70$80f65550$@nexbridge.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Feb 2018 17:22:11 -0500
X-Google-Sender-Auth: npKT22g_tt9QaKxjjVXkYsu-gWI
Message-ID: <CAPig+cTHTZT2vRBYbdAgeVg+TDuo_C=mXRXYX4o094VmtygxRQ@mail.gmail.com>
Subject: Re: [BUG] Worktree prune complains about missing path
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 3:36 PM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> I=E2=80=99m a bit confused about this, as I thought I understood worktree=
s :(.
>
> /home/randall/nsgit/test/test dir.mytest: rm -rf dest.wt
> /home/randall/nsgit/test/test dir.mytest/dest: git worktree prune -v
> Removing worktrees/dest.wt: gitdir file points to non-existent location
>
> It seems like one or two situations are a problem:
> 1) I=E2=80=99m using a full path for the worktree.
> 2) There=E2=80=99s a blank in my path =E2=80=93 deliberate=E2=80=A6 tests=
, yanno.
>
> This is git 2.16.2. Could anyone shed some light on this?

This appears to be working as intended. "git worktree prune" is
telling you that it is pruning the administrative data for the
"dest.wt" worktree (reason: "worktree location no longer exists"),
which you intentionally deleted before pruning. It's not clear what it
is that you find confusing. There is not a lot more I can say without
understanding what behavior you were expecting and how your
expectation differs from the actual experience.

(Also, please consider how easy or difficult it is for a reader to
interpret your pasted "sample session". The one provided is more
confusing than necessary due to the command prompt bearing the same
path information as the output of the "git worktree list" command, as
well as unnecessary duplicated commands, such as "ls", and missing
"cd" commands which do not help to illuminate what it is you are
trying to get across. The pasted transcript also contains invalid
code-points which render as oddball characters -- or not at all --
which didn't help. Best would be to prepare a minimal example of shell
commands to reproduce the behavior you're trying to illustrate.)
