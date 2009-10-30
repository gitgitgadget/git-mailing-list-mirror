From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [UNSTABLE PATCH 03/19] Allow programs to not depend on remotes
 having urls
Date: Fri, 30 Oct 2009 02:02:16 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910300157170.14365@iabervon.org>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> <1256839287-19016-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 07:02:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3kZ5-00040d-C6
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 07:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755725AbZJ3GCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 02:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755528AbZJ3GCN
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 02:02:13 -0400
Received: from iabervon.org ([66.92.72.58]:57993 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755243AbZJ3GCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 02:02:12 -0400
Received: (qmail 17112 invoked by uid 1000); 30 Oct 2009 06:02:16 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2009 06:02:16 -0000
In-Reply-To: <1256839287-19016-4-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131674>

On Thu, 29 Oct 2009, Sverre Rabbelier wrote:

> From: Daniel Barkalow <barkalow@iabervon.org>
> 
> For fetch and ls-remote, which use the first url of a remote, have
> transport_get() determine this by passing a remote and passing NULL
> for the url. For push, which uses every url of a remote, use each url
> in turn if there are any, and use NULL if there are none.
> 
> This will allow the transport code to do something different if the
> location is not specified with a url.
> 
> Also, have the message for a fetch say "foreign" if there is no url.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> ---
> 
> 	I rebased this on master and had major conflicts with the
> 	recent 'advice' series, Daniel, please have a look at this to
> 	see whether it is sane at all.

Yup, this is right. Perhaps I should try to get the refactor in 
builtin-push to use push_with_options() without any behavior change into 
master ahead of the rest of this series, to avoid having to deal with this 
sort of conflict every time someone touches this section of code, which 
has happened several times recently now. Anyway, you correctly understood 
the intended change here.

	-Daniel
*This .sig left intentionally blank*
