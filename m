From: Tommi Virtanen <tv@eagain.net>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Fri, 17 Apr 2009 16:48:59 -0700
Message-ID: <20090417234859.GY898@eagain.net>
References: <1239916256-10878-1-git-send-email-mh@glandium.org> <7v63h24znd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 02:01:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuxzU-0002eI-36
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 02:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbZDQX7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 19:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754042AbZDQX7a
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 19:59:30 -0400
Received: from eagain.net ([208.78.102.120]:58199 "EHLO eagain.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537AbZDQX73 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 19:59:29 -0400
X-Greylist: delayed 628 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 Apr 2009 19:59:29 EDT
Received: from musti.eagain.net (unknown [208.79.94.252])
	by eagain.net (Postfix) with ESMTPS id 960B455E6D;
	Fri, 17 Apr 2009 23:49:00 +0000 (UTC)
Received: by musti.eagain.net (Postfix, from userid 1000)
	id 8080A508018; Fri, 17 Apr 2009 18:48:59 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7v63h24znd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116805>

On Fri, Apr 17, 2009 at 04:40:54PM -0700, Junio C Hamano wrote:
> How does this interact with a typical gitosis installation?  I think it
> extracts bits from the ORIGINAL_COMMAND and formulates a sanitized command
> line and then passes it to git-shell but I do not think it removes the
> variable from the environment.

Yup, not sanitizing. I could make that change easily, if you want, but
there's plenty of installations out there already.

I'd say add a git-shell flag that enables any magic behavior, don't
just magically work differently based on that environment variable.
Sometimes that is set for reasons that are not related to what you're
actually running in the end; e.g. "chroot /foo exec-whatever-i-gave-you".

-- 
:(){ :|:&};:
