From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: setup gitosis on Fedora 11
Date: Sun, 19 Jul 2009 06:59:57 +0530
Message-ID: <2e24e5b90907181829j1bf832a3k1812aba498ea09cf@mail.gmail.com>
References: <1247867114.2384.15.camel@brizlyMobil>
	 <2e24e5b90907171844o11eb6699m929e3c0df621ef67@mail.gmail.com>
	 <1247902835.2384.86.camel@brizlyMobil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: brizly vaan van Ulciputz <brizly@freenet.de>
X-From: git-owner@vger.kernel.org Sun Jul 19 03:30:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSLEO-0007mg-Dy
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 03:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbZGSBaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2009 21:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753984AbZGSB37
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 21:29:59 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:40426 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbZGSB36 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2009 21:29:58 -0400
Received: by pxi15 with SMTP id 15so1179072pxi.33
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 18:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LEzy8pRu7JzdZeB3Y49jmDDCP4ROpmzaKJnQDTcj8qI=;
        b=ARJaA8tymmSSXAx7N188I6Bxc7kkdRgGj18ourKx6MwtiyHzJ8vYYa8JHFcPJ5NRBY
         fapQ5zvIeLehDU/fRTeUl+dtN5Prc9QZKI7GrYB4SbZdtcPXFFj27JEeRNSPj6sv2sL2
         Nv+6jG8Wg/4N2/PcG449n8kqSHpkRzrcdP/4E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=azrbXJj3ai/+TSv/wm8ip2I2UJCTnMrrEwFukzwII+iCRfDHKJwvOWuxy17sx1ZP5q
         AioHxYoccPqsacwBdvEJ+v23etX6cnZXNSBdiFNC/erGD1iDhX0HwAGVNvXfnWWBaXRK
         1oXnS+wS1ANTt6YkxXKeZzw2LjnWvuBbHXswQ=
Received: by 10.114.133.1 with SMTP id g1mr4406517wad.162.1247966997776; Sat, 
	18 Jul 2009 18:29:57 -0700 (PDT)
In-Reply-To: <1247902835.2384.86.camel@brizlyMobil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123544>

On Sat, Jul 18, 2009 at 1:10 PM, brizly vaan van Ulciputz
<brizly@freenet.de> wrote:
>
> i think it could be the think with post-update.
> But because i don't know for sure how to set it up,

It was in the how to you mentioned.

> comment: gitosis uses the same key as me as admin. isn't a problem, is
> it? The user brizly exists on notebook as on s2

By "gitosis uses..." I presume you mean "the userid on the server that is
being used as the gitosis user".  Should not matter, normally, but see below

> > (2) your gitosis.conf is all correct, but you forgot the "chmod" somewhere
> > above, and the post-update hook never ran, so the real gitosis.conf (which
> > gitosis uses -- this is ~git/.gitosis.conf) doesn't have the same data
>
> as mentioned above i don't know exactly where to set up the thing with
> the post-update. And i actually don't have a git-user on the server (i
> had one, but thought i didn't need one, so deleted it).

you either follow howtos (good or bad) as closely as you can, or you
understand enough about ssh to bypass it.  You are mixing these two
approaches; sorry I can't really help you.

Let me say this: gitosis requires far more ssh knowledge than git knowledge.
I do not want use this list to teach ssh, more than bare minimum.  Anyway I
have written quite a lot of stuff at
http://sitaramc.github.com/0-installing/9-gitosis-server-install.html that
might help you in understanding.

> > I also don't like that howto; it appears to be doing everything on one
> > machine, with the same userid, so people who don't grok ssh very well will
> > still have trouble even after all this is done to translate that knowledge to a
> > real deployment.
>
> Because my first run wasn't very successfull, i tried another tutorial
> where the developer-machine and the gitosis-server are 2 different ones.
> see http://www.shakthimaan.com/installs/gitosis.html
>
> > Bottom line: here's what should match for that error to go away:
> >
> >   - the public key corresponding to the private key your client-side ssh is
> >     using
> >   - must match *exactly* one of the public keys in the server-side
> >     ~git/.ssh/authorized_keys
>
> see md5sums above, i think they are the same.

You compared id_rsa.pub on both sides; you did not even compare the file I
mentioned here (authorized_keys).  Sorry.

One mistake I made is I used the wrong emphasis above.  "*exactly* one" should
be read "exactly *one*" meaning it should not match more than one entry in the
authorized_keys file.

Oh the below para clarifies my intent anyway...

> > [this is probably OK in your case, but please check there is *exactly one*.  I
> > have a vague memory of seeing a case when someone adds a key twice with
> > different usernames in error.  Ssh picks up perhaps the first one, while your
> > gitosis.conf talks about the second one...]

> So it is a problem when by 'normal' user on the server uses the same key
> as gitosis does? The server is not only serving gitosis, an for other
> reasons the user "brizly" is, for perspective of ssh, the same on
> notebook and on server.

Yes normally it is a problem.  I repeat: this is nothing to do with gitosis;
it is ssh knowledge you need.

> > and
> >   - the name after "gitosis-init" on the pubkey line that matched above
> >   - must match a username in ~git/.gitosis.conf (which is a symlink to
> >     something but never mind)
>
> How do i check that?

Since you did not even look in the file I asked you to look, I guess you would
not find it...

Summary: gitosis does require you to know a fair bit about unix and ssh.  I'm
sorry that most howtos pretend to whitewash all that.
