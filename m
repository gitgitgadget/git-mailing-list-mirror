From: Paul Mackerras <paulus@samba.org>
Subject: Re: gitk: synchronize highlighting in file view for 'f'&'b' commands
Date: Fri, 2 May 2008 22:49:41 +1000
Message-ID: <18459.3557.603906.871664@cargo.ozlabs.ibm.com>
References: <279b37b20803171300v748b5d23rcc5c0e534429d1be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 14:57:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrupT-0004dm-Ot
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 14:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764361AbYEBM4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2008 08:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761544AbYEBM4s
	(ORCPT <rfc822;git-outgoing>); Fri, 2 May 2008 08:56:48 -0400
Received: from ozlabs.org ([203.10.76.45]:47848 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760760AbYEBM4q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2008 08:56:46 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8DB5CDDE01; Fri,  2 May 2008 22:56:43 +1000 (EST)
In-Reply-To: <279b37b20803171300v748b5d23rcc5c0e534429d1be@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 22.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80986>

Eric Raible writes:

> Previously, 'b', backspace, and delete all did the same thing.
> This changes 'b' to perform the inverse of 'f'.  And both of
> them now highlight the filename of the currently diff.

OK, but...

> +    set file [regsub -- "-* (.*?) -*" [$ctext get $loc "$loc lineend"] "\\1"]
> +    set cline [$cflist search -regexp [subst {^$file$}] 0.0]

This seems to be working out the index of the line we want to
highlight in the file list, but both the callers of highlightfile can
supply that info much more easily by incrementing a count as they go
through $difffilestart, as far as I can tell.

Paul.
