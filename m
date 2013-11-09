From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 0/5] fix up 'jk/pack-bitmap' branch
Date: Sat, 09 Nov 2013 12:35:09 +0100
Message-ID: <527E1DED.9030800@web.de>
References: <527C0CEA.4020705@ramsay1.demon.co.uk> <20131107221944.GA19238@sigill.intra.peff.net> <527D1B06.3090807@web.de> <20131108222903.GB19912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Vicent Marti <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 09 12:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf6ov-0001O8-JH
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 12:35:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab3KILfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Nov 2013 06:35:13 -0500
Received: from mout.web.de ([212.227.17.11]:58143 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab3KILfM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 06:35:12 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MCIe5-1VWcMJ1EWn-009Bgz for <git@vger.kernel.org>;
 Sat, 09 Nov 2013 12:35:10 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <20131108222903.GB19912@sigill.intra.peff.net>
X-Provags-ID: V03:K0:UqHMJ838NDzm6oDRi3wKHx3kmAyaYe/Xx7B1nE8zttKSwseuTr7
 TVfoX8ceK0wSTNmyUyHGOQVzkE82k2hCwdAzu6pOAtL2nM26aG+mVA6KPLnA3ZhblJXbkpp
 MoFmIk6IIiV4JqR8z7L36Pk5OqCQeX0u8GMgbTncUZ/hTswGoWmdX1n+QUVGCvi6qAkBB9W
 0lncNK3tyVA1mYWdqCQ0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237574>

On 2013-11-08 23.29, Jeff King wrote:
> On Fri, Nov 08, 2013 at 06:10:30PM +0100, Torsten B=C3=B6gershausen w=
rote:
>=20
>> Side question:
>> Do we have enough test coverage for htonll()/ntohll(),
>> or do we want do the "module test" which I send a couple of days bef=
ore ?
>=20
> The series adds tests for building and using the ewah bitmaps, which =
in
> turn rely on the htonll code. So they are being tested in the existin=
g
> series.
>=20
> -Peff
You are thinking about t5310-pack-bitmaps.sh ?
If I do like this in compat/bswap.h

# define ntohll(n) (n)
# define htonll(n) (n)
(on an Intel processor, little endian)

then t5310 passes, even if the uint64_t words are written
in little endian to disc instead of big endian.

What do I miss?
/torsten
