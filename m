From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: rebase -i and --whitespace, was Re: [PATCH] git-rebase.sh: Update USAGE string (No. 1)
Date: Mon, 4 Feb 2008 16:42:50 +0100
Message-ID: <200802041642.52088.jnareb@gmail.com>
References: <m3lk6161jo.fsf@localhost.localdomain> <200802041113.m14BDLMl004301@mi1.bluebottle.com> <alpine.LSU.1.00.0802041505230.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?=
	 =?utf-8?q?_?= <nanako3@bluebottle.com>,
	Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 16:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM3U2-0007tG-NQ
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 16:43:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbYBDPnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Feb 2008 10:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYBDPnF
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 10:43:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:38156 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbYBDPnC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 10:43:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3000667wah.23
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=pAZri5kl06+gXk+3KaF0pEj9m5n/f6xuDlHZlATtgew=;
        b=E64RDw4woyyzyAzdo2TigGISlRpkSV/0qu0XVEOg9AH9fHx2U6/YFYwKR+0/YrAheEonuPMjhiAbKRV5sRwBq/J8/3sFqHYqTuRpGqCZAFGw4nqZyqZv2ioB+pfGI4QOYY/4Oa1jEof14iYLrPq/TGD/d1O1k9kh3x+xkPc31c0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Ri3b+OV4vb4aRMF8cqbl7ySYKrCLNF+EwkE3cHVGMPZXEt/3ljttrwUahwpAWgkWRixA/8lqocO4hXvIY9blrT6dCyVyhgyaSvf8eYWCar1sYnv9QojXSgh5MvY6X8vrv7+pL2CjkUOH9n9cgF0rYmYBDsvAe19/UC8aj0HHNDE=
Received: by 10.114.106.1 with SMTP id e1mr300422wac.95.1202139781192;
        Mon, 04 Feb 2008 07:43:01 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.221.201])
        by mx.google.com with ESMTPS id i3sm20151136nfh.28.2008.02.04.07.42.58
        (version=SSLv3 cipher=OTHER);
        Mon, 04 Feb 2008 07:42:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802041505230.7372@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72518>

W poniedzia=C5=82ek 4. lutego 2008 16:06, Johannes Schindelin napisa=C5=
=82:
> On Mon, 4 Feb 2008, =E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=
=AA=E3=81=93 wrote:
>=20
> > I tried to run "git rebase --interactive --whitespace=3Dstrip" but =
it does=20
> > not seem to strip blank characters at the end of my lines.  Did I f=
ind a=20
> > bug?
>=20
> Yes.  Interactive rebase never bothered with --whitespace options, si=
nce=20
> it works purely with cherry-pick (the --merge option to non-interacti=
ve=20
> rebase).  Therefore, the operation is not patch based, and does not c=
all=20
> git-apply at all (which would handle the whitespace).

So it means that synopsis should, instead of current (pre-patch)

'git-rebase' [-i | --interactive] [-v | --verbose] [-m | --merge]
        [-C<n>] [ --whitespace=3D<option>] [-p | --preserve-merges]
        [--onto <newbase>] <upstream> [<branch>]

should read

'git-rebase' [-v | --verbose]  [-p | --preserve-merges]
        [{-i | --interactive} | [-C<n>] [ --whitespace=3D<option>] [-m =
| --merge]]
        [--onto <newbase>] <upstream> [<branch>]

or perhaps even separated into interactive / non-interactive merge?

--=20
Jakub Narebski
Poland
