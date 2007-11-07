From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [ANNOUNCE] cgit v0.7
Date: Wed, 7 Nov 2007 11:52:21 +0100
Message-ID: <8c5c35580711070252g4b0c2914v6ecb73320a07ee83@mail.gmail.com>
References: <8c5c35580711030408n658eb11fk19d554f0fa3b17@mail.gmail.com>
	 <Pine.LNX.4.64.0711060903070.8577@ds9.cixit.se>
	 <8c5c35580711060044i7a3d0134p42e9437cbe2a258b@mail.gmail.com>
	 <6b6419750711061039l26290561wd2abe07035a8679c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "git list" <git@vger.kernel.org>
To: "Patrick Aljord" <patcito@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 11:52:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpiWT-0001RQ-E5
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:52:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbXKGKwX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXKGKwW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:52:22 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:31512 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXKGKwV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:52:21 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2762836wah
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 02:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KlN+ov3t557u1FTshd8URvTT5hORmAArKWneqdnQV4U=;
        b=UlVQ6ShYws/OC+Emair+VQEyP1S07AgGnv/CssoJMPBvhcTjm3Ec2Bo6AZYgHKy6ChP8pK8WXAc0gdNtOP10JLkDYGYcPkiqj/H4YxnGY6HwZtoFlbVum17HHWUKy7nm5PTPUPwPRYuWV/BjR1+4EarKApJsCGtQ9ddnBSqkPxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PU1TyXnkCJOWLQL4BH1X4/DMA0BVjHxVwsMuoe4vvAjMO+P+PCpmuT4oD0jATgsepC1N+dLtRJhhi9mQDevXOh9O+/XLGLFi35iPV67rtSBNOSPf+qSnq/hBeWhB6wGyT6V9mrnEXAlG9xFiJADDSoTu7RRFKE9uHkxkOThBniw=
Received: by 10.115.106.7 with SMTP id i7mr7380372wam.1194432741154;
        Wed, 07 Nov 2007 02:52:21 -0800 (PST)
Received: by 10.114.235.4 with HTTP; Wed, 7 Nov 2007 02:52:21 -0800 (PST)
In-Reply-To: <6b6419750711061039l26290561wd2abe07035a8679c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63803>

On Nov 6, 2007 7:39 PM, Patrick Aljord <patcito@gmail.com> wrote:
> Looks great, thanks for the new release.

Thanks!

> It would be great if when a commit message contains something such as
> #1234 it would automatically link to the bug tracker page of that bug
> (like Trac does) by preconfiguring the bugtracker URL.

Yeah, it shouldn't be to difficult either. We could just add a couple
of repo-options to cgitrc, maybe something like this:

  repo.bugtracker-regex=(#[0-9]+)
  repo.bugtracker-url=http://bugs.freedesktop.org/show_bug.cgi?id=%1

and then use regexec() combined with the interpolate() function in git
to perform the substitution. There could also be similar global
options, i.e.:

  bugtracker-regex=(#[0-9]+)
  bugtracker-url=http://bugs.freedesktop.org/show_bug.cgi?id=%1

which would be used if the per-repo options weren't specified.

I'll put it on my todo-list (and patches are always appreciated).

--
larsh
