From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] pull: handle =?UTF-8?Q?--log=3D=3Cn=3E?=
Date: Mon, 18 May 2015 16:53:56 +0200
Organization: gmx
Message-ID: <5661061272076a1883cfde1087be4a42@www.dscho.org>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 16:54:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuMQj-0005ek-K2
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 16:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbbEROyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 10:54:02 -0400
Received: from mout.gmx.net ([212.227.17.20]:65398 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799AbbEROyB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 10:54:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MHrk1-1YsyJk2TqH-003aKF; Mon, 18 May 2015 16:53:57
 +0200
In-Reply-To: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:IX1dMEHc/AyuMN93asIEpXT0uyv7tgD+C2XNihqsFXf4WxIwaks
 TL57c0k9rDoVZq3+FV27dg7PLLnTkNZLcXrnKFEH8rHoIGsK4oIXwBqrV5H5DdcUpU4paQt
 Y23wSqxkKrbxantdZTwWe99+hdFcAijUeVR2agCX55LwSlcujcapD9AwMxEBDmAZP1UM5HT
 1rQdBnpXaumqDT4+5qm6w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269256>

Hi Paul,

On 2015-05-18 15:39, Paul Tan wrote:

> diff --git a/t/t5524-pull-msg.sh b/t/t5524-pull-msg.sh
> index 8cccecc..eebb8c9 100755
> --- a/t/t5524-pull-msg.sh
> +++ b/t/t5524-pull-msg.sh
> @@ -17,6 +17,9 @@ test_expect_success setup '
>  		git commit -m "add bfile"
>  	) &&
>  	test_tick && test_tick &&
> +	echo "second" >afile &&
> +	git add afile &&
> +	git commit -m "second commit" &&
>  	echo "original $dollar" >afile &&
>  	git add afile &&

I completely forgot to send a mail last time where I wanted to mention the test_commit function. I *think* that above invocation is equivalent to

    test_commit "second commit" afile second

with the additional benefit that `test_tick` is called automatically. Maybe you want to use that more concise function call?

Ciao,
Dscho
