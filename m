From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git: Unexpected behaviour?
Date: Mon, 14 Nov 2011 13:33:51 -0800 (PST)
Message-ID: <m3k472mltc.fsf@localhost.localdomain>
References: <1321044904175-6986736.post@n2.nabble.com>
	<4EBD9428.3030506@gmail.com> <4EBDBCA2.7070603@gmail.com>
	<7vlirlp1y6.fsf@alter.siamese.dyndns.org>
	<CAOeW2eEUbvd0eJHjNfbvi9QnDiUO=mFA9rrKsjv8Yu0_QiPgSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"J.V." <jvsrvcs@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 22:34:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ4AB-0007H2-IL
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 22:33:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab1KNVdy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Nov 2011 16:33:54 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41455 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754476Ab1KNVdx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2011 16:33:53 -0500
Received: by bke11 with SMTP id 11so6373512bke.19
        for <git@vger.kernel.org>; Mon, 14 Nov 2011 13:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=aCp17CR9quNoKhuACZoOh64AVI/fpG53acz/lmjY4t8=;
        b=I9o/4uHpI1NU4jWfZ9DpBeYmiFtbx/7Yu0/nGaqRgYOqVsfezOijtBy4VYKD6U/cWu
         MpkT9Zg9tD48QXke7d+4x6+QQXV7+KLTnUVtfq220hvGJgWhDxX91s4N7x1JhXQEI/M0
         5nYIW6CNBAmeIIQkCDfvtza3JU+2KcdqV5h1c=
Received: by 10.205.119.207 with SMTP id fv15mr21283244bkc.100.1321306432570;
        Mon, 14 Nov 2011 13:33:52 -0800 (PST)
Received: from localhost.localdomain (abvw208.neoplus.adsl.tpnet.pl. [83.8.220.208])
        by mx.google.com with ESMTPS id e8sm34939419bkd.7.2011.11.14.13.33.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Nov 2011 13:33:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pAELXJwp004281;
	Mon, 14 Nov 2011 22:33:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pAELX325004277;
	Mon, 14 Nov 2011 22:33:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAOeW2eEUbvd0eJHjNfbvi9QnDiUO=mFA9rrKsjv8Yu0_QiPgSw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185404>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
> On Sat, Nov 12, 2011 at 11:37 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
> > "J.V." <jvsrvcs@gmail.com> writes:
> >
> > > OK so "work tree" is a new term for me. =A0I thought we were in i=
solated
> > > sandboxes called "branches" and changes made in a branch would st=
ay in
> > > that branch regardless.

That would be the default and only solution if each branch was checked
out to a separate working directory.

You can do that in git using git-new-worktree script from contrib.

> > Do not think of "branches" as isolated _sandboxes_.
> >
> > Rather, "branches" are where the independent states are to be _reco=
rded_.

Branches are lines of development, and are about _comitted_ changes.
This means that when switching branches "in place", un-committed
changes are not on any branch.

> I think I was confused about this when learning Git too. I friend of
> mine made the following argument, which I agree with and which I have=
n
> seen on the list before:
>=20
> Either you want the modifications to stay on the branch, or you want
> them to carry over to the branch you are checking out. In the former
> case, you would want Git to fail if there are modifications (that you
> might have forgotten you made). In the latter case, you would want
> "git checkout -m". The current behavior is somewhere in between. It i=
s
> not clear to me if there is a use case where the current behavior is
> better (from the user's point of view) than either failing or
> "checkout -m".

The "checkout -m" behavior is unsafe; you can land in a state where it
would be difficult to revert, and could lose your changes.  The
default behavior of switching branches is to carry over changes if it
is safe to do so.
=20
> It is obviously too late to change this now, though.

Well, we could in theory add knob that would stash changes when
switching to branch, and unstash when switching to branch.

--=20
Jakub Nar=EAbski
