From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Fri, 28 Jul 2006 05:56:16 -0400
Message-ID: <b8bf37780607280256q485b7ae9p9cdedf9b621a0e9b@mail.gmail.com>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
	 <1154018302.13273.0.camel@dv>
	 <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
	 <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org>
	 <b8bf37780607271017p22fa908bt82a564a4a1a15a79@mail.gmail.com>
	 <b8bf37780607271025m1a611006x65a900e9e487ce1b@mail.gmail.com>
	 <Pine.LNX.4.64.0607271049460.4168@g5.osdl.org>
	 <1154025679.13273.5.camel@dv>
	 <b8bf37780607271216i5b1d8d34n900ffeacbe81f380@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Ribeiro, Humberto Plinio" <humberto.ribeiro@siemens.com>
X-From: git-owner@vger.kernel.org Fri Jul 28 11:56:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6P5G-0002ez-3L
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 11:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWG1J4S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 28 Jul 2006 05:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbWG1J4S
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 05:56:18 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:59219 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751079AbWG1J4R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 05:56:17 -0400
Received: by py-out-1112.google.com with SMTP id s49so577485pyc
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 02:56:16 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JiMtpFY72hOnGm3MSL1UczKboG5QEKR3Er185sWwR+keyleoX4YCLMRPuLtkIxEZQdB1w7ucVxQgPLQT+N0nDQhMG1hxlsWSYFcCBydiGHlOpuw6Npc8naCIUF5HRn73lJ+YuDpaW2wMgm/hLFS80i50s/oJ22z1BwixqqIChb0=
Received: by 10.35.87.8 with SMTP id p8mr14243288pyl;
        Fri, 28 Jul 2006 02:56:16 -0700 (PDT)
Received: by 10.35.128.2 with HTTP; Fri, 28 Jul 2006 02:56:16 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <b8bf37780607271216i5b1d8d34n900ffeacbe81f380@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24379>

On 7/27/06, Andr=E9 Goddard Rosa <andre.goddard@gmail.com> wrote:
> On 7/27/06, Pavel Roskin <proski@gnu.org> wrote:
> > On Thu, 2006-07-27 at 10:50 -0700, Linus Torvalds wrote:
> > > Nope. I have a fairly constant 120kbps, and:
> > >
> > > [torvalds@g5 ~]$  git clone git://source.mvista.com/git/linux-dav=
inci-2.6.git
> > > Checking files out...)
> > >  100% (19754/19754) done
> >
> > Same thing here.  Current git from the master branch.
>
> Forgot to say that we are using this script in GIT_PROXY_COMMAND
> environment variable:
>
> (echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | nc <proxy_add> <portnum=
>
> | (read a; read a; cat )
>
> The first 'read a' removes the 'CONNECT SUCCESS HTTP RESPONSE 200' an=
d
> the second removes an empty line as described here:
>
> http://www.gelato.unsw.edu.au/archives/git/0605/20664.html
>
> I will try from home later again.

Okey, I tried from home (without the proxy trick) and it behaved a lot
better but my disc went full in the process and I got these messages:
=2E..
=2E..
=2E..
error: git-checkout-index: unable to write file drivers/scsi/mac53c94.c
error: git-checkout-index: unable to write file drivers/scsi/mac53c94.h
error: git-checkout-index: unable to write file drivers/scsi/mac_esp.c
error: git-checkout-index: unable to create file
drivers/scsi/mac_scsi.c (No space left on device)
error: git-checkout-index: unable to create file
drivers/scsi/mac_scsi.h (No space left on device)
error: git-checkout-index: unable to create file
drivers/scsi/mca_53c9x.c (No space left on device)
error: git-checkout-index: unable to create file
drivers/scsi/megaraid.c (No space left on device)
error: git-checkout-index: unable to create file
drivers/scsi/megaraid.h (No space left on device)
fatal: cannot create directory at drivers/scsi/megaraid

And it finished keeping the downloaded files, but I still cannot see
these files listed above.
I tried to pull but it says that I'm up-to-date:

doctorture:/opt/downloads/mvista/linux-mvista # git-pull
Already up-to-date.

I remember that using CVS I just used 'cvs update' after checkout and
it would bring the missing files to me.

What I'm doing wrong here?

Thank you so much,
--=20
[]s,
Andr=E9 Goddard
