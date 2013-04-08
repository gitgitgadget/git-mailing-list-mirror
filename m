From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Sun, 7 Apr 2013 21:11:03 -0400
Message-ID: <20130408011103.GI27178@pug.qqx.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin>
 <20130408000658.GG27178@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 08:49:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5rq-0000sy-1S
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:47:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934590Ab3DHBLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 21:11:06 -0400
Received: from pug.qqx.org ([50.116.43.67]:33385 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934526Ab3DHBLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 21:11:06 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 1F2BE57DE5; Sun,  7 Apr 2013 21:11:04 -0400 (EDT)
Mail-Followup-To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20130408000658.GG27178@pug.qqx.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220395>

At 20:06 -0400 07 Apr 2013, I wrote:
>At 16:48 -0700 07 Apr 2013, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>Would it make sense for the message to say something like the
>>following?
>>
>>	fatal: alternate object store '/path/to/repo.git/objects' is not a local directory
>
>That would also avoid lying to the user.  But if combined with the 
>second patch in this series it could cause confusion for a different 
>reason.  Once .git files are honored, the path reported there may have 
>no relation to the path supplied by the user.

Thinking on this further, even without the companion patch there's 
another issue.  The problem isn't just that 
/path/supplied/by/user/objects isn't a directory.  It's that neither 
that nor /path/supplied/by/user/.git/objects is a directory.  And in 
many cases it's the latter that the user would be expecting to have been 
used.  Reporting on just the last name checked isn't really a good 
description of what's going on.
