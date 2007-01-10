From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Provide better feedback for the untracked only case in status output
Date: Tue, 09 Jan 2007 23:39:34 -0800
Message-ID: <7v4pqzfhzd.fsf@assigned-by-dhcp.cox.net>
References: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
	<1168412892113-git-send-email-j.ruehle@bmiag.de>
	<17828.37642.473000.296809@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 08:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Y3f-0008JQ-VW
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 08:39:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbXAJHjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 02:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbXAJHjg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 02:39:36 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:42354 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723AbXAJHjg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 02:39:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110073935.RZRM19398.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Wed, 10 Jan 2007 02:39:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9Kek1W00U1kojtg0000000; Wed, 10 Jan 2007 02:38:45 -0500
To: Juergen Ruehle <j.ruehle@bmiag.de>
In-Reply-To: <17828.37642.473000.296809@lapjr.intranet.kiel.bmiag.de> (Juergen
	Ruehle's message of "Wed, 10 Jan 2007 08:17:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36484>

Juergen Ruehle <j.ruehle@bmiag.de> writes:

> Juergen Ruehle writes:
>  > [Corrupted patch deleted]
>
> Will try again when I know what happened.

While you are at it, let me point out one thing that has been
annoying me for a while.

This is an example e-mail I have been getting from you (the
below is before decoding MIME):

  From: Juergen Ruehle <j.ruehle@bmiag.de>
  Subject: [PATCH] Provide better feedback for the ...
  Date: Wed, 10 Jan 2007 08:08:12 +0100
  Message-ID: <1168412892113-git-send-email-j.ruehle@bmiag.de>
  Content-Type: text/plain; charset=UTF-8
  Content-Transfer-Encoding: quoted-printable
  Cc: git@vger.kernel.org,
          =?utf-8?q?J=C3=BCrgen_R=C3=BChle?= <j-r@online.de>
  X-Mailer: git-send-email 1.5.0.rc0.g525e

  From: =3D?utf-8?q?J=3DC3=3DBCrgen_R=3DC3=3DBChle?=3D <j-r@online.de>

  Since 98bf8a47c296f51ea9722fef4bb81dbfb70cd4bb status would claim that
  git-commit could be useful even if there are no changes except untracked =
  files.

  Since wt-status is already computing all the information go the whole way=
   and
  separately track the (non-)emptiness of all three sections, unify the cod=
  e, and
  provide separate messages for each case. This adds a new message for the
  untracked only case and adds an explanation for a completely empty workin=
  g
  directory during initial commit.

  This change is effectively reverting 98bf8a47c296f51ea9722fef4bb81dbfb70c=
  d4bb
  and replacing it by a cleaner version.

  Signed-off-by: J=C3=BCrgen R=C3=BChle <j-r@online.de>

Notice:

 * The message claims to be from git-send-email;

 * Content-Type and CTE are UTF-8 and QP (which is fine);

 * You have in-body From: line; this is not wrong per-se and I
   understand why you would want one (your e-mail From: line
   uses ASCII approximations "ue" and "ue" and you would want
   the resulting commit to spell your name correctly).

 * However, this in-body From: line is _doubly_ QP encoded (what
   you see above is your name, first RFC 2047 encoded and then
   QP encoded).  It shouldn't be.

So, my questions are:

 (1) is this what git-send-email generates and sends out by
     default?  If so that means it is a bug in that program that
     needs to be fixed.

 (2) if not, are you inserting the in-body From: by hand,
     perhaps cut & paste from format-patch output, before
     feeding git-send-email (which runs QP on it)?

If the latter, please do not paste the RFC 2047 quoted form.
You can spell your name in raw UTF-8 on the in-body From: line
just like you did on your Signed-off-by: line.
