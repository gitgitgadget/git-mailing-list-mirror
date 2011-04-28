From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 11:11:16 +0200
Message-ID: <BANLkTi=b3bSt8VUvFJw2TiXZNXf0+wLj+Q@mail.gmail.com>
References: <4DB80747.8080401@op5.se> <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org> <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net> <7vwrif5q93.fsf@alter.siamese.dyndns.org>
 <20110427220748.GA19578@elie> <7vsjt35l84.fsf@alter.siamese.dyndns.org>
 <20110427234224.GA26854@elie> <7viptz5j82.fsf@alter.siamese.dyndns.org>
 <BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com> <alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
 <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com> <BANLkTi=VLKoKxib+_NDOJYKL-R=AZWDi6g@mail.gmail.com>
 <BANLkTi=skWHp+ALSqg9BOTqAjqw5Si_-4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: david@lang.hm, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:11:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNGC-0001e5-N8
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab1D1JLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:11:39 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40910 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369Ab1D1JLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:11:37 -0400
Received: by pzk9 with SMTP id 9so1553344pzk.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:11:37 -0700 (PDT)
Received: by 10.68.27.194 with SMTP id v2mr2973305pbg.179.1303981896099; Thu,
 28 Apr 2011 02:11:36 -0700 (PDT)
Received: by 10.68.55.163 with HTTP; Thu, 28 Apr 2011 02:11:16 -0700 (PDT)
In-Reply-To: <BANLkTi=skWHp+ALSqg9BOTqAjqw5Si_-4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172327>

On Thu, Apr 28, 2011 at 10:09 AM, Jon Seymour <jon.seymour@gmail.com> wrote:

> Ok, I have tried to explain why separating the concerns of package
> management and plugin management is an appropriate thing to do, and
> why one directory for each plugin is also a good thing to do. BTW: I
> thought you actually suggested this concept yourself in your earlier
> post.

Please, re-read my mails. I *am* suggesting that plugins store data in
different directories!

- The "main command" (git-atomic, for instance) would be stored in
GIT_PREFIX/lib/git-plugins (instead of GIT_PREFIX/lib/git-core, which
is where git stores its commands). Git would have to learn to search
in GIT_PREFIX/lib/git-plugins in addition to git-core, of course.

- Porcelain for git-atomic would go to
GIT_PREFIX/lib/git-plugins/git-atomic (or something like this)

- The documentation would be stored in GIT_PREFIX/doc/git-atomic

- Resources in GIT_PREFIX/share/git-atomic

- etc

I. e. each plugin stores its stuff in a separate directory, it's just
that directory is not a *single* directory but *many* directories,
each one inside the proper path under GIT_PREFIX, just like it is for
anything you install on a Unix system

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
