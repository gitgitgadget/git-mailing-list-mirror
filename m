From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v3 03/16] index-helper: new daemon for caching index and
 related stuff
Date: Thu, 14 Apr 2016 14:20:54 -0400
Organization: Twitter
Message-ID: <1460658054.5540.89.camel@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
	 <1459980722-4836-4-git-send-email-dturner@twopensource.com>
	 <CACsJy8C5NhaAAW=wzpwkBdLvVZz8wVM7QX==n_CL5g+LLAKY=A@mail.gmail.com>
	 <1460153784.5540.19.camel@twopensource.com>
	 <1460417232.5540.53.camel@twopensource.com>
	 <CACsJy8C2FtdetQ_NJSKR_JCZ5Ju0E3rV7Du=J4f2_kn5qrcHxg@mail.gmail.com>
	 <1460482108.5540.59.camel@twopensource.com>
	 <xmqqfuuqr9ca.fsf@gitster.mtv.corp.google.com>
	 <CACsJy8B6o-8YJYemcYX3NwyMaY9jV666ZwKJYwfbwMSmzM-YGw@mail.gmail.com>
	 <xmqqd1psgiuc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=E6var_=FE=F3r?= <aevarb@gmail.com>,
	jeffhost@microsoft.com
To: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:21:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqltm-0004Uz-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbcDNSVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:21:32 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35028 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbcDNSU5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:20:57 -0400
Received: by mail-qk0-f169.google.com with SMTP id o6so31771107qkc.2
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 11:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=61bzFUVHhPYB24xPfi0JA3huNbAzW9lfpIFqLjtoRp0=;
        b=G+4XBVdItxfsh46A/4HMUMx54pERpzY654hhUQPhcIOsnP4M49wLi1vREjfraHd7ga
         pWe94C7yzhDlwhKTpjR05fsW2gNvNufWf+/spywcpNT3KuH/beq6rfnSv4W5Jn7Z4osu
         QwIQbtUmZrp56iROBCz42Eu+PfnlrJ3pUSSmCejShS32xU9P26I9KuykreVEptYEqHPN
         eo8DJueCVGJxf/8O+hfLW0m9LAUPScgZ6QVM3UPR259rSE1vo8kyaWdTkXbiaNESMGSY
         mcJDKKiH0ogGpm9/Z49IOYcxx5tovvA4mWoT3uZQw68yhh855dtHXgxuyMEyWU56kMzZ
         a94w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=61bzFUVHhPYB24xPfi0JA3huNbAzW9lfpIFqLjtoRp0=;
        b=LdWyQyzBA7iiD9H5U96BEaNAA6oR8lS7vlSSNfOCdVkK9Y8ZGH+bCjJsYk3FTbBfBw
         P7RhnKc1vvO450G7dplSMcvrgL7ZozhDLqY7Yar02kzJmxgxPliodnq+HkaX/EDQwi97
         rwKOeHuZK0F6HEkHqkNwhZUZ2RvfDfp71pq8MtSysRDEXmTi6W9dYWRSZjrvjIsX5riT
         Hkgc5TOvzfgp1X6G6U39wN6XwCoKWY5IIThe8A3htVtoAK20LBnRYhDjk1mdaILS8XK+
         DM6yqY3aC4SOY7e9Krla/LTxgI9t8lIF5Acd4cGTsrEcG9YvaPzfQaSYe7B7HuK4AyyX
         CCzw==
X-Gm-Message-State: AOPr4FUopBgEgphOfUhHzWhjFRAesXH5W32JpX1U/ukPkSWzUVQ5pDMejesgrs6LSuu7Vg==
X-Received: by 10.55.166.132 with SMTP id p126mr20424187qke.8.1460658056724;
        Thu, 14 Apr 2016 11:20:56 -0700 (PDT)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id y12sm1439974qkb.42.2016.04.14.11.20.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Apr 2016 11:20:55 -0700 (PDT)
In-Reply-To: <xmqqd1psgiuc.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291549>

On Thu, 2016-04-14 at 11:12 -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > On Wed, Apr 13, 2016 at 1:05 AM, Junio C Hamano <gitster@pobox.com>
> > wrote:
> > > > >  - access is slow (unless cached, but we can't be sure)
> > > > 
> > > > We could solve this (and the other problem) with mlock.
> > > 
> > > Probably you meant madvise(2)?
> > > 
> > > For something of a size comparable to the index file held by
> > > index-helper-daemon in-core, I'd expect we wouldn't page too
> > > badly.
> > 
> > I had a look at linux implementation of madvise(MADV_WILLNEED). All
> > it
> > does is force populating the entire memory region, which is good.
> > But
> > I suspect when memory is under pressure, some pages may be
> > reclaimed.
> 
> I share that suspicion.  Why is such a reclamation bad thing, though?
> 
> > index files in monster repo case can go up to a few hundred
> > megabytes,
> > chances of being reclaimed rise accordingly. But we can reconsider
> > mlock() later when/if real problems happen.
> 
> Holding onto "a few hundred megabytes" just so that occasional Git
> operations will not stall with the daemon and slowing down the
> overall work of the user by panalizing other elements in the user's
> workflow does not sound like a good trade-off to me.  Wouldn't the
> user better off by not using the daemon at that point, which would
> give the few hundred megabytes back to the system for better uses?

By running git index-helper, the user has signaled their intent about
memory usage.  It's probably reasonable to honor this intent (even if
the user might be mistaken about what the right trade-off is).
