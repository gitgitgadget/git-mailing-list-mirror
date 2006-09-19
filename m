From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: more support for PATH_INFO based URLs
Date: Tue, 19 Sep 2006 11:49:53 +0200
Organization: At home
Message-ID: <eeoeee$q4u$1@sea.gmane.org>
References: <20060916210832.GV17042@admingilde.org> <eejhtr$paa$1@sea.gmane.org> <eejlht$870$1@sea.gmane.org> <20060919081933.GB31940@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 19 11:50:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPcEc-0003Ws-UZ
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 11:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964918AbWISJto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 05:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964954AbWISJto
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 05:49:44 -0400
Received: from main.gmane.org ([80.91.229.2]:44501 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964918AbWISJtn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Sep 2006 05:49:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GPcEN-0003S9-AU
	for git@vger.kernel.org; Tue, 19 Sep 2006 11:49:31 +0200
Received: from host-81-190-25-93.torun.mm.pl ([81.190.25.93])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 11:49:31 +0200
Received: from jnareb by host-81-190-25-93.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 11:49:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-93.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27270>

Martin Waitz wrote:

> On Sun, Sep 17, 2006 at 04:20:23PM +0200, Jakub Narebski wrote:
>> matled (Matthias Lederhofer) on #git proposed to use ':' as a separator
>> between branch and filename (as branch doesn't need to be flat, 
>> e.g. "jc/diff" like branch name), because valid branch name cannot contain
>> ':' (and this limit is only for branch name).
> 
> you are right, my patch doesn't work with hierarchical branch names.
> However using ":" alone does not work eighter.
> My main motivation for this patch was to be able to export .html files
> and to have working links between them.
> However a <a href="main.html"> link inside "branch:index.html" would
> try to get "main.html" and not "branch:main.html".
> 
> Perhaps use ":/" as separator?

That would be _very_ easy to add. Just strip leading "/" from pathname,
and we can have

        path/to/project.git/hierarchical/branch:/path/to/filename

By the way, besides hierarchical branches, we might need this if
the repository (project) has the branch (head) and tag with the same name,
and we want to select one or the other.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
