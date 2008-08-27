From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH v4] make git-shell paranoid about closed stdin/stdout/stderr
Date: Wed, 27 Aug 2008 19:22:06 +0200
Message-ID: <20080827172206.GA27450@cuci.nl>
References: <E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net> <7vbpzgb94q.fsf@gitster.siamese.dyndns.org> <E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net> <20080826074044.GA22694@cuci.nl> <32541b130808262201v4d7c1aa5r781720a80b79fcd0@mail.gmail.com> <20080827091800.GB484@cuci.nl> <48B54A3D.3080708@gnu.org> <E1KYMtm-0007Cd-Gt@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, quarl@cs.berkeley.edu, gitster@pobox.com,
	j.sixt@viscovery.net
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Aug 27 19:23:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYOji-0001mQ-6v
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 19:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbYH0RWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 13:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbYH0RWJ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 13:22:09 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:34049 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbYH0RWI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 13:22:08 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 993715465; Wed, 27 Aug 2008 19:22:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <E1KYMtm-0007Cd-Gt@fencepost.gnu.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93903>

Paolo Bonzini wrote:
>Fixing this in git was considered to be overkill, so this patch works
>around it only for git-shell.  The fix is simply to open all the "low"
>descriptors to /dev/null in main.

Since git-shell is not setuid, this strictly is not necessary, however,
I concur that git-shell is potentially started in a partially broken
environment which is not always easily fixable by the user.
And since git-shell needs to sanitise the filedescriptors anyway before
launching other programs, it might as well cleanup at startup if needed.

Acked-by: Stephen R. van den Berg <srb@cuci.nl>
-- 
Sincerely,
           Stephen R. van den Berg.
"First, God created idiots.  That was just for practice.
 Then he created school boards."  --  Mark Twain
