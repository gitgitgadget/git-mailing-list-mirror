From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] test-lib.sh: Dynamic test for the prerequisite SANITY
Date: Wed, 28 Jan 2015 09:28:56 +0100
Message-ID: <54C89DC8.1050805@web.de>
References: <54C7B115.7020405@web.de> <xmqqh9vbkgrg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 29 03:07:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGeVx-0005wW-2Z
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 03:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761298AbbA2CHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Jan 2015 21:07:15 -0500
Received: from mout.web.de ([212.227.15.3]:53873 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761232AbbA2CHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 21:07:11 -0500
Received: from birne.lan ([78.68.171.17]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0MEER6-1YROUe3UvA-00FWxz; Wed, 28 Jan 2015 09:29:00
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqh9vbkgrg.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:9f+iAu476SC22vX5M0YZsGQNCG22t6visCdJzgGv+WZ3szLqVIV
 pNyCewVa03OFzw11qh7WcKD8PifGhrw6KZofK9ByJz5rApRbzULQLUTgphoCxmX5gpk1+Cz
 fJWiy60xR4i+pog4akT6KCgLtEqp+Vm5afw0PiE2/tix9hrf+3jmUNQxsRP3Momwmwu7UKY
 6p7/CHTt7k13ps1F7WvDA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263133>

On 27.01.15 23:20, Junio C Hamano wrote:

> How about extending it like this (not tested)?
Thanks, this looks good: the test is more extensive,
I can test this next week.

>=20
> -- >8 --
> From: Torsten B=C3=B6gershausen <tboegi@web.de>
> Date: Tue, 27 Jan 2015 16:39:01 +0100
> Subject: [PATCH] test-lib.sh: set prerequisite SANITY by testing what=
 we really need
>=20
> What we wanted out of the SANITY precondition is that the filesystem
> behaves sensibly with permission bits settings.
>=20
>  - You should not be able to remove a file in a read-only directory,
>=20
>  - You should not be able to tell if a file in a directory exists if
>    the directory lacks read or execute permission bits.
>=20
> We used to cheat by approximating that condition with "is the /
> writable?" test and/or "are we running as root?" test.  Neither test
> is sufficient or appropriate in more exotic environments like
> Cygwin.
How about going this direction:

We used to cheat by approximating that condition with "is the /
writable?" test and/or "are we running as root?" test. Neither test
is sufficient or appropriate, especially in environments like
Cygwin, Mingw or Mac OS X.
