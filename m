From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] Add core.mode configuration
Date: Tue, 15 Oct 2013 13:51:41 -0500
Message-ID: <525d8ebd19c67_5feab61e8037@nysa.notmuch>
References: <1381561485-20252-1-git-send-email-felipe.contreras@gmail.com>
 <20131014205908.GA17089@shrek.podlesie.net>
 <525c63b6711fa_197a905e845b@nysa.notmuch>
 <20131015123505.GA3097@shrek.podlesie.net>
 <525d35e766ad4_55661275e7426@nysa.notmuch>
 <20131015133327.GA22723@shrek.podlesie.net>
 <525d4354a5436_5844e73e843d@nysa.notmuch>
 <20131015145139.GA3977@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 21:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW9tK-0003lS-Nz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 21:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759677Ab3JOTCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 15:02:47 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65113 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759580Ab3JOTCq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 15:02:46 -0400
Received: by mail-oa0-f46.google.com with SMTP id g12so1686057oah.19
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=iQEq4VvA9kVj1L2phMoTvCjnrajhho304PlFoWc3m0Y=;
        b=kUVfRI2R1qnP+wyeqxfQm5alzYAkN6Fgal91Gd6T2yFVeth9NtyKdKKrTWuO2/J6CS
         O1B30oEjnemFsPkiTgKqQu81CDe7SENjJm6P8PqWn+Bct1grW+ian1A6ISBYvp62QocK
         44QDnoCCIk9yDn84BZ+7KXPKVR6wQF+ePj1uQCByovct4VDsrbq5u+6tB3n4AEj01tKX
         /NycLL+yifPJRAIKhgL7n82gPYAE07FqhdABb1nHZVviq7lBF9H8aKVaDvZveH4j/IQI
         G7LtUGz6gdfc1qleX8ySKuNlmmsKC5kSJDPbTZwrq1/PjggbAjINVIfrWVkAL9lodZZ4
         NmeQ==
X-Received: by 10.182.73.231 with SMTP id o7mr11273619obv.34.1381863765285;
        Tue, 15 Oct 2013 12:02:45 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm52535381obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 12:02:44 -0700 (PDT)
In-Reply-To: <20131015145139.GA3977@shrek.podlesie.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236194>

Krzysztof Mazur wrote:
> On Tue, Oct 15, 2013 at 08:29:56AM -0500, Felipe Contreras wrote:
> > Krzysztof Mazur wrote:
> > > On Tue, Oct 15, 2013 at 07:32:39AM -0500, Felipe Contreras wrote:
> > > > Krzysztof Mazur wrote:
> > > > > 
> > > > > But with core.mode = next after upgrade you may experience incompatible
> > > > > change without any warning.
> > > > 
> > > > Yes, and that is actually what the user wants. I mean, why would the user set
> > > > core.mode=next, if the user doesn't want to experencie incompatible changes? A
> > > > user that sets this mode is expecting incompatible changes, and will be willing
> > > > to test them, and report back if there's any problem with them.
> > > 
> > > With your patch, because it's the only way to have 'git add' v2.0.
> > 
> > Yeah, but that's not what I'm suggesting. I suggested to have *both* a
> > fined-tunned way to have this behavior, say core.addremove = true, and a way to
> > enable *all* v2.0 behaviors (core.mode = next).
> 
> I'm just not sure if a lot of users would use core.mode=next,

I'm not sure if a lot of urser would even notice the difference.

> because of possible different behavior without any warning.

I don't see what is the problem. We haven't had the need for push.default =
simplewarning, have we? If you want the warning, you don't change anything, if
you want to specify something, you already know what you are doing.

> Maybe we should also add core.mode=next-warn that changes defaults like next
> but keeps warnings enabled until the user accepts that change by setting
> appropriate config option?

Maybe, but would you actually use that option?

> That's safer than next (at least for interactive use) and maybe more users
> would use that, but I don't think that's worth adding.

Maybe, but I don't think many users would use either mode, and that's good.

> For me, old behavior by default and warnings with information how to
> enable new incompatible features, is sufficient. So I don't need
> core.mode option, but as long it will be useful for other users I have
> nothing against it.

OK, but that seems to mean you don't need core.mode = next-warn either. I'm not
against adding such a mode, but I would like to hear about _somebody_ that
would like to actually use it. I don't like to program for ghosts.

Cheers.

-- 
Felipe Contreras
