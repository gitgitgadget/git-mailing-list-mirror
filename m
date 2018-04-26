Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAF51F424
	for <e@80x24.org>; Thu, 26 Apr 2018 17:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756767AbeDZRXF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 13:23:05 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35335 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753282AbeDZRXE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 13:23:04 -0400
Received: by mail-vk0-f53.google.com with SMTP id h134so16547274vke.2
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ddc+Yp88wBlQNMdII4jJfgfvJnJ0YJeHSE+YY6YImak=;
        b=MIUWpHBGz5J9W0lHCgGyaGqHT3LxC78pkAV9m5uAR1+9qAPO5zGAX+fYslOsB/NLJ/
         3YBrKKBdamKhfKSVY9vg2GJlBXqYC2yPiZLo4E3344ThbQCh2M+xkh0e+khTcoah4wzC
         q3GLfTdf42CkTeaADPDJNnBzWlM9zN/HjXv2KAUAAyNHkeueHMPosn9zqjYJz/CM7z5k
         UFSyYIkcb/B421g4q87xWtHC4KR0w/Gx709ZBzjGBgPy52A0eNVx4uDw9fS9QubkkWdE
         gmMJbIQytBZuegAk3IDYax/tAtq7+zKw6FJyimZDDfCL06ODp7kPqaDeYySklhyUjY1D
         MZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ddc+Yp88wBlQNMdII4jJfgfvJnJ0YJeHSE+YY6YImak=;
        b=oUUjP9nsYViEDLs3JM1XHEgLgADuKGm24QedZcjBr9tMWdG15sAzeU4D78gCAQeVTQ
         Z3DdyVoPxLx8uizoMktZOB0KYM/Dn2C4dm88x7oNRPG720jYdqYbabb+VYMTBEK0ZbeQ
         5JRDDr9OUWkremmJxMxyiDsDONwDm7dk8rpyErlLWPXX9CCT6gBhdb5gcXHuHktKxK21
         JslAkW5n4mFuPWHdJ/cD4DDtdDyZ+uMRbP0zFR0x4gbbDKRHuu5IHhgGg5nP7XAfV9MH
         qDeDs9vb1zyT0ROyjb0RHjxdcsqzFoC/aNlBYeyqhOAWkAuVW0wPLjJgM1l7GfIz2fE+
         Vd1w==
X-Gm-Message-State: ALQs6tCxkqm8mAMK1HuxamKuz5cWIq9lWzJnEpYkLMhkqNaET5xLvTMI
        qH0alLyKvCez9k4eweXP+eNS51RC5MlgSD7049Y=
X-Google-Smtp-Source: AIpwx48MBmE7w86+mA2j1XTetYHmlExmQdnH3IjveynB6lkx6TGHIMxwD0iQOEkAXZmGs9Z/8yLpynaVdYSTsQ2vmoU=
X-Received: by 10.31.114.207 with SMTP id n198mr24130480vkc.149.1524763383615;
 Thu, 26 Apr 2018 10:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 10:23:02 -0700 (PDT)
In-Reply-To: <94c6fa4d-afe0-5a08-f844-85d3c091d3b2@web.de>
References: <CABPp-BEe+BK6Ew0ZLnkgCn=1J6kyJa5VTaibuJOEVeDdgLd_Ow@mail.gmail.com>
 <94c6fa4d-afe0-5a08-f844-85d3c091d3b2@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 10:23:02 -0700
Message-ID: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
Subject: Re: BUG report: unicode normalization on APFS (Mac OS High Sierra)
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 10:13 AM, Torsten B=C3=B6gershausen <tboegi@web.de>=
 wrote:
> Hm,
> thanks for the report.
> I don't have a high sierra box, but I can probably get one.
> t0050 -should- pass automagically, so I feel that I can do something.
> Unless someone is faster of course.

Sweet, thanks for taking a look.

> Is it possible that  you run
> debug=3Dt verbose=3Dt ./t0050-filesystem.sh
> and send the output to me ?

Sure.  First, though, note that I can make it pass (or at least "not
ok...TODO known breakage") with the following patch (may be
whitespace-damaged by gmail):

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 483c8d6d7..770b91f8c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
        auml=3D$(printf "\303\244")
        aumlcdiar=3D$(printf "\141\314\210")
        >"$auml" &&
-       case "$(echo *)" in
-       "$aumlcdiar")
-               true ;;
-       *)
-               false ;;
-       esac
+       stat "$aumlcdiar" >/dev/null 2>/dev/null
 '

 test_lazy_prereq AUTOIDENT '


I'm just worried there are bugs elsewhere in dealing with filesystems
like this that would need to be fixed and that this papers over them.

Anyway, the output you requested, at least for the last two failing tests, =
is:


expecting success:
git mv "$aumlcdiar" "$auml" &&
git commit -m rename

fatal: destination exists, source=3D=C3=A4, destination=3D=C3=A4
not ok 9 - rename (silent unicode normalization)

#
# git mv "$aumlcdiar" "$auml" &&
# git commit -m rename
#

expecting success:
git reset --hard initial &&
git merge topic

HEAD is now at 1b3caf6 initial
Updating 1b3caf6..2db1bf9
error: The following untracked working tree files would be overwritten by m=
erge:
=C3=A4
Please move or remove them before you merge.
Aborting
not ok 10 - merge (silent unicode normalization)

#
# git reset --hard initial &&
# git merge topic
#

# still have 1 known breakage(s)
# failed 2 among remaining 9 test(s)
