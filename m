From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Fri, 6 May 2016 17:34:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605061733170.2963@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org> <alpine.DEB.2.20.1604251704300.2896@virtualbox> <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com> <572BA80E.3000309@kdbg.org>
 <CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 17:35:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayhmO-0001Hz-RN
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 17:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758143AbcEFPe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 11:34:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:57666 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758037AbcEFPe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 11:34:56 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MXIov-1bB6Gl1fSH-00WIrd; Fri, 06 May 2016 17:34:34
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Y5dPoipeZ1svo5W5naS2skI2nrHF46Ea//2+NVg0A/7L8rNm0ip
 9vs600xk5w2J0ZINmppsHb/KzezjWmYcxeV8UAmtDhfPdeuSrAqnTivq90diUxcxEkv528F
 p1wpGzOjvUvguO2hu6IdvX+0Sn+kuTBCGuFWq4nJ4K2D1xYMgEbgLzBVkXCJRSLx+3Rij4Q
 lRJjPI1qE5CWUjpSHJK5Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dI+weC/P20U=:xNDEGP8w/mG5aweyxTnfvp
 pzyEQoNXQVo1YO6CjdlnzBFgQm2/O/ublcqIS2VKFAoxXIEnKPH/Zxr1jhLRq2h0AHrtye+T2
 e3A+tYx1rZ5s76BHDpu9TFkQDndOG1FNRYodBnGowXdeJiMJY6vgcaY9BLQBzKjK8CGk6KVxx
 C0IiajAV+5oX+f5hlNUyK/kOt2UaiVtNj/Xym4PyxWhZpvp/3S/2CtlWGDp/cgTjflmo0Qchr
 NF4FNknxSAfEu7Q6AU7kSBFwE97Hr9RmX1qKslddvHrrN8llNwUZ34FVKHcUzt4IOveMYr+um
 BN1GWLLrPXO75V3PsI5XRd+jFObwISshKzllxJxiIrXPVE0y0TbLOyckT5Lkc0jx31NVM6sxP
 1sgqvetxx0dwM/dnzCWsUrxSPnZNgkmMpE/myekaTNuxiz0Jl79wK3ytF+UhMJFEDmYUmEOvY
 CzB/e88EUpKodespKVhKmPNz5ZyI8KLhEbVSpu7tkK0jq8BBqC0nLGp9xFbyOH0CTGwR9CBKV
 +UJL+lvix+JhQAXd+R4PhR9oBtrJS/b7YD79VaSP1OCSbq6kASluWR0gk5h1/lZk6p+qqRIq3
 KWhW6t0/NhWUr8PyZRnMTrKxWf1/SvylNnlKXME9tZGnTmGpoLCISwCDujw43XY9Ys3OQNdA3
 gJNMIOp5RxPfxujNbGQnb/emfNFRlE+Rn+Ww7rdAB8uj/3HtEWv1WgyL7t/nw0mT225brOSL8
 VVWwt2bhO1CfnW2jrJqukNsfl0ApQyLNBmFKanym6MQXt+v1d3S2LtdwGVsHrpMThNna5fSi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293791>

Hi Chris,

On Fri, 6 May 2016, Christian Couder wrote:

> On Thu, May 5, 2016 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Am 05.05.2016 um 11:50 schrieb Christian Couder:
> >>
> >> On Mon, Apr 25, 2016 at 5:05 PM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >>>
> >>> Hi Chris,
> >>>
> >>> On Sun, 24 Apr 2016, Christian Couder wrote:
> >>>
> >>>> diff --git a/run-command.c b/run-command.c
> >>>> index 8c7115a..29d2bda 100644
> >>>> --- a/run-command.c
> >>>> +++ b/run-command.c
> >>>> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
> >>>>   }
> >>>>
> >>>>   #ifndef GIT_WINDOWS_NATIVE
> >>>> -static inline void dup_devnull(int to)
> >>>> +void dup_devnull(int to)
> >>>>   {
> >>>
> >>>
> >>> The #ifndef GIT_WINDOWS_NATIVE rings very, very loud alarm bells.
> >>
> >>
> >> Yeah, but I must say that I don't know what I should do about this.
> >> Do you have a suggestion? Should I try to implement the same function
> >> for Windows?

No, you should change the code that requires that ugly dup()ing so that it
can be configured to shut up.

> > No, just remove the #ifndef brackets. There is already code in
> > compat/mingw.c that treats the file name "/dev/null" specially.
> 
> Ok, I will do that in the same patch though the "#ifndef
> GIT_WINDOWS_NATIVE" was already there before.

The idea was that compat/mingw.c is *really* only for the MINGW version,
not for the MSVC version.

Ciao,
Dscho
