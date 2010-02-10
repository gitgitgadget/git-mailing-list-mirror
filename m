From: Tzafrir Cohen <tzafrir.cohen@xorcom.com>
Subject: Re: git-svn: Cannot lock the ref 'refs/remotes/tags/autotag_for_.'.
Date: Wed, 10 Feb 2010 19:07:57 +0200
Organization: Xorcom*
Message-ID: <20100210170757.GZ3599@xorcom.com>
References: <20100209213929.GL3599@xorcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 18:09:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfG3r-0007wC-Dc
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 18:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754723Ab0BJRJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 12:09:05 -0500
Received: from local.xorcom.com ([62.90.10.53]:41759 "EHLO local.xorcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754358Ab0BJRJE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 12:09:04 -0500
Received: by local.xorcom.com (Postfix, from userid 1000)
	id E1515C55AA9; Wed, 10 Feb 2010 19:07:57 +0200 (IST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20100209213929.GL3599@xorcom.com>
X-Forced-Service: Sadly Using Gmail [tm]
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139521>

Small update,

On Tue, Feb 09, 2010 at 11:39:29PM +0200, Tzafrir Cohen wrote:
> Hi
> 
> I'm using git-svn for watching over SVN repositories in
> svn.asterisk.org . The largest one there is
> http://svn.asterisk.org/svn/asterisk .
> 
> This worked fine up until recently. I was using Debian Stable with Git
> 1.5.6 .
> 
> Recently I upgraded my system to Debian Testing with Git 1.6 (I
> currently have 1.6.6.1-1). Today I tried to update the repository (git
> svn rebase --fetch-all) and got the following error:
> 
>   fatal: Cannot lock the ref 'refs/remotes/tags/autotag_for_.'.
> 
> IIRC it followed an automatic garbage-collection in the repository.
> 
> I decided to re-clone the SVN repository (I was planning on doing that
> for quite some time, with a proper AUTHORS file this time. But it's a
> repo of some 200,000 revisions and takes a few days to clone)
> 
> I eventually got the same error.
> 
> The specific revision that triggered it:
> 
>   http://svnview.digium.com/svn/asterisk?view=revision&revision=47394
> 
> Should git-svn mangle SVN tag names to be legal git ref names? Or just
> panic before it makes the git repo invalid?
> 
> Is there a way for me to skip some tags? I can avoid that specific tag.

Here's one that did not work:

$ git svn clone -s --ignore-paths='^/tags/autotag_for_.$' http://svn.asterisk.org/svn/asterisk

I again stress that git-svn manages to fetch a faulty repository.
Another sub-question is: how do I remove that faulty reference git-svn
added?

> 
> Please CC your replies to me as I don't actively follow this list.

-- 
               Tzafrir Cohen
icq#16849755              jabber:tzafrir.cohen@xorcom.com
+972-50-7952406           mailto:tzafrir.cohen@xorcom.com
http://www.xorcom.com  iax:guest@local.xorcom.com/tzafrir
