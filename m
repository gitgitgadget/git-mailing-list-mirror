Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96CDD1F51C
	for <e@80x24.org>; Fri, 25 May 2018 10:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966229AbeEYKsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 06:48:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33376 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965255AbeEYKsv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 06:48:51 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180525104849euoutp01883aaee1cf51cb0f64195cfbaf1931e6~x3YkbJNbl2893328933euoutp01t
        for <git@vger.kernel.org>; Fri, 25 May 2018 10:48:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180525104849euoutp01883aaee1cf51cb0f64195cfbaf1931e6~x3YkbJNbl2893328933euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1527245329;
        bh=g9wzl1fG73f8tIocXCuDVITOn1pYSBeXn7qyIWScVwY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=utqwN5TKmElHsATwFwhaYmuN6QFM75MKwcK5I69pEUrQI0EXuN06/cnDtXKfdTdt2
         QTdoCb9dX20J2POHHCoF+kRvmCZKfKBILm/0HkrFg8GjAncBa5Tp10C3kaApxvSgYT
         unnK99KXJlX2nc/K0hQ3AligGMFIs36mAj0lUX5A=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180525104848eucas1p1808113ea8d150e4397b92c30ccac6a67~x3YjrqWnd0705607056eucas1p1Y;
        Fri, 25 May 2018 10:48:48 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D6.BF.05700.01AE70B5; Fri, 25
        May 2018 11:48:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90~x3Yi9nZab0660706607eucas1p2D;
        Fri, 25 May 2018 10:48:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180525104847eusmtrp2338605a8a895247ac9a09703532f7042~x3Yiu7t5e0386803868eusmtrp2I;
        Fri, 25 May 2018 10:48:47 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-df-5b07ea10625f
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id EA.EA.04178.F0AE70B5; Fri, 25
        May 2018 11:48:47 +0100 (BST)
Received: from localhost (unknown [106.116.147.110]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20180525104847eusmtip1e058255c6cfebae6a6e415899892a737~x3YikUi2j2876728767eusmtip1K;
        Fri, 25 May 2018 10:48:47 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] completion: complete remote names too
Date:   Fri, 25 May 2018 12:48:42 +0200
Message-Id: <20180525104842.2930-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWy7djP87oCr9ijDTYtUrDoutLNZHHz0ApG
        ByaPvi2rGD0+b5ILYIrisklJzcksSy3St0vgyujtamUseM5a8fraErYGxt8sXYycHBICJhJP
        N09h72Lk4hASWMEo0fVsLyuE84VRYtneRWwQzmdGif/tt5lgWqZ8eMwOYgsJLGeUOHeWG6Lo
        JaPEqv4GsCI2AUeJ/qUnWEFsEQFxibfHZ4I1MAvYS0yc9Z8NxBYWMJO4+fkL2B0sAqoSu5Zc
        ZgaxeQWsJCb1/2CHWCYvsavtIitEXFDi5MwnYPX8AloSa5qus0DMlJdo3jqbGeQICYH7bBKv
        lq5ihWh2kbj2eAczhC0s8er4FqihMhL/d86H+iZf4svve1B2hcSfTUug6q0l/qyaCHQoB9AC
        TYn1u/QhwrYSL6/vYgUJSwjwSdx4KwhxAp/EpG3TmSHCvBIdbUIQ1SoS6/r3QENaSqL31QpG
        CNtDoun7KvYJjEqzkDw2C8kzsxD2LmBkXsUonlpanJueWmyYl1quV5yYW1yal66XnJ+7iRGY
        GE7/O/5pB+PXS0mHGAU4GJV4eDkOs0ULsSaWFVfmHmKU4GBWEuFtus4eLcSbklhZlVqUH19U
        mpNafIhRmoNFSZw3TqMuSkggPbEkNTs1tSC1CCbLxMEp1cC4J6djq9jJ0H/s0e0PTPc3Ler+
        MbP6xa87ydXG1x38m3Zeq622l7HMala4dHbO8p8L4g44XJFsNNP6FeLmaNISb2j5R+JnkUlx
        V8qrqtwugYI1vP+cTi/xWMG+rUIu/e18tc8zQlp9XsvMZp85Uaw3aepC5s45678WJhib7j5r
        5Hxkda0oo58SS3FGoqEWc1FxIgCWhSbCCAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsVy+t/xu7r8r9ijDR491LXoutLNZHHz0ApG
        ByaPvi2rGD0+b5ILYIrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJ
        zcksSy3St0vQy+jtamUseM5a8fraErYGxt8sXYycHBICJhJTPjxm72Lk4hASWMoosajlOFMX
        IwdQQkpi5dx0iBphiT/Xutggap4zSqz4eJMRJMEm4CjRv/QEK4gtIiAu8fb4THYQm1nAXmLi
        rP9sILawgJnEzc9fwJaxCKhK7FpymRnE5hWwkpjU/4MdYoG8xK62i6wQcUGJkzOfsIDcwCyg
        LrF+nhBImF9AS2JN03UWiPHyEs1bZzNPYBSYhaRjFkLHLCRVCxiZVzGKpJYW56bnFhvqFSfm
        Fpfmpesl5+duYgSG9bZjPzfvYLy0MfgQowAHoxIP74YDbNFCrIllxZW5hxglOJiVRHibrrNH
        C/GmJFZWpRblxxeV5qQWH2I0BXpnIrOUaHI+MObySuINTQ3NLSwNzY3Njc0slMR5zxtURgkJ
        pCeWpGanphakFsH0MXFwSjUwhj5Z9vyhkrvm52nGr1wn/tPNmrdvdY/6VLeViqapTHaty5fa
        6v+ZMWvl5Rttd8+Vvu+7bekR4VadFe7RrKtTaPV6Ce8O2RclG4wrin70NIbfcGP7Xscuo5++
        VuNqYYWsozCX1WrF0x/c4q/JSH6QLIsLuy/+vsOZeadQ4+RNV1atvOf2RPmOEktxRqKhFnNR
        cSIA/j+CMoECAAA=
X-CMS-MailID: 20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR:  20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90
X-RootMTR: 20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90
References: <CGME20180525104848eucas1p28c88d657362066ea26d4eedaaef71f90@eucas1p2.samsung.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git remote update" accepts both groups and single remotes.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 961a0ed76..fb05bb2f9 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2632,7 +2632,7 @@ _git_remote ()
 		__gitcomp_builtin remote_update
 		;;
 	update,*)
-		__gitcomp "$(__git_get_config_variables "remotes")"
+		__gitcomp "$(__git_remotes) $(__git_get_config_variables "remotes")"
 		;;
 	set-url,--*)
 		__gitcomp_builtin remote_set-url
-- 
2.11.0

