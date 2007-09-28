From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 14:38:51 +0200
Message-ID: <F00B74F4-7BEA-480C-B84E-A469515717B7@wincent.com>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 14:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbF9e-0001Oy-A4
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 14:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752401AbXI1MlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Sep 2007 08:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXI1MlH
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 08:41:07 -0400
Received: from wincent.com ([72.3.236.74]:48788 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbXI1MlG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 08:41:06 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l8SCcrE3013233;
	Fri, 28 Sep 2007 07:38:54 -0500
In-Reply-To: <7v3awzvrpr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59389>

El 27/9/2007, a las 21:22, Junio C Hamano escribi=F3:

> What you would want to change is the fallback behaviour for
> unconfigured "remote.<name>.push".  I think it is sensible to
> have an option to make it push only the current branch.  I am
> not sure if it is sensible to make that the default (and
> introduce --matching option to get the current behaviour) at
> this point in 1.5.X series, but from the general usability point
> of view, I would not object to demote 'matching' to optional and
> make 'current only' the default in 1.6.X or later.
>
> Thoughts?

I'd certainly welcome this change for two reasons:

1. It makes the behaviour more conservative (that is, harder to do =20
something destructive and irreversible) by using the more limited =20
scope by default. If you make a mistake and see that you really meant =20
to push all matching branches then you can just do the push again =20
with that switch; compare that to the situation now where if you =20
accidentally push all matching branches when you only wanted to push =20
the current branch then there's no way for you to "unpush".

2. Mental baggage from working with SVK (where "push" means merge =20
changes back to the branch the current branch previously branched =20
from, and "pull" means merge changes into the current branch from the =20
branch you previously branched from). At least for me and I suspect =20
for many others the "current only" default in 1.6 or latter would be =20
less "surprising" than the current behaviour can be.

Cheers,
Wincent
