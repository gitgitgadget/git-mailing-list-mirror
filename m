Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A150120A1E
	for <e@80x24.org>; Sat,  8 Dec 2018 00:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLHAKH (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 19:10:07 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:38409 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLHAKH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 19:10:07 -0500
Received: by mail-qk1-f174.google.com with SMTP id d19so3480304qkg.5
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 16:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=rCBcn5jEy6xuJWuWIH+CDzYznCAeTOuoudzTorZ1IZ8=;
        b=KTNz7ZYwL3kJU9mKP8WNSDiUXHPapq584tB46iHnU1H6I15TtYlSHwAD3WLUk1/c5M
         GSQOJmNU4SxEqbURcTs8MWs6XxCMUZDfHSCNnGMGdjm1kZQMCrIeZi0EPTLN61JiGTst
         SuNmwuQT85YHgB2hnNxHX9w8Ej1Qh31Rozo96tjgn0s28Y0Z9witNqRUm8XGyCmmhYOi
         AsKvZ1aGaseLswCxxkX3yMRfdI8qi2rfauF87XuA4SFI+/WKebiYsgBaCqhZGbSwShQw
         RuajU2JLmGrFwEg2dqM5xQxhmxI+MIvaan6uhiC5lYhob1qLHZTpyhqSLNpKahd7wKbQ
         tJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=rCBcn5jEy6xuJWuWIH+CDzYznCAeTOuoudzTorZ1IZ8=;
        b=s5x2MbI3c3ugW6LfmIXuDrQKHfK+ym6JWKiQjZHoSA2Ss7zqi3Tcb0WCF9r48eWo2E
         QSpzJdafaK97YTIYKmRNOZ0V1r0yV6YOfWjgIqVmk0Usw920IrwErZhFugZU8teaWjx8
         Z4nwDt0yq1GzWq3S1Vd0P5YlH/4p4OKI2Sddam3mDJrfk2d5PgYf8kRC5L/S9ozjd7Vr
         7N7xblCwH3UWrrHzeO3JQc87rCpVtzICccueldASZWrGRz+ADNEZ2xsXQiHqSJ0F/ARD
         W9hOj20deAaAwhxANiPV5w54F20uQl+cehed/C1h2pwK9qL8DBgpm/esIZykyhHl+L6r
         5a+A==
X-Gm-Message-State: AA+aEWZKPDQk6eRNWkSOH6fbzdnjp4j5hCcwLaIDz1ThSjvUXfwTDq/3
        cXKTp8bpzB3LRb1olxp8ch0WjyMx
X-Google-Smtp-Source: AFSGD/VNZJwBtCs6UwRb+d6olGdej4tuU9IrqGyicA5MJEugBYgeJw7CORKAi+s7/PwDMfjSqv+rVQ==
X-Received: by 2002:a37:7d05:: with SMTP id y5mr3512631qkc.310.1544227805762;
        Fri, 07 Dec 2018 16:10:05 -0800 (PST)
Received: from dyn-160-39-175-117.dyn.columbia.edu (dyn-160-39-175-117.dyn.columbia.edu. [160.39.175.117])
        by smtp.gmail.com with ESMTPSA id b8sm3690045qka.79.2018.12.07.16.10.04
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 16:10:05 -0800 (PST)
From:   George King <george.w.king@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Difficulty with parsing colorized diff output
Message-Id: <799879BD-A2F0-487C-AA05-8054AC62C5BD@gmail.com>
Date:   Fri, 7 Dec 2018 19:09:58 -0500
To:     Git Mailing List <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I have a rather elaborate diff highlighter that I have =
implemented as a post-processor to regular git output. I am writing to =
discuss some difficult aspects of git diff's color output that I am =
observing with version 2.19.2. This is not a regression report; I am =
trying to implement a new feature and am stymied by these details.

My goal is to detect SGR color sequences, e.g. '\x1b[32m', that exist in =
the source text, and have my highlighter print escaped representations =
of those. For example, I have checked in files that are expected test =
outputs for tools that emit color codes, and diffs of those get very =
confusing.

Figuring out which color codes are from the source text and which were =
added by git is proving very difficult. The obvious solution is to turn =
git diff coloring off, but as far as I can see this also turns off all =
coloring for logs, which is undesirable.

Then I tried to remove just the color codes that git adds to the diff. =
This almost works, but there are some irregularities. Most lines begin =
with a style/color code and end with a reset code, which would be a =
perfect indicator that git is using colors. However:

* Context lines do not begin with reset code, but do end with a reset =
code. It would be preferable in my opinion if they had both (like every =
other line), or none at all.

* Added lines have excess codes after the plus sign. The entire prefix =
is, `\x1b[32m+\x1b[m\x1b[32m` translating to GREEN PLUS RESET GREEN. =
Emitting codes after the plus sign makes the parsing more complex and =
idiosyncratic.


In summary, I would like to suggest the following improvements:

* Remove the excess codes after the plus sign.

* When git diff is adding colors, ensure that every line begins with an =
SGR code and ends with the RESET code.

* Add a config feature to turn on log coloring while leaving diff =
coloring off.


I would be willing to attempt a fix for this myself, but I'd like to =
hear what the maintainers think first, and would appreciate any hints as =
to where I should start looking in the code base.


If anyone is curious about the implementation it is called `same-same` =
and lives here: =
https://github.com/gwk/pithy/blob/master/pithy/bin/same_same.py

I configure it like this in .gitconfig:

[core]
  pager =3D same-same | LESSANSIENDCHARS=3DmK less --RAW-CONTROL-CHARS
[interactive]
  diffFilter =3D same-same -interactive | LESSANSIENDCHARS=3DmK less =
--RAW-CONTROL-CHARS


Thank you,
George

