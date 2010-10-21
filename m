From: mrevilgnome <mrevilgnome@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Wed, 20 Oct 2010 18:54:31 -0700
Message-ID: <AANLkTi=mhN1M+KrGVCYLhZiMUMXSABG-YEPPgDFb-nSv@mail.gmail.com>
References: <20101018051702.GD22376@kytes>
	<m3bp6pkrf0.fsf@localhost.localdomain>
	<1287582160.2673.25.camel@wpalmer.simply-domain>
	<201010202244.39728.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 03:54:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8kMY-0004CO-EJ
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 03:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756792Ab0JUByc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 21:54:32 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37472 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab0JUByb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 21:54:31 -0400
Received: by qwa26 with SMTP id 26so2990590qwa.19
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7ZRdwW3OBHKbISKR2E354E8vuscmLvZy7XzEwgCm570=;
        b=Jz0rN4dsNjuoIxHVPp2D8VoNxepBO9HIe7GxOzrVHtGnmrnISnm8EvPLBfC2/kd8lu
         faJkRE7oKFnGEQpA48UyNJwY/qmH8pRxZBmYgzpzQFevoBCEKXG5LEdxNJ/jcP82F9nf
         9QUhFlFO+UzKvBEyr+9tAefAcQTvzt76MWhI0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LMPRnEGf1j4Wdcaj24MXWs+Y9ImQUa0sHzdbPrq728AEt5+IKixQBeelaqk0tEDJ+w
         87EGxTM5dBvlkXksI5HwpnOnEf4Nq2SYUOHo8kipA/YwKNl17evAg3qcar3WpKoz1Ndk
         GmvS6Bj4CFAyJNDZjv9JlIDN3tkY3G1z4hpvg=
Received: by 10.224.215.7 with SMTP id hc7mr157763qab.67.1287626071247; Wed,
 20 Oct 2010 18:54:31 -0700 (PDT)
Received: by 10.220.189.6 with HTTP; Wed, 20 Oct 2010 18:54:31 -0700 (PDT)
In-Reply-To: <201010202244.39728.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159455>

I agree.  The repository that I'm interested in converting has
branches all over the place /sandbox/, /sandbox/<username>/*,
/stable/MAIN/*, /stable/Features/*,  /features/*, /branches/*, etc...
Because subversion didn't enforce the convention it was all to easy to
ignore when our questionable branching strategy was created.  Instead
of expecting sub-folders of a particular path to be a branch is there
something that we can key off of in the dumpfile?  Are copy operations
notated in some fashion?

> Subversion uses the inter-file branching model (Wikipedia says it was
> "borrowed" from Perforce) to handle branches and tags. =C2=A0It uses =
"branches
> are copies (folders)" paradigm, and technically it doesn't have separ=
ate
> namespace for branches but have projects, branches, and projects'
> filesystem hierarchy mixed together; what part of path is branch name
> is defined by convention only. =C2=A0This model makes it easy to mess=
 up
> repository (because there are no technological barriers for going
> against conventions, like mentioned all-branches change, or changing
> tags, or reversed hierarchy or branches and projects).
