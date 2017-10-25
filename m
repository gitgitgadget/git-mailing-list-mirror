Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E896F2055E
	for <e@80x24.org>; Wed, 25 Oct 2017 20:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbdJYUkp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 16:40:45 -0400
Received: from mout.gmx.net ([212.227.17.22]:61999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbdJYUko (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 16:40:44 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjN0F-1dcFas3anv-00dVdt; Wed, 25
 Oct 2017 22:40:37 +0200
Date:   Wed, 25 Oct 2017 22:40:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 0/1] Do not handle submodules in excluded directories as
 untracked
In-Reply-To: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1508964005.git.johannes.schindelin@gmx.de>
References: <244d71f47336e985ae265573b7d523cd8b3943bd.1508244305.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:6ElCbV9jv/TQXe8L//Rv8GWAcOBPM9hbECzkHX2yxJhkMmqrt1E
 9rryAT7oX4jFZ1zPiprFzOoMTGroGN4IWnM476SKFQ0r5YUhhExxJy/01kUe9GNq7t5vnbJ
 La+ZVqHQFDCNPBpBdjCoFazzNVWkf7YHkcMSn6WYhdEL7nsUSYDymKik5yJ1auwu6qKk6zE
 qn4zWHpbm8hJ6Eo4gDThg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TFk0U1vQIxA=:AqDktLxyejapyP1cKd0I4g
 BFqhsBVQOYBhjb7HBPpHynwvnMxA/xOkGahbg8ZRPKU/D9VD0eYo/Ai+CeqI15MGP8LmI+TtH
 xv1SkbEizzT9U2RUDzDJP/8uEH1AFt9KrT91LSoYDVriTKXpqnU5Sa2uyncOqviWPjr1fEnvW
 MaEAoFgdk03FZmS2CVjZyLbYnVukanuING1mzazN9Ttkc5247e7J6nRECVhHNJ5CxS0oQxJ4Y
 VMCABU8gnQ/ta7Jm2Yck2w0gQK8iYUZYFr+lQoOg4pWkdKcIuTWSAswNWnQC/EfP2zXFhmQ9l
 oVhq70nt8mXH23a7YIHpWBxhCl3xjcMN/oR3qgmc2els73bI0zFKvs/E76S3NDEbMm2Fq2KW4
 Vtez+SHKwH+uiL+T0JbNfhIYhxdg4IKTF8rBCSojPqET3kP6gKWwa1a/y2WsAgWyZe1MIp5xp
 F/JApfTuewgUyvGm3AvlPedGZZRL252RCrlcgv7EncCS6T2nqqZR9SB0W+ey0Ii1x7l3n45YU
 GK68/jQMl8sjYw9HEhOgMrgTvurYv71G34+j8kow/qUwAWw2vC/gKFvWsc06gPnEVi998gJwA
 d00Fbc+w9Pirp8P1Bcn/jRnkGnU+bMqkdgXDC483AbwTcZPNuy2laW7p9u8Dx/jrdZzrCFNW4
 g0LXEHl/grwRokaKDSvoLZkVhcI+LH3GDSShvbaEr9opPVoSZD8vdtWQgAoykGoXnFCKnvkbC
 HzjAmpR58Ie/kEs3FuAWJjQ+EWO6oCD/Xmo+znw8T0b/tq2kFxGQedWrO24RU9qCskUK247e7
 3rVNI7gyJrYZ6+8RidzaD+Fl/F85V1wkWXdUdw9PEoDG8/ESpMevLCooNBcAbL7cXg5rus1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anything in an excluded directory should be ignored, not only files and
directories but also submodules.

Changes since v1:

- simplified the test case, as suggested by Kevin

- added explicit output to the commit message to demonstrate what is fixed


Johannes Schindelin (1):
  status: do not get confused by submodules in excluded directories

 dir.c                      |  2 +-
 t/t7061-wtstatus-ignore.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)


base-commit: ba78f398be65e941b93276680f68a81075716472
Published-As: https://github.com/dscho/git/releases/tag/submodule-in-excluded-v2
Fetch-It-Via: git fetch https://github.com/dscho/git submodule-in-excluded-v2

Interdiff vs v1:
 diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
 index 8c849a4cd2f..0c394cf995c 100755
 --- a/t/t7061-wtstatus-ignore.sh
 +++ b/t/t7061-wtstatus-ignore.sh
 @@ -278,10 +278,7 @@ EOF
  
  test_expect_success 'status ignores submodule in excluded directory' '
  	git init tracked/submodule &&
 -	(
 -		cd tracked/submodule &&
 -		test_commit initial
 -	) &&
 +	test_commit -C tracked/submodule initial &&
  	git status --porcelain --ignored -u tracked/submodule >actual &&
  	test_cmp expected actual
  '
-- 
2.14.3.windows.1

