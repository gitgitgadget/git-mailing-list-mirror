From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 2/2] pretty=format: Add %d to show decoration
Date: Wed, 09 Apr 2008 23:40:38 +0200
Message-ID: <47FD37D6.2030506@lsrfire.ath.cx>
References: <alpine.DEB.1.00.0804071439480.430@eeepc-johanness> <alpine.DEB.1.00.0804071441040.430@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 09 23:41:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jji2p-00033F-UD
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 23:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbYDIVkn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 17:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753264AbYDIVkn
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 17:40:43 -0400
Received: from india601.server4you.de ([85.25.151.105]:55775 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbYDIVkm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 17:40:42 -0400
Received: from [10.0.1.101] (p57B7E69B.dip.t-dialin.net [87.183.230.155])
	by india601.server4you.de (Postfix) with ESMTPSA id 237A92F8028;
	Wed,  9 Apr 2008 23:40:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <alpine.DEB.1.00.0804071441040.430@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79139>

Johannes Schindelin schrieb:
> With this patch, "git log --decorate --pretty=3Dformat:%d", shows the=
=20
> name decoration (i.e. whenever a commit matches a ref, that ref's=20
> name is shown).

Cute idea. :)

What about objects with multiple decoration?  How about producing a
comma-separated list like git-log does?

How about making %d imply --decorate?  You could load the decorations
lazily when it's first encountered.

> Maybe %d should expand to " (<name decoration>)" instead of "<name=20
> decoration>"?

foobar2000 (http://foobar2000.org/) has a kind of music tagging
language, and one of its features might be interesting for us here: you
can group a placeholder and other stuff inside brackets.  The construct
resolves to an empty string if the placeholder is NULL, i.e. in your
example "[ (%d)]" would resolve to either " (the decoration)" or "",
depending on the object having a decoration or not.  (It might be a
better fit for --pretty=3Dformat: to use %[ and %].)

By the way, your patch reminds me that I wanted to add a placeholder fo=
r
git-describe's output.  I doubt I'll find time for that in the near
future, though..

Ren=E9
