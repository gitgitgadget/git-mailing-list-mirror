From: Bryan Turner <bturner@atlassian.com>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Thu, 15 Jan 2015 19:56:12 +1100
Message-ID: <CAGyf7-Hi2YZQZ610uH6iAsQYRNdLndPCy+ArzZpi4Up7NhkpqQ@mail.gmail.com>
References: <20150114115130.GA5677@inner.h.apk.li>
	<20150114124936.GC30383@peff.net>
	<20150114143946.GE13247@inner.h.apk.li>
	<xmqqmw5lb7ho.fsf@gitster.dls.corp.google.com>
	<CAGyf7-EL03E8oFcuDzGcmN4bKQhroHw-T4Azm4mb0QX9F40RFw@mail.gmail.com>
	<20150115063806.GH13247@inner.h.apk.li>
	<CAGyf7-HMsBnim5yoOgyNJ2=HNpnW8ftvitarMc6UO-zTLfQkBA@mail.gmail.com>
	<20150115074334.GJ13247@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Users <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 09:56:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBgDy-0002nt-2o
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 09:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbbAOI4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 03:56:13 -0500
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:49063 "HELO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751175AbbAOI4N (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 03:56:13 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]) (using TLSv1) by na3sys009aob127.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVLeArE5sBZj80bdD8qLkaubiGIZVCLVF@postini.com; Thu, 15 Jan 2015 00:56:12 PST
Received: by mail-ob0-f169.google.com with SMTP id vb8so12446645obc.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 00:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WAIQLNDSCUw+5bAekWp6Co6Uizyn2q3sXKbp+m7JpKo=;
        b=gCJiEaAWFbnRt8YCjbggql3Hdy2+Y7bX2yeW0TUnTFSMLffjFSHqrx1fBLPxSK+XAn
         l8YfIkGvMnHIgdRrPz6qChuFbvBGSBjdI36kEqvnuevWo79QL9StMij1FKAdA8jvx/Qo
         3Q34srrVWEx3QCBGp3/5D8x4+do5FEPooemEIHJiDNp0kpyoBZKVY2N0SXr7OHj4T31y
         /+eleg6ktbbkvPGGZQmV1HjYOEg7A1rkkBzNBoy8PFnVBzWu+WkWWtevCvOXqAC2+Gh6
         hlTC3vsMdyyDvr18FGIKXFSuXznG88/C8NOQ6aOiiTkDVAB0LAbnLYvLSWk7gs1RvfBd
         F6SQ==
X-Gm-Message-State: ALoCoQmTrI7iX9I4iIgDyDyt8FFwBfxCvYLkrlZHzjiOn8saX/Y6RMPGYq7n0cEm4KSDIuhiS0B1ZF5kdfk2oRZb6E3NmnCEI6TrTnpv76efA00MS/tiY1s4LxarVwuE1NZnU4VBHvRQHQ281C+OVXImQP1HUEBacA==
X-Received: by 10.202.135.78 with SMTP id j75mr4865734oid.106.1421312172273;
        Thu, 15 Jan 2015 00:56:12 -0800 (PST)
X-Received: by 10.202.135.78 with SMTP id j75mr4865728oid.106.1421312172185;
 Thu, 15 Jan 2015 00:56:12 -0800 (PST)
Received: by 10.182.98.225 with HTTP; Thu, 15 Jan 2015 00:56:12 -0800 (PST)
In-Reply-To: <20150115074334.GJ13247@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262468>

On Thu, Jan 15, 2015 at 6:43 PM, Andreas Krey <a.krey@gmx.de> wrote:
> On Thu, 15 Jan 2015 18:05:46 +0000, Bryan Turner wrote:
> ...
>
> They do. So it seems it was forked once upon a time, but...
>
> /opt/apps/atlassian/stash-data/shared/data/repositories $ grep '' */objects/info/alternates
> 158/objects/info/alternates:/data/opt_apps/atlassian/stash-data/shared/data/repositories/20/objects
> 45/objects/info/alternates:/data/opt_apps/atlassian/stash-data/shared/data/repositories/33/objects
> 93/objects/info/alternates:/data/opt_apps/atlassian/stash-data/shared/data/repositories/91/objects
>
> ...there is no trace of a fork still existing (the repo in question is 143).

Yes, the system doesn't currently detect when a repository becomes
un-forked because it's not a common use case.

At this point I think we should probably take this off-list. You can
either e-mail me directly (bturner at atlassian dot com), or, better
still, raise a ticket on support.atlassian.com. Either way I'll work
with you directly to un-fork the repository on disk and allow it to
clean itself up.

>
> Andreas
>
> --
> "Totally trivial. Famous last words."
> From: Linus Torvalds <torvalds@*.org>
> Date: Fri, 22 Jan 2010 07:29:21 -0800
