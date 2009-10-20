From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Moving git
Date: Tue, 20 Oct 2009 12:33:42 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910201222080.14365@iabervon.org>
References: <25926819.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Richard Lee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:33:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Hel-00010F-SN
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbZJTQdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752729AbZJTQdk
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:33:40 -0400
Received: from iabervon.org ([66.92.72.58]:41612 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752681AbZJTQdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:33:39 -0400
Received: (qmail 12774 invoked by uid 1000); 20 Oct 2009 16:33:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Oct 2009 16:33:42 -0000
In-Reply-To: <25926819.post@talk.nabble.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130808>

On Tue, 20 Oct 2009, Richard Lee wrote:

> 
> Hi Git forum,
> 
> I've just started using git yesterday, so I'm very new. So please excuse if
> I've done something the wrong way.
> 
> I cloned a git directory/repository? and then moved it. I'm trying to prune
> branches and it gives
> 
> ]fatal: '/var/www/vhosts/mydomain.co.uk/b2.git': unable to chdir or not a
> git archive
> fatal: The remote end hung up unexpectedly
> ls-remote --heads /var/www/vhosts/mydomain.co.uk/b2.git: command returned
> error: 1
> 
> b2.git was the cloned bare thing I create following the instruction here:
> 
> http://book.git-scm.com/4_setting_up_a_private_repository.html
> 
> Is there someway I can get git to update the git base directory?

The exact problem, I think, is that your clone has saved the original 
location of the bare repository as the default upstream repository 
location, and now it's not there. (It's a little hard to tell without the 
command that you were running when you got the error.)

If you edit the clone's .git/config, you should see the old location in a 
'[remote "origin"]' section. If you change this to the new location, 
everything should work. You can also do it with "git remote" somehow, but 
I personally just edit the config file, so I don't know the details.

	-Daniel
*This .sig left intentionally blank*
