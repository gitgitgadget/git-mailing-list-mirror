From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 11:44:42 -0700
Message-ID: <20150828184442.GE8165@google.com>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
 <20150828170141.GB8165@google.com>
 <xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
 <20150828182008.GC8165@google.com>
 <xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
 <20150828183501.GA17222@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:44:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOdu-0000sJ-Jw
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbH1Soq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:44:46 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35043 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751725AbbH1Soq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:44:46 -0400
Received: by pacdd16 with SMTP id dd16so70673810pac.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+fPmx1kVagLAtlZYa5DJZTo8iQQl/n2JFlmF2dNVCz8=;
        b=n0eDFpmviRu2AbElBlvgM+L/Vb77+mh3eER3Z8l49uogDVpAigSKMeVTviu444QPSC
         mF7cL3I4iJ5RgyoKPBm6+tqUUy9RVLOXwROk2zPCjTd80SA8ZFkahrcV8eexh3cSYDh9
         HFfGXmzKe4Z3hx2SZ+i78d7D87Qn6Wdm0y8OLKDrw4aP/84g0jPMvo5KT7mu5+wZLtUR
         NGxx47oaBgNym2o2d4DcD9pl4pk74QLVHzbGgFyVRryf2+mWm+Oh8wczQaV4qU9aPyiC
         HvNKTWNxKiPXHFdOgAJFXeIpA78NHxWNcfDjue8U9ZeiGT0TZ1twDLv2SFkRs4A3ADsF
         LzDg==
X-Received: by 10.66.102.102 with SMTP id fn6mr17853899pab.13.1440787485235;
        Fri, 28 Aug 2015 11:44:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:d830:475:d6b6:5fa8])
        by smtp.gmail.com with ESMTPSA id r6sm6493214pdj.39.2015.08.28.11.44.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Aug 2015 11:44:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150828183501.GA17222@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276753>

Jeff King wrote:

> I think Jonathan's point is that you could pick _one_ active child to
> show without buffering, while simultaneously buffering everybody else's
> output.

Yep.  Thanks for interpreting.

[...]
> So to an observer, it would look like a serial operation, but subsequent
> operations after the first would magically go much faster (because
> they'd been working and buffering in the background).

Yes.

Thanks,
Jonathan
