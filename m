From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Jabber, question on push,pull and --tags, and no help but jabber
Date: Mon, 06 Jun 2011 16:31:50 +0200
Message-ID: <4DECE4D6.9000204@drmicha.warpmail.net>
References: <20110606130205.GA41674@sherwood.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 16:32:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTaqT-00021P-RB
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 16:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848Ab1FFObx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 10:31:53 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46991 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752048Ab1FFObw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 10:31:52 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id E9F782068C;
	Mon,  6 Jun 2011 10:31:51 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 06 Jun 2011 10:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=ceNhPA3JdZfqyditGPeRxUW80IQ=; b=sy3mvIB0ZNDbx+SiubH2DvPk7jhj3EESR1J5ir1tK/mogVvBOBhd788us5o0+EWb2XDQ3nN1ynutmHTIASnHwG6MGZefxufCnfx/k9ho7tVyIqX4UA5H6xxLTF+Hv7GzMJzj3wHz/lv7curJjrjIEqsJ0WMfdPGTDR3p9Pm7LWk=
X-Sasl-enc: BVMhAFuPi6JnNrhiXO2N4+5d0W+eeMi4lSZOc6xRSRqI 1307370711
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6B9AC4074EF;
	Mon,  6 Jun 2011 10:31:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110606130205.GA41674@sherwood.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175127>

Steffen Daode Nurpmeso venit, vidit, dixit 06.06.2011 15:02:
> Hello GIT,
>     first paragraph is reserved for praising your existence.
>     'Used cvs(1) for long years in small team projects with local
>     private repos and never felt the need for anything else.  2011
>     is different.  I first tried you but failed resoundingly.  Due
>     to vim(1) and mutt(1) i discovered hg(1) and i still love it's
>     simple usage.  'Talking about the front-end anyway.  It's huge
>     memory consumption and slow performance forbids it's usage on
>     our old PCs (e.g. Cyrix 166+) though.  So i came back and
>     found you still receptive!  And the more i work, the less
>     i hurt, the greater the knowledge, the smoother the
>     interaction.  Are you the final word on RC in the end?
> 
> I stumbled over one thing i don't understand, because it seems
> illogical: why do i need to use --tags to force pushing of tags?
> Because there is even a config option for the latter, i suspect
> this is because of intention.  It would be nice to get some
> information on the background of that, like a link to yet existing
> documentation.  Anyway i was a bit astonished to look at some

Tags may contain private information. Say you pull some changes from
your head of group, find a strange commit you want to look at later and
tag it with "what-is-this-crap"...

More seriously, tags are not part of the "remotes layout", so when you
push them and others pull them they overwrite their tags if there's a
name clash.

> heavily scripted page of my free private repo webhoster :-) and
> don't see any tags, even though i've pushed multiple times and
> v0.0.0 was created directly after the first commit.  I would *not*
> have detected that otherwise ...
> (Yes i know it's somewhat implied by 'git help push'..--tags.
> But i'm blonde.)
> 
> Some more i'll pack into this so that it's gone with the wind:
> 
> - Due to my weak GPRS or noisy HDSPA radio connection here in the
>   pampa :) i hope for continuable network actions - failing after
>   98% is a costly pain.  So it was a real joy to read somewhere
>   that a GSOC project will address this issue!!
> - OpenSSL support for signing.  I don't use PGP/GPG.  But i use
>   HTTPS, POPS, SSH etc., so i'll have an OpenSSL/OpenSSH
>   environment here on my box ready to use.

"git tag" and "git verify-tag" call out to "gpg". That could be easily
adapted to call out to "openssl smime", or put your S/MIME signatures in
a note.

Cheers
Michael
