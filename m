From: "=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>
Subject: Re: Git clone stalls at a read(3, ...) saw using strace
Date: Thu, 27 Jul 2006 15:16:33 -0400
Message-ID: <b8bf37780607271216i5b1d8d34n900ffeacbe81f380@mail.gmail.com>
References: <b8bf37780607270516i7fbd8844he03e107b15fd2ed7@mail.gmail.com>
	 <1154018302.13273.0.camel@dv>
	 <b8bf37780607270943w562ec21fuab0eb882b3ccffeb@mail.gmail.com>
	 <Pine.LNX.4.64.0607270947540.4168@g5.osdl.org>
	 <b8bf37780607271017p22fa908bt82a564a4a1a15a79@mail.gmail.com>
	 <b8bf37780607271025m1a611006x65a900e9e487ce1b@mail.gmail.com>
	 <Pine.LNX.4.64.0607271049460.4168@g5.osdl.org>
	 <1154025679.13273.5.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Ribeiro, Humberto Plinio" <humberto.ribeiro@siemens.com>
X-From: git-owner@vger.kernel.org Thu Jul 27 21:17:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6BLZ-0005tp-SD
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 21:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWG0TQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 27 Jul 2006 15:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbWG0TQe
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 15:16:34 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:56866 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751033AbWG0TQe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 15:16:34 -0400
Received: by py-out-1112.google.com with SMTP id s49so405565pyc
        for <git@vger.kernel.org>; Thu, 27 Jul 2006 12:16:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TYcc79wP3/DPdN5KwQ2ypKVCVXj6yNBJE4h3TkLvhBXIkghZZbYCAJaHdAio3yT42OENQogR2LwmJEvZoxSIEpQqVsEXpoVuDuBxeSsosy0KFdYYym1/v1Gb1brRZqz8IRSK9+Jd/m9RrA70ugx3IUlDefFmrnUot/14wjujsB0=
Received: by 10.35.78.9 with SMTP id f9mr13609072pyl;
        Thu, 27 Jul 2006 12:16:33 -0700 (PDT)
Received: by 10.35.128.2 with HTTP; Thu, 27 Jul 2006 12:16:33 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1154025679.13273.5.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24332>

On 7/27/06, Pavel Roskin <proski@gnu.org> wrote:
> On Thu, 2006-07-27 at 10:50 -0700, Linus Torvalds wrote:
> > Nope. I have a fairly constant 120kbps, and:
> >
> > [torvalds@g5 ~]$  git clone git://source.mvista.com/git/linux-davin=
ci-2.6.git
> > Checking files out...)
> >  100% (19754/19754) done
>
> Same thing here.  Current git from the master branch.

=46orgot to say that we are using this script in GIT_PROXY_COMMAND
environment variable:

(echo "CONNECT $1:$2 HTTP/1.0"; echo; cat ) | nc <proxy_add> <portnum>
| (read a; read a; cat )

The first 'read a' removes the 'CONNECT SUCCESS HTTP RESPONSE 200' and
the second removes an empty line as described here:

http://www.gelato.unsw.edu.au/archives/git/0605/20664.html

I will try from home later again.

Thanks,
--=20
[]s,
Andr=E9 Goddard
