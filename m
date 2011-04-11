From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/11] revert: Lose global variables "commit" and "me"
Date: Mon, 11 Apr 2011 14:27:19 +0530
Message-ID: <20110411085717.GC28959@kytes>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
 <1302448317-32387-3-git-send-email-artagnon@gmail.com>
 <201104110524.21104.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 10:58:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Cwq-0001eg-6p
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 10:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab1DKI6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 04:58:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45124 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756223Ab1DKI6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 04:58:10 -0400
Received: by iwn34 with SMTP id 34so5417665iwn.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Fzp/XESKylXIXZ9pdf7dF7/DhaRykeKvkvxhOk/LK9c=;
        b=NOtdVbfzum/e2UF+IHwBWOwhho9jZR9a626D/WvOCIq4dxF5VpwZim60n9/tZGt83T
         czbmFjpTWydEDjtaGAuCwn5uqCPXfGoOl7F2/IUSkHU4zFn+Omnd/gAHYRRp3b9B08cw
         nM2FehubgUse6bCnBa1nDjHQO5wl1dGncCrSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=m+oBqzN4In0n4T3ByJonfhUPdvti91ma2sWz9etZACKtnCk3htA/yp7rvWeB99BSvB
         6UuEyg0JppwsnWmtzwKMq9uZkKbhcnhdNJu6dRoy4l/CVcJDyrlNms5xsBlNt/+vaqQK
         2qd4IqHknCH1rCey8uCANN3lT4V3xjGwJpHm0=
Received: by 10.43.62.210 with SMTP id xb18mr7802151icb.349.1302512289721;
        Mon, 11 Apr 2011 01:58:09 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id y10sm4088256iba.29.2011.04.11.01.58.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 01:58:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201104110524.21104.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171316>

Hi Christian,

Christian Couder writes:
> On Sunday 10 April 2011 17:11:48 Ramkumar Ramachandra wrote:
> > @@ -546,10 +547,13 @@ static int prepare_revs(struct rev_info *revs)
> >  	return 0;
> >  }
> > 
> > -static int read_and_refresh_cache(const char *me)
> > +static int read_and_refresh_cache(void)
> >  {
> >  	static struct lock_file index_lock;
> >  	int index_fd = hold_locked_index(&index_lock, 0);
> > +	const char *me;
> > +
> > +	me = (cmd_opts.action == REVERT ? "revert" : "cherry-pick");
> 
> It looks like this patch will not compile as cmd_opts is introduced in patch 
> 03/11.

Rebase fail.  Thanks for pointing it out.  I'll add some features and
rework the series shortly.

-- Ram
