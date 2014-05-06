From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Mon, 05 May 2014 19:20:48 -0500
Message-ID: <53682ae027b7d_24f8d2930881@nysa.notmuch>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue May 06 19:54:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiFk-0007Xo-3G
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933383AbaEFAbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 20:31:33 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:60598 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbaEFAbc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 20:31:32 -0400
Received: by mail-oa0-f53.google.com with SMTP id m1so6837777oag.40
        for <git@vger.kernel.org>; Mon, 05 May 2014 17:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=QkewHPiRCYvh1wPzD8kyf9ZJxN7nAxy68GUKt58iJU4=;
        b=1IQGzC16tMI7/V9GehOm6YpiM6ZGMiPARqQx0rsmLgUciV/7ObcvWxszNbim1J7XuI
         ETZTwvp1XlItNt6llFZUNCcGWUtK/OzShl760CwpT6c3cqo4u8h+9dYTVPCTp1HNf4Bf
         v5kUItipSvY/okn+Fn65//+oT5A/j3M5j8sOQxFOX4k0tokWvpjG/cVVukFqvulL4HGn
         Go3M2cMX2hJ44NfOCj/5N/I9WIIPtYgjeQrZAmKZZrqoW0ZVan8zS8TSSBNVc9lOz5kO
         o5vf+zbBxxfBmI2p7/VSZbKKvYmc/kB8gNedgCLBpS5ZllvgwyeQ4cjrQz185t8uL1DQ
         ettg==
X-Received: by 10.182.250.200 with SMTP id ze8mr77376obc.72.1399336292347;
        Mon, 05 May 2014 17:31:32 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id w4sm44573075oem.8.2014.05.05.17.31.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 17:31:30 -0700 (PDT)
In-Reply-To: <xmqqoazb944d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248195>

Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:

> > In the case of git-remote-hg specifically, the remote helper has to use
> > an interface that the Mercurial developers consider unstable [1];...
> > I do not want to end up in a situation where an update to Git is blocked
> > by a distribution because git-remote-hg is not updated to support newer
> > versions of Mercurial sufficiently quickly; this previously happened in
> > Gentoo due to git-svn and meant that was stuck on 1.7.8 until 1.7.13 was
> > released [2].
> 
> The same argument would apply to git-svn, git-p4, and git-cvsimport,
> I would think.
> 
> Among these, I am not sure if we can find willing maintainers who
> can give enough love to them.  But unlike these other importers,
> remote-hg and remote-bzr do have an active maintainer (and IIRC I
> think I heard that Hg one even has an active competitor or two?)

Unfortunately there are no more real competitors to remote-hg. A far as
I can tell msysgit has dropped their remote helper, and gitifyhg is not
being actively maintatined and it's even pointing to our git-remote-hg
as probably the best alternative to use at the moment.

> so I am reasonably confident that these can live on their own merit
> outside of my tree.  In the ideal world, I would think it may be even
> beneficial to the end users of these helpers to unbundle them.

It might be benefitial in the future, but right now I'm willing to bet
there's many people that don't know git-remote-hg/bzr even exist. If Git
v2.0 distributes them by default, and they are mentioned in the release
notes:

 * Transparent support to pull and push to and from Mercurial and Bazaar
   repositories is now enabled by default.

Many more people will know about that, and in the future when we try to
unbundle them they can shout if for some reason it would be inconvenient
for them. At the moment I don't think we can say for sure.

Even if people don't use these bridges, I think just mentioning that
feature helps the project in general.

> You raised a good point on the issue of external dependencies may
> impact Git as a whole, even for those who are not interested in the
> particular remote helpers at all.  I'll have to think about it.

Yes, it's worth thinking about it because it's a real possibility.
However, real possibilities are many times not likely to happen, and I
think this is one of those cases.

As I've said, if history is any indication these issues won't happen. As
far as I can remember the only issues that have happened are backwards
compatibility issues, not present or future. And as I said I've setup
TravisCI builds to detect those, which is why we haven't had those
issues since then.

> So it boils down to "how much resource are there to make sure a helper
> will stay compatible with wider versions of both sides?" and "how far
> backwards are helper maintainers willing to bend to support users
> better?".

This is not that big of an issue. For example, notice how the changes in
the transport-helper to enable say --force and --dry-run did not
require to align changes in remote-hg/bzr. That's because remote-hg/bzr
had already the code for these features, it was just not exercised until
the transport-helper was modified.

I think the current transport-helper infraestructure is already good
enough to detect the features and options of the remote helpers so
unbundling wouldn't be a major problem.

Having said that alignment issues do happen, and we have one of those in
Git v2.0, but I don't think they are a major concern (at least for
remote-hg/bzr).

-- 
Felipe Contreras
