From: Marat Radchenko <marat@slonopotamus.org>
Subject: Re: [PATCH v4] MinGW(-W64) compilation
Date: Wed, 8 Oct 2014 08:53:30 +0400
Message-ID: <20141008045330.GA5672@seldon>
References: <1412060563-22041-1-git-send-email-marat@slonopotamus.org>
 <543472A0.3020401@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysGit <msysgit@googlegroups.com>,
	marat@slonopotamus.org
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: msysgit+bncBCE7TAPITACRBT4G2OQQKGQEQ2HRS5Q@googlegroups.com Wed Oct 08 06:53:37 2014
Return-path: <msysgit+bncBCE7TAPITACRBT4G2OQQKGQEQ2HRS5Q@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f183.google.com ([209.85.212.183])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCE7TAPITACRBT4G2OQQKGQEQ2HRS5Q@googlegroups.com>)
	id 1XbjFp-0002oN-0m
	for gcvm-msysgit@m.gmane.org; Wed, 08 Oct 2014 06:53:37 +0200
Received: by mail-wi0-f183.google.com with SMTP id z2sf565351wiv.10
        for <gcvm-msysgit@m.gmane.org>; Tue, 07 Oct 2014 21:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=bm6ZbiAoq48bxRAbFFDQuDVyLPkAk3gPjvh8bqw42ZQ=;
        b=Ng0imqUoHBaLjQojNJgxevQ4iUv6BgRmJ6NCXEfpL6EqFvR7iGmWTyvtjXJC2lawVq
         Xv+SZswgRsG8q6hsM6y9ixVo27WfXzBY9jb1F7FoBpML+tiPUVZZmaSuak5XgRijJtEI
         hlYlrxLc3DsnKukErY1ydYVc9rIn7rYlBQShTsNGR2sTvhQ9qfcRy+5sXc8lIGFrcLFE
         hyTyhv+btLM37j0VEuv5ydDtmAyDaJkVPpnSzFs+E/fumM3eEjTaOgvjj6E1R71hlppp
         d/Z0OXVdOb854KeP4RVa0aZi3GNU8VVmgUYvKGNvsS7aEWfNNeosrxOpYe85FbzcvP1a
         lvKg==
X-Received: by 10.152.20.98 with SMTP id m2mr112lae.25.1412744016742;
        Tue, 07 Oct 2014 21:53:36 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.23.227 with SMTP id p3ls18201laf.39.gmail; Tue, 07 Oct
 2014 21:53:34 -0700 (PDT)
X-Received: by 10.152.2.97 with SMTP id 1mr30426lat.6.1412744014551;
        Tue, 07 Oct 2014 21:53:34 -0700 (PDT)
Received: from slonopotamus.org ([94.242.204.247])
        by gmr-mx.google.com with ESMTPS id hv5si30051wib.1.2014.10.07.21.53.34
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2014 21:53:34 -0700 (PDT)
Received-SPF: none (google.com: marat@slonopotamus.org does not designate permitted sender hosts) client-ip=94.242.204.247;
Received: from marat by slonopotamus.org with local (Exim 4.80.1)
	(envelope-from <marat@slonopotamus.org>)
	id 1XbjFi-0001UM-Ko; Wed, 08 Oct 2014 08:53:30 +0400
In-Reply-To: <543472A0.3020401@virtuell-zuhause.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Original-Sender: marat@slonopotamus.org
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: marat@slonopotamus.org does not designate permitted sender
 hosts) smtp.mail=marat@slonopotamus.org
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/msysgit/subscribe>
Content-Disposition: inline

On Wed, Oct 08, 2014 at 01:09:20AM +0200, Thomas Braun wrote:
> Am 30.09.2014 um 09:02 schrieb Marat Radchenko:
> > This patch series fixes building on modern MinGW and MinGW-W64 (including x86_64!).
> > 
> > *Compilation* tested on:
> >  - MSVC
> >  - msysGit environment (twice)
> 
> Hi Marat,
> 
> I wanted to verify that on msysgit but some patches fail to apply
> cleanly. Did you also had to tweak the patches?
> If yes, are these tweaked patches still available somewhere?

msysgit != git-for-windows, as msysgit folks say. msysgit is a development
environment for git-for-windows.

I tested my patches by applying them to git.git/master and building
inside msysgit.

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "Git for Windows" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
