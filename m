From: Mike Hommey <mh@glandium.org>
Subject: Re: corrupt object on git-gc
Date: Fri, 9 Nov 2007 20:52:37 +0100
Organization: glandium.org
Message-ID: <20071109195237.GA20030@glandium.org>
References: <4fe79b4b0711090538wf483ce7j89c518962e89780e@mail.gmail.com> <alpine.LFD.0.999.0711090758560.15101@woody.linux-foundation.org> <4fe79b4b0711090953h5b06f7d4l2d17972630a4d355@mail.gmail.com> <alpine.LFD.0.999.0711091000310.15101@woody.linux-foundation.org> <4fe79b4b0711091037g8c6c048h29b7d387e75d62bb@mail.gmail.com> <alpine.LFD.0.999.0711091050230.15101@woody.linux-foundation.org> <20071109190707.GA17864@glandium.org> <4fe79b4b0711091141i38044a5o1ef940d9c7afd58f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, ae@op5.se,
	Yossi Leybovich <sleybo@mellanox.co.il>
To: Yossi Leybovich <sleybo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 20:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqZwn-0006Fj-16
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 20:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755299AbXKITym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 14:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755285AbXKITym
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 14:54:42 -0500
Received: from vawad.err.no ([85.19.200.177]:46353 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbXKITyl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 14:54:41 -0500
Received: from aputeaux-153-1-50-102.w82-124.abo.wanadoo.fr ([82.124.10.102] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IqZw1-0002VS-EU; Fri, 09 Nov 2007 20:54:35 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IqZu9-0005ER-QK; Fri, 09 Nov 2007 20:52:38 +0100
Content-Disposition: inline
In-Reply-To: <4fe79b4b0711091141i38044a5o1ef940d9c7afd58f@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64256>

On Fri, Nov 09, 2007 at 02:41:05PM -0500, Yossi Leybovich wrote:
> What I do notice is that this commit involve few files. most of the
> file the commit generate the right next SHA1
> only for one file its generate broken SHA1
> 
> From the git show <commit> I can see that the file which end up
> corrupted is actually being totaly remove from
> 
> diff --git a/SymmK/St.c b/SymmK/St.c
> index 308806c..4b9458b 100755
> --- a/SymmK/St.c
> +++ b/SymmK/St.c
> @@ -1,1535 +0,0 @@
> -MODULE_ALIAS(m_st);
> -
> -#include <errno.h>
> -#include <string.h>
> -#include <stdarg.h>
> -#include <sys/types.h>
> -#include <sys/time.h>
> -#include "ib_global_init.h"
> ....
> .....
> ....
> 
> 
> While I tried to delete the whole file and I did not get the right SHA1
> Is this soud familiar to some one ?
> maybe its releated to issue with some kind of white character I cant see.

Because the blob is corrupted, git show can't display the correct diff.
You have to guess it by yourself ! The best you can do is look at the
diff for this file between its previous version and the one just after
the corrupted version.

Mike
