From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/4] Refactor skipping DOS drive prefixes
Date: Sun, 24 Jan 2016 11:56:26 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601241152060.2964@virtualbox>
References: <cover.1452536924.git.johannes.schindelin@gmx.de> <cover.1452585382.git.johannes.schindelin@gmx.de> <05cb9e00756e8a364f972cd227804764f6a6380c.1452585382.git.johannes.schindelin@gmx.de> <56A279DA.8080809@kdbg.org> <xmqq60ylv3bk.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601230924090.2964@virtualbox> <56A3CE34.20808@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Jan 24 11:57:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNIMC-0000uN-B3
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 11:57:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbcAXK4n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 05:56:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:57071 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbcAXK4l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 05:56:41 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MMT1y-1aTLoT1vkU-008GV3; Sun, 24 Jan 2016 11:56:27
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <56A3CE34.20808@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:X7HpH9mvt3ZqnuAE0HIGyFWMaxXOlLuqoF2mLNq4ipwVbdTVFNA
 MU9Gv38UydHoebNyZ7eG3Ub7HR8oOeF9Llxa+lwSotugwytoOwIeLGkB6872Se78VvYbscn
 vBkbiTk/ew/q/+1bSxjeBztCNwhjvqfA1nOA+l1U9cECXGiWV15erz2M3saZxLsp06DoFsC
 I8ucAMsXxLT6Uf7uyt/UA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yeSZNVg2HY8=:/HlPoOTfjsRmje7b2r6sro
 nII0ygjL/3lKwz5Z1PMP7CaWepSX38dWWk5A01ARp9mLZcGjLjX5OUxHB0M+OEZPtNbLgKcIw
 WNJkyHTJ7e4qKomwgejXJL71O9AxGGw96YFeYrd73oZG8vnHygStsUyTlLi+V1xlz6lVHr5VV
 wAPUO8eIoW0TY+p/B3SIenA75VAVbQTbSJokl9AT4pk9s6YImHk71HkDEyw5RI2/yXUv6J9Ou
 AdyvTR0BJxm0oxTfuHwK6p9+mgAaTYUnsSouIAdajd+jAgWu5psThB0DCUK+iTzMxKEIuHbEa
 KwEPa/ooJRKlwkwvcHt3TnvBzLBoaShe2ccaz4xORjX+vUW95h6EZrfpx2tt/OIaOA8dhqhtp
 878ffaY/8PSLN8yhvA3kseQODodZjQoALzmsUHsX61otJDUpOJ6mwI/KlQ9+ld1ToJOt0O+Ce
 WPg6w4MmQZ9hJ/HXSjF7hx70EFB9+6+6ofNaxAf9FMfW7/EsDZaflyGi2bPI0t+j8DjQmFJ0D
 j+9mbxTuAqGMX0ZTC5FvnQ4nAvHaOv2rKEuCmnu3s0GceYJ3Ts+rONpfDqTSJxCCWG+n291OJ
 4K1nJedq6BCSGDJSdEWqMQuEaLtPUkb+eRHs4/o+Q1T+RtYE2lNIAJ5udRa06L6c0bYmiMd8a
 Vq3imBvaRY9UsSsHEPjFgx+rgHv1J1fhMfoXz81GdgnheIq3hBxRD0+ncgKPVyEm965rhmZG7
 4/kE229yAPeUdqONJ2WXZ4WQiyneOI4adNF6izd0RDyegSH4RSEhDPms08ern2tMH4d9cQIw 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284645>

Hi Hannes,

On Sat, 23 Jan 2016, Johannes Sixt wrote:

> Am 23.01.2016 um 09:25 schrieb Johannes Schindelin:
>
> > On Fri, 22 Jan 2016, Junio C Hamano wrote:
> >
> > > Johannes Sixt <j6t@kdbg.org> writes:
> > >
> > > > I suggest to move the function definition out of line:
> > > >
> > > > diff --git a/compat/mingw.c b/compat/mingw.c
> > > > index 10a51c0..0cebb61 100644
> > > > --- a/compat/mingw.c
> > > > +++ b/compat/mingw.c
> > > > @@ -1915,6 +1915,13 @@ pid_t waitpid(pid_t pid, int *status, int
> > > > options)
> > > >   	return -1;
> > > >   }
> > > >
> > > > +int mingw_skip_dos_drive_prefix(char **path)
> > > > +{
> > > > +	int ret = has_dos_drive_prefix(*path);
> > > > +	*path += ret;
> > > > +	return ret;
> > > > +}
> > > > +
> > > >   int mingw_offset_1st_component(const char *path)
> > > >   {
> > > >   	char *pos = (char *)path;
> > > > diff --git a/compat/mingw.h b/compat/mingw.h
> > > > index 9b5db4e..2099b79 100644
> > > > --- a/compat/mingw.h
> > > > +++ b/compat/mingw.h
> > > > @@ -360,12 +360,7 @@ HANDLE winansi_get_osfhandle(int fd);
> > > >
> > > >   #define has_dos_drive_prefix(path) \
> > > >   	(isalpha(*(path)) && (path)[1] == ':' ? 2 : 0)
> > > > -static inline int mingw_skip_dos_drive_prefix(char **path)
> > > > -{
> > > > -	int ret = has_dos_drive_prefix(*path);
> > > > -	*path += ret;
> > > > -	return ret;
> > > > -}
> > > > +int mingw_skip_dos_drive_prefix(char **path);
> > > >   #define skip_dos_drive_prefix mingw_skip_dos_drive_prefix
> > > >   #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
> > > >   static inline char *mingw_find_last_dir_sep(const char *path)
> > >
> > > This sounds good to me.  Dscho?
> >
> > Yep, sounds good to me, too.
> >
> > Personally, I have no inclination to add compatibility with the
> > now-safely-obsolete MSys to my responsibilities, but if Hannes wants to do
> > it, who am I to stand in his way? Especially when the fix is as trivial as
> > here.
> 
> This is not a matter of compatibility. I am VERY curious why you do not see
> an error (or warning) without my proposed fixup. As I mentioned, isalpha() is
> defined much later than the definition of mingw_skip_dos_drive_prefix().
> Where does your build get a declaration of isalpha() from?

$ grep -w isalpha /mingw32/i686-w64-mingw32/include/*.h
/mingw32/i686-w64-mingw32/include/ctype.h:  _CRTIMP int __cdecl isalpha(int _C);
/mingw32/i686-w64-mingw32/include/ctype.h:#define __iscsymf(_c) (isalpha(_c) || ((_c)=='_'))

I guess that definition gets pulled in somehow.

Ciao,
Dscho
