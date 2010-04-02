From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH] Add Tru64/OSF1 support in Makefile
Date: Fri, 2 Apr 2010 16:07:39 +0200
Message-ID: <u2ld2d39d861004020707m7577182et40b4cd6b93bae830@mail.gmail.com>
References: <d2d39d861003301122p646efc1fj9d88af1893b84b3c@mail.gmail.com>
	 <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Apr 02 16:07:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxhXH-0003jV-UA
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 16:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755055Ab0DBOHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 10:07:43 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:63896 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab0DBOHl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 10:07:41 -0400
Received: by fxm27 with SMTP id 27so421745fxm.28
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:received:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=WBs+GHw0IquCRV8G9/vjt02kBFZUkdkHoFkuDRP7bx8=;
        b=BMBMDcpN9Cwc0oAOLxGfwLGhRByMSgRoBjFeFtm0Yl117kxRhJ7aAY+fQFLHqkkGpy
         wbCxWJyeC+d4KNUBue7u13YoVNtoUMrC3EEQRCGVDgspW6pUJctqrvz63q32htY7u92m
         NODpO7HorX+uEYUK5j7YPZ+FWL2LzJ2+CYVvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Q2LXFmcViuicabBwDvg5mcBriu3fSJImxok3NEjNRA3qVppQ5fiqtFqStHOfKvTfFU
         CvG7SbLzPUS4hk4KA9LHOL4efYjrvn5omsDiqkWPLjp1hrvz9NB4fEUM4EKmUwQ+zrvA
         mq5EL/zDhsYbzrcVnRy++12jL4MAaTuv1t3/8=
Received: by 10.239.138.80 with HTTP; Fri, 2 Apr 2010 07:07:39 -0700 (PDT)
In-Reply-To: <DA8Or5TA0_betHA0BMcLIT0so7oVjDK6CYr4x1LCiX60SEmuPqVnXg@cipher.nrlssc.navy.mil>
X-Google-Sender-Auth: 3ca72d93a8c2443e
Received: by 10.239.185.19 with SMTP id a19mr171512hbh.159.1270217259708; Fri, 
	02 Apr 2010 07:07:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143817>

On Wed, Mar 31, 2010 at 18:29, Brandon Casey
<brandon.casey.ctr@nrlssc.navy.mil> wrote:
> On 03/30/2010 01:22 PM, Tor Arntsen wrote:
>> This patch to Makefile makes git build for me on Tru64/OSF1 V5.1 wit=
h
>> the native compiler.
[..]
>> +ifeq ($(uname_S),OSF1)
>> + =A0 =A0 # Tested with V5.1 w/libcurl and zlib-1.1.4-5 in /usr/loca=
l/
>> + =A0 =A0 CC =3D cc
>> + =A0 =A0 CFLAGS =3D -O2 -g3
>
> I wonder if the native compiler will be the most common compiler
> used on this platform? =A0I tend to lean towards configuring the
> Makefile for gcc, unless gcc is not available for a platform. The
> user can set CC and CFLAGS in config.mak and on the make command
> line if they desire something different.
>
> This isn't an objection by me, I'm just mentioning it to bring
> attention to the issue in case others think it is worthy for
> git to have a stated policy one way or the other.

I'm not certain. I do in fact have gcc (3.3) installed on this Tru64
box, but it doesn't seem to be part of the original 'freeware' CD that
used to come with Tru64. Besides, the freeware CD was first removed as
physical CD, and later (two or three years ago, apparently) pulled by
HP from the online download which was used by their 'tachometer'
('apt-get'-like) freeware tool. Tru64 V51B (which seems to be the
latest, there's no 5.2 as I originally thought) is still available for
download, and so is the native compiler. As far as I can tell it's
incredibly difficult to find precompiled freeware/oss packages for
Tru64 anymore.

>> + =A0 =A0 SHELL_PATH =3D /bin/ksh
>
> Can you run the test suite with this ksh? =A0If it suffers from
> the same exit status behavior of ksh on IRIX and SunOS, then
> I have a patch which allows the test suite to run.

Good idea. I'll do that, and maybe that would indicate if there are
issues with using the native compiler as well.

> Also, I wonder if it suffers from the same trap handling that
> ksh has on SunOS.
[..]
I tested that snippet you provided, and it exits with 0 on Tru64 (I
also verified that indeed it doesn't on Solaris 10).

>> + =A0 =A0 BASIC_CFLAGS +=3D -D_POSIX_C_SOURCE=3D1 -D_OSF_SOURCE=3D1
>> + =A0 =A0 BASIC_CFLAGS +=3D -pthread
>
> There is a PTHREAD_LIBS variable and it seems there is precedent
> for setting it to -pthread in the FreeBSD section.

Right, I can do it similarly in my next version of the patch. Thanks
for your comments!

-Tor
