From: Ron Garret <ron1@flownet.com>
Subject: Re: How to tell if a file was renamed between two commits
Date: Wed, 03 Feb 2010 09:48:22 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-F82E20.09482203022010@news.gmane.org>
References: <ron1-2EA926.18292002022010@news.gmane.org> <20100203023219.GA13092@spearce.org> <ron1-08A0F6.18483502022010@news.gmane.org> <20100203025347.GB13092@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 18:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcjLl-0002g1-1M
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 18:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932775Ab0BCRtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 12:49:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:37794 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932692Ab0BCRtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 12:49:05 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NcjLV-0002Rx-Rx
	for git@vger.kernel.org; Wed, 03 Feb 2010 18:48:57 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 18:48:57 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 18:48:57 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138849>

In article <20100203025347.GB13092@spearce.org>,
 "Shawn O. Pearce" <spearce@spearce.org> wrote:

> Ron Garret <ron1@flownet.com> wrote:
> > In article <20100203023219.GA13092@spearce.org>,
> >  "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > > > So... is there an easy way to work around this?  Is there a way to get, 
> > > > say, rev-list to tell me when the file it is tracking changed names?
> > > 
> > > Maybe use the -M flag to git log, or the --follow flag to
> > > log/rev-list?
> > 
> > Nope.  git log --follow will follow through a name change but won't 
> > actually say when the name changed happened or what the previous name of 
> > the file was.
> > 
> > And actually playing around with it some more, it appears that git 
> > rev-list doesn't actually track file renames, or at least it doesn't do 
> > it all the time.  Weird.  I'm going to have to play around with this 
> > some more.
> 
> Use:
> 
>   git log --format=%H -M --name-status --follow -- path 
> 
> I just tried it:
> 
> $ git log --format=%H -M --name-status --follow 
> gerrit-prettify/src/main/resources/com/google/gerrit/prettify/client/prettify.
> js
> 8db22c85c49814b99639b2e6346583e9be4c289f
> 
> R100    
> gerrit-patch-gwtexpui/src/main/java/com/google/gwtexpui/safehtml/client/
> 544546fcd680f82a88df3e9eba7df8acfadf1e46
> 
> M       
> gerrit-patch-gwtexpui/src/main/java/com/google/gwtexpui/safehtml/client/
> d83ac11a52c1b6d4acae932a8495daf1e9129fdf
> 
> R100    
> gerrit-patch-gwtexpui/src/main/java/com/google/gwtexpui/safehtml/public/
> 44671f5c6929a8f05223dd359182610286ceb98a
> 
> R100    src/main/java/com/google/gerrit/public/prettify20090521/prettify.js   
>   
> 56fc9e3d951b0886c4781a5c8623dbc3da824f30
> 
> A       src/main/java/com/google/gerrit/public/prettify20090521/prettify.js
> 
> 
> Yay, its been renamed 3 times in its life here.  :-)

Cool!  Thanks!

rg
