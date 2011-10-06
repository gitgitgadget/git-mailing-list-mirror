From: "Bernhard R. Link" <brl+git@mail.brlink.eu>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Thu, 6 Oct 2011 13:25:30 +0200
Message-ID: <20111006112530.GB27897@server.brlink.eu>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 13:23:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBm2x-0008NB-UJ
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 13:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935824Ab1JFLXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 07:23:22 -0400
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:49379
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935288Ab1JFLXT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Oct 2011 07:23:19 -0400
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1RBm2k-0001ls-TQ; Thu, 06 Oct 2011 13:23:14 +0200
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1RBm4w-0007HP-3v; Thu, 06 Oct 2011 13:25:30 +0200
Content-Disposition: inline
In-Reply-To: <7vzkhf713u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182938>

* Junio C Hamano <gitster@pobox.com> [111005 20:19]:
> I do not necessarily think that it is a good approach to forbid the same
> branch to be checked out in two different places, by the way. [...]
> [...] The problem arises only when one of the repositories try
> to update or delete the branch while it is checked out in another working
> tree.

I think this is mostly the same problem that also make pushing to a
checked out branch a problem.

Isn't the real problem that a checked out branch / a branch having a
workdir only has information what branch it belongs to?

Wouldn't both problems (multiple workdirs of the same branch, pushing
to a checked out branch) solved if each working directory (including
the default one in a non-bare repository) also stored the commit id
last checked out? (And then giving a warning, error or automatically
creating a detached head setting whenever the branch it followed is
moved behind it's back?)

	Bernhard R. Link
