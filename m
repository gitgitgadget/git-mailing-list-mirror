From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git and binary files
Date: Wed, 28 Jul 2010 16:17:29 -0400
Message-ID: <AANLkTiktAjui6=PECv8jFx7_0Suqv5sY=R9t4q1Jz+Be@mail.gmail.com>
References: <AANLkTikceXUDDDcisnJRzg_i8mbi0TGwGiE5znAaK2aM@mail.gmail.com> 
	<vpqwrsf1xz0.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jan Dittmer <jdi@l4x.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 28 22:17:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeD4e-0004qB-UM
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 22:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748Ab0G1URw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 16:17:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36611 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0G1URv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 16:17:51 -0400
Received: by wwj40 with SMTP id 40so2862501wwj.1
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=xc6v1qKssuefiJ00EmgsQx8U2ilppzOoixQuHA+ljHI=;
        b=a4ihzYnKn36df/2LGGNkZl+rew+ykJEoIrBGLS2J9pBkJ45kwhl5Nk/S7GIdSnWq8z
         ltnvS+Q5CwHc8liJUbL7O6HRBZv51AMOCDnjBSdngLjj6ecqnPuE16tj9ocf5B9aA5FU
         ZEjb6IkTIrIVIyZSsOY4NmT6gdqGoDMbtFeZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=K/pxy4iglPEDkdudARXXXY5eYcaQZ5PLBb0D6EgQwOn6tQ9+LDiWjfkXfrHOxJaM9I
         +h4Pt44TPn6w+AnxHVwQNd+nhxKuYoxWkXY2eH65HSeUEsCoSgnJI1NNn7jOT004t1Ow
         D2gzRmCae5hqKJsk/uPl35VhzVWqOJ1UyEQ/w=
Received: by 10.227.145.14 with SMTP id b14mr1563569wbv.24.1280348270210; Wed, 
	28 Jul 2010 13:17:50 -0700 (PDT)
Received: by 10.216.235.202 with HTTP; Wed, 28 Jul 2010 13:17:29 -0700 (PDT)
In-Reply-To: <vpqwrsf1xz0.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152117>

On Wed, Jul 28, 2010 at 10:29 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Jan Dittmer <jdi@l4x.org> writes:
>> The problem I'm facing is, that 'git status' is very
>> very slow. They seem to read through every file in the directory
>> tree. Is it possible to tell git to just use mtime/size information for
>> an initial guess?
>
> This is what it does by default. You probably need an initial "git
> status" to be slow to get this information right in the index, though.

Judging from the description, it sounds like 'git status' is the
problem, not the solution.  Although at 18 GB, it was probably pretty
slow to run, so maybe Jan only ran it once and the second time it
would have been fast :)

Depending on what the requirements are (ie. just keeping multiple
versions for posterity/safety as opposed to actually checking out old
versions on a regular basis), bup might be more useful than git in
this case: http://github.com/apenwarr/bup .

Have fun,

Avery
