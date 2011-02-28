From: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
Subject: Re: [PATCH] Limit file descriptors used by packs
Date: Mon, 28 Feb 2011 21:35:57 +0100
Message-ID: <20110228203557.GA8189@pcpool00.mathematik.uni-freiburg.de>
References: <1298924835-23413-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 21:36:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu9pP-0001B5-5q
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 21:36:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755234Ab1B1UgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 15:36:03 -0500
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:45837
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755164Ab1B1UgB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 15:36:01 -0500
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1Pu9oz-000669-Sg; Mon, 28 Feb 2011 21:35:57 +0100
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1Pu9oz-00028y-QP; Mon, 28 Feb 2011 21:35:57 +0100
Content-Disposition: inline
In-Reply-To: <1298924835-23413-1-git-send-email-spearce@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168138>

* Shawn O. Pearce <spearce@spearce.org> [110228 21:27]:
> By using a hard upper limit that is below the rlimit of the current
> process, it is not necessary to check for EMFILE on every single
> fd-allocating system call.  Instead reserving 8 file descriptors
> makes it safe to assume the system call won't fail due to being
> over limit in the filedescriptor limit.

Isn't 8 quite a bit low for a reserve? Couldn't some libc stuff
(especially nss modules perhaps activated by something) easily surpass
that?

	Bernhard R. Link
