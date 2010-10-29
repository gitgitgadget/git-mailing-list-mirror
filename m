From: Lukasz Palczewski <l.palczewski@prevac.pl>
Subject: Re: Restart submodule update --recursive
Date: Fri, 29 Oct 2010 07:17:03 +0000 (UTC)
Message-ID: <loom.20101029T085153-262@post.gmane.org>
References: <loom.20101028T090353-376@post.gmane.org> <20101028181515.GB14212@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 09:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBjDI-0007im-5A
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 09:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab0J2HRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 03:17:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:33732 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713Ab0J2HRN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 03:17:13 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PBjD5-0007dR-Ms
	for git@vger.kernel.org; Fri, 29 Oct 2010 09:17:11 +0200
Received: from ayr35.internetdsl.tpnet.pl ([83.18.121.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 09:17:11 +0200
Received: from l.palczewski by ayr35.internetdsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 09:17:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.18.121.35 (Mozilla/5.0 (Windows; U; Windows NT 5.1; pl; rv:1.9.2.12) Gecko/20101026 Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160311>

Hi Jonathan,

Jonathan Nieder writes:

> [...]
> But if there are many, many submodules, it could be better to script
> a --save-progress and --resume along the lines you described.
> 
> Two possible approaches:
> 
>  - Make a new script using "git submodule foreach --recursive" that
>    steps through the list by hand, or
> 
>  - Take cmd_update from git-submodule.sh in the git sources and modify
>    to taste.
> [...]

I think modyfying the git-submodule.sh will be better for me. So I looked into
it and first problem araised: 
How do I get a name of submodule with a name of a previous submodule?
Maybe I will start with how my repository looks like:

Main
 |
 --> sub1
 |     |
 |     --> nsub1
 |     |
 |     --> nsub2
 |     |
 |     --> nsub3
 |     |
 |     --> etc.     
 |
 --> sub2
 |     |
 |     --> nsub2 (no nsub1)
 |     |
 |     --> nsub3
 |     |
 |     --> nsub4
 |
 --> sub3
 |     |
 |     --> nsub1
 |     |
 |     --> nsub3 (no nsub2)
 |     |
 |     --> nsub4
 |
 etc.

It would be nice if I could get name like this sub1/nsub1 when I am in submodule
sub1. Right now, I can get submodule name: nsub1. I tried to find some commands
to get something like this, but could not find it.

If I can get that, I will be in home. Do You know how to do it?
BTW. thanks for previous suggestion.

Lukasz Palczewski
