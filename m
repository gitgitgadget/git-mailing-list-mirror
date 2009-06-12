From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 2/4] parse-remote: support default reflist in get_remote_merge_branch
Date: Thu, 11 Jun 2009 20:09:00 -0700
Message-ID: <7vocsucfn7.fsf@alter.siamese.dyndns.org>
References: <1244759961-4750-1-git-send-email-santi@agolina.net>
	<1244759961-4750-3-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 05:10:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEx9o-0006g8-2Z
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 05:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759485AbZFLDJB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 23:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbZFLDJA
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 23:09:00 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:34143 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932530AbZFLDI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 23:08:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090612030901.LYVS25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jun 2009 23:09:01 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2r901c00Q4aMwMQ03r903k; Thu, 11 Jun 2009 23:09:01 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=ULhWby5NEzkA:10 a=-flaUtY0sAEA:10
 a=3yCQnsJiAAAA:8 a=xPZvS_hxKpQPM-ie5N4A:9 a=PSk9wQUT6J8FVQCFo-sobqJXOGYA:4
 a=cdoSpQTWPqQA:10
X-CM-Score: 0.00
In-Reply-To: <1244759961-4750-3-git-send-email-santi@agolina.net> ("Santi
 =?utf-8?Q?B=C3=A9jar=22's?= message of "Fri\, 12 Jun 2009 00\:39\:19
 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121384>

Santi B=C3=A9jar <santi@agolina.net> writes:

> Expand get_remote_merge_branch to compute the tracking branch to merg=
e
> when called without arguments (or only the remote name).

I've queued this series (sans 3/4--see other message), but I am wonderi=
ng
if this has the same "only works with the defeault layout" issue and if=
 so
if it should be documented more clearly.

What plumbing support do you need to get the information in a more prec=
ise
way in the scripted Porcelain?  Is exposing branch_get() from remote.c
enough?  That is what is used by fill_tracking_info() in builtin-branch=
=2Ec
and the call to format_tracking_info() remote.c made by report_tracking=
()
in builtin-checkout.c --- they are used to produce the "Your branch is
ahead of that branch you are tracking" messages.
