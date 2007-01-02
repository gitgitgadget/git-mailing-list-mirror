From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to commit removed file?
Date: Tue, 02 Jan 2007 23:13:45 +0100
Organization: At home
Message-ID: <enel8u$n8g$2@sea.gmane.org>
References: <20061231102444.GD26552@mellanox.co.il> <20070102201041.GB10451@mellanox.co.il> <Pine.LNX.4.63.0701022211100.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfyatt8di.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Jan 02 23:11:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1rqb-0006mU-AY
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 23:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbXABWK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 17:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754990AbXABWK6
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 17:10:58 -0500
Received: from main.gmane.org ([80.91.229.2]:55417 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754982AbXABWK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 17:10:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1H1rqJ-00015Z-QG
	for git@vger.kernel.org; Tue, 02 Jan 2007 23:10:48 +0100
Received: from host-81-190-20-195.torun.mm.pl ([81.190.20.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 23:10:47 +0100
Received: from jnareb by host-81-190-20-195.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 02 Jan 2007 23:10:47 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-20-195.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35828>

Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> On Tue, 2 Jan 2007, Michael S. Tsirkin wrote:
>>
>>>> I'd like to remove a file and commit the removal while
>>>> leaving out other changes in repository/index.
>>>> 
>>>> $git rm kernel_patches/fixes/ib_verbs_warning_fix.patch
>>>> rm 'kernel_patches/fixes/ib_verbs_warning_fix.patch'
>>>> 
>>>> $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
>>>> error: pathspec 'kernel_patches/fixes/ib_verbs_warning_fix.patch' did
not match
>>>> any file(s) known to git.
>>>> Did you forget to 'git add'?
>>>> 
>>>> A similiar thing works with "git add".
>>> 
>>> Any ideas? Can this be done with git?
>>
>> Did you actually try the "--" thing I suggested in 
>> http://article.gmane.org/gmane.comp.version-control.git/35699/?
>>
>> Besides, I just tested with current "next": 
>>
>> $ git commit kernel_patches/fixes/ib_verbs_warning_fix.patch
>> Created commit 89a5bb5ac16fb8be9b6e061284e191cafb3e4da2
>>  1 files changed, 0 insertions(+), 22 deletions(-)
>>  delete mode 100644 a234
> 
> The difference is Michael did "git rm" to explicitly tell git to
> forget about that path, while you used the vanilla "/bin/rm".
> 
> Personally I never saw the point of having "git rm".  Maybe we
> should remove it to prevent this confusion from happening.

Does this happen with new git-rm, which removes file also from
working directory?

BTW. you probably can do this with git-update-index...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
