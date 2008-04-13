From: "Paul Fredrickson" <paul.fredrickson@gmail.com>
Subject: Re: [PATCH/RFC 01/10] Teach rebase interactive the mark command
Date: Sun, 13 Apr 2008 13:51:50 -0700
Message-ID: <69a88a530804131351n7d9f8188vf2bbb0174ade3ca0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: joerg@alea.gnuu.de, junio@pobox.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 22:52:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl9Bk-0007kp-NV
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 22:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbYDMUvw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 16:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbYDMUvw
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 16:51:52 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:19786 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbYDMUvv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 16:51:51 -0400
Received: by an-out-0708.google.com with SMTP id d31so339587and.103
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 13:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=EiJLOtMDe0GA8LWkzmNuPvRfvI+xkigUjeG15CAfUUc=;
        b=bU3P0gM3If8PcYpNkzJf8NJ/+78MhKuaz/LLa/8D3blCvAzLCwrMzBWW3+TNDdIHca2nmWvq7RjSm03X6Lo/zcDYP3FrWRKVQ+YQCx/kzseWZdm9+pcjW0+ujhdx9qMJFUN5ODuiKxRm6BACSQYOE9C+/gzPjtUdbLvQNS0mbpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VP6N+eHyWZnUtJQPctJ6F+cr6aAQyZzztzK2rzb1CpO7cZr354TmPpKfgHjJRkNCnAMOE7N2YwCllCafm+AG1GCGkll8GJF5Af//dmUR0jOWY99cdvHUPEnCbmD1ozi4PYv/6Ut5o62BO2Gncat+ktrNaI7RN+fygGcEaTrAQeM=
Received: by 10.100.41.4 with SMTP id o4mr4068942ano.136.1208119910686;
        Sun, 13 Apr 2008 13:51:50 -0700 (PDT)
Received: by 10.100.210.5 with HTTP; Sun, 13 Apr 2008 13:51:50 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79424>

> Jrg Sommer <joerg@alea.gnuu.de> wrote:
> > > Wouldn't
> > >
> > > pick 5cc8f37 (init: show "Reinit" message even in ...)
> > > mark 1
> > > pick 18d077c (quiltimport: fix misquoting of parse...)
> > > mark 2
> > > reset 1
> >
> > "reset 18d077c~2" or "reset some-tag" or "reset my-branch~12"
> >
> >         merge #2
> > >
> > > be easier for people?
> >
> > I don't know. Using the special sign everywhere a mark is used looks more
> > consistent to me. The only case where it might be omitted is the mark
> > command, because it only uses marks.
>
> Why not use the mark syntax that fast-import uses?  In fast-import
> we use ":n" anytime we need to refer to a mark, e.g. ":1" or ":5".
> Its the same idea.  We already have a language for it.  Heck, the
> commands above are bordering on a language not too far from the
> one that fast-import accepts.  :-)

I like the idea of adding marks to an interactive rebase in general, but instead
of adding a separate command, what if rebase *automatically* marked all the
commits in the session:

    1: pick 5cc8f37 (init: show "Reinit" message even in ...)
    2: pick 18d007c (quiltimport: fix misquoting of parse ...)
    reset 1
    merge 2

or "reset :1" and "merge :2".  Neither notation bothers me for marks.

--Paul
