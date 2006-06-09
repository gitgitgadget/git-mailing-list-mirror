From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 20:58:09 +0200
Organization: At home
Message-ID: <e6cgbo$2rm$1@sea.gmane.org>
References: <5A14AF34CFF8AD44A44891F7C9FF41050795782F@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 09 20:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FomBe-00032e-Jl
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 20:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWFIS6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 14:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030396AbWFIS6X
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 14:58:23 -0400
Received: from main.gmane.org ([80.91.229.2]:55716 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030393AbWFIS6X (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 14:58:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FomBN-0002zR-TC
	for git@vger.kernel.org; Fri, 09 Jun 2006 20:58:10 +0200
Received: from 212-87-13-71.sds.uw.edu.pl ([212.87.13.71])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 20:58:09 +0200
Received: from jnareb by 212-87-13-71.sds.uw.edu.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 20:58:09 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212-87-13-71.sds.uw.edu.pl
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21539>

Post, Mark K wrote:

> I'm trying to set up a git repository for mainframe Linux developers to
> use at git390.osdl.marist.edu.  Everything _seemed_ to go well, until
> Martin Schwidefsky started actually pushing changes back to the
> repository.  When he does that, the projects disappear from the web page
> that gitweb.cgi is generating.
> 
> As far as I can tell, the problem is happening because these files are
> being written out with file permissions of 640, and since Apache is
> running as user wwwrun, it can't read them:
> -rw-r-----  1 sky git  5490 Jun  9 03:35 ./linux-2.6.git/info/refs

One of the possible soultion would be to add sky to Apache group,
make directory sticky-group, and make files readable by group (perhaps by
marking repository as shared, or something).

-- 
Jakub Narebski
Warsaw, Poland
