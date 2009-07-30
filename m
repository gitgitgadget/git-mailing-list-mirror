From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: exec-path behavior
Date: Thu, 30 Jul 2009 10:48:01 -0700
Message-ID: <BLU0-SMTP449412ED39DA595CF1527AAE130@phx.gbl>
References: <4389ce950907301000m5b264771jf87cc06398bee7e0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 19:48:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWZji-000560-F1
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 19:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbZG3RsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Jul 2009 13:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZG3RsF
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 13:48:05 -0400
Received: from blu0-omc3-s8.blu0.hotmail.com ([65.55.116.83]:3338 "EHLO
	blu0-omc3-s8.blu0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751270AbZG3RsF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 13:48:05 -0400
Received: from BLU0-SMTP44 ([65.55.116.73]) by blu0-omc3-s8.blu0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Jul 2009 10:48:04 -0700
X-Originating-IP: [69.104.164.24]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from hobo ([69.104.164.24]) by BLU0-SMTP44.blu0.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 30 Jul 2009 10:48:04 -0700
In-Reply-To: <4389ce950907301000m5b264771jf87cc06398bee7e0@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.16.2; i586-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Jul 2009 17:48:04.0218 (UTC) FILETIME=[E39265A0:01CA113D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124474>

On Thu, 30 Jul 2009 12:00:29 -0500
Jeffrey Middleton <jefromi@gmail.com> wrote:

> I'm wondering about the intended behavior of the
> --exec-path/GIT_EXEC_PATH option - is it supposed to override or add
> to the built-in path?=A0 It seems to do some of both.
[...]
> There are plenty of commands in each category, and it's not
> immediately obvious to me what criteria separate them.=A0 Not a huge
> problem, since it's easy enough to use --exec-path=3Dfoo:<normal-path=
>,
> but I was in the process of adding support for exec-path to the bash
> completion, and it's an important distinction there - and much easier
> if it adds to the built-in, of course.

Jeffrey,

The commands that are "built-in" and compiled into the git executable
will execute because no searching of the exec-path is necessary.  Any
commands that are compiled into a separate executable will fail since
git can not find them in the incorrect exec-path directory.

If you take a listing of the exec-path directory on your system you'll
see that many commands are hard-linked to the single "git" executable.
The commands that aren't linked to git are external and will be those
that fail when you supply an erroneous exec-path.

Sean
