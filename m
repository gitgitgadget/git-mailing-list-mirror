From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 19:42:43 +1000
Message-ID: <BANLkTin2Ts5C=Sp60w7xnkJ078MaNiroVw@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
	<BANLkTi=VLKoKxib+_NDOJYKL-R=AZWDi6g@mail.gmail.com>
	<BANLkTi=skWHp+ALSqg9BOTqAjqw5Si_-4Q@mail.gmail.com>
	<BANLkTi=b3bSt8VUvFJw2TiXZNXf0+wLj+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "david@lang.hm" <david@lang.hm>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 11:42:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFNkN-0001ar-Mu
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 11:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab1D1Jmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 05:42:45 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37972 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab1D1Jmn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 05:42:43 -0400
Received: by vxi39 with SMTP id 39so1889494vxi.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zYGpvjG1x+K+bT7L9x/P2mm5lVmpUtbEAq/lWYb9mdk=;
        b=m19sxO+FsheiNOrwSBRGUqbaZP+Ga9beFMf5xkh2h97bGvVUh206mehoePaf7Ca4iP
         mMxCpXBJwltKAd4L1VpGd2nKZlQM6TYvhnHE5EYTYhYlFLXINlo+8Wn1sO1ONjNXwf96
         QVi9HUWvONfk/bgEkd67CBZ87YyuaUbbDxp6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kJUnYOJlmtN4Y1b8raadZ1W9Y8roz8Fr6Iw5i3kgwj0Oz3hlDhx75NK3ZfUPaDjtsX
         /yHIBAF8fuBfgSyBN3urSgJ3vD10zyJx66nUi8HPA6fj8he3Kr8vAcRUQwRKqObzhzFi
         pQaO9lJdv1MvOSGLvPPEKI40xuE4YoIoVGGpg=
Received: by 10.52.169.135 with SMTP id ae7mr4661190vdc.79.1303983763174; Thu,
 28 Apr 2011 02:42:43 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Thu, 28 Apr 2011 02:42:43 -0700 (PDT)
In-Reply-To: <BANLkTi=b3bSt8VUvFJw2TiXZNXf0+wLj+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172338>

On Thursday, April 28, 2011, Pau Garcia i Quiles <pgquiles@elpauer.org> wrote:
> On Thu, Apr 28, 2011 at 10:09 AM, Jon Seymour <jon.seymour@gmail.com> wrote:
>
>> Ok, I have tried to explain why separating the concerns of package
>> management and plugin management is an appropriate thing to do, and
>> why one directory for each plugin is also a good thing to do. BTW: I
>> thought you actually suggested this concept yourself in your earlier
>> post.
>
> Please, re-read my mails. I *am* suggesting that plugins store data in
> different directories!

Good. Sorry I explained why an activation step is good for
performance, particularly if you have a plugin architecture that uses
multiple directories, one per plugin. I misinterpreted your confusion
about why an activate step was necessary as an explicit rejection of
my arguments that an activation step was a plus for performance and
conflict detection in an environment in which each plugin is installed
in it's own directory. Apologies.

Supposed you have 100 plugins. Suppose the user invoked git foobar
where foobar is an installed plugin. How does git find the plugin to
invoke? Why it has to scan 100 directories looking for a match.

If you use an activation step (just after installation) you get O(1)
performance instead of O(n). Small gain for 2 plugins, I agree.

But then that isn't the only reason to use an activation step. As I
said, an activation step alllows precise detection and prevention of
conflicts that just isn't possible if you rely on first-in-PATH
semantics.

It is true, you can delegate conflict detection to the package
manager, but do you know what, that would be in Andreas"s words
"Brilliant" as it would force package maintainers become git extension
experts.

My proposal makes the git-core maintainerrthathe experts on git
extension management and relieves plugin authors, package authors and
package-manager authors of this responsibility.

I ask. is that not a very good thing?

>
> - The "main command" (git-atomic, for instance) would be stored in
> GIT_PREFIX/lib/git-plugins (instead of GIT_PREFIX/lib/git-core, which
> is where git stores its commands). Git would have to learn to search
> in GIT_PREFIX/lib/git-plugins in addition to git-core, of course.
>
> - Porcelain for git-atomic would go to
> GIT_PREFIX/lib/git-plugins/git-atomic (or something like this)
>
> - The documentation would be stored in GIT_PREFIX/doc/git-atomic
>
> - Resources in GIT_PREFIX/share/git-atomic
>
> - etc
>
> I. e. each plugin stores its stuff in a separate directory, it's just
> that directory is not a *single* directory but *many* directories,
> each one inside the proper path under GIT_PREFIX, just like it is for
> anything you install on a Unix system
>
> --
> Pau Garcia i Quiles
> http://www.elpauer.org
> (Due to my workload, I may need 10 days to answer)
>
