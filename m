From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/4] gitweb: show notes in log
Date: Sat, 6 Feb 2010 22:47:27 +0100
Message-ID: <201002062247.30691.jnareb@gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> <201002061357.59245.jnareb@gmail.com> <cb7bb73a1002060514p33a4bcbdqb13d636cd6448998@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 22:52:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdsZx-0001Y8-86
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 22:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915Ab0BFVrl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 16:47:41 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:64469 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab0BFVrk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 16:47:40 -0500
Received: by fxm3 with SMTP id 3so5707264fxm.39
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 13:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=s8j5PvLRTpjU0mm8K5tPfRyfOqHYIuz7btqWXM3ZhAY=;
        b=YumqDSjcCyVafk/vvNCTrG/AlIsio5STldce8iwxc1UZzO1Csg/0amo0UgD/D2YzVL
         mw4EdKHG3EkG+MxcIPNWgXRrXLqEl6MORMq4zewGwktjE1ODyg5E7OifdhEGQBkvwaxl
         /EN1P8wj4PsGRswoPtUQ+IcSf+DwzS8h0J7IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xQYybOjX8/aIUg2OeuxFn7pINl0M60QwbWCvyXwY8AQSnjZ9ffgYIry/hk6htyYmRV
         FvrgjKQecGkvDC9pCFHHWOdGLn+myJJKoTMxAIBTP2gJjTiJ90cJlh8p+W6o/lA8jt2P
         YbwEyDFLHzgcQGtFjLIiYld496WQl9i1BxsTg=
Received: by 10.87.69.26 with SMTP id w26mr5291512fgk.39.1265492858407;
        Sat, 06 Feb 2010 13:47:38 -0800 (PST)
Received: from ?192.168.1.13? (abws80.neoplus.adsl.tpnet.pl [83.8.242.80])
        by mx.google.com with ESMTPS id l12sm6881962fgb.0.2010.02.06.13.47.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Feb 2010 13:47:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a1002060514p33a4bcbdqb13d636cd6448998@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139195>

On Sat, 6 Feb 2010, Giuseppe Bilotta wrote:
> 2010/2/6 Jakub Narebski <jnareb@gmail.com>:
> > On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:
> >
> > > The notes are shown in full to the left of the log message.
> >
> > Thats all good if you have wide (high resolution) screen, and your
> > project follows common commit message conventions of keeping lines =
in
> > commit message no longer than at most 80 characters, and you don't =
need
> > to use large size fonts.
> >
> > What happens if screen size is too small to contain both commit mes=
sage
> > and notes? =A0Does it do the sensible thing of putting notes _below=
_
> > commit message in such situation? =A0I do not know CSS+HTML enogh t=
o
> > answer this question myself.
>=20
> The CSS forces the width of the notes div at 150px, which is the
> amount left to the left of the commit message. This means that notes
> will line-wrap, but they will not shift the text.
[...]
> > > + =A0 =A0 =A0 =A0 =A0 =A0 print "$notes\n";
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "<div class=3D\"log_body\">\n";
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_print_log($co{'comment'}, -final_=
empty_line=3D> 1);
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "</div>\n";
> >
> > With respect to the question about what happens if the screen is no=
t
> > wide enough, shouldn't notes be put in HTML source below body (comm=
it
> > message)?
>=20
> As I mentioned, notes width is fixed at the amount of the whitespace
> to the left of the log, so this should not be an issue. Additionally,
> putting notes below makes it much harder to let them float to the lef=
t
> of the log body.

Perhaps the log body should be floated to the right, instead of notes
being floated to the left, so that when screen width is to narrow for
both commit message and notes, notes would be put below commit message.

A question how to create styles using HTML elements and CSS styling
to get side-by-side with one below other as fallback can be asked
on http://stackoverflow.com, or perhaps even better on http://doctype.c=
om/

--=20
Jakub Narebski
Poland
