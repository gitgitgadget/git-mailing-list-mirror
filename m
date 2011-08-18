From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH resend] Makefile: Use computed header dependencies if the
 compiler supports it
Date: Thu, 18 Aug 2011 13:41:42 -0500
Message-ID: <20110818184142.GF30436@elie.gateway.2wire.net>
References: <1313347512-7815-1-git-send-email-frekui@gmail.com>
 <20110814190050.GA16819@elie.gateway.2wire.net>
 <CALx8hKRBjXr44gM1JA+d=RU80pmruPV56s-G3JvViz87eJ=ajQ@mail.gmail.com>
 <20110814200255.GC16819@elie.gateway.2wire.net>
 <20110818183439.GA21560@fredrik-Q430-Q530>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 20:41:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu7XM-0007kw-72
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 20:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410Ab1HRSlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 14:41:47 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39961 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab1HRSlr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 14:41:47 -0400
Received: by yxj19 with SMTP id 19so1697245yxj.19
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VO+qo9Wb/WUrr2sHG4aF9mAbrSxGQloAmQragA65uOs=;
        b=tYFYS3c7m8Im/tiF/znP/QEit1ii/DoEQ7iFFkyH4zbudp0vcVEcm3xALcaxFvqMSL
         BIy8vpJ8y6yoNdwdaTLGFZzHr6ex9yNtBu7y25PFyHO9Mjqz1E93MeOEkTorAAM7236w
         Ba8mY4P+WHyF9KkrqXr78mQuB7yy/hLihAy70=
Received: by 10.42.153.73 with SMTP id l9mr1089545icw.123.1313692906488;
        Thu, 18 Aug 2011 11:41:46 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-105-3.dsl.chcgil.sbcglobal.net [68.255.105.3])
        by mx.google.com with ESMTPS id m21sm1072987ibf.25.2011.08.18.11.41.45
        (version=SSLv3 cipher=OTHER);
        Thu, 18 Aug 2011 11:41:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110818183439.GA21560@fredrik-Q430-Q530>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179611>

Fredrik Kuivinen wrote:

> Oh, I missed "--help". But for me gcc always exits with status code 0
> when I give it "--help", regardless of what other flags I
> provide. Therefore, I don't see how "--help" can be used to test for
> support of -MMD.

Ah, my mistake.  Good catch.

> Here is an updated patch. It avoids the ++empty.c file by giving "-x
> c" to the compiler.

Much nicer, thanks!

> It also avoids the auto-detection when
> COMPUTE_HEADER_DEPENDENCIES is set

Unfortunately "ifdef" in Makefiles means "if nonempty", so the
overhead of detection is still there if I want to explicitly disable
COMPUTE_HEADER_DEPENDENCIES.  That's okay, since that overhead is
small.  So for what it's worth,

Acked-by: Jonathan Nieder <jrnieder@gmail.com>
