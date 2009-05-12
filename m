From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: How to move users from SEU (AS400) to Git?
Date: Tue, 12 May 2009 17:47:08 +0100
Message-ID: <e2b179460905120947u465c99c9x46d030b2ff0b2959@mail.gmail.com>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com>
	 <4A09A0E0.6010102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jon Brisbin <jon.brisbin@npcinternational.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue May 12 18:47:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3v8a-0004cU-3u
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbZELQrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753219AbZELQrJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:47:09 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:33196 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbZELQrI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:47:08 -0400
Received: by fxm2 with SMTP id 2so89089fxm.37
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kUrGrsCbm81RNvjhqO6DraRwF8xhOt8lIzBw5X2Hww8=;
        b=VsQgoz6Dt0haJvckFC6OI7lQFHpCNjZPxfv9FA97FwAYTJ/RzRaI7Ysu9fFaZDuMOz
         soPLKLVqvEQ8OKgJgFlaSsvLXNOa60CSgoGMhSb/vPwuNVTICW2/RiYcxMmin5M1jx54
         PSuMXOJpaPvF1Yr+iDJGWXKUl4hMJ4ie/djqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fjCw0mh+YqtrkMj4yzlK8ME29iOoYKOQEmxTQUp65fRM3FqXrRPLoaBCera5vNrN8+
         FPg/tsKZ8FV78nL5G2j6ReX5ycjD0f7P1OvAmlculawIG7dtcdh9QmoZikaOC0I2wXbT
         dyLyspeqMzywwFhMesqcWBlC0qOsMifebHKNw=
Received: by 10.223.110.4 with SMTP id l4mr5014641fap.47.1242146828223; Tue, 
	12 May 2009 09:47:08 -0700 (PDT)
In-Reply-To: <4A09A0E0.6010102@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118925>

2009/5/12 Andreas Ericsson <ae@op5.se>:
> I'd say: Hey, coders. If you want locking, we can write a small tool for
> that. To make it a learning process too, that tool will be versioned by
> git. We need a small (and stupid) server and a small (and stupid) client.
> Locking will be advisory, so you can stick to it if you like, and you get
> a nice reason to yell at whoever ignored your lock in case of conflicts.
>
> But that's just me, I guess. I've actually wanted such a tool as a sort
> of "I'm working from home on *this* and *this*", but haven't been able
> to muster the energy to work on it, especially since most of us where I
> work are reasonably comfortable in the face of merge-conflicts.

To indicate what's being worked on, both within and outside our
traditional pessimistic locking strategy, we simply push lightweight
tags to the central repo.

It allows us to see who's got what locked (and since when), but it
also allows us to do file-level three-way merges if necessary so we
can keep long-running / speculative development up-to-date. The
poor-man's rebase does the patch and moves the source tag along.
Releasing the lock removes the tag.

Mike
