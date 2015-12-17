From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCHv2 2/7] xread: poll on non blocking fds
Date: Thu, 17 Dec 2015 21:42:01 +0100
Message-ID: <56731E19.7050504@web.de>
References: <1450224252-16833-1-git-send-email-sbeller@google.com>
 <1450224252-16833-3-git-send-email-sbeller@google.com>
 <56731715.9000509@web.de>
 <CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9fNZ-00076Q-Pq
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 21:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbbLQUmW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Dec 2015 15:42:22 -0500
Received: from mout.web.de ([212.227.15.3]:57887 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139AbbLQUmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 15:42:21 -0500
Received: from birne9.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0LgpIE-1aWMby3eoI-00oIDZ; Thu, 17 Dec 2015 21:42:05
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.4.0
In-Reply-To: <CAGZ79kZD_vrwHyd2WZzx-9FF3D6CVVi6X=Cx1=HAgr1gqNKyaA@mail.gmail.com>
X-Provags-ID: V03:K0:AIJ36vTT40S6sjt03czwPNn1Ne7vwT3Ug2szJqYO0/GeVzqpLlN
 0yiqr0F8QCzkMY5E5SC3kzLXmSBhy7lCCR8vQFBGAJMgMS3QJU8BpegS3ehSTK6za+2d+GP
 zvJNIr97zSsIvDoF7dkgq3SkZBPsIqDWhpf+fHcve5oazLfdILDr3beo4Kyd8bXEbyLw3YE
 pT0U38IZbPjY0K+r2RwQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1D2hOAwkM3M=:k4p7ffPLujs5lrISfmDr5d
 NlUeQH27NspwtXI6NBxjW6HAqI2oDNvJGAICeuAshxum6kmeRa3Pk/m36912Ijm4wuUT+PaB5
 /9ATzXDnizPVpN9/aUjHFtZCgAKZzgKTf31fW7YcpMRQuHoh6LlTek6pU0PEWESgzmY+xA7x7
 01xhm//Ulyx0cNLyjrb1wUb4+TjNA5DxJqdg26C3SebKclNtHFbV0JjQcy72xAWH7dVrsF7mi
 tx26uX8FgWwdcxv8xvvsQWLxeSr9rwvzyZBYH1L2PJRir+xUkenC4GR/x7AXpJRdX4DNV0T0k
 Z319yp0ck6EtD8eZgRcOmVGIK4AcXTkinfQuO4+F2gL5FylBehG3EikqSV+NYMvcOuSF4FeD7
 2sCQfCc8u9XCHPYpfFMRAqASHGAsOj7APGK1ZrUyo8rnwsiTBDuBDawq1cKjYeOSRXAQNqwgU
 4vGOVR7sJU9rnRaQNnjt2e+wtws1LVbUJuW0eXzZ2aYfkVDlk7nukjTL4dNyFXd0HNorBilcZ
 R3TSeDPr+HkDdVImJQve8YiuHvsZwVxkop/k6J9vnDOBqHBXoN2w4CdFO+QBM3gS+JPeE4zWk
 IWsbgrVQZoUh556X4hAmX06f3AeP8rBLxUcZcNjm4RNjOFBupwT7tPN2vNosnPU7/RNIWp2s5
 fuNTdAT3M4yQ7GMeASXFmLGpZUHobl1tzgEYr9XAEKlqco/ppsicXmr3N2ktc8mM8CYwbMyHi
 SlXHlQhc856Ro5IsK97FiKD3vFVmQq1tElOpanvzD4pidcvtDozn1MjdBQ/5plGDR/bcNguU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282674>

On 17.12.15 21:22, Stefan Beller wrote:
> On Thu, Dec 17, 2015 at 12:12 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>> On 16.12.15 01:04, Stefan Beller wrote:
>>> The man page of read(2) says:
>>>
>>>   EAGAIN The file descriptor fd refers to a file other than a socke=
t
>>>        and has been marked nonblocking (O_NONBLOCK), and the read
>>>        would block.
>>>
>>>   EAGAIN or EWOULDBLOCK
>>>        The file descriptor fd refers to a socket and has been marke=
d
>>>        nonblocking (O_NONBLOCK), and the read would block.  POSIX.1=
-2001
>>>        allows either error to be returned for this case, and does n=
ot
>>>        require these constants to have the same value, so a portabl=
e
>>>        application should check for both possibilities.
>>>
>>> If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
>>> As the intent of xread is to read as much as possible either until =
the
>>> fd is EOF or an actual error occurs, we can ease the feeder of the =
fd
>>> by not spinning the whole time, but rather wait for it politely by =
not
>>> busy waiting.
>>>
>>> We should not care if the call to poll failed, as we're in an infin=
ite
>>> loop and can only get out with the correct read().
>> I'm not sure if this is valid under all circumstances:
>> This is what "man poll" says under Linux:
>> []
>>  ENOMEM There was no space to allocate file descriptor tables.
>> []
>> And this is from Mac OS, ("BSD System Calls Manual")
>> ERRORS
>>      Poll() will fail if:
>>
>>      [EAGAIN]           Allocation of internal data structures fails=
=2E  A sub-
>>                         sequent request may succeed.
>> And this is opengroup:
>> http://pubs.opengroup.org/onlinepubs/9699919799//functions/poll.html=
:
>> [EAGAIN]
>>     The allocation of internal data structures failed but a subseque=
nt request may succeed.
>>
>> read() may return EAGAIN, but poll() may fail to allocate memory, an=
d fail.
>> Is it always guaranteed that the loop is terminated?
>=20
> In case poll fails (assume a no op for it), the logic should not have
> changed by this patch?
>=20
> Looking closely:
>=20
>>>       while (1) {
>>>               nr =3D read(fd, buf, len);
>>> -             if ((nr < 0) && (errno =3D=3D EAGAIN || errno =3D=3D =
EINTR))
>>> -                     continue;
>>> +             if (nr < 0) {
>>> +                     if (errno =3D=3D EINTR)
>>> +                             continue;
>>> +                     if (errno =3D=3D EAGAIN || errno =3D=3D EWOUL=
DBLOCK) {
>>> +                             struct pollfd pfd;
>>> +                             pfd.events =3D POLLIN;
>>> +                             pfd.fd =3D fd;
>>> +                             /*
>>> +                              * it is OK if this poll() failed; we
>>> +                              * want to leave this infinite loop
>>> +                              * only when read() returns with
>>> +                              * success, or an expected failure,
>>> +                              * which would be checked by the next
>>> +                              * call to read(2).
>>> +                              */
>>> +                             poll(&pfd, 1, -1);
>=20
> Or do you mean to insert another continue in here?
I was thinking that we run into similar loop as before:
read() returns -1; errno =3D EAGAIN  /* No data to read */
poll() returns -1; errno =3D EAGAIN /* poll failed. If the fd was OK, t=
he failure may be temporaly,
                                    as much as poll() can see.
                                    But most probably we run out ouf me=
mory */

So the code would look like this:

   if (!poll(&pfd, 1, -1))
      return -1;


>=20

>>> +                     }
>>> +             }
>>>               return nr;
>>>       }
>>>  }
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
