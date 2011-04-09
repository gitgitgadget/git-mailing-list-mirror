From: Marco Maggesi <marco.maggesi@gmail.com>
Subject: Re: New to git
Date: Sat, 9 Apr 2011 21:15:54 +0200
Message-ID: <BANLkTikCF7Kv2xVYmr3O_P2t1TAzEFxXiA@mail.gmail.com>
References: <BANLkTimy-95OJGxU9XzcaR=0jTJWXOwsDg@mail.gmail.com>
	<20110408201024.GA15964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 21:16:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8ddn-0002oW-AD
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 21:16:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab1DITP4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 15:15:56 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45412 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754907Ab1DITPz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 15:15:55 -0400
Received: by qwk3 with SMTP id 3so2627658qwk.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=PX5WpXk70la66BdkWB6d/jmrOStkEOquZ3HYunUmHnM=;
        b=hMJnSETlJguHkQ9DHOunpkGV4v4ADhJR0k23ACAqs4u5uEzw9l+BluSmH4VauaFXDE
         8rfE/F9b0nW6UB5dljWUdRuTl8qp3hWpYPWsy6wYnpHtzN3SAbMzmXbDNKU7ryFHqJ5L
         mugBwXSceIFVWi2mlGEnJKpCL1asdsXG5PLBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=tbn8nvC6L742wEeppTg2B9I/q9/RQu9BzOr05MqNa/JIXerXg280z8dAIIWD2te8WD
         0ZofCrptvdc/0svaw0nI6n3Ntt2krsMECtQcKAMYv59oUHoX4Na85CWnEyz36fGSMnBg
         iTIeheGvJ3fTm+Reeaz4HqL8SsH/HlxHzlTkA=
Received: by 10.224.205.138 with SMTP id fq10mr2887577qab.91.1302376554481;
 Sat, 09 Apr 2011 12:15:54 -0700 (PDT)
Received: by 10.224.208.6 with HTTP; Sat, 9 Apr 2011 12:15:54 -0700 (PDT)
In-Reply-To: <20110408201024.GA15964@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171203>

Hi Chris and Peff,

2011/4/8 Jeff King <peff@peff.net>:
> But if you are just using the server as a distribution point for a
> single repository, it can be much simpler. For example, if you always
> just want to push and overwrite what is on the server (i.e., like a
> mirror), you can just use plain rsync outside of git. To avoid mirror
> lag, you do want to update the objects before the refs. So this:
>
> =A0LOCAL=3D/path/to/repo.git
> =A0REMOTE=3Dserver:path/to/repo.git
> =A0rsync -a $LOCAL/objects/ $REMOTE/objects/
> =A0rsync -a $LOCAL $REMOTE
>
> would work. And then expose repo.git on the server via http or ftp, a=
nd
> clients can clone directly from it.

this is the solution I was looking for (but I where not sure that it wo=
rked).

> You didn't list your reasons, so I'll assume they're good. But note t=
hat
> you don't need to be the administrator to accept a git push. You can
> build it as a regular user, and have git connect over ssh and run the
> server side.

Well, the server is a very old machine and I didn't find easy to
compile git on it because of many missing dependencies (but I didn't
try very hard either).  A better solution would be to upgrade the
server.  But your solution is perfect meanwhile.

Thank you,
Marco
