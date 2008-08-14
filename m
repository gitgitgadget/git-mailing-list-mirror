From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 00:44:11 -0400
Message-ID: <48A3B81B.10804@griep.us>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814043817.GC11232@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 06:45:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTUi9-0000hU-8e
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 06:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbYHNEoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Aug 2008 00:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbYHNEoR
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 00:44:17 -0400
Received: from hs-out-0708.google.com ([64.233.178.245]:63745 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYHNEoR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 00:44:17 -0400
Received: by hs-out-0708.google.com with SMTP id 4so218207hsl.5
        for <git@vger.kernel.org>; Wed, 13 Aug 2008 21:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=Vwt18FptG9Jp7T1GmL81AWtu91/dEA2b+xcV67YLrbc=;
        b=NH5ONdxyIOSO1HyOVwB02YjMAeb1xug1uvTevOjb9GbhPxol9UF8l93SmkZrT4fX6c
         WzFW1wNqmfBC4l6gnK+L2IClmHBUVwTZJo8x0IJsc5hioecGlX8U56rPbYTH7gya6Lgw
         FMaMFXFZLyN5U8iZB9pl1RyZB0FZuouDBHRJs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=DVWnIn5+HZQZBOpWAx0DV5xUZYRz6jKgMgP2YkpEntHpwtGEfH9tG4ziQzDpD0wRfQ
         tIRMBslc14LAuVwRsgL0BZe5IVAVWZ9Es5tBdUdbcRg/L0FAUo8k7VMLKrKXeOz7MNb0
         0qFgtoY6gM3mQ1USG3DsReusa4HmFkWdBp5G4=
Received: by 10.90.104.20 with SMTP id b20mr1090256agc.69.1218689056237;
        Wed, 13 Aug 2008 21:44:16 -0700 (PDT)
Received: from ?192.168.1.3? ( [71.174.65.78])
        by mx.google.com with ESMTPS id 17sm1206545hsq.19.2008.08.13.21.44.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 Aug 2008 21:44:15 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080814043817.GC11232@spearce.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92314>

Shawn O. Pearce wrote:
> Hmm.  This probably should be static.  Or if it really is meant
> to be a utility for use elsewhere in Git, moved to someplace where
> string handling is done.  Its not strbuf related, but maybe strbuf.c
> is a better location for this sort of library function.
>=20
> If you do move this to strbuf.c, how about having it take a strbuf
> in and appending the formatted text onto it?  You'll neer have to
> worry about the buffer being too small and it fits into the whole
> strbuf.c module thing.
>=20
> If you keep this static here in builtin-count-objects.c, how about
> making the char *buf static scoped to the function, so you don't
> need to pass the buffer, its size, nor check its size?

I'll take this into account.  Though I didn't plan it to be a
cross-git utility function, it probably could be, so I'll look
at putting it in strbuf.c.

> We don't declare variables after statements.  Please declare all
> variables at the start of the block as not all compilers we support
> support this C99 syntax.

This is the first time I've hacked on vanilla-C in about 5 years,
so I'm quite rusty.  Much less my first time hacking on perl, ever,
in the case of git-svn.  Thanks for the pointers.

> Oh, and welcome to Git.  I saw your SVN patches.  Glad to see
> you hacking.  ;-)

Glad to be a part.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
