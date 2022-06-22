Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D33C43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 19:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357783AbiFVTdz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 15:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359376AbiFVTdP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 15:33:15 -0400
Received: from sonic317-20.consmr.mail.gq1.yahoo.com (sonic317-20.consmr.mail.gq1.yahoo.com [98.137.66.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A76640902
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1655926232; bh=06Pa9koPYHdfFYl7ZXw8Pf0g4ZY7+Cduuai6uQIE6a0=; h=Date:From:To:Subject:References:From:Subject:Reply-To; b=g0DV9CwMe/fOTMbnRQcqJOG8v3e3AxyagvJcodDCMQ3zzhp6YxeF8oySh2+NhSIb01V7qrpLbwAPQppvgcU4t3FxzwouFgcU5f2z856H5g8CiWTWK0oSMGIRRSMUwNTdXR7VPAFvcEftKMggcblk9LAhdL7j5C4M4qe/ddBtfI7TzBCOLkCVwoDPmRGd1AZAiqXWKwjMOz+RgAI1J2l1fJgAGzCkt667+0UxaUfByrU+/tRfOg04k2cNLqBLqCntgKOeRLxNCQrpP8/18ADZo4zen3jgTFuecDIQALXp1m+GjUqXKW8s6GYGdY+5jA670jtdh9vuUN+YWiYtQHqP6Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1655926232; bh=H7MbeDIGSWjGA7wLH4hULic7an49z/4dol5+itEUo6F=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=bslWjDdNVCdxzGqGu7n4+Jp+6d6Gzzsuzhj79bg+HNuuOk4NPQ8lRdlYZ+Y2AxrXv/23BV5lGYw6fbtnw3L1eUsnl430jtC5LGvEtM35iCWptWdVVYqJnLPae8EJxohiVk9abDeil7hYPjQpkv4yhNhR0iOG1tAVA+yZt5+Y8F9quI8Re/0bYYDg5XFerWTSb+2LttBwmhO7NDVac8Xqmtuu+RJ0p7KoLVV5rd76tKcSZ4YMHhnehYN99WpDCo1QzHi9/zrzL2/i0RYpiy+1L3dTWJZ8p+xOPNM/LI87OeUiW5ELJCmtKWFgt2nzrHVAa8vh7uxlG2c/kTmzSQtNVA==
X-YMail-OSG: gMpgg04VM1lLsnmCF0OJ0Ma4ZO9hECDAtPyNiiSQxaQFc5WhDJah80gvyXg_SOZ
 oZKgIGXV6RVseaOqYfv0zowAnCP1LvjvBjYfeKvMvVGI2onJFhsMLhNtGEL1kFGsmOgkY34ptJNB
 oaa0flLom_AFB00IM8md.K0_7hwHYOkYrscfko3wr9dOYzIxLtifh7Hygm6F7ScN4ROSqVGEEYY1
 ruvy2wNK3shTs0.lvSvDQzvKn0bpKTfBPumhSgw40VH1Vqus4ISZ3P8zM.jw6Z6Uk6cjoxTp5zTl
 tGClBduYgnJmyR0S7hggr1XXyTHSrjJaP2Ygfxo.sjyoL5SjHuwcKgq.zz8gvq3kXsvySqinap5T
 .3nRaHZzqafiyRwTAH9v3EdQ3ce9HyU2dLCnG6UR3cfofCNlkJeDAl18yjBXeUu_abFR8ydijQ7Q
 GZLzOzFnvpE7FRMuxHANQNtuqiG6YekgEO5ddTtwCm2m8ZEoxTUJujySrMB1vaeqg90yH1IeY4Q7
 1.R35YgpOUZQsDfgbjusqSc7QcDLrkFTzJgCSGEE4WnAEWeLKfWYAZaOeKtGkoTpoLtP5LCVBDdg
 4YVFLT2BLXJ0euhyb5cXVncacXmTBeCt645GTR.8adW488pzhcQ9raiRTuwvNJOVPuyWz5JsgwQN
 Itn2_cRgBhPb7kmKct1lKjDg9an0mjDCjYEAxo75dtzsSw6R2Sb24e7vvoba5xlG9G.lSwRx4eLH
 WoNc685ov5HiH.cCIR.5Xo8oQ6hTmbkuw2hwcl78UlX0Ef8xBffUHlamrrjGQdidoGWn1oJyu4ML
 md7ABiRrZtsjMkdQBksYpv92qvv3EgujkhMx2JaRKDa0vaUYY7qsNkqcUC03whTlKJv8bYFrsy3z
 joDnzHSgFdSDeyivLgSXkRVxz6huMcBzMX2eUgwOJWxY6ulERDxaRDENXNIYhiQPSa16.6UXKgAD
 38ZMgbDYipFLBi.omIUXRblg2o_nezCDE2NgS.NOROMV4jJ30LrMlmHSB0CpyXIaICvQREK0ogZ1
 c99HXgfdHiqaW3.lq_a5LYERCnga9lfBt9KC.OecQaa226VZkn04ZP36LcL2Dxxw7OM_.s6zUUlt
 3b9eLHxA0n0Wt.oJ1eCqQIcBbLsohR1I6VnvLYn2.8QU2Pbzf0ErdeL2VSGBmOjKoM6AzTBO6rcf
 EMryfiZm3BpuStU3xV8pCxpZ80g1gJzXnZV_R1TqSPCQgdw9awv3.kAOqulvbG7Lax_nzEUDg71Q
 eebwprRu0wJJdd1BNydCfSLiDwf1p5A6AyWMNyWWrzlF0.hIHp.nYUWczRPy6wlYIQE.J2LVOGPg
 JM3ixq7RGP9xh_i1KLj2PiFnK3URen74S7Jpj7ZcSaO02sJJA.ukzjXEcre1kR3zVoOQpr_wRROS
 EDE0F.n68APSIQwt8WIroz2wSIr7Lo.yS19u4Y9ZF8vzQ1FL6EWrmefgCbxN7APKdlWqxK.4qNSC
 hYB4yvKSapJxfIHdTlyLc8UFjmym3UvuJZP6QFXoMKOKGg8wx_6Ub7XjrgV6_6i3SbgjcOjQI5Ig
 mR5evZajcwC7wmzQhRJJNxXr1XO3C2wjW4LYguRqAqWNJiEfCc2OFgh9rriAbyh2Fpx2.FLllHiT
 XXsIbjjy.BgOI9z0QwQxqKPLOAxYd6vJTqYv5dXHuTdSoA2GDZQKrR.Qe_8F8lSSmiC_VQVCwcLo
 UJMiPKnvBXqnVLXRkvrQVhiCg1PqUjvHQVvtGzpM26gE5PgESm0p3aQ9aElAhywqAdjICWjBgz7T
 Rqc.YQlqNiwogLK9qGMoF.7jwB79i1m_GZAco.HdEw8n1q4RLdK87vSF6ZsbgGYSKvblE7LNh13p
 1hI5vlTgvm0fS1BHbMYR5ihYKkAhN7rQmccGPKl1PK2SiZsWlgSGPsPT4QJDJzFCKazY39vmFAmI
 RjDbUL_WHP4pm785yU6kRGK.y0q_MQQBU7wSpWe0IfD5fI7YqE7Py9depQzwFew_uhla41zlSb0F
 GD8djFeqv37GN58Bl6T_xu5wg47MlBqjBYRpiAGWDgWJwlrEFVT0YIvKOxKzG8hQjGBNWbfZji6i
 WevTdW.D_ORhYwyKoN16rHR0AGyD0NrMAzj4gRyBUIwXgHMSxc9OHOc7fqPMcBC3IdXwpfrNWKdw
 _f4E4WjN4FYakUPhrn0FCswvpqrOTPsaBBtAUTIVcRrRKFjbrlGsYP9UnK4E7MvA-
X-Sonic-MF: <foley_tom@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Wed, 22 Jun 2022 19:30:32 +0000
Received: by hermes--canary-production-sg3-559fcd5995-zgdgz (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f599fe10fd5f9909fa364cf6ddf673d8;
          Wed, 22 Jun 2022 19:30:29 +0000 (UTC)
Date:   Thu, 23 Jun 2022 01:00:25 +0530 (GMT+05:30)
From:   foley_tom@aol.com
To:     git@vger.kernel.org
Message-ID: <33408832.61.1655926225394@localhost>
Subject: Clear ongoing developments include
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
References: <33408832.61.1655926225394.ref@localhost>
X-Mailer: WebService/1.1.20280 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi and all the best wishes for a safe and healthy year.
Some organizations will be remaining at home in spite of loosened travel and commute restrictions through the rest of this year and possibly beyond. Are you planning to increase your investment in collaboration as a result?
