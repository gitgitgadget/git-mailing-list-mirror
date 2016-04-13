From: Stephen Kelly <steveire@gmail.com>
Subject: Re: Why doesn't gitk highlight commit references from git-describe?
Date: Wed, 13 Apr 2016 23:55:49 +0200
Message-ID: <nemf95$e1u$1@ger.gmane.org>
References: <nemal5$mb$1@ger.gmane.org> <CAGZ79kZVC0FxUN45KgLh-2tEK2=j2-yyTajYOc=s-LECgx+yqQ@mail.gmail.com> <xmqqk2k1jita.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_C9wSS+z7XwPEWiM+8vhYuZzs_SPZ0mQR=LB+MPzTJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 23:56:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqSle-0002FI-VM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 23:56:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbcDMV4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 17:56:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:44178 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922AbcDMV4F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 17:56:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aqSlS-00029F-AY
	for git@vger.kernel.org; Wed, 13 Apr 2016 23:55:58 +0200
Received: from x55b39f7f.dyn.telefonica.de ([85.179.159.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 23:55:58 +0200
Received: from steveire by x55b39f7f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 23:55:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x55b39f7f.dyn.telefonica.de
User-Agent: KNode/4.14 pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291493>

Stefan Beller wrote:

> We also want to have 4b9ab0ee0130~1^2 to work `right`, in the sense
> that not just the hexadecimals are highlighted and linking to
> 4b9ab0ee0130, but the whole expression should link to 49e863b02ae177.

Presumably the same logic which finds 4b9ab0ee0130 to link it can also see 
if it is suffixed with '~1^2' ?

Is a ref like 4b9ab0ee0130~1^2 commonly useful? In cmake we use the output 
of cmake describe --contains (when there is a following tag) to refer to 
commits, in a pattern which I've also seen in git.git occasionally:

 https://cmake.org/gitweb?p=cmake.git;a=commitdiff;h=23f3798c

I think the only reason for using the output of cmake describe --contains is 
that it shows the reader the 'era' of the commit (and release it appears in) 
without having to look it up. I'm not really aware of another good reason to 
use it, but I think that's enough to make sense.

However I'm not sure I understand why anyone would refer to 4b9ab0ee0130~1^2 
instead of 49e863b0 (or perhaps v2.6.5~12, depending on whether the tag is 
there).

>> What does 'HEAD^' mean? If it is 'the commit before this one', then why
>> not link it?
> 
> As said I was thinking about the git development

> I do not think we would want to link HEAD to anything in that example.
> (I'd have no idea what it would link to here, so just not link it?)

Right, so if a commit message contains something like 

 Make git rebase -i HEAD^^^^ ten times better

then HEAD^^^^ shouldn't become a link. Makes sense to me.

Thanks,

Steve.
