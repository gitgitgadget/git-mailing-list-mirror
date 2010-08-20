From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: wishlist bugreport: make limit configurable for
 do_fmt_merge_msg (merge.log)
Date: Fri, 20 Aug 2010 14:06:19 +0530
Message-ID: <20100820083614.GD12794@kytes>
References: <20100820020127.GG22469@onerussian.com>
 <20100820064741.GC12794@kytes>
 <20100820081641.GA32127@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 10:38:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmN7I-0002Ft-Op
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 10:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab0HTIiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 04:38:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35610 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538Ab0HTIiH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 04:38:07 -0400
Received: by pzk26 with SMTP id 26so1134220pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 01:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OMonEwYJa52xdLFdPgkeajWZq3MmnAGrTnhyRzNqF5A=;
        b=Vl6ILs/rTLDFJH0MNuHDdx7Dp2R+OLXbfe07rAPDZJ9J+0zwZlq6VNtjoJqgPBCbGT
         S9M0zJuL3CcF84vC1xVbRmLt8pOZcvB2J932Dlf+DZT2BJHHtc1xz9kL9EtLCz03aQLI
         sgdnpufYXmY94BsO0Pgyjr6N4ziwdNbfxHvh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=arO6uCpzfxJgmPl/67EGYksJXq0PveWrJFq3FVvwn+1WKI+GEHQ7URg4sjizMQ8Rp9
         qSdmOXdyP/g+ADVRjxI+q2Un6WThZrxaZ5ji0tJJeTubuWYg/j9lHMqTF8op060mCGYU
         9YamSL76fNf6OZf3IB3Ki0sOtYZdi58rRTkno=
Received: by 10.142.156.14 with SMTP id d14mr921208wfe.2.1282293486726;
        Fri, 20 Aug 2010 01:38:06 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id z1sm2909861wfd.3.2010.08.20.01.38.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 01:38:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100820081641.GA32127@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153985>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> >     fmt-merge-msg: Make the number of log entries in shortlog configurable
> >     
> >     Introduce a new configuration option called merge.logLimit to limit
> >     the number of log entries displayed in the shortlog of a merge commit
> >     configurable. Set the default value to 20.
> 
> Neat.  Sign-off?

Oops. I forgot about the new policy: when a patch isn't ready for
inclusion, I must say that explicitly and sign off so others can base
their work on my patch, right?
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

> > +++ b/builtin/fmt-merge-msg.c
> > @@ -22,6 +23,8 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
> >  	}
> >  	if (!found_merge_log && !strcmp("merge.summary", key))
> >  		merge_summary = git_config_bool(key, value);
> > +	if (!strcmp("merge.logLimit", key))
> > +		log_limit = git_config_int(key, value);
> 
> Maybe something like the following would be good on top (or maybe not;
> you decide).

Looks good- since you're interested in this too, I'll include your
patch, test it and post a series to the list.

Thanks.

-- Ram
