From: Peter van der Does <peter@avirtualhome.com>
Subject: Re: [PATCH v2/RFC] Make git-completion Bash 4 compatible.
Date: Wed, 27 Oct 2010 20:52:17 -0400
Message-ID: <20101027205217.3f28b9d1@MonteCarlo>
References: <20101027131506.4da06c6d@MonteCarlo>
	<20101027173132.GA15657@burratino>
	<20101027225318.GB1877@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Kevin Ballard <kevin@sb.org>,
	Mathias Lafeldt <misfire@debugon.org>
To: SZEDER =?ISO-8859-1?B?R+Fib3I=?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Oct 28 02:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBGjL-0000DF-7h
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 02:52:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932255Ab0J1Awa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 20:52:30 -0400
Received: from morn.lunarbreeze.com ([216.227.218.220]:49986 "EHLO
	morn.lunarbreeze.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757846Ab0J1Aw3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 20:52:29 -0400
Received: from c-69-248-103-68.hsd1.nj.comcast.net ([69.248.103.68] helo=monza.grandprix.int)
	by morn.lunarbreeze.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <peter@avirtualhome.com>)
	id 1PBGj5-0008KH-BO; Wed, 27 Oct 2010 17:52:19 -0700
Received: from MonteCarlo (montecarlo.grandprix.int [192.168.1.102])
	by monza.grandprix.int (Postfix) with ESMTPA id 443E7101F82;
	Wed, 27 Oct 2010 20:52:18 -0400 (EDT)
In-Reply-To: <20101027225318.GB1877@neumann>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.22.0; i486-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - morn.lunarbreeze.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - avirtualhome.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160143>

On Thu, 28 Oct 2010 00:53:18 +0200
SZEDER G=E1bor <szeder@ira.uka.de> wrote:

> Hi Jonathan,
>=20
>=20
> On Wed, Oct 27, 2010 at 12:31:32PM -0500, Jonathan Nieder wrote:
> > Could some zsh user perhaps test that the new zsh support is not
> > broken?
>=20
> I'm afraid it is.
>=20
> The commit message of 06f44c3 (completion: make compatible with zsh,
> 2010-09-06) says:
>=20
>     ${var:2}
>         Zsh does not implement ${var:2} to skip the first 2
> characters, but ${var#??} works in both shells to replace the first 2
> characters with nothing.  Thanks to Jonathan Nieder for the
> suggestion.
>=20
>     for (( n=3D1; "$n" ... ))
>         Zsh does not allow "$var" in arithmetic loops.  Instead,
> pre-compute the endpoint and use the variables without $'s or quotes.
>=20
> However, the functions taken over from the bash-completion code
> contain constructs like:
>=20
>     ${cur:0:$index}
>     # ok, this is not exactly the same as ${var:2}, so it might even
>     # work...
>=20
> and
>=20
>     for (( i=3D0, j=3D0; i < ${#COMP_WORDS[@]}; i++, j++)); do
>=20
> But I haven't actually tried it.
>=20
>=20
> Best,
> G=E1bor
>=20
On the zsh change, I replied to the email "What's cooking in git.git
(Oct 2010, #02; Tue, 26)"

> With the patch "Make git-completion Bash 4 compatible" in mind, it
> might be useful to start looking into a different way to distribute
> the completion script to accommodate different shells. Adding
> compatibility for each shell into one script can get nasty. We could
> have a different completion script for each shell.

The bash completion script could still be included with the core, but
we can offer different versions for different shells.

--=20
Peter van der Does

GPG key: E77E8E98

IRC: Ganseki on irc.freenode.net
Twitter: @petervanderdoes
