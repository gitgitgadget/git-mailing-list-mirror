Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B6F01F462
	for <e@80x24.org>; Thu, 20 Jun 2019 10:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfFTK7s (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 06:59:48 -0400
Received: from [195.159.176.226] ([195.159.176.226]:40998 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfFTK7r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 06:59:47 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <gcvg-git-3@m.gmane.org>)
        id 1hdunB-0016pa-U9
        for git@vger.kernel.org; Thu, 20 Jun 2019 12:59:45 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Yuri D'Elia <wavexx@thregr.org>
Subject: git fetch --shallow-since hangs
Date:   Thu, 20 Jun 2019 12:59:38 +0200
Message-ID: <87h88kh691.fsf@wavexx.thregr.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.50 (gnu/linux)
Cancel-Lock: sha1:jylDCsI+tui8D0X0movH0TFDDnw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to run git fetch using --shallow-since with a date range that
results in no commits to be selected.

In this scenario the command hangs indefinitely:

git fetch --shallow-since=2019-05-20 -vv
Server supports multi_ack_detailed
Server supports side-band-64k
Server supports ofs-delta
Server version is git/2.21.0
want 33eeead1a93fed4d25ff90b0b45acec5d822c13c (refs/heads/B-2012-04)
want 49455fcb45a950adf7702d96a2be0ff70cd06577 (refs/heads/B-2012-07)
want c9964f78fd7d1a43db7abca9d2ed2d04ffc7d9a3 (refs/heads/B-2012-08)
want bb8869e3c2697c901b27658cadeb994dd8193897 (refs/heads/B-2012-11)
want 386210eb1ed98abeaa678cc90de639a7773d0802 (refs/heads/B-2013-04)
want b1828494a89fe4532549df31ff93a7816b7c6341 (refs/heads/B-2013-07)
want ff6829912631132fe9b6d8880a6ea8a14676b5c9 (refs/heads/B-2013-09)
want 4c59a0e2317b3bbd6a8bfdad89dbc2c8ca172f8d (refs/heads/B-2013-12)
want ce9729b1c2f26f5a1eab6c623d710df50b4e87fc (refs/heads/B-2014-03)
want 39db34fc97fcafb43faaaba25618473cb2fa8ed6 (refs/heads/B-2014-08)
want f710bb0552db364c40cac542fb591af3b384210c (refs/heads/B-2014-12)
want d6569610cf5da4aced818ba246aa9bc3ad4d7c4a (refs/heads/B-2015-04)
want 3333479999a695f07c30ffca319fa38fc74e01e3 (refs/heads/B-2017-05)
want 111801742054e910a214fca96531824e6f806bd8 (refs/heads/V-2012-04)
want e64b751dd156ee7ee06521b9670284fbe2b79b8e (refs/heads/V-2012-04.1)
want 8bf4adb022e39d06872758d68672fc6f327513cb (refs/heads/V-2012-04.2)
want 31254791e193524c634e19dbcd766b0254f0f21b (refs/heads/V-2012-07)
want 245045e41db2e87c9467830d8fdb570a17b321ed (refs/heads/V-2012-07.1)
want 6ae10ad37c9083e83a43b1679d5514302ce0355d (refs/heads/V-2012-07.2)
want f07291acd0eddddb168d322e27c9425ca084f239 (refs/heads/V-2012-08.1)
want 4a5e3ab5f4eb412b905ddb7e91e0db70bd6cd17f (refs/heads/V-2012-11.1)
want 4b36f254523dbc1d2a80f29886d96cb9a6851584 (refs/heads/V-2013-04)
want f2040101186b31bc99e0f8d4c370101ad0f45ac8 (refs/heads/V-2013-07)
want ba38be154fb9b5627e8c74b2cd75df628961d998 (refs/heads/V-2013-07.1)
want 6029a5638a486886be507c78cc876f266dca2cc7 (refs/heads/V-2013-09)
want 370adcc9a4e82b75a83a999f6cf08d83cba31ce8 (refs/heads/V-2013-09.1)
want d89488b9e3dbd53e4b96bb00f1075901306fcf58 (refs/heads/V-2013-12)
want 86f8eb18bc5657566793ce7ec9c3c05de9de994b (refs/heads/V-2014-03)
want da6f1539444152bff219732ce694454a33444457 (refs/heads/V-2014-03.1)
want b68d4411d16d293817127856f396d460894e8978 (refs/heads/V-2014-03.2)
want d11d83083b31d44940ff78b0a8e656f21473ab46 (refs/heads/V-2014-08)
want 6d81e7ce60bf125c1cd5528a943e73164f8d3bbe (refs/heads/V-2014-08.1)
want 648f93cab60e4525b4278aa172b50740040ce817 (refs/heads/V-2014-12)
want baf41800559a7a3b0d0c6963f01c04bbd4d65be5 (refs/heads/V-2015-04)
want 619d51d2592cd8dc572c252f4c7b169c04aad6fb (refs/heads/V-2017-05)
want ef021b04df54a5f94e164b79133f1e64b9edc02e (refs/heads/master)
fatal: no commits selected for shallow requests
<hangs here>

I reproduced this on the client side using git 2.20.1 and git
2.22.0.455.g172b71a6c5 (the latest debian unstable package).

