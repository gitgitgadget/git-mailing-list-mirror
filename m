From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 15:15:28 +0100
Message-ID: <20120210151528.56145e0c@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<1328865494-24415-7-git-send-email-michal.kiedrowicz@gmail.com>
	<m339aivn4z.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 15:15:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvrGE-0007jT-NK
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 15:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab2BJOPe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 09:15:34 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33894 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753511Ab2BJOPd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 09:15:33 -0500
Received: by eekc14 with SMTP id c14so969445eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 06:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=v250KvLEZUvRjNADZvHnbt6j6sYwMTbJcv2+/J/XmbM=;
        b=Ve36g7PR2Z7ADgFzeyhrr0a0mc/22SsYt6njRimB/RQIoN1CSEcjI9vPf6bgFx1PrP
         OVAMcIk++z/UdlGYrv5yylXXPSdX1QY0X8zttcvLFAPNJX0/OPbPoaEd4Mr+7OZOREtb
         PSeiswLqk+wOW+tYxq1GhX22MSeMEkyuGCWNM=
Received: by 10.213.23.20 with SMTP id p20mr382158ebb.68.1328883332360;
        Fri, 10 Feb 2012 06:15:32 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id z47sm22535511eeh.9.2012.02.10.06.15.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 06:15:32 -0800 (PST)
In-Reply-To: <m339aivn4z.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190410>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
> > The code that comares lines is based on
> > contrib/diff-highlight/diff-highlight, except that it works with
> > multiline changes too.  It also won't highlight lines that are
> > completely different because that would only make the output unread=
able.
> > Combined diffs are not supported but a following commit will change=
 it.
>=20
> I was thinking that if gitweb were to support "diff refinement
> highlighting", it would either use one of *Diff* packages from CPAN,
> or "git diff --word-diff" output.
> =20

I think highlighting inline and side-by-side diff outputs is
something different from "git diff --word-diff". I find it useful for
people who are used to these diff formats (i.e. me :).

OTOH I'm not against using a dedicated package from CPAN. But I think
my approach is proven to work (I use contrib/diff-highlight as a
filter) and more lightweight (doesn't add another dependency to
gitweb). Moreover, adding support for some Diff package may be done
later, at any moment. It's just a matter of replacing one function
(format_rem_add_line()) with the one that uses Diff.=20
