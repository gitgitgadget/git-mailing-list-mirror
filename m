From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Fri, 18 Dec 2015 09:50:46 +0100
Message-ID: <5673C8E6.8010001@web.de>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
 <1450224252-16833-3-git-send-email-sbeller@google.com>
 <56731715.9000509@web.de>
 <CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
 <56731E19.7050504@web.de> <20151218031336.GA8467@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 18 09:51:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9qlR-0005Nt-5p
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 09:51:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934563AbbLRIvb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Dec 2015 03:51:31 -0500
Received: from mout.web.de ([212.227.17.12]:59044 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934981AbbLRIv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2015 03:51:27 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0LfiuU-1aXPBn2WYE-00pImn; Fri, 18 Dec 2015 09:50:53
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <20151218031336.GA8467@sigill.intra.peff.net>
X-Provags-ID: V03:K0:LsxryS/tABL+CqKq32tGAnoNsaXWl1AS7F+Ifyf1i6L0vplJ3pf
 sAGIB3+lgSdKeiZYGpH0cAJ+1DXeUTWmzRmiSQ2kgILVafGOlLOotKUkPjiALdTjCyNx2CY
 WqO/qLUOQXY36G78VOqTov3na6DQiGa3tEnKW0/Ztcz1jdKrmLlUThnNmkgt8FH2Kri5YT2
 X8hROqZb1kyaBQs4ZM/EA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/zWmsgKZn1E=:XlJzvv7XsYhOfxafX0qvms
 EvsPHZTjMC+lqGyf+Gokv4WGGRfPnnJCtpjwOIC2nPc6rPxEXbSwDjep8+tDyi3MkZK9zImtR
 bsHnVoWzpZ87xv5cL2rirQg7/A/QBSZyruoMxPqVP1z/w2hJfw1qsJrVPFpG7w3cVDc9vRrID
 KV13ab2QUu7bO3R3Fssf9M1WuoMHTBOmyP+1o/0sWW5IZCkaegjUt/tFRKzAyrZfeIVvBb1GQ
 +W2XPZQvZvng6wA3wPdSvMNg8YKAP3QvzCoBJR/cm+2Ew0Bo2iFyaHXkI6mr248/htZoG+Y3n
 tT1wD1O/PHa+fXn9sQY7zaIZT3IyVGqURgMA4jsR5XN7Ewl8zrvM+xTkS6gk6mN1QE2soXD+7
 vgDrfOFeeQ8O3jjKRPVgOqoY6fhMvmdFDZeP9ATpV/He+v2uw70xIyMGXivoy/5SJtT7QrXQC
 yOdhmg6+goVj2MeMGaeSIr9qfZfXOLPXwFCZ2dcRGypooHooovFn30n0ZcWDMWHVjyg3S2cVm
 oFWp/y2CxdpIDfyhTPbgSvfl7Ow0gNuGqma9rWKY0H3uyeVU0kIitFUxWWHpUTK+FJp6HGi8H
 erif8wU3b1gMscwwR+UdXr459MxwsWzLp6SXaX/JpNA9XiXn9aR+AyUriX3GAwZIc4a+yzvpk
 nWWiLhPY2IAqkOMtT17SOYq3WQRefNdCRxx4htpMQtYT+a24vJCTiWpqEHGmwABaL1Orgc5P3
 ia9bsFCTNgvs3OSoAxmKRB8bGppRrvsMX+195EsIbmxzRUiGFWb1B9QisgeLF5vUsiNr9HZj 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282703>

On 18.12.15 04:13, Jeff King wrote:
> On Thu, Dec 17, 2015 at 09:42:01PM +0100, Torsten B=C3=B6gershausen w=
rote:
>=20
>>> Or do you mean to insert another continue in here?
>> I was thinking that we run into similar loop as before:
>> read() returns -1; errno =3D EAGAIN  /* No data to read */
>> poll() returns -1; errno =3D EAGAIN /* poll failed. If the fd was OK=
, the failure may be temporaly,
>>                                     as much as poll() can see.
>>                                     But most probably we run out ouf=
 memory */
>>
>> So the code would look like this:
>>
>>    if (!poll(&pfd, 1, -1))
>>       return -1;
>=20
> That changes the semantics of the function. The poll() is just a
> convenience to avoid spinning. If it fails, with Stefan's patch[1] th=
e
> worst case is that we would spin on read() and poll(), instead of
> actually blocking in the poll().
>=20
> But if we return on poll() failure, now the caller will see errors fr=
om
> poll() even though they don't know or care that we called poll() in t=
he
> first place. Consider what would happen with your code if read got
> EAGAIN and then poll got EINTR. We would report an error, even though
> the whole point of xread() is to loop on these conditions.
>=20
> -Peff
>=20
> [1] Stefan's patch does have a bug. It forgets to "continue" after
>     calling poll, which means we will block with poll and _then_ exit
>     with -1, instead of restarting the loop.
> --
I love this group: Curing one bug with another doesn't work :-)

/* So the code v2 would look like this: */

    if (!poll(&pfd, 1, -1)) {
        if (errno =3D=3D EINTR)
            continue;
         return -1; /* poll() failed, this is serious. */
    }
