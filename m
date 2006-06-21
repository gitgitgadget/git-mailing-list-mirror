From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] gitweb: Use --git-dir parameter instead of setting $ENV{'GIT_DIR'}
Date: Wed, 21 Jun 2006 15:42:31 +0200
Organization: At home
Message-ID: <e7bibt$7m0$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com> <20060621130535.G2b34d382@leonov.stosberg.net> <20060621130930.G421234bb@leonov.stosberg.net> <20060621163302.47271f89.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed Jun 21 15:43:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2z8-0008Ck-D1
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWFUNnF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWFUNnF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:43:05 -0400
Received: from main.gmane.org ([80.91.229.2]:40846 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932158AbWFUNnE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 09:43:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ft2yo-000896-Sk
	for git@vger.kernel.org; Wed, 21 Jun 2006 15:42:51 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 15:42:50 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Jun 2006 15:42:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22273>

Timo Hirvonen wrote:

> Dennis Stosberg <dennis@stosberg.net> wrote:
> 
>> -    open my $fd, "-|", "$gitbin/git-cat-file -t $hash" or return;
>> +    open my $fd, "-|", "$gitbin/git --git-dir=$git_dir cat-file -t $hash" or return;
> 
> How about adding a function to simplify calling the git commands?
> 
> Something like git("cat-file -t $hash") which would return
> "$gitbin/git --git-dir=$git_dir cat-file -t $hash" string.

Or rather add a function(s) to call git commands, either returning git command
output, or filehandle to read from, e.g.

  my $fd = git_open("cat-file", "-t $hash") or return; 

i.e. each parameter separately, just in case.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
