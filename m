From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Mon, 20 Oct 2008 08:26:12 +0200
Message-ID: <81b0412b0810192326n7ace9d4fjd8013cbe1872df22@mail.gmail.com>
References: <20081019000227.GA9423@charybdis.dreamhost.com>
	 <20081019131745.GA8643@coredump.intra.peff.net>
	 <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net>
	 <20081019141634.GA8997@coredump.intra.peff.net>
	 <7vr66b50gy.fsf@gitster.siamese.dyndns.org>
	 <7vhc774ydr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Maciej Pasternacki" <maciej@pasternacki.net>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 15:14:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KroEh-0008W6-7b
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 08:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbYJTG0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 02:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbYJTG0O
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 02:26:14 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:39270 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbYJTG0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 02:26:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so79901and.103
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 23:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=5+23tloHwRDVxUwAFeGGYotppMwO7IL2coc5bX92zfU=;
        b=Dxn+Jvt26IVa2z6tZsCBHrbD+Ux+6tTYFQj3MNY6S8M3kXeuvDhHew0SltBTYoAXmn
         zzeX3PFFiM15lUC4t0o5QTxEW+yXWzPY9kkzhKSMiygrfNqZftJHDgXDOZtcctRiQKyT
         pda00KYrxv4VPAE0Hxdhwol7wddZwEYaD3qi4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=AA8vWmwMMmcnNFnw6ZSMvOJvIDjw/Y/W+NSo3I2ryJVBf8c0o+SBEVLW8H1JBIUemy
         E/gIPmMYXhMSaZP7WdyAdXfDpzVG859Buutq66XqX1/z/V75x0EjG6ZxcB5lsg3iqmam
         Es7mAMQH7WzjHhv0SqWItXId8gYF5/wBd5cc0=
Received: by 10.100.227.6 with SMTP id z6mr7953339ang.34.1224483972647;
        Sun, 19 Oct 2008 23:26:12 -0700 (PDT)
Received: by 10.100.91.8 with HTTP; Sun, 19 Oct 2008 23:26:12 -0700 (PDT)
In-Reply-To: <7vhc774ydr.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98666>

2008/10/20 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
> I wouldn't however suggest allowing the syntax to set environment
> variables, like:
>
>        $ git GIT_AUTHOR_NAME="A U Thor" commit
>
> as this is something your shell lets you do easily, i.e:
>
>        $ GIT_AUTHOR_NAME="A U Thor" git commit
>

No, someplace else it doesn't (yes, windows again).
It is mostly hard to do there, because the system shell is so
primitive, and installation of something sane (sh or env) is
an additional (and hard to explain to windows zealots) hassle.

And even in something like Perl it is hard: you cannot
change the environment just for the child process, you
have to change your own, run the process and change
it back.

So, yes, I like your suggestion, but I'd like to _include_
setting all the Git's environment.
