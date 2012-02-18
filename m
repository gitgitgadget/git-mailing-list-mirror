From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] git-send-email: allow overriding smtp-encryption config
 to 'none'
Date: Fri, 17 Feb 2012 21:27:44 -0800
Message-ID: <CAN8TOE-vek=ooq4DRcNF0iCg+rJMt6SUhMi4+_dOWaRJ44KLLA@mail.gmail.com>
References: <1329342178-14540-1-git-send-email-computersforpeace@gmail.com>
	<20120215220629.GA17672@sigill.intra.peff.net>
	<CAN8TOE_BnkOcMQRTY-GWrHozYD0+0giWn2LtjB8AVnP_DzA+Sg@mail.gmail.com>
	<20120216004903.GA21170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 18 06:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rycpt-0003mf-Px
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 06:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230Ab2BRF1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Feb 2012 00:27:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60001 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917Ab2BRF1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2012 00:27:45 -0500
Received: by ghrr11 with SMTP id r11so2144917ghr.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 21:27:44 -0800 (PST)
Received-SPF: pass (google.com: domain of computersforpeace@gmail.com designates 10.236.72.170 as permitted sender) client-ip=10.236.72.170;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of computersforpeace@gmail.com designates 10.236.72.170 as permitted sender) smtp.mail=computersforpeace@gmail.com; dkim=pass header.i=computersforpeace@gmail.com
Received: from mr.google.com ([10.236.72.170])
        by 10.236.72.170 with SMTP id t30mr17105902yhd.101.1329542864923 (num_hops = 1);
        Fri, 17 Feb 2012 21:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+tiquqLfbua0G1vYk2nCtSs4TmnRU1ZXNRTbILRUDIs=;
        b=FDyCkDg+S6pp5Sw4Acf8+yvQHc1HhXYp+joiRTGd+YK3IK6NDwaFkUK3/QTaGWOncI
         NO4VLUFm9AKl3QYcaSN3BlyaIJG4wLuHthxw+yX1L25WuNkJezzzmhFZVal+8U7HTj5V
         1Dg6uoPAkk8IqwZq6IkYoWboXzMRbTYydwqUU=
Received: by 10.236.72.170 with SMTP id t30mr13102148yhd.101.1329542864877;
 Fri, 17 Feb 2012 21:27:44 -0800 (PST)
Received: by 10.236.25.5 with HTTP; Fri, 17 Feb 2012 21:27:44 -0800 (PST)
In-Reply-To: <20120216004903.GA21170@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190994>

On Wed, Feb 15, 2012 at 4:49 PM, Jeff King <peff@peff.net> wrote:
> Ah, I see. I misunderstood the original problem you were trying to solve
> (I thought your example was "see? Encryption is off, so the server won't
> do AUTH, demonstrating that the patch works.").

Yeah, I got a little bit off track on what my actual goal was...

> Overriding the smtp user from the config is a separate issue, and I
> don't think that is currently possible. The usual way to spell an option
> like that in git is "--no-smtp-user", but it seems that we use perl's
> GetOptions, which does not understand that syntax. So you'd have to add
> a "--no-smtp-user" by hand.

I think the "--no-smtp-user" is what I really wanted. I've written a
different patch that actually targets the user name properly, but I've
also found a current solution that can work for scripting purposes:
just redirect the $GIT_CONFIG environment variable to /dev/null
temporarily. Perhaps I'll send my new patch sometime, but it's not
pressing and I'm not sure what kind of use it would actually get.

Thanks for the pointers.

Brian
