From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stgit: bug with refresh and -p
Date: Fri, 18 Jul 2008 10:41:27 +0200
Message-ID: <20080718084127.GA7042@diana.vm.bytemark.co.uk>
References: <9e4733910807171829q6abdcfc2m90c40a70dbc8fef5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 10:20:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJlCI-00089c-UZ
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 10:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbYGRITO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 04:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbYGRITO
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 04:19:14 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2132 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbYGRITM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 04:19:12 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KJlWp-000261-00; Fri, 18 Jul 2008 09:41:27 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910807171829q6abdcfc2m90c40a70dbc8fef5@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89007>

On 2008-07-17 21:29:01 -0400, Jon Smirl wrote:

> A refresh with -p is not picking up newly added files.
>
> jonsmirl@terra:~/fs$ stg status
> ? include/linux/i2c/max9485.h
> jonsmirl@terra:~/fs$ git add include/linux/i2c/max9485.h
> jonsmirl@terra:~/fs$ stg refresh -p max9485
> Checking for changes in the working directory ... done
> Popping patches "jds-audio" - "jds-psc" ... done
> Refreshing patch "max9485" ... done
> Fast-forwarded patches "jds-psc" - "jds-audio"
> jonsmirl@terra:~/fs$ stg status
> ? include/linux/i2c/max9485.h
> jonsmirl@terra:~/fs$ stg --version
> Stacked GIT 0.14.3.163.g06f9

Hmm, I don't immediately see why this happens. I've posted a bug about
it: https://gna.org/bugs/index.php?12038

It's fixed by the refresh rewrite in my experimental branch, but
there's no test for it, so I had to check by hand.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
