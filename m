From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 11/12] t5524: test =?UTF-8?Q?--log=3D=31=20limits?=
 =?UTF-8?Q?=20shortlog=20length?=
Date: Thu, 07 May 2015 18:28:56 +0200
Organization: gmx
Message-ID: <05adfac12cb9a7ad183281974d991e00@www.dscho.org>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
 <1430988248-18285-12-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 18:29:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqOfb-0008Bb-3h
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 18:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbbEGQ3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 12:29:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:61540 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751189AbbEGQ3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 12:29:00 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lqn7e-1ZTHrM2MHi-00eJ21; Thu, 07 May 2015 18:28:58
 +0200
In-Reply-To: <1430988248-18285-12-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:T9F17T1fn+Zhn2OVHxvitzhHuIVVC899DHnzf6Qf1MvJPkCUdQ7
 VSGeSl4CCapNViYc0nNKmCfo545o+nmrYWAjXANr8kVf5T/lxjpvV5ObR3XIc/Yy1wFWbhL
 /9NKr97lNKkKHEI+SvGsSZMtVb7CSc4fuaPZhqw6g22uufZ7gwLFgikovqc3fkhBxqxpeRP
 dzP/Mkc8BZqGP+XVgYJHw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268544>

Hi Paul,

On 2015-05-07 10:44, Paul Tan wrote:
> @@ -32,4 +35,18 @@ test_expect_success pull '
>  )
>  '
>  
> +test_expect_failure '--log=1 limits shortlog length' '
> +(
> +	cd cloned &&
> +	git reset --hard HEAD^ &&
> +	test `cat afile` = original &&
> +	test `cat bfile` = added &&
> +	git pull --log &&
> +	git log -3 &&
> +	git cat-file commit HEAD >result &&
> +	grep Dollar result &&
> +	! grep "second commit" result
> +)

I think it might be better to use `test_must_fail` here, just for consistency (the `!` operator would also pass if `grep` itself could not be executed correctly, quite academic, I know, given that `grep` is exercised plenty of times by the test suite, but still...)

What do you think?

Ciao,
Dscho

P.S.: I missed 12/12 but the rest of the patches looked fine to these old eyes. Thanks!
