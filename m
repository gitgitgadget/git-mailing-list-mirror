From: chombee <chombee@lavabit.com>
Subject: Re: Syncing a git working tree with Dropbox?
Date: Thu, 14 Jan 2010 13:40:49 +0000
Message-ID: <20100114134049.GA16445@dulip>
References: <20100113235718.GA7033@dulip> <be6fef0d1001132139p56944cdax22674ca773af0199@mail.gmail.com> <83d7aaa41001140519g2f84199j38bd0e9a5c73953@mail.gmail.com> <20100113235718.GA7033@dulip> <be6fef0d1001132139p56944cdax22674ca773af0199@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 14:41:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVPwc-0002DJ-JP
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 14:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756316Ab0ANNk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 08:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251Ab0ANNk5
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 08:40:57 -0500
Received: from karen.lavabit.com ([72.249.41.33]:34408 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755348Ab0ANNk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 08:40:56 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 4CADC11B89C
	for <git@vger.kernel.org>; Thu, 14 Jan 2010 07:40:56 -0600 (CST)
Received: from dulip (77-44-113-77.xdsl.murphx.net [77.44.113.77])
	by lavabit.com with ESMTP id 361N8SM322UO
	for <git@vger.kernel.org>; Thu, 14 Jan 2010 07:40:56 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=mxlD/gzEbHCOTVuP9eiHft7CAeZDu5iANSCoR2lS79Tz2FRJRyBhn+v53QhN2EkgxA/RBDE71IIK2zStqztQRw4BSLRHY2VMU7ysNSkfVRmw23WIPYMP2wVeuwQzUdQ9LdHyoSWhDRWWJPJGId1OfG7eVz06i0cEbGRi/it3Ufc=;
  h=Date:From:To:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
Content-Disposition: inline
In-Reply-To: <83d7aaa41001140519g2f84199j38bd0e9a5c73953@mail.gmail.com> <be6fef0d1001132139p56944cdax22674ca773af0199@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136990>

Ok, I was aware that I would have to sync the .git directories also, but
my plan was to do that in the normal way (git pull and git push) but
sync the working tree automatically with Dropbox. However, I'm now
imagining all kinds of mind-bending problems this might cause. If I
commit and push some changes on machine A, and Dropbox syncs the working
copy, then I go to machine B, git status will show that machine B has
changes to commit, until I do git pull on machine B. As Geoffrey points
out, changing branches could be even worse!

In any case, I've had problems with detached working trees. With an
older version of git it was refusing to checkout a detached working
tree. I upgraded git and checkout worked, but it refused to do git pull.

Ah well.

I'm not too sure about keeping the .git directory itself in Dropbox.
Googling it, it seems lots of people do it without any problems, but
there are some reports of it going haywire.

On Thu, Jan 14, 2010 at 01:39:10PM +0800, Tay Ray Chuan wrote:
> Hi,
> 
> On Thu, Jan 14, 2010 at 7:57 AM, chombee <chombee@lavabit.com> wrote:
> > My idea is that I keep my .git folder safely outside of my Dropbox
> > folder, but my git repository has a detached working tree that is
> > located in the Dropbox folder. On machine B it would be the same setup.
> > So the two machines each have their own clone of the git repo and these
> > are synchronised by git push and git pull with a 'central' remote repo.
> > But the two clones share the same working tree, or more accurately their
> > working trees are synced by Dropbox.
> >
> > The working tree is just files, I don't see how it's different from
> > Dropbox syncing any other files. Dropbox and git ought not to collide in
> > any way. So this should work fine shouldn't it?
> 
> Your changes in git (like new commits) won't be synced.
> 
> -- 
> Cheers,
> Ray Chuan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

On Thu, Jan 14, 2010 at 05:19:08AM -0800, Geoffrey Lee wrote:
> On Wed, Jan 13, 2010 at 9:39 PM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> > On Thu, Jan 14, 2010 at 7:57 AM, chombee <chombee@lavabit.com> wrote:
> >> My idea is that I keep my .git folder safely outside of my Dropbox
> >> folder, but my git repository has a detached working tree that is
> >> located in the Dropbox folder. On machine B it would be the same setup.
> >> So the two machines each have their own clone of the git repo and these
> >> are synchronised by git push and git pull with a 'central' remote repo.
> >> But the two clones share the same working tree, or more accurately their
> >> working trees are synced by Dropbox.
> >>
> >> The working tree is just files, I don't see how it's different from
> >> Dropbox syncing any other files. Dropbox and git ought not to collide in
> >> any way. So this should work fine shouldn't it?
> >
> > Your changes in git (like new commits) won't be synced.
> 
> You have to sync your .git directory. For example, using your setup,
> if you switch branches on Machine A, your working directory will
> change on Machine B, but Machine B will still think it's on the
> previous branch. This scenario would cause a lot of problems for Git.
> 
> There shouldn't be any problems with placing your entire repository
> (working tree and .git directory) inside Dropbox as long as you only
> use one computer at a time.
> 
> -Geoffrey Lee
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
