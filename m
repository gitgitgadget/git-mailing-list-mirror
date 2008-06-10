From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/4] remote show/prune improvement
Date: Tue, 10 Jun 2008 19:11:01 +0200
Message-ID: <200806101911.02625.jnareb@gmail.com>
References: <7vd4mqdrhi.fsf@gitster.siamese.dyndns.org> <m3ej75pbrw.fsf@localhost.localdomain> <484EA77D.7040003@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 19:12:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K67O8-0007JZ-Lg
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 19:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbYFJRLK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2008 13:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbYFJRLJ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 13:11:09 -0400
Received: from gv-out-0910.google.com ([216.239.58.186]:15175 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753436AbYFJRLI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 13:11:08 -0400
Received: by gv-out-0910.google.com with SMTP id e6so644672gvc.37
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=uIw4v9NycJzo/mkNLBvI+lCrgEVM8GbebKd1pp88UlY=;
        b=AoJkybBRxpOoDlRJ/yUBXI/qe125v/RyTBbf66YdvpCHXpMKtUssDeWbK4SOQZM5X/
         F+1SwQpfD/xauHl/0t8yQLhzbLQgcbkSpq8U7Ao08n5rlthGtXY6+mSQzj4uj/2Itb1P
         AOcSjAwVmoO3F734Y1zOYdOPxtUFFCXlCcpDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=aK31UIZjCKfQBzVOKsMSBcSI8CK3gCterDDvgGZXJcouVSn4aN2tuPQTogE9wWPBW1
         C8oIUYEDd2c8o2q5pREBNJ17+cBc4b5sVYS9ensO9bG8muUxR4BXVIJYWmkf7A+0WgZ3
         TsR4jTNoHMT18sPVuqxOezOuJ8tBlkX0BYAdU=
Received: by 10.103.206.12 with SMTP id i12mr3514851muq.33.1213117866559;
        Tue, 10 Jun 2008 10:11:06 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.192.165])
        by mx.google.com with ESMTPS id n10sm20341453mue.14.2008.06.10.10.11.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 10:11:05 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <484EA77D.7040003@free.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84525>

Dnia wtorek 10. czerwca 2008 18:10, Olivier Marin napisa=B3:
> Jakub Narebski a =E9crit :
>> Olivier Marin <dkr+ml.git@free.fr> writes:
>>=20
>>>   [1/4] remote show: fix the -n option
>>>   [2/4] builtin-remote: split show_or_prune() in two separate
>>>         functions.=20
>>>   [3/4] remote prune: print the list of pruned branches
>>>   [4/4] remote show: list tracked remote branches with -n.
>>=20
>> I like this series... but the [4/4] lacks documentation (all other
>> patches update documentation).

Ah, sorry, my mistake.  It looks like [4/4] is just improvement
to [1/4], which is documented.=20
=20
> I'm not sure, it's a minor change. Perhaps, I can squashed it in
> 1/4 instead.=20
>=20
> What do you think?

Perhaps it could be, but this is not strictly necessary.

After reading patches a bit more carefully, I think that the features
are documented well enough, and any Documentation (and patches)=20
improvements are not necessary, and further changes can happen "in=20
tree".


In "[PATCH 1/4] remote show: fix the -n option" you have:
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
[...]
> -'git-remote' show <name>
> +'git-remote' show [-n] <name>

while in Documentation/git-remote.txt there is remainder of Perl
implementation

   'show'::

   Gives some information about the remote <name>.
   +
   With `-n` option, the remote heads are not queried first with
   `git ls-remote <name>`; cached information is used instead.

The information about using `git ls-remote <name>` is no longer fully
accurate in builtin version, and perhaps could be removed.


In "[PATCH 3/4] remote prune: print the list of pruned branches":
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
[...]
> -'git-remote' prune <name>
> +'git-remote' prune [-n | --dry-run] <name>
[...]
> -With `-n` option, the remote heads are not confirmed first with `git
> -ls-remote <name>`; cached information is used instead.  Use with
> -caution.
> +With `--dry-run` option, report what branches will be pruned, but do
> +no actually prune them.

No `git ls-remote` is mentioned there, as it should be.

--=20
Jakub Narebski
Poland
