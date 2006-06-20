From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] checkout -f: do not leave untracked working tree files.
Date: Tue, 20 Jun 2006 04:18:56 -0700
Message-ID: <7vfyi09isf.fsf@assigned-by-dhcp.cox.net>
References: <449557B6.1080907@garzik.org>
	<7vbqsqdru0.fsf@assigned-by-dhcp.cox.net> <4495DB3B.10403@garzik.org>
	<7v4pyhdel5.fsf@assigned-by-dhcp.cox.net>
	<4497B39E.2050205@garzik.org>
	<7vr71kb257.fsf@assigned-by-dhcp.cox.net>
	<7vfyi0b1gv.fsf_-_@assigned-by-dhcp.cox.net>
	<8764iw5bvl.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 13:19:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FseG5-0005GR-NM
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 13:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964969AbWFTLS7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Jun 2006 07:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbWFTLS7
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 07:18:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:19584 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964969AbWFTLS6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 07:18:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060620111857.OWSD6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 20 Jun 2006 07:18:57 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <8764iw5bvl.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Tue, 20
	Jun 2006 13:01:50 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22192>

Santi B=E9jar <sbejar@gmail.com> writes:

> Another thing to take into account is that, for this particular
> case/sequence, the untracked file-F is exactly the same as the one fr=
om
> the pull, so you are not overwritting that file and it could succeed.

Yes and no.  The untracked file is not even known to git when
pull is happening (that is the definition of "untracked").  Yes,
we could see if the contents happen to match and choose to
overwrite, but I think it is often more likely that the contents
do not match that it is not worth it (I have not examined what
it would involve to add that check yet, so it might turn out to
be a cheap check but I doubt it).
