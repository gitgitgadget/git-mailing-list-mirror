From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Intricacies of submodules
Date: Fri, 18 Apr 2008 16:02:31 +0200
Organization: At home
Message-ID: <fua9lm$qts$1@ger.gmane.org>
References: <47F15094.5050808@et.gatech.edu> <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com> <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com> <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com> <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com> <7vhcebcyty.fsf@gitster.siamese.dyndns.org> <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com> <7v63uqz265.fsf@gitster.siamese.dyndns.org> <1207859579.13123.306.camel@work.sfbay.sun.com> <7vd4oxufwf.fsf@gitster.siamese.dyndns.org> <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com> <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo> <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org> <1208202740.25663.69.camel@work.sfbay.sun.com> <7vd4or7wdt.fsf@gitster.siamese.dyndns.org> <1208317795.26863.91.camel@goose.s
 un.com> <87lk3c4ali.fsf@jeremyms.com> <1208461808.26863.129.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 17:33:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmrBW-0004t8-TX
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 16:03:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYDROCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 10:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbYDROCl
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 10:02:41 -0400
Received: from main.gmane.org ([80.91.229.2]:49080 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbYDROCk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 10:02:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JmrAl-0004xP-NG
	for git@vger.kernel.org; Fri, 18 Apr 2008 14:02:39 +0000
Received: from abvk125.neoplus.adsl.tpnet.pl ([83.8.208.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 14:02:39 +0000
Received: from jnareb by abvk125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 18 Apr 2008 14:02:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvk125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79891>

Roman V. Shaposhnik wrote:
> On Thu, 2008-04-17 at 14:09 -0400, Jeremy Maitin-Shepard wrote:

>>> And here's one more thing: in-tree .gitconfig and in-tree 
>>> update-my-git-settings.sh are absolutely identical as far
>>> as their security ramifications are concerned. If you really paranoid
>>> you have to eyeball either of them.
>> 
>> There is a huge difference: if you allow in-tree .gitconfig by default,
>> then git clone <some-repository> becomes an unsafe operation.  I can't
>> even inspect some arbitrary repository to _see_ if I like the code and
>> think it is safe very easily, since I'd normally do that by cloning the
>> repository.

[...]
>> Obviously any configuration option that specifies a shell command to run
>> is unsafe to specify in an in-tree .gitconfig.  As Junio noted,
>> smudge/clean commands are especially unsafe because they will be
>> executed even if the user only uses the clone command.
> 
> Are you saying that a *remote* in-tree .gitconfig would be capable of
> affecting *local* system before the end of the clone operation?

At the end of clone operation you usually do a checkout. clean/smudge
commands could wipe out your disk at the end of clone.  And one usually
does checkout to view contents of repository (alternative is to use
plumbing git-cat-file, which does not use .gitattributes).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
