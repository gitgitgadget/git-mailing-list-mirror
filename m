From: Junio C Hamano <junkio@cox.net>
Subject: Re: describe fails on tagless branch
Date: Wed, 07 Feb 2007 08:29:06 -0800
Message-ID: <7vbqk67wz1.fsf@assigned-by-dhcp.cox.net>
References: <eqb660$ft7$1@sea.gmane.org>
	<200702070922.57163.andyparkins@gmail.com>
	<7vy7na8f2t.fsf@assigned-by-dhcp.cox.net>
	<200702071201.16931.andyparkins@gmail.com>
	<eqch3d$5gc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 07 17:29:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEpfV-0006wN-Uo
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 17:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbXBGQ3K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 11:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbXBGQ3K
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 11:29:10 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:49462 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161371AbXBGQ3J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 11:29:09 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207162908.BLUU1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Feb 2007 11:29:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LgV71W0051kojtg0000000; Wed, 07 Feb 2007 11:29:07 -0500
In-Reply-To: <eqch3d$5gc$1@sea.gmane.org> (Jakub Narebski's message of "Wed,
	07 Feb 2007 13:37:32 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38937>

Jakub Narebski <jnareb@gmail.com> writes:

> Andy Parkins wrote:
>
>>> It might not be a bad idea to give '-q' option to make it silent
>>> when it fails because the commit is indescribable.
>>=20
>> I don't think it's worth it. =C2=A0The "-q" be used only in scripts,=
 and in a=20
>> script you would do the whole "2> /dev/null || echo 'No tag found'" =
thing=20
>> anyway.
>
> It would be worth for Perl (for gitweb) to be able to use list form o=
f magic
> open, without spawning shell (and assorted argument quoting troubles)=
, but
> silently.=20
>
> I think it would be fairly easy to add -q option to git wrapper: it w=
ould
> simply set die, error and warn routines and no-op (no-write) versions=
=2E

You completely missed my point.  describe -q would not squelch
*all* errors and die()'s, but only the specific "this cannot be
described".  If you give a non-existent object name on the
command line, it _should_ barf loudly.
