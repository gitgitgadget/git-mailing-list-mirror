From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 06/13] Dump the revprops at the start of every revision
Date: Mon, 26 Jul 2010 23:23:27 +0530
Message-ID: <20100726175325.GN17468@kytes>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-7-git-send-email-artagnon@gmail.com>
 <20100707190434.GA2732@burratino>
 <20100721185513.GB23839@kytes>
 <1280153007.2404.65.camel@edith>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarb@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org
To: Julian Foad <julian.foad@wandisco.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 19:55:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdRtd-0006dm-Un
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 19:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142Ab0GZRzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 13:55:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44515 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416Ab0GZRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 13:55:17 -0400
Received: by pwi5 with SMTP id 5so171866pwi.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 10:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=p/NTSzsZ3MQ7C44GUahpNFhKfK6rLFP31gEuNxRDsFs=;
        b=sUoJ3d+1k93pjYePHmT5PYcr9prj2IJlQwXShDeBcg9uebmajZPVyOgST/q32WDSVg
         8V4ABTKrLVhxUl9dEyGo+jFkvakiNbgALLHkotXxexLCc77b5IVlR2lo5Oa6YbltZwcR
         DVpDoi+iJcD0Bu9M5TWFd19uiVVNIDtFmJn7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FwUkFFzdR+5t5Ik5KHCchhZi4GcMPAV+3XVZ1Pkw9UnIt8KiiocDZ26zhxsrjY1yPc
         2TH+gLB1f1J4u7On2JmnSHJHTwn7gEUCmvx6krsNw/X7DICGp1BOaVw2CTqzPDjewQdy
         Ege2I2dp2qmpF8YQRC3AJF8xgTweHWB5BMLwY=
Received: by 10.114.173.5 with SMTP id v5mr12121198wae.79.1280166917494;
        Mon, 26 Jul 2010 10:55:17 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm7076610waa.21.2010.07.26.10.55.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 10:55:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1280153007.2404.65.camel@edith>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151863>

Hi Julian,

Julian Foad writes:
> On Thu, 2010-07-22, Ramkumar Ramachandra wrote:
> > Jonathan Nieder writes:
> [...]
> > > > +			/* Output name length, then name. */
> > > > +			svn_stringbuf_appendcstr(*strbuf,
> > > > +						 apr_psprintf(pool, "K %" APR_SSIZE_T_FMT "\n",
> > > > +							      keylen));
> > > > +
> > > > +			svn_stringbuf_appendbytes(*strbuf, (const char *) key, keylen);
> > > 
> > > Is the cast needed?  (The answer might be "yes" if this code is meant
> > > to be usable with C++ compilers.)
> > 
> > These casts are all over in the source tree, so I'm guessing the
> > answer is "yes".
> 
> Actually no - Subversion C code is not intended to be compilable as C++
> and that cast is not needed.  (Other casts that you see in Subversion
> code are for different situations.)

Thanks for pointing that out. I'll fix them in my future commits.

-- Ram
