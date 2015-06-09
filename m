From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: How to compile without iconv?
Date: Tue, 09 Jun 2015 20:46:18 +0200
Message-ID: <5577347A.5080107@web.de>
References: <CAGUt3y4RgtkP35XstHGQ=T3zkb_akZSRS=q227wMehVzmu9MDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Sascha Ziemann <ceving@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 20:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2OXc-0006Fl-C7
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 20:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbbFISqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 14:46:24 -0400
Received: from mout.web.de ([212.227.17.12]:62576 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752372AbbFISqX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 14:46:23 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0Lb1wz-1ZUpak1Bph-00kfhT; Tue, 09 Jun 2015 20:46:19
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAGUt3y4RgtkP35XstHGQ=T3zkb_akZSRS=q227wMehVzmu9MDA@mail.gmail.com>
X-Provags-ID: V03:K0:Z2pZKVBWnF1QxSbh7R9Fs78Hgs27heP89xe7aSs7nzSLmrpmGtU
 Jit0/bCwH/I5mAt7fNXb7NbmObeA/0y5L0R44uIXCU6f8Kh6Gk0il0xiJHh1WY+TwMx6uRl
 iZDbg49/KmbZrS0hrv4Nf0ZB/TCnUxcLNzct5ygqKBAfRHDGLnGK/iIBR53r0aLurlmKsfU
 R5K6EwxZVMwYbzm9ond4Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uQ8TSFbqd6c=:vs2vvh8V8ygi5L8vl5MGzs
 jNMpnKSMT+YF1vLaxK0GbOevs9d4NdmUCwg71CHePQiZXVNc/xyzAW9qv9TS1+KhXkczWF42g
 0jKfDq7jYTFPlJYQ1UboxEFn1Bou4RnBg5PxOPCCIAgkuBc/JrjciYaNQkgYNGrY4WB4HF6PB
 1hXZLDF6s7WXxejV03iIadlX3aFITcKRRm+fvAt/uNcvFTBm2YGFrwF9XlwP17CJBg9kutZeD
 QrfIwxd7mtccw2mErehzKVE3o80AgLrY6PSaz89arM2pR+1lS6zgDQhsk9ARkbPP4ZdHYrYcT
 i11JpFFfCnL5d4nsxkFlMzeDBwr94zkSaho+ViWoh6zLZ/rIm+uPSqB3OZxrODdix2sbkBYHW
 D4WACH+2AX3gPs0Eyyr1x2/Qp30ZxcR3Mf24zZk25xneBz4AGS2RAXbPft4ZA5cxfUryvd9i/
 tYVBzeUdVahiNvgaQBM3M1TIMqJ25qtQOJTApYZlKekJnOEp5gfwaffsFwq0EgkBp6+dKxolt
 IKuonFp9jhSlsBHUCZkUIt6hfBTz4gWmpREJZ4YDU5bUsvF0aRvF4rB520nq31o9bNtcAF997
 S/h38QzjIlsyizAyKOylnFiDl6FSIg/WPOEnJC0jKy9Q7akKnxCCdSBdLLx4rVxmifBEBgusq
 Gp7J/vqmcmZSFbeY+5Rh3evYw8G3PxnF748wVxEDVsd9+95kWy0Z2+i1zeN03/UxyFho=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271223>

On 2015-06-09 16.07, Sascha Ziemann wrote:
> I tried to compile git 2.4.3 on Solaris 10. I used the following configuration:
> 
> $ ./configure --without-iconv
> 
> $ grep -i iconv config.status
> ac_cs_config="'--without-iconv'"
>   set X /bin/bash './configure'  '--without-iconv'
> $ac_configure_extra_args --no-create --no-recursion
> OLD_ICONV=UnfortunatelyYes
> 
> But when I try to compile it, I get an error that libiconv is missing:
> 
>     LINK git-credential-store
> Undefined                       first referenced
>  symbol                             in file
> libintl_gettext                     libgit.a(lockfile.o)
> libiconv_close                      libgit.a(utf8.o)
> libiconv_open                       libgit.a(utf8.o)
> libintl_ngettext                    libgit.a(date.o)
> libiconv                            libgit.a(utf8.o)
> ld: fatal: symbol referencing errors. No output written to git-credential-store
> collect2: ld returned 1 exit status
> gmake: *** [git-credential-store] Error 1
> 
> How can I work around this?

It seems that you need to switch of gettext as well.
(Somewhat untested, I don't have Solaris)
What happens if you run the default Makefile (without configure)

NO_ICONV=t NO_GETTEXT=t make
