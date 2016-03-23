From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2 3/4] t1300: fix the new --show-origin tests on Windows
Date: Wed, 23 Mar 2016 12:08:16 +0100
Message-ID: <144C8B10-A98F-4888-ADB8-8C9D67BF52D9@gmail.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de> <cover.1458730457.git.johannes.schindelin@gmx.de> <86f6c23e500867f403c33c2716826dc0c5db0cdb.1458730457.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 23 12:08:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aigeP-0007Ml-6u
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 12:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754844AbcCWLIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 07:08:23 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37759 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752145AbcCWLIW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Mar 2016 07:08:22 -0400
Received: by mail-wm0-f50.google.com with SMTP id p65so18916201wmp.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 04:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yXnIZZEBuqI4m2jUFlEog0F9En3ZouUi9TboLb6Ak7Y=;
        b=sThZbn12mRDtgcV9KhNEgId0txP5jd+sUYifzB3hgzzpZomr1541WkPnsnR5pQErty
         8tOv91nLGrvcOxh8BWkAelKr35tWYmVvjCJKCfu5A2oEmI+BQnUUsYUIqBw5qbbzsgXc
         ZC5c+d/W16dQcBDxeEnR6OwXCndDjiElnUkuhVrXkHBe534k7erM9uIZFrFnHj57ViNh
         zi2L8DH2xnd9oRxOmHOZJqeJvDG1Vn0Sn0/8bd4Wp1Jvr2vJfo+CEDzA//cm62kRrQNl
         xp7tV2KojSPUCWTOula3J83QJ3DdcxMNCjPWstuj81V1323DMlq7N+rPIUc16Sok9fz6
         l1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yXnIZZEBuqI4m2jUFlEog0F9En3ZouUi9TboLb6Ak7Y=;
        b=kR4axM5HLYB12+Cci4uA1/NYXQR6aVF20OokYanfLdDjG7RXvwIeJj8d4hhYVWKRcW
         JrSw/Nppr5w9yl7xKY2Fyiqss+s2wOeqHGnrEBQDPI+8/Pj9b08Vq/+wBFno3DeSjW8M
         fDa8f/gHVDe1kpSkUR+3sSwIAV45rJS4pjXmaH2psw4C4EHjap1Nwq+nRVrZ4/o8odo2
         0uBcDS1cA+1k2sCoxujcFyTtmEOEEJPrE9nwIeXLEQSpQe+pYpBVctRn0npchW7w1lrB
         5AaMKhSDPrNCJ7CasZWE3Wy6zUaJBWFr7lcl2O2bEWJuQxNdI8R4sYjYZ5HRuFmnYXjd
         r3uA==
X-Gm-Message-State: AD7BkJKpaFzu/rGekOhlOLnlZ3b9DsL/HBNdibPb9mKdrs3XPGumfJSBb9ooqRnROo5ZMA==
X-Received: by 10.28.141.10 with SMTP id p10mr3080802wmd.83.1458731300632;
        Wed, 23 Mar 2016 04:08:20 -0700 (PDT)
Received: from slxbook3.fritz.box (p508BA3D3.dip0.t-ipconnect.de. [80.139.163.211])
        by smtp.gmail.com with ESMTPSA id v188sm21614477wmv.3.2016.03.23.04.08.18
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Mar 2016 04:08:20 -0700 (PDT)
In-Reply-To: <86f6c23e500867f403c33c2716826dc0c5db0cdb.1458730457.git.johannes.schindelin@gmx.de>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289648>


On 23 Mar 2016, at 11:55, Johannes Schindelin <johannes.schindelin@gmx.de> wrote:

> On Windows, we have that funny situation where the test script can refer
> to POSIX paths because it runs in a shell that uses a POSIX emulation
> layer ("MSYS2 runtime"). Yet, git.exe does *not* understand POSIX paths
> at all but only pure Windows paths.
> 
> So let's just convert the POSIX paths to Windows paths before passing
> them on to Git, using `pwd` (which is already modified on Windows to
> output Windows paths).
> 
> While fixing the new tests on Windows, we also have to exclude the tests
> that want to write a file with a name that is illegal on Windows
> (unfortunately, there is more than one test trying to make use of that
> file).

Thanks for these Windows fixes! After the 2.8 release I will try to post 
a patch that uses a different filename where possible.

Cheers,
Lars

> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> t/t1300-repo-config.sh | 10 +++++++---
> 1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> index dca27a3..a37ebb2 100755
> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -1205,6 +1205,9 @@ test_expect_success POSIXPERM,PERL 'preserves existing permissions' '
> 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) != 0600"
> '
> 
> +! test_have_prereq MINGW ||
> +HOME="$(pwd)" # convert to Windows path
> +
> test_expect_success 'set up --show-origin tests' '
> 	INCLUDE_DIR="$HOME/include" &&
> 	mkdir -p "$INCLUDE_DIR" &&
> @@ -1232,6 +1235,7 @@ test_expect_success 'set up --show-origin tests' '
> 	EOF
> '
> 
> +
> test_expect_success '--show-origin with --list' '
> 	cat >expect <<-EOF &&
> 		file:$HOME/.gitconfig	user.global=true
> @@ -1304,7 +1308,7 @@ test_expect_success 'set up custom config file' '
> 	EOF
> '
> 
> -test_expect_success '--show-origin escape special file name characters' '
> +test_expect_success !MINGW '--show-origin escape special file name characters' '
> 	cat >expect <<-\EOF &&
> 		file:"file\" (dq) and spaces.conf"	user.custom=true
> 	EOF
> @@ -1333,7 +1337,7 @@ test_expect_success '--show-origin stdin with file include' '
> 	test_cmp expect output
> '
> 
> -test_expect_success '--show-origin blob' '
> +test_expect_success !MINGW '--show-origin blob' '
> 	cat >expect <<-\EOF &&
> 		blob:a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
> 	EOF
> @@ -1342,7 +1346,7 @@ test_expect_success '--show-origin blob' '
> 	test_cmp expect output
> '
> 
> -test_expect_success '--show-origin blob ref' '
> +test_expect_success !MINGW '--show-origin blob ref' '
> 	cat >expect <<-\EOF &&
> 		blob:"master:file\" (dq) and spaces.conf"	user.custom=true
> 	EOF
> -- 
> 2.7.4.windows.1
> 
> 
