From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: bug & patch: exit codes from internal commands are handled incorrectly
Date: Thu, 18 Dec 2014 18:43:15 +0100
Message-ID: <54931233.6080900@web.de>
References: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com> <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Kenneth Lorber <keni@his.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 18 18:43:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1f6l-0005DF-1B
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 18:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbaLRRnX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2014 12:43:23 -0500
Received: from mout.web.de ([212.227.15.3]:59389 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033AbaLRRnW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 12:43:22 -0500
Received: from birne.local ([78.72.72.190]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LbftD-1Xcons1TTv-00lB6q; Thu, 18 Dec 2014 18:43:19
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com>
X-Provags-ID: V03:K0:K66XEYnTTsdt0bY/VlyphdO1ETWgpIGqJSlRJj+gv8SJOZBhM4S
 S9UUHtcbO5qpydzouHTAwHiqqDL8RtbNW4u3WDSAwYKwCR6Ox721QUMy8y/HZbnh0Pff7VZ
 /u9En/UvPfywS5tUFSrgnGAzaexSmIYVsxcUm35X3wbWQe/wzNJpucZofp2CuDYCk4GZNFJ
 HW/yHAk5yc1TV1oVrkB+A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261531>

On 18.12.14 03:15, Kenneth Lorber wrote:
> The situation is actually slightly more complex than I stated previou=
sly.  From the docs:
>   The exit value of this program is negative on error,
> But there=92s no such thing as a negative error code under Unix, so (=
at best) that will be exit(255).
>=20
> No patch, because this is getting painfully close to needing someone =
with a global view of the code to fix.
>=20
> Thanks,
> Keni
>=20
My spontanous question:
Would it be save to clamp at 127 ?

>> +       if (status > 127)
>> +               status =3D 127;   /* prevent exit() from truncating =
to 0 or becoming negative */


(And the rest looked good enough to become a patch,=20
or at least to start a wider discussion)
