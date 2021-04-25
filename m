Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123C7C433ED
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68AF610A1
	for <git@archiver.kernel.org>; Sun, 25 Apr 2021 07:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhDYHLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Apr 2021 03:11:33 -0400
Received: from mout.gmx.net ([212.227.17.21]:47813 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhDYHLc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Apr 2021 03:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619334652;
        bh=fi+l1JI3czoZ5zQ4ZHpF54EIiyFHSO2gz9cLYeJnxeI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=WPhKaE0f2JpxdXc5JghnPUVvGLjunPMdDinZX92D2/bd7kMG6MjvZ6zPt6JomNFTR
         Kp6++c9RaPoiQ5HZlwGeo4aXUG36XJAi5BH2w34axTVC+6M/Z3TVyu+MAOK4LBKEsz
         dmhZLv6fcEkWyUV0QVs1Md0rwRuc6xJO3/a3uoQY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from E15-2016.optimum.net ([70.19.86.82]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1wll-1lTw142v4T-012Fnh for
 <git@vger.kernel.org>; Sun, 25 Apr 2021 09:10:52 +0200
Date:   Sun, 25 Apr 2021 03:10:49 -0400
From:   Boruch Baum <boruch_baum@gmx.com>
To:     git@vger.kernel.org
Subject: Feature request: stash rename
Message-ID: <20210425071049.fic7abm43v2sy3pe@E15-2016.optimum.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
X-Provags-ID: V03:K1:tQJPYpq8phQHIKcgMGaPKiwhxZM/pT56dFduQ1AR7LmlN1ujU05
 r71/PaW0xo2dt62go5ZutNZoSR3M7KlbILfG/S+Vgqxxwcbe6URcJP+t7AfwfIFtdnMSbiP
 XTd/gtNbtifrE/qqVAzJasm91OHNMCqtP4L4XFkJ5N8l/xFFkdlE3NILVLBgTZ0GpLW6Ibi
 8MNTk6OlVIHmULXBwxgRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h5RLT3e/atI=:cTmMakhc/FjM2CImFM/31h
 PYRCDV+81nGOeHS4t66u00YyRIaZOL8FvKcsCF82et9aPxJ7jHpqYutIHLvcRDX3QlMyyf52S
 VMrc3Ww+prCGY9BJUfs+F7i0cpozoPVpOaxiRL7Wz04LGgS+temYA4CYMdpTyefNEa/d2Kzgj
 ExnxMecr84El4B8UnjS4CptodAFZJNlP/eCRQEspxw29RZsUPRDeOrjVYM7WRMCN8y7Iil6k+
 KYc9EOhydIYGejO8qYxUet+96wQWIRU03XUFZdC247twwZePb5Cm/kfEUBKkLp55lGn2ZeYsA
 IVk2dE+VCEI7AkD4In+7BtrCA3bJyugpAxGCT+dmnFWPhX6m8hZwFPSBr9AP9jygHINA2M7+J
 VIzqb9II5sKPx8apjCY8XOPo1u+encgZodYewQSO1jbRJFDGJR/jjbTG94HyXgED+uzrgo9Fe
 hTcBfkMIiNjBne/wSGYhSVH6CO2pSt1zrkL7BXqCQzLJxR38U8qHZIPZzEYW4I1J8WLfjrNCD
 FVqMBn0H2BhiMMeNLdwqSd+TmJ4wg4x1El13aVtEOI2fOzaZ1wegGY14Tpz6yREk90NYxD+aE
 YwslT+PMRl7ICFWfr3+yhpu8nXbYZqaZuFRFP7t8EtVGHFxIrn9Qki3T7zhnkjcBBOpaKOjXC
 hachtDJsjCHhAGyGWufbO+/0sH6+p9UWwPi/B+fL/3IlGA29B/Dn9oDI6vZmKMsYkp5C5sCA5
 Zg6INSBdLcGOjy0e+r5aQijxhHnDWh3Wyzk4omEyI7VqAMTF2tXfjkccTwkKZKUfdnelM+r5F
 g+EuIKMv2vDvb9+tVn3oRykGnnqToocyYiK9WasKzkE9ixcoBiFJKrUkXEwDCNCN6TYRZtZiP
 Ej+pq69S7i+fdMPPfxmKH9EfQaYIxergWaNb7eYL0SuYq39pUTYNR9Ia47GabLDuSzVJmwWzl
 EZPXUHHPKjYctoRyQyOQf8QMdGh7bsForVUrJe8fC2MC04lNTWDrb9LT+U7Pg9CJlqmShuorQ
 osQ/f6OwRI1BLJm7BceMuMU1gR5NMv+6WTB4VlqJOPOqiVx/t7mUCl0w4loy8z6zTt/dgFLhE
 Y/OhclHp2FN+XhUiXFsQu31KL5IXZYR75ULR410gs4tjV4rqmivsPA3YfPsO7njHjpjDD3yik
 bF/zxQkbq37Lamlzogj9YkgqX3AOAh/zr7LRBGhra+i+tnam9Js2iVQm1/u4nkge4/MA0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I do see from a cursory internet search that this has been requested as
far back as eleven years ago, and that in the meantime there have been
many attempts to do this using aliases and scripts. Please consider
implementing an official guaranteed-safe method to just rename a stash's
label/message.

=2D-
hkp://keys.gnupg.net
CA45 09B5 5351 7C11 A9D1  7286 0036 9E45 1595 8BC0
