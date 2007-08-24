From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add "--only-untracked" flag to status commands.
Date: Fri, 24 Aug 2007 00:46:02 -0700
Message-ID: <7v8x81s7d1.fsf@gitster.siamese.dyndns.org>
References: <4fcfda4a654b003f3ae3dc8d56424b5f59f48093.1187897406.git.v@pp.inet.fi>
	<20070823203246.GB3516@steel.home>
	<6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?VsOkaW7DtiBKw6RydmVsw6Q=?= <v@pp.inet.fi>
X-From: git-owner@vger.kernel.org Fri Aug 24 09:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOTs6-0004DY-5x
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 09:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757165AbXHXHqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 24 Aug 2007 03:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756722AbXHXHqI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 03:46:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074AbXHXHqH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2007 03:46:07 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7C2B91274CB;
	Fri, 24 Aug 2007 03:46:26 -0400 (EDT)
In-Reply-To: <6D8BA2E0-50CD-4B7B-84D3-3D9A61421131@pp.inet.fi>
 (=?utf-8?B?VsOkaW7DtglKw6RydmVsw6Qncw==?= message of "Fri, 24 Aug 2007
 09:35:13 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56561>

V=C3=A4in=C3=B6 J=C3=A4rvel=C3=A4 <v@pp.inet.fi> writes:

> The way I see the flag used is: A user runs "git status", sees that
> there is too much untracked files and not enough scrollback, so he
> runs "git status --only-tracked" to filter the results.

Why?

Just set up .gitignore once then (1) you do not have to worry
about them ever again, and (2) you _will_ still be able to
notice if you accidentally added more cruft, or more
importantly, if you forgot to tell an important file to git.

I think the latter is more important point.  If you train a
naive user to use --only-tracked to ignore "Untracked" list, you
are doing him or her a great disservice.  Mistake to forget "git
add" a new file before commiting will bound to happen.
