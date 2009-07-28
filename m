From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 17:07:45 +0200
Message-ID: <20090728150745.GB16168@vidovic>
References: <200907280446.22890.elendil@planet.nl> <200907281127.44558.trast@student.ethz.ch> <20090728104423.GA12947@vidovic> <200907281313.51304.elendil@planet.nl> <20090728113814.GB12947@vidovic> <40aa078e0907280447p4ed92133jb5e586fb0ca40ef2@mail.gmail.com> <40aa078e0907280510s1afee3ddw3a9333620a3c7d7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Frans Pop <elendil@planet.nl>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 17:11:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVoKa-0008Tz-5t
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 17:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbZG1PID (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 11:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbZG1PIB
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 11:08:01 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:64111 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbZG1PIA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 11:08:00 -0400
Received: by ewy26 with SMTP id 26so96563ewy.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=rVCBl9+YhMcURB43kB8nVwoG1kuezqbz9Bf7e4GTJVw=;
        b=k9AOuOoUyxHkwZvDH4dTt896rEgvfXyPeZm5i25qg1UfO5p+/6K0BgxfomGv/CizXF
         7ijwoF3EHJhQ3VPuxMyhhUZeVJHgl/JEbNiIpSWwh/FEKopbe1MJKXkAd1O6JkJBJfxW
         YYtu21lccIz+SBD2w2KfY/kZbjmgSswWq/M4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R+js4kW31W9bAsx0h/x03a1gwB2KOEGwqzWZFByLnlbYGu45HtsBXghVBEhC6s1yNU
         U/qLlFJs5mV7uTL2yERXBvleE1Gab2ZtScYVXV1zESnd2YtVQV1BJ6XoJ+Zu5yhnoU//
         8vTi5FWqz9Kx0h05H9opiJWKUZfMZDSh9ykc4=
Received: by 10.210.118.13 with SMTP id q13mr6753874ebc.48.1248793678857;
        Tue, 28 Jul 2009 08:07:58 -0700 (PDT)
Received: from @ (91-165-131-3.rev.libertysurf.net [91.165.131.3])
        by mx.google.com with ESMTPS id 24sm363079eyx.43.2009.07.28.08.07.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 08:07:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <40aa078e0907280510s1afee3ddw3a9333620a3c7d7a@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124256>

The 28/07/09, Erik Faye-Lund wrote:
> 
> Here's an attempt to fix the case when Sys::Hostname::hostname returns
> "" (domains aren't allowed to be empty if I read RFC2822 correctly).
>
> The problem with the previous attempt was that the earlier if assigned
> "user@" to $du_part, so the last if was never entered ($du_part was
> always defined).

Yes, thank you.

> I generally don't write Perl, so people will most likely barf all over
> this one, but at least it should show the concept. It might not even
> work.

Looks ok here.

> I also suspect that it is not needed.

I'm not sure because http://linux.die.net/man/2/gethostname does not
tell either (and POSIX neither).

That said, I tend to think it worth to merge this fix before having a
bug report.

-- 
Nicolas Sebrecht
