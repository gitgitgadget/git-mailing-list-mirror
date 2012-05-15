From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] builtin/blame.c: Fix a "Using plain integer as NULL pointer"
 warning
Date: Tue, 15 May 2012 18:33:12 +0100
Message-ID: <4FB29358.90408@ramsay1.demon.co.uk>
References: <4FB02A7C.1000605@ramsay1.demon.co.uk> <4FB0463D.4010909@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue May 15 19:33:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SULci-0000YB-Ig
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 19:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966099Ab2EORdU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 13:33:20 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:60923 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966052Ab2EORdT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 13:33:19 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1SULcb-0006TC-oC; Tue, 15 May 2012 17:33:18 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4FB0463D.4010909@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197845>

Ren=E9 Scharfe wrote:
> Am 13.05.2012 23:41, schrieb Ramsay Jones:
>>
>> Signed-off-by: Ramsay Jones<ramsay@ramsay1.demon.co.uk>
>> ---
>>
>> Hi Junio,
>>
>> I try to catch these warnings, while the topics are still in the
>> pu branch, so that we can squash the fix into them before they
>> hit next. I don't know how I missed this one (commit 4b4132f,
>> "blame: factor out helper for calling xdi_diff()", 09-05-2012)
>> which was part of the 'rs/xdiff-lose-emit-func' branch.
>>
>> Sorry about that.
>>
>> ATB,
>> Ramsay Jones
>>
>>
>>   builtin/blame.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index 778d661..24d3dd5 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -93,7 +93,7 @@ static int diff_hunks(mmfile_t *file_a, mmfile_t *=
file_b, long ctxlen,
>>   {
>>   	xpparam_t xpp =3D {0};
>>   	xdemitconf_t xecfg =3D {0};
>> -	xdemitcb_t ecb =3D {0};
>> +	xdemitcb_t ecb =3D {NULL};
>>
>>   	xpp.flags =3D xdl_opts;
>>   	xecfg.ctxlen =3D ctxlen;
>=20
> The warning is given by sparse, not a C compiler, correct?  It's=20
> probably worth shutting it up by making that change; my excuse for us=
ing=20
> {0} is that it is such a nice and portable idiom [1] for initializing=
=20
> any structure, however.

Yes, sorry, it is indeed a sparse warning. (The original
subject line mentioned sparse, but it was too long ... ;-)

Thanks!

ATB,
Ramsay Jones
