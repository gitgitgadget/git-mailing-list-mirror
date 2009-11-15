From: Lorenzo Bettini <bettini@dsi.unifi.it>
Subject: Re: pushing remote branches
Date: Sun, 15 Nov 2009 11:21:53 +0100
Message-ID: <hdoko1$s78$1@ger.gmane.org>
References: <hdneuv$nc8$2@ger.gmane.org> <2e24e5b90911141645n59680856ja21f2f3c7063f7c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 11:22:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9cFf-0003Xz-UI
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 11:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629AbZKOKWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 05:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbZKOKWY
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 05:22:24 -0500
Received: from lo.gmane.org ([80.91.229.12]:53027 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbZKOKWX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 05:22:23 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1N9cFP-0003OV-AV
	for git@vger.kernel.org; Sun, 15 Nov 2009 11:22:19 +0100
Received: from 93.88.112.188 ([93.88.112.188])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 11:22:19 +0100
Received: from bettini by 93.88.112.188 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 11:22:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 93.88.112.188
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <2e24e5b90911141645n59680856ja21f2f3c7063f7c0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132929>

Sitaram Chamarty wrote:
> Hi Lorenzo,
> 
> On Sun, Nov 15, 2009 at 5:07 AM, Lorenzo Bettini <bettini@dsi.unifi.it> wrote:
> 
>>            url = git://...
> 
>> isn't this enough to be able to push the experiments branch?
> 
> not normally.
> 
> The "git://" protocol is a read-only protocol by default.  Since it is
> completely unauthenticated, enabling push via git:// is not a good idea in
> general.

so probably I managed to push origin master anyway because gitorious 
asked me for my ssh passphrase?

> 
>>            url = git@...
> 
> This is a shortcut for something like ssh://git@..., which then allows write
> also.

Thus, if I had

[remote "origin"]
         fetch = +refs/heads/*:refs/remotes/origin/*
         url = git@...
[branch "master"]
         remote = origin
         merge = refs/heads/master
[branch "experiments"]
         remote = origin
         merge = refs/heads/experiments

instead of

[remote "origin"]
         fetch = +refs/heads/*:refs/remotes/origin/*
         url = git://...
[branch "master"]
         remote = origin
         merge = refs/heads/master
[branch "experiments"]
         remote = origin
         merge = refs/heads/experiments

I would have been able to push also to branch experiments?  Without 
having to add

[remote "experiments"]
         url = git@...
         fetch = 
+refs/heads/experiments:refs/remotes/experiments/experiments

?

thanks in advance
	Lorenzo

-- 
Lorenzo Bettini, PhD in Computer Science, DI, Univ. Torino
ICQ# lbetto, 16080134     (GNU/Linux User # 158233)
HOME: http://www.lorenzobettini.it MUSIC: http://www.purplesucker.com
http://www.myspace.com/supertrouperabba
BLOGS: http://tronprog.blogspot.com  http://longlivemusic.blogspot.com
http://www.gnu.org/software/src-highlite
http://www.gnu.org/software/gengetopt
http://www.gnu.org/software/gengen http://doublecpp.sourceforge.net
