From: Alexey Shumkin <ashu@rarus.ru>
Subject: Re: [PATCH] pretty: user format ignores i18n.logOutputEncoding
 setting
Date: Tue, 26 Jul 2011 17:18:44 +0400
Message-ID: <20110726171844.68b6e8ff@ashu.dyn.rarus.ru>
References: <1311589875-12569-1-git-send-email-zapped@mail.ru>
	<1311589875-12569-2-git-send-email-zapped@mail.ru>
	<7vwrf6qh49.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexey Shumkin <zapped@mail.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 15:19:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlhXQ-0000Gq-AB
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 15:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab1GZNTC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 09:19:02 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61492 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659Ab1GZNSw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 09:18:52 -0400
Received: by ewy4 with SMTP id 4so405712ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 06:18:51 -0700 (PDT)
Received: by 10.213.108.147 with SMTP id f19mr2351688ebp.34.1311686327480;
        Tue, 26 Jul 2011 06:18:47 -0700 (PDT)
Received: from ashu.dyn.rarus.ru (mail.rarus.ru [213.247.194.83])
        by mx.google.com with ESMTPS id x3sm357376eem.66.2011.07.26.06.18.45
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 06:18:46 -0700 (PDT)
In-Reply-To: <7vwrf6qh49.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.22.0; i386-redhat-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177866>

=D0=92 Mon, 25 Jul 2011 12:45:26 -0700
Junio C Hamano <gitster@pobox.com> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> Alexey Shumkin <alex.crezoff@gmail.com> writes:
>=20
> > git log --graph --oneline
> > and
> > git log --graph --pretty=3Dformat:'%C(yellow)%h %Creset%s'
> > give different outputs on Linux UTF-8 console
> > when commit messages contain non-UTF-8 characters
>=20
> (content) "different" is not specific enough to describe a problem (i=
n
> some cases, difference in command line arguments is the way to obtain
> different results), especially if you do not state that they "should"
> be the same to begin with, and preferrably under what condition they
> should be the same.
Ok, I'll fix the description

> (content) Do you really need all of the above options to observe the
> breakage, or can you drop --graph?  If so, drop it from the proposed
> commit log message, as it is distracting without merit.
You're right. I do not. I just observed the error with such parameters,
so I wrote them, but they are not neccessary for the error appearance.

> (content) Do you really mean SP before %Creset, not after?
Realy do, but it does not matter here

> (style) Somehow I find this hard to read. Perhaps make the two "sampl=
e
> commands" stand out more from the surrounding text?  E.g.
>=20
> -- >8 --
> The following two ought to give the same output to a terminal:
>=20
> 	$ git log --oneline
>         $ git log --pretty=3Dformat:'%C(yellow)%h %creset%s'
>=20
> However, the former pays attention to i18n.logOutputEncoding
> configuration, while the latter does not when it format "%s". A log
> messages written in an encoding i18n.commitEncoding that is not UTF-8
> is shown corrupted with the latter even when i18n.logOutputEncoding
> is set to convert to UTF-8.
>=20
> Signed-off-by: ...
> -- 8< --
I'm sorry. I'm newbie in a patch distribution and collaborative work on
Enlgish (it is not my native language). So thanks for the correction.

> (question) Does this change affect other commands, most notably
> format-patch, and if so how?
I'll discover this, thanks for pointing me a direction.
