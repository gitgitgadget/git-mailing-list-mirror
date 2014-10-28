From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 01/19] dir.c: optionally compute sha-1 of a .gitignore
 file
Date: Tue, 28 Oct 2014 18:37:17 +0100
Message-ID: <544FD44D.4000101@web.de>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com> <1414411846-4450-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 28 18:37:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjAi2-0002BP-FV
	for gcvg-git-2@plane.gmane.org; Tue, 28 Oct 2014 18:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbaJ1Rh0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2014 13:37:26 -0400
Received: from mout.web.de ([212.227.17.11]:59963 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbaJ1RhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2014 13:37:25 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0LqlSQ-1YM4Dz2nek-00ePk8; Tue, 28 Oct 2014 18:37:21
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1414411846-4450-2-git-send-email-pclouds@gmail.com>
X-Provags-ID: V03:K0:r+iJ2W9fAK8CZjQN62LlkGpVVJdNPHmj1ROZnSqnBmksBAsw7h0
 hHrau1fcrdwBHXUw2rykrfbVSi7Ixk1MKAeidk3ecoreC55i6GEeysdVmSGF7eQdDQIMp4I
 uazr1DQK4vg4zwpeG7D2zPjH8vmo5p7pg1fpP6yu5+fsKYWLVHdaxkuk9VBqcVPDrZo/X88
 XCiv2czMFmlY3lDurU/YA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2014-10-27 13.10, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
[]
Nice serious, I can imagine to test & benchmark it (so I assume there i=
s a branch=20
on github or so ?)
Another thing:
Can we switch the feature off?

It could be nice to benchmark with and without the cache on the command=
 line,
and besides that we may want to switch it on or off, depending on the f=
ile system.
I think this can be easily done when reading and writing the index file=
=2E
(But may cost a config variable, core.dirmtime ??)

To my knowledge there is support for the mtime in SAMBA (and probably N=
=46S),
but I can help to find out more.



> diff --git a/dir.c b/dir.c
> +static int add_excludes(const char *fname, const char *base, int bas=
elen,
> +			struct exclude_list *el, int check_index,
> +			struct sha1_stat *ss, int ss_valid)
Cosmetic question: does it make sense to write

struct sha1_stat *sha1_stat
or=20
struct sha1_stat *s_stat
