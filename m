From: Rogan Dawes <lists@dawes.za.net>
Subject: Re: CRLF problems with Git on Win32
Date: Thu, 10 Jan 2008 22:50:56 +0200
Message-ID: <47868530.2010501@dawes.za.net>
References: <7vmyrgry20.fsf@gitster.siamese.dyndns.org> <C3AC2971.10D2D%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Gregory Jefferis <jefferis@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 21:54:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JD4Pf-0002J7-5p
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 21:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbYAJUxj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jan 2008 15:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753970AbYAJUxj
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 15:53:39 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:50432 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753898AbYAJUxi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 15:53:38 -0500
Received: from spunkymail-a19.g.dreamhost.com (sd-green-bigip-83.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 91B7B1797FC
	for <git@vger.kernel.org>; Thu, 10 Jan 2008 12:53:37 -0800 (PST)
Received: from [192.168.201.100] (dsl-241-218-187.telkomadsl.co.za [41.241.218.187])
	by spunkymail-a19.g.dreamhost.com (Postfix) with ESMTP id B713011E53;
	Thu, 10 Jan 2008 12:51:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <C3AC2971.10D2D%jefferis@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70085>

Gregory Jefferis wrote:

> I'm not sure that I understand the whole deal about platform default =
line
> endings.  Isn't plain git functionally agnostic about line endings?  =
You can
> check in CRLF text files to git and it doesn't care.  You can diff, s=
how etc
> just fine.  I haven't yet found anything that breaks with CRLF files.=
  In
> this sense plain git is already Windows ready.  Maybe I'm missing som=
ething?
>=20
> Doesn't the problem only come if you try to diff a CRLF file with a n=
ew
> version that has LF only line endings?  Then right now you have to us=
e
> something like:
>=20
>     git diff --ignore-space-at-eol
>=20

> In conclusion all of these CRLF options are designed to help Windows =
users
> play nicely with others.  But it seems to me na=C3=AFve Windows users=
 can be
> perfectly happy with plain git so long as they stay in their own Wind=
ows
> world.
>=20
> jm2c, corrections welcome and apologies to those suffering from eol
> exhaustion,
>=20
> Greg.


One example that bit me recently was "git-apply --whitespace=3Dstrip"

I have files with CRLF in my repo, but git was stripping the CR from=20
lines that I applied via a patch.

I worked around it with a smudge/clean filter of "dos2unix | unix2dos"=20
(first removes all CR's, second puts one back on each line)

Rogan
