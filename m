From: Aaron Schrab <aaron@schrab.com>
Subject: Re:  Adding hooks.directory config option; wiring into run_hook
Date: Fri, 16 Dec 2011 20:58:21 -0500
Message-ID: <20111217015820.GC30928@pug.qqx.org>
References: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: git@vger.kernel.org
To: Christopher Dale <chrelad@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 03:06:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbjfO-0007aX-0k
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 03:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760729Ab1LQCGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 21:06:22 -0500
Received: from pug.qqx.org ([209.177.157.228]:57865 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760643Ab1LQCGU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 21:06:20 -0500
X-Greylist: delayed 479 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Dec 2011 21:06:20 EST
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 2A38E20308; Fri, 16 Dec 2011 20:58:21 -0500 (EST)
Mail-Followup-To: Christopher Dale <chrelad@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CADQnX_e76LzuRUDOKFOsRHU=e8Cw+qh5x1BdW5HMEdMmP5PaHg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187346>

At 12:00 -0600 16 Dec 2011, Christopher Dale <chrelad@gmail.com> wrote:
>Since the hooks directory is within a directory that by it's very 
>nature requires write permissions,

Are you sure about this?  I'd think that this would mainly be used for 
bare repositories.  For a test I created a bare repository, removed 
write permission, changed the owner to root, then pushed into it from 
another repository.  So it seems that, at least for basic usage, a bare 
repository can be modified even if with write permission removed since 
no entries are being created or removed at the top level.

For this to be a workaround, new repositories would need to be created 
by an admin.  The requirement that the containing directory not be 
writeable wouldn't necessarily be an issue; at least on Linux I'm able 
to create files/directories as root even in a non-writeable directory.
