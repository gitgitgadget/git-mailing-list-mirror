From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Thu, 17 Feb 2011 19:57:10 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102171951240.14950@debian>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian> <201102161108.26637.jnareb@gmail.com> <vpqhbc4mg1c.fsf@bauges.imag.fr> <AANLkTikq67jQnM555nHKeyk5t0Ln+Hp97WSztTaej_CW@mail.gmail.com>
 <7v8vxflv7p.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1102171947230.14950@debian>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:57:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEev-0007Q0-RW
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756002Ab1BRA5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:57:15 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37917 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108Ab1BRA5O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:57:14 -0500
Received: by qyk12 with SMTP id 12so3279215qyk.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=BbbJ2kjjQYQ8l+wovVijlUZtx4sAuW+KaDoFqB4nkWM=;
        b=PlEJxQWMyrm5CrGgS13a2mjaUp99BVcWb0usimLIZMJ6ShZ5/v3OenC6DylAIAAi7B
         e+gxVLh8Tm8Y8e2obP3GtA8YRg/Loug62zxorRblHsKFOWKpcp0l6rVXk8+ubiM+tBwl
         n42RDzPdMQnHTBXHO2/d/CF1HOa+rdX259y5c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=vnEypf0AjwWF7Myjv/PJE9ceu1lSrcEuYlgBjCyJsO0xIB75Ojyi1QQ14m4U3HF5MZ
         IQCJhkFGB1pfBiZWT/LDy03GH11j+9kqcW/yTzrkYKc0EQpfLNeCvgefvRKYTYWEqCrK
         ceVKNp23+j8jcaFTlqtYsu1+C4qtOT+WDLasc=
Received: by 10.229.235.147 with SMTP id kg19mr78758qcb.61.1297990633616;
        Thu, 17 Feb 2011 16:57:13 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id g32sm1141319qck.34.2011.02.17.16.57.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:57:12 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <alpine.DEB.2.00.1102171947230.14950@debian>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167147>

On Thu, 17 Feb 2011, Martin von Zweigbergk wrote:

Sorry, sent by mistake (wrong key).

> On Wed, 16 Feb 2011, Junio C Hamano wrote:
> 
> > As to its value being what the other end calls the source, I think it is
> > not a good idea to change it, and it is even a worse idea to add a new
> > configuration variable that points into the tracking branches on our side.
> > @{upstream} is a short-hand notation to call the tracking branch of the
> > "upstream" we have been discussing, and has to point at refs/remotes/
> > hierarchy, but the entire point of the notation is that the users do not
> > have to see/type "refs/remotes/" when they say
> > 
> >     $ git merge @{upstream}

What I meant to say was that I'm not sure I agree that the point of
the @{upstream} notation is to hide the refs/remotes hierarchy. At
least to me. I think more important is having a single way to refer to
the upstream, whatever its value may be.

> > 
> > but at the level of an end-user's world-view, his branch that was forked
> > from origin's "master" integrates with origin's "master", and the use of
> > an intermediary, the refs/remotes/origin/master remote tracking branch
> > that is kept on the local side, is a mere implementation detail.

Anyway, I agree with with this part. And I'm happy Johan adding the
"upstream" alias.


/Martin
