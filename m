From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v2] Add a "fast stat" mode for Cygwin
Date: Sat, 27 Sep 2008 10:35:07 +0200
Message-ID: <20080927083507.GA5342@blimp.localhost>
References: <20080923140144.GN21650@dpotapov.dyndns.org> <1222498926-30635-1-git-send-email-marcus@griep.us>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Sat Sep 27 10:36:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjVHr-0002dL-Vu
	for gcvg-git-2@gmane.org; Sat, 27 Sep 2008 10:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbYI0IfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Sep 2008 04:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751820AbYI0IfM
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Sep 2008 04:35:12 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:36438 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYI0IfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Sep 2008 04:35:10 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AU8zrdc=
Received: from tigra.home (Faa4e.f.strato-dslnet.de [195.4.170.78])
	by post.webmailer.de (mrclete mo22) (RZmta 17.7)
	with ESMTP id R02067k8R7b3py ; Sat, 27 Sep 2008 10:35:07 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id A855B277AE;
	Sat, 27 Sep 2008 10:35:07 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 81D9036D1E; Sat, 27 Sep 2008 10:35:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222498926-30635-1-git-send-email-marcus@griep.us>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96903>

Marcus Griep, Sat, Sep 27, 2008 09:02:06 +0200:
> This patch introduces core.cygwinnativestat configuration flag. If this

"cygwin.nativestat"? If only to shame them

> variable is not set then Git will work as before. However, if it is set
> then the Cygwin version of Git will try to use a Win32 API function if
> it is possible to speed up stat/lstat.
> 
> This fast mode works only for relative paths. It is assumed that the
> whole repository is located inside one directory without using Cygwin
> mount to bind external paths inside of the current tree.
> 
> Symbolic links are supported by falling back on the cygwin version of
> these functions.

The cygwins .lnk cannot be supported. The names just don't exist for
native GetFileAttributesExA.
