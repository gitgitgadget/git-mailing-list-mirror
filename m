From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Tue, 22 Sep 2015 20:40:06 +0200
Message-ID: <5601A086.5060104@web.de>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
 <1442875159-13027-3-git-send-email-sbeller@google.com>
 <xmqq37y78gzt.fsf@gitster.mtv.corp.google.com> <5600DF2D.9010202@web.de>
 <CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:40:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSUP-0006Kn-Hd
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934230AbbIVSkX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 14:40:23 -0400
Received: from mout.web.de ([212.227.17.12]:49866 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932151AbbIVSkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:40:21 -0400
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Ls91n-1ahXfd0xvr-013vxe; Tue, 22 Sep 2015 20:40:14
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.2.0
In-Reply-To: <CA+P7+xozmsT4mZsBdvSQkGx4Wk-bOE1h-vAbRG_LAL5A-MAwTw@mail.gmail.com>
X-Provags-ID: V03:K0:xSYPDrcwGvpqOhoPvF/VQWfeREiYHj/CM2cl1H32AvBltHZNms2
 o7e7AyqTgeTutW5GTTPzeFWbHFDDVghKHiozrnf52Hm+w2Xm9UFGsR2UZAiGJM48mERJ3y7
 9bUTA07/oIezUHEp2lcqPhv4OnjMJ4hhBwtSMjCPmJ7+TNGHAA3Pu21Z+bYyK0B4A/9QaCU
 lVGt3+Y5KkZ/JJ1ESLsog==
X-UI-Out-Filterresults: notjunk:1;V01:K0:U2o8FJfDnQs=:3P33r66zQh2kvSFNLOU0MX
 BjJpecvsiEyUzihCLQyjslZtPrvQerz12JMMv0zQm0a2W27qHgCtxaWpoipMBmg4fz1wwcwcr
 0NkC5SGJkEKtcQJ+jJqFZDp6SPoMfBcEG/dPumUbmpHoOFGwFY9N8IX4i6v8cUfGG/YSW2+mY
 tH1SSD/RjivyxH4MiAct1WwmtZ8HVIbZi1/QMgtJ2M9BgMAoi9t4cdd7KVhHS4ePZ7jKAQLaj
 5SeiPVI4aSgF8DoKRRoYCGMTFLNa1m2rt0Pch0WJ/jtH+RbdHQAXVWyRUc4nDxbSzaBI+0Z00
 tY4gKv/wf6THGbieV0zVgLiHGqxCpmjuqXnCyFlG+PmtYCAPN1ViFsm3dGFe4gShgdI3ul6zt
 GQZXL8eDfIOMka0U57UYR+bWsOAGQQ/uIcR4unyo4Yk//k6vMvfLFKPZLfj9bQMuwM8nqy6wX
 DT2z1Fe4Bqj9cdtDZgpiGLpQPtgVKaikuhNlAqjzJ+SzJjCpu8DoF2f9qh1LqqtYdxYdOi5P2
 n95jrW/3q1Bbf33TYtJ75WNRk4QBKlw+0dp2mSEUY/7NxHBUnYnuopCFXCtF7hE0sxlWHqh0b
 Ip1oC3A5AUjm5vlfobjrSGRr/tfrllNg9JKzwIzX0G6QwHte0Nd0ijlviTSw6l20a7KrXSYkp
 KFfrW8w+w0IeYGT9EIOa3CyV2Z5N9TPJlpk+ye8e8bNdpjiM4X8/fIBG9PMxFkJZZUuiPGoaS
 FspGtd71bQPd918Hx9aRVreV1bi8Y8uuMx5rCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278412>

On 22.09.15 08:23, Jacob Keller wrote:
> On Mon, Sep 21, 2015 at 9:55 PM, Torsten B=C3=B6gershausen <tboegi@we=
b.de> wrote:
>> But in any case I suggest to  xread() as it is, and not to change th=
e
>> functionality
>> behind the back of the users.
>>
>>
>=20
> I don't think this patch actually changes behavior as it stands now. =
I
> think Junio's suggestion does. Personally, I'd prefer some sort of
> warning when you use xread and get EAGAIN or EWOULDBLOCK. I'd rather
> see it somehow warn so that we can find the bug (since we really
> really shouldn't be calling xread with a blocking socket, especially
> if we have xread_noblock or similar as in this series.
>=20
> Not sure if we really want to handle that, but I know we don't want t=
o
> change external behavior of xread... I think that polling is better
> than the current "spinning" behavior.
>=20
> Regards,
> Jake
Oh sorry for my comment, I mis-read the whole thing completely.

And yes, a warning would be better than a poll()
