From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/4] parse-remote: function to get the tracking branch to be merge
Date: Mon, 08 Jun 2009 16:30:31 -0700
Message-ID: <7v8wk2wbfs.fsf@alter.siamese.dyndns.org>
References: <1244451651-22651-2-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Tue Jun 09 01:30:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDoIa-0001Jy-Qq
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 01:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbZFHXab convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2009 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751858AbZFHXaa
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 19:30:30 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58659 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbZFHXaa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 19:30:30 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608233033.XEVN18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Mon, 8 Jun 2009 19:30:33 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1bWY1c0034aMwMQ04bWYdD; Mon, 08 Jun 2009 19:30:32 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=RAp76dD47iIA:10 a=eDh-fbTsmFgA:10
 a=3yCQnsJiAAAA:8 a=IlVFgqLpY9YpfdnFHpkA:9 a=BCxkenqJmfbLZSXIkXgA:7
 a=KlV15RXvdILgpxQPYb1dLhnN2kMA:4 a=cdoSpQTWPqQA:10
X-CM-Score: 0.00
In-Reply-To: <1244451651-22651-2-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Mon\,  8 Jun 2009 11\:00\:48
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121130>

Santi B=C3=A9jar <santi@agolina.net> writes:

> The only user of get_remote_refs_for_fetch was "git pull --rebase" an=
d
> it only wanted the tracking branch to be merge. So, add a simple
> function with this new meaning.
>
> No behavior changes.

I am all for code reduction, but after following the original logic tha=
t
uses remote_refs_for_fetch (which knows about things like "git pull the=
re
+refs/heads/master:refs/heads/origin tag v1.6.0" from the command line)
that in turn calls canon_refs_list_for_fetch (which returns a list e.g.
+refs/heads/master:refs/heads/origin refs/tags/v1.6.0:refs/tags/v1.6.0)=
,
and do not quite see how you can casually say "No behaviour changes."
