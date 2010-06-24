From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: on pulling/cloning git notes
Date: Thu, 24 Jun 2010 15:16:46 +0200
Message-ID: <4C235ABE.9050504@drmicha.warpmail.net>
References: <AANLkTilDMVU6b7SwHx0Bztu1rTCubiIPTuDDX6pJBcHx@mail.gmail.com>	<4C2329E5.8050904@drmicha.warpmail.net> <AANLkTilGS6t29J4NQMgseZY9WD1kAPCr9oFeQt1RaWjP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 15:17:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORmJC-00044F-II
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 15:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab0FXNR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 09:17:28 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35629 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754810Ab0FXNR1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jun 2010 09:17:27 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 69ABC107E63;
	Thu, 24 Jun 2010 09:17:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 24 Jun 2010 09:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=dQ3fDzs88DjLSNkPLABkgN6Ni5I=; b=jWgoQRxfL92zfpYcF/fd9UCuCEYekr2CD+y73wl9du8luaqj11B7hnnBO55UFYWQDW58VYFbwH+qyi3oWWhwOQ4lHjIHW/oi8dX8hq67/y3mr4vJf7C/OpsEPulKse1g632HRZaghEv35y8ycW3UTDm+DbftmJRniVExGm+6kCE=
X-Sasl-enc: MdmuLj/OO6awRXNl3RYAtEMk/ys0NR+X5PPuPX042IxT 1277385447
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id BF70C66C9D;
	Thu, 24 Jun 2010 09:17:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.6pre) Gecko/20100610 Lightning/1.0b2pre Lanikai/3.1.1pre
In-Reply-To: <AANLkTilGS6t29J4NQMgseZY9WD1kAPCr9oFeQt1RaWjP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149592>

Christian MICHON venit, vidit, dixit 24.06.2010 14:25:
> On Thu, Jun 24, 2010 at 11:48 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> As you can see from the default "fetch" line above, "refs/heads" are
>> fetched by default (when cloning, fetching etc.), but nothing else
>> (well, besides some tags). You can set up an additional fetch refspec to
>> get the notes also.
> 
> I'm actually doing a fresh clone elsewhere, using 'git clone --mirror
> gitolite:daat'.

You didn't say "--mirror" before ;)

> 
> I was expecting to grab everything from the remote refs, as in this
> case my .git/config will look like this:
> [remote "origin"]
>         fetch = +refs/*:refs/*
>         mirror = true
>         url = gitolite:daat

Hmmh. I have notes in the standard "refs/notes/commits", push them into
that same ref on the remote side (using an additional push refspec).
When I "clone --mirror" that I do get them back in "refs/notes/commits"
in the (bare) mirror repo.

> [remote "origin"]
>         fetch = +refs/heads/*:refs/notes/*
>         mirror = true
>         url = gitolite:daat
> 
> Thanks for the hint, Michael!
> 

I'm glad it helped though I don't know why...

Did you push the notes into head refs?

Comparing the output of

git ls-remote gitolite:daat

to that of "git show-ref" in you local repos (the original one and the
mirror) may clear things up quite a bit.

Cheers,
Michael
