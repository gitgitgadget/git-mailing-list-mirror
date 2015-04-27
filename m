From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false
 positives
Date: Mon, 27 Apr 2015 09:57:12 +0200
Organization: gmx
Message-ID: <302f37d0837581378cc0db33499d8297@www.dscho.org>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Apr 27 09:58:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymdvb-0000aW-R2
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 09:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668AbbD0H6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 03:58:03 -0400
Received: from mout.gmx.net ([212.227.17.20]:52642 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbbD0H6B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 03:58:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MVJze-1YoCSz3YT8-00Yfp8; Mon, 27 Apr 2015 09:57:15
 +0200
In-Reply-To: <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:uDHftyPvLjOrA2xh1mojdEUedxmrP9YlVpr6CeomUATadbdjtTO
 7eNn2Ul+T8nLxtYb3En9fMfGmUyxZhgR1SvoGxSZ0wXqDgmbTY70RJ2dghsvBg89Tj6JfeU
 a6lKvAibyQMS9KY4GdDLoicwDeVzG/XpfPeHbOGnkzFnHY2ltTysG/JbOjq8GwYaKRrAW5T
 5R+sFiF0zkziZgl7NN4tg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267848>

Hi,

On 2015-04-26 22:30, brian m. carlson wrote:
> The git_connect function has code to handle plink and tortoiseplink
> specially, as they require different command line arguments from
> OpenSSH (-P instead of -p for ports; tortoiseplink additionally requires
> -batch).  However, the match was done by checking for "plink" anywhere
> in the string, which led to a GIT_SSH value containing "uplink" being
> treated as an invocation of putty's plink.
> 
> Improve the check by looking for "plink" or "tortoiseplink" (or those
> names suffixed with ".exe") only in the final component of the path.
> This has the downside that a program such as "plink-0.63" would no
> longer be recognized, but the increased robustness is likely worth it.
> Add tests to cover these cases to avoid regressions.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>

I like it!

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho
