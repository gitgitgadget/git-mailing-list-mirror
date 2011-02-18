From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Thu, 17 Feb 2011 19:51:05 -0500 (EST)
Message-ID: <alpine.DEB.2.00.1102171947230.14950@debian>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com> <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian> <201102161108.26637.jnareb@gmail.com> <vpqhbc4mg1c.fsf@bauges.imag.fr> <AANLkTikq67jQnM555nHKeyk5t0Ln+Hp97WSztTaej_CW@mail.gmail.com>
 <7v8vxflv7p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jakub Narebski <jnareb@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:51:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEZ2-000432-E0
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754104Ab1BRAvM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:51:12 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36938 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab1BRAvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:51:09 -0500
Received: by vws16 with SMTP id 16so1561921vws.19
        for <git@vger.kernel.org>; Thu, 17 Feb 2011 16:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=o/pH4RVx0dKQzKx0se9RlTwN33qb0/IisIEijfm04YU=;
        b=VmWklhQGaUemA2FLqWb/BQoeI5qKQrVsaAilwSlbz0W30sv/7T/uPb7Nr1jS4GYBWq
         pFErYb+AxXQDX8K9SjwCM5a8DLKn5ttPXvVoBvzwLjUMiH6OulLcnQWtrDl0MyCXC3LB
         t0okvIc+KWnkKFptCwFxI+BBk9HkMesufg1lc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=agTY+cNX3yDteJxJVsKbWmtvLnjTlMFlilInkH69jdoy1aRN3kQbi32ClxcVYHKdNm
         PuLcGSTJLvEfVxwyXiMye+Vmttlx2j9Wtxx9AsUYORGdtl+Cr98rzUhgS/kskIKvKlF8
         tot9ZrIk6SV2kTF9NhrXvzln3oP3doR++7TVc=
Received: by 10.52.167.33 with SMTP id zl1mr167089vdb.53.1297990268678;
        Thu, 17 Feb 2011 16:51:08 -0800 (PST)
Received: from [192.168.1.100] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id l6sm771018vcp.14.2011.02.17.16.51.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Feb 2011 16:51:07 -0800 (PST)
X-X-Sender: martin@debian
In-Reply-To: <7v8vxflv7p.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167145>

On Wed, 16 Feb 2011, Junio C Hamano wrote:

> As to its value being what the other end calls the source, I think it is
> not a good idea to change it, and it is even a worse idea to add a new
> configuration variable that points into the tracking branches on our side.
> @{upstream} is a short-hand notation to call the tracking branch of the
> "upstream" we have been discussing, and has to point at refs/remotes/
> hierarchy, but the entire point of the notation is that the users do not
> have to see/type "refs/remotes/" when they say
> 
>     $ git merge @{upstream}
> 
> but at the level of an end-user's world-view, his branch that was forked
> from origin's "master" integrates with origin's "master", and the use of
> an intermediary, the refs/remotes/origin/master remote tracking branch
> that is kept on the local side, is a mere implementation detail.
