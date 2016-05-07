From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Sat, 7 May 2016 14:13:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605071409490.2963@virtualbox>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org> <alpine.DEB.2.20.1604251704300.2896@virtualbox> <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com> <572BA80E.3000309@kdbg.org> <CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
 <alpine.DEB.2.20.1605061733170.2963@virtualbox> <CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Sat May 07 14:14:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az17b-0003S6-5d
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 14:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752146AbcEGMNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 08:13:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:50302 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbcEGMNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 08:13:45 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Ldspr-1bPaDY4AuB-00j0r5; Sat, 07 May 2016 14:13:24
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:KzWUvID0MDaahfX1Y8Bu4dXwOuKY+MjB9igurBJZFVvpcumBtmf
 zCu4l1Ym+M8u9nzs4JCprHFhmYLTeNzrcMqUmEb+R4YTz4zfL/J21bJSFnnS+zf6k0SL+VH
 kXnfn9u+I6jAcvlTi+dXTVknGxTtlRi5M9cLlDjlXfj7k/c7suLBC3JR4MmAUHgdk2kjwAz
 NW0Fy38Af2OB6sOKqldeA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/GzoPjoEw6s=:GvgU5yrK4uPd1RE+9wiv7w
 MiYxhRiRQ67O1DttlBfZsWxj0BHvxvOc0NhMkKqZS2GNAccwfO3WCAr3hq5OV5qV28nFfJmSZ
 yE6/wh0DySIEiqJMG79MYP0krCK+jXdRMQFTGnJI+2uKsRk2TRrb8YXjhS1BgYRwE3bssecqW
 SdhV8uo9fmlmg3h9f1A9Bjgpf5dfEXkTMrI0V3i6fSOPh2YnRpjGOmE1MTngXJIDv2yXeuXDa
 /K/9d6/NMDAxKi4lPB3eFfg6/f/50a0I+cQtf3o/t02wcWpRGaETfmk6l/pm89Tu19WbBbhY/
 gNPfVzjG24h2dQH78LCFjm21Tz0c5vtwkOVhECKncq1ASrnF1j6VGXItEppXMlIRXFhshQKda
 Tslr3HRbGCZ62d9zYegbNuI1KcUy18xJcPW7WeUd710OFGtGm5NzZG9kPD/NgS2G1kYBLRLhQ
 xDyhi7z06to+82DBtLTYJJGM3qpXZEAgqDNrrlRaPem12A5BkpXCUJpw3Q2+DgaM62Avl8B21
 Agqih0rExKTaQ+M2If9wauldMvk55fOV02DKbsRlMiZuPszyEKu5l490M4JROhFOr+k71ECQ/
 HdzM11u/Ismm7gviD6jldJNx6zXuWutF9VYZVb3eCk14YE8p6kUThTWKPb2gwgcNstGd++XXo
 Vl9bt6vEYRI172ZzU4mZrcPFpmMDsqU9LdUihL+fVu2UJx1pBBsTA3kDpXX66O+e0aOWeCuQS
 hTxuPlSdLNEABBVir8TXYqmZRYuool7qALBj/bVJM2OcDM+1VPBxisSqCxoMWcZle1YUkD8s 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293892>

Hi Chris,

On Sat, 7 May 2016, Christian Couder wrote:

> On Fri, May 6, 2016 at 5:34 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Fri, 6 May 2016, Christian Couder wrote:
> >
> >> On Thu, May 5, 2016 at 10:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> >> > Am 05.05.2016 um 11:50 schrieb Christian Couder:
> >> >>
> >> >> On Mon, Apr 25, 2016 at 5:05 PM, Johannes Schindelin
> >> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >>>
> >> >>> Hi Chris,
> >> >>>
> >> >>> On Sun, 24 Apr 2016, Christian Couder wrote:
> >> >>>
> >> >>>> diff --git a/run-command.c b/run-command.c
> >> >>>> index 8c7115a..29d2bda 100644
> >> >>>> --- a/run-command.c
> >> >>>> +++ b/run-command.c
> >> >>>> @@ -85,7 +85,7 @@ static inline void close_pair(int fd[2])
> >> >>>>   }
> >> >>>>
> >> >>>>   #ifndef GIT_WINDOWS_NATIVE
> >> >>>> -static inline void dup_devnull(int to)
> >> >>>> +void dup_devnull(int to)
> >> >>>>   {
> >> >>>
> >> >>>
> >> >>> The #ifndef GIT_WINDOWS_NATIVE rings very, very loud alarm bells.
> >> >>
> >> >>
> >> >> Yeah, but I must say that I don't know what I should do about this.
> >> >> Do you have a suggestion? Should I try to implement the same function
> >> >> for Windows?
> >
> > No, you should change the code that requires that ugly dup()ing so that it
> > can be configured to shut up.
> 
> After taking a look, it looks like a routine that does nothing could
> be passed to set_error_routine() and that could do part of the trick.
> 
> This part might not be too ugly, but it would anyway be more complex,
> less close to what the code is doing now and more error prone, as one
> also need to make sure that for example no warning() or
> fprintf(stderr, ...) are called and nothing is printed on stdout.

I am afraid that you *have* to do that, though, if you truly want to
libify the code.

Of course you can go with really ugly workarounds instead. Something like
a global flag that die() and error() and warning() respect. It would
incur some technical debt, but it would make your life easier in the short
run.

Both the real solution and the workaround would be better than the current
version of the patches that dup() back and forth, just to avoid addressing
the real problem.

Ciao,
Dscho
