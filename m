From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 0/9] Reduce index load time
Date: Mon, 16 Nov 2015 22:51:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511162249480.1686@s15462909.onlinehome-server.info>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1379692850-1447710668=:1686"
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
To: =?VISCII?Q?Nguy=ADn_Th=E1i_Ng=F7c_Duy?= <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 22:51:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyRgC-0000aK-1v
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 22:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbbKPVvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 16:51:12 -0500
Received: from mout.gmx.net ([212.227.15.19]:50269 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465AbbKPVvL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 16:51:11 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0LcSAg-1ah9pa0VPS-00jmlS;
 Mon, 16 Nov 2015 22:51:08 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:46AQiSul6nzfQCUVmrslzDc6rbq9l/LNQU4FRDb3sf6xRziOkox
 EBHpVRuACnYi84Xg0JhExtXcHifghHpOkwukU8J2MX5OwHmsdbL4MRW7kZ2UEm67otGca/l
 XzeEyufqn1+rKEx9YrhvbKX6DEZxJTPT+/vV5/5INBykEXy8MW+OrjH8JoQGAfa3yM1pPbt
 gnA+qC4vjGlbttckrzyBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J+KW+DFKTKc=:Xt5ZXIann3Dk0QnKVTX5q0
 1bSo9xHed3MaDew3noXyA3Us75wHMejCL+8+EIjKed3et40JmjD4jhCtVhiUd2ohbonxebMVX
 KR4lu3MSIWhG3XkcbRKVYauq24YQXwlOyKImHkRuPpPcdy9AX/b26TbUpPE9Ekrq0zScKJQ1Q
 HKS/id51YSQVpYsDpMAn/Q7Yxh0Hq7qK+82AS5E0Ro7yM6q9ImlOx6Pcf+QoJ/yTGT1149pj8
 17W5NKFFeQCsYqcreG8w1DFpFewYWlQ+79dpDUsEXTKUpQmMySYFEH/SWdLBY9xE08ZLk41ox
 sMXt0BPdJDbxWAc7Lqs6NrDVcIktV/51fg51m1V5q2e+5yNMb4aWeqOZJ58NzQuYhE+s1v66H
 mKMAU00TXgzxUruj5La5WcxUzURHooV2uPsje0OtihrrxYn4N0MSYYmp8l7o3g4rkwxZpnWc9
 iDLLuUl1COV5dwnztdHSuQ4Sqc7j1iicRw3+fZJjNwU8qONXriUP4O5tgCzKqYk3KUpR0Ij3H
 X3G76v1mvXR24ubmSqlvAwqmIidbmsWq9+mPDjIRU+4sazrQ8OiirFWmBKvuyoOaTnu6IcQe7
 YdDRyKTdG8AtRH3UO9tUZV2vo8cnGLV9sHHGtqB9+p1x41JXbk0oKrSUFp9ponno2duzcOXsQ
 J6uaQF6Z5AAY3VanOi+SmYVG8hXb2MfhqFeNOmz4gaS1vJqWtw2DGETiLsPwH9A9MBZ41DHH5
 LiVGrylY9OrBJYTXu0f8z2Y1qrAyu3Vdgfx4DGi3XqgUIubiGCdC/hStTbnZk7OYeRJ1xvVJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281361>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1379692850-1447710668=:1686
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Sun, 1 Nov 2015, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This is the rebased version since last time [1] with
> s/free_index_shm/release_index_shm/ as suggested by David Turner. It
> introduces a daemon that can cache index data in memory so that
> subsequent git processes can avoid reading (and more importantly,
> verifying) the index from disk. Together with split-index it should
> keep index I/O cost down to minimum. The series can also be found at
> [2].
>=20
> One of the factors that affected my design was Windows support. We
> now have Dscho back, he can evaluate my approach for Windows.

You flatter me! ;-)

Seriously again, this patch series comes at a very good time: I will have
a closer look soon (sorry about being so vague, but I am once again a
little bit short on time/brain cycles).

Thanks!
Dscho
--1784107012-1379692850-1447710668=:1686--
