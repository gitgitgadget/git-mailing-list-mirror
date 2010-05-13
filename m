From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI 
	script
Date: Thu, 13 May 2010 17:13:12 +0000
Message-ID: <AANLkTilnaHQ4Q8n3GOhYPcYAFi_tT8uSE_uTZhU_QYhK@mail.gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com>
	 <201005111258.53388.jnareb@gmail.com>
	 <20100511120924.GC5220@screwed.box>
	 <201005111551.21316.jnareb@gmail.com>
	 <20100513131016.GA5250@screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@suse.cz>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Peter Vereshagin <peter@vereshagin.org>
X-From: git-owner@vger.kernel.org Thu May 13 19:13:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCbyK-00059V-5R
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 19:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120Ab0EMRNO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 May 2010 13:13:14 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42239 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab0EMRNN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 May 2010 13:13:13 -0400
Received: by pwi10 with SMTP id 10so117463pwi.19
        for <git@vger.kernel.org>; Thu, 13 May 2010 10:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nt/XnTtx6BuSeC+SJ2mrSERyofnMMsy7qWvC9aRY4yY=;
        b=qVO9sEkYa1zcP5G7Vs7yYsMN4HiHjwgYJjBELnwq9D/XLZw8XHUx4rANCdDTf0bw37
         ltTHF2l/hjvwh79zqEyVHy9ldknRbsFMdXTfpI42oZyNh5SXUoaDEVIOajG8uKxhwvxL
         zhwkZPSVf/xzD0S6d/MLSFpQiD2CFa992rfQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fNpPNTWbuZMvoEYnZ9QCHgOiubJJLe+UdcZ4isYOKtZDwoSMw5GSfzNdCp3dTdC6ky
         RYgqSsaDn4scl9Iw43BbN0ss3zHEALjtniWBkzW6iqLNnEX84CCC/h9u/VUdsWLFPA35
         WGQPNCMgzjATVDLX914kM/K61d1TTNvzmr2bw=
Received: by 10.142.4.31 with SMTP id 31mr6628850wfd.255.1273770792582; Thu, 
	13 May 2010 10:13:12 -0700 (PDT)
Received: by 10.231.160.11 with HTTP; Thu, 13 May 2010 10:13:12 -0700 (PDT)
In-Reply-To: <20100513131016.GA5250@screwed.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147016>

2010/5/13 Peter Vereshagin <peter@vereshagin.org>:
> Hey Mr(s) Jakub show some good to me!
> 2010/05/11 15:51:15 +0200 Jakub Narebski <jnareb@gmail.com> =3D> To P=
eter Vereshagin :
> JN> On Tue, 11 May 2010, Peter Vereshagin wrote:
> JN> > 2010/05/11 12:58:50 +0200 Jakub Narebski <jnareb@gmail.com> =3D=
> To Peter Vereshagin :
> JN>
> JN> > > > > I have changed this 'exit' to non-local goto to toplevel.=
 =C2=A0It could be
> JN> > > > > done instead by redefining 'exit' subroutine, like shown =
below, but I
> JN> > > > > feel that would be hacky if you can change gitweb code (i=
t is not
> JN> > > > > black box you should not touch).
> JN> > > >
> JN> > > > Right, one shouldn't ever redefine perl built-in functions.=
 I did only because
> JN> > > > of no other way to 'get things working'
> JN> > >
> JN> > > Why not? =C2=A0For example CGI::Carp redefines 'die' to log e=
rrors.
> JN> >
> JN> > Ouch, sorry, I meant 'last' or something like that.
> JN>
> JN> "last" / "last LABEL" is a command, not a function, therefore you=
 cannot
> JN> redefine it.
>
> it's a flow control statement thus it is a built-in thing same way as=
 any other
> functions are explained in a 'perldoc -f'
> Therefore it is treated by monkeys crowd as function. It's obvious fo=
r me to
> stay out here ( here !=3D maillist ) yet in such an environment.

These things are called "operators" in Perl, some of them (like exit)
you can redefine. Some (like last) you can't. At least not without
some deep magic.

> Anyway, I compare last() here =C2=A0with exit() and die() which look =
to user just
> like the same kind of: the flow control statements. I guess any perl =
user who
> makes things like gitweb ( at least as a CGI-only app ) shouldn't car=
e about
> such an internal difference of flow control statements those are
> hidden/incapsulated inside the implementation of those statements?
> Needless to mention that the 'last LABEL' ( goto, gosub, ... named th=
em ) =C2=A0is a
> bad and a very deprecated style which is every schoolboy is aware abo=
ut
> nowadays to keep from using in the application, not system, programmi=
ng in imho
> every language.

`last LABEL' is not bad or deprecated. It's what you use to get out of
nested for-loops in Perl:

    OUTER: for my $i (1 .. 10) {
        for my $j (1 .. 10) {
            last OUTER if $i =3D=3D 5 and $j =3D=3D 5;
        }
    }

goto is also recommended in some cases in Perl. That's because it
doesn't do the same thing as in C:

    # Don't create a stack frame
    sub foo { goto &bar }

Anyway, arguing over which control flow operator is evil in an
imperitive language is just splitting hairs. Certain uses of them are
a bad idea, not the operators themselves.
