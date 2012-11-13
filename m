From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 14/13] test-wildmatch: avoid Windows path mangling
Date: Tue, 13 Nov 2012 19:06:15 +0100
Message-ID: <50A28C17.9020506@kdbg.org>
References: <7vvcdco1pf.fsf@alter.siamese.dyndns.org> <1352801169-10501-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:06:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKsc-0001HA-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:06:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab2KMSGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2012 13:06:20 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:61655 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab2KMSGT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:06:19 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 25589130056;
	Tue, 13 Nov 2012 19:06:16 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 5D6D719F30E;
	Tue, 13 Nov 2012 19:06:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121025 Thunderbird/16.0.2
In-Reply-To: <1352801169-10501-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209649>

Am 13.11.2012 11:06, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
> On Windows, arguments starting with a forward slash is mangled as if
> it were full pathname. This causes the patterns beginning with a slas=
h
> not to be passed to test-wildmatch correctly. Avoid mangling by never
> accepting patterns starting with a slash. Those arguments must be
> rewritten with a leading "XXX" (e.g. "/abc" becomes "XXX/abc"), which
> will be removed by test-wildmatch itself before feeding the patterns
> to wildmatch() or fnmatch().
>=20
> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Sun, Nov 11, 2012 at 5:47 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>  > The title taken together with the above explanation makes it sound
>  > as if wildmatch code does not work with the pattern /foo on Window=
s
>  > at all and to avoid the issue (instead of fixing the breakage) thi=
s
>  > patch removes such tests....
>=20
>  OK how about this?

Thanks, the patch lets the tests pass on Windows.

-- Hannes
