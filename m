From: John Keeping <john@keeping.me.uk>
Subject: Re: Git hook commit similar to subversion start-commit hook
Date: Tue, 5 Mar 2013 21:31:02 +0000
Message-ID: <20130305213102.GW7738@serenity.lan>
References: <20130305211440.GA9929@banach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jose Garcia Juanino <jjuanino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 22:31:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzSS-0003oc-7s
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 22:31:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865Ab3CEVbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 16:31:09 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:34432 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742Ab3CEVbI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 16:31:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 09269198038;
	Tue,  5 Mar 2013 21:31:08 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.999
X-Spam-Level: 
X-Spam-Status: No, score=-0.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vdqtZZBVj+m1; Tue,  5 Mar 2013 21:31:07 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D2DCD198029;
	Tue,  5 Mar 2013 21:31:04 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20130305211440.GA9929@banach>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217483>

On Tue, Mar 05, 2013 at 10:14:42PM +0100, Jose Garcia Juanino wrote:
> Is there any hook in Git similar to start-commit subversion hook? The
> requirements would be:
> 
> 1- A hook on the server side (as pre-receive)
> 2- It will execute the actions *before* the begin of transaction
> (pre-receive hook needs the references already pushed before).
> 
> For example, it would be useful to refuse a push if the server has a
> high load.

If you are using Gitolite[1] then a PRE_GIT trigger could do this.

With plain Git you can achieve the same by specifying a custom shell for
the users logging in and performing the custom check when
git-receive-pack is being executed.


[1] http://gitolite.com/gitolite

John
