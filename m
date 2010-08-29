From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 02/13] fast-export: support done feature
Date: Sun, 29 Aug 2010 15:15:40 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1008291500070.14365@iabervon.org>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com> <1283053540-27042-3-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 21:16:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpnME-0004bD-TI
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 21:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab0H2TPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 15:15:53 -0400
Received: from iabervon.org ([66.92.72.58]:53987 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753818Ab0H2TPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 15:15:52 -0400
Received: (qmail 2175 invoked by uid 1000); 29 Aug 2010 19:15:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Aug 2010 19:15:40 -0000
In-Reply-To: <1283053540-27042-3-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154702>

On Sat, 28 Aug 2010, Sverre Rabbelier wrote:

> If fast-export is being used to generate a fast-import stream that
> will be used afterwards it is desirable to indicate the end of the
> stream with the new 'done' command.
> 
> Add a flag that causes fast-export to end with 'done'.

I was assuming that whatever passed the output from fast-export to 
fast-import would add the "done" itself when its fast-export child 
exitted. Obviously, if there's going to be anything after the gfi stream, 
something's going to have to write the next thing, and whatever that is 
can write the "done". Of course, the caller can't add the feature, so if 
the feature is necessary (and I don't remember all the possible 
interactions to say), this would be necessary.

	-Daniel
*This .sig left intentionally blank*
