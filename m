From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 19:37:41 -0400
Organization: Twitter
Message-ID: <1400801861.18134.49.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	 <1400782642.18134.8.camel@stross>
	 <20140522183930.GB1167@sigill.intra.peff.net>
	 <1400785669.18134.21.camel@stross>
	 <20140522190959.GA18785@sigill.intra.peff.net>
	 <20140522193030.GA22383@sigill.intra.peff.net>
	 <xmqqha4hmr9d.fsf@gitster.dls.corp.google.com>
	 <1400795586.18134.40.camel@stross>
	 <xmqqd2f5mq5h.fsf@gitster.dls.corp.google.com>
	 <1400796077.18134.41.camel@stross>
	 <xmqq61kxmphw.fsf@gitster.dls.corp.google.com>
	 <xmqq1tvlmp8w.fsf@gitster.dls.corp.google.com>
	 <CACsJy8Bh+igRNsV0nCQ84EvvOh_ye3pqoTi3g_5ix_1LgX-EvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WncYW-0005xJ-Df
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 01:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900AbaEVXho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 19:37:44 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:40671 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899AbaEVXhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 19:37:43 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so6901248qgf.7
        for <git@vger.kernel.org>; Thu, 22 May 2014 16:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=iqcLeGo5J7BMJRG3L0EbMkwdWTb3vK00EwxgEwVuc+A=;
        b=geEHpRk3FlYO/mdmVNPj5an9X1neJLsHIr6bUIf+DOJ3AGMJ7hDuHBj6wMExiHQxRz
         MtO9OXfMJeRl2P4xoVRMtZ5DbviApg8nCH16/qwBKvtvQrjunx+oyuStqmTcO46Ya5aI
         H0I4DAgCd2pEWjijKSxGIgWTgprohJWa0yG8jdN//RE5fWRgbrfytmqRmg78UF9ka0G6
         /O3quZTHJfhL/Rf9BX4RuQVu/LDbvYtTbqY6NuRVpRbOLEV+rkus+Rg7Z2tP3PEhshLW
         nH3xciQ8P/gSOTw0CdKBswU38jDIPtvmbKrUJAzMj1soACU1YGVqaplifH6P9h2nP2IC
         Wmwg==
X-Gm-Message-State: ALoCoQl6wWrT14TQiFfAqnPavEx0rzhdw4cFY5FmRm5KzWfq/s7dTnH0qsRNFZ1/ws1rBXoO/4cN
X-Received: by 10.229.125.130 with SMTP id y2mr1534673qcr.22.1400801863179;
        Thu, 22 May 2014 16:37:43 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id 6sm2003555qam.44.2014.05.22.16.37.41
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 16:37:42 -0700 (PDT)
In-Reply-To: <CACsJy8Bh+igRNsV0nCQ84EvvOh_ye3pqoTi3g_5ix_1LgX-EvQ@mail.gmail.com>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249963>

On Fri, 2014-05-23 at 06:33 +0700, Duy Nguyen wrote:
> On Fri, May 23, 2014 at 5:18 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > ... and the "incrementally repair" Peff talks about would be to
> > cover more cases where we may know (either because we have already
> > computed it to write out a subtree, or we have just read from a
> > known tree to populate a part of the index and we know the paths in
> > the index that correspond to that subtree are exactly the same ones
> > as found in the tree we read from) parts of the cache-tree can be
> > updated with tree object names for subtrees, but we don't do
> > anything right now.
> 
> I wanted to do this but it's hard. For "diff --cached" (which should
> be where we find out and repair cache-tree), we flatten the trees in
> traverse_trees() and let unpack-trees figure out the differences
> against the index. The's no direct connection between a change and a
> tree. Maybe I missed something. David if you are interested in "git
> status" performance, this repairing thing could be important when the
> worktree is large because the diff cost increases accordingly if
> cache-tree is not fully populated. Empty cache-tree could cost us
> nearly the same time we save with avoiding opendir/readdir..

I am interested, and I believe I might be able to start looking into it
in a week or two.
