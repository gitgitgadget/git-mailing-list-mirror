From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Windows performance / threading file access
Date: Thu, 10 Oct 2013 22:19:13 +0200
Message-ID: <52570BC1.2040208@gmail.com>
References: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: msysGit <msysgit@googlegroups.com>, 
 Karsten Blees <karsten.blees@gmail.com>
To: Stefan Zager <szager@google.com>, git@vger.kernel.org
X-From: msysgit+bncBDZMLEGXWQLBBRUX3SJAKGQE536X7XA@googlegroups.com Thu Oct 10 22:19:19 2013
Return-path: <msysgit+bncBDZMLEGXWQLBBRUX3SJAKGQE536X7XA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-lb0-f192.google.com ([209.85.217.192])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDZMLEGXWQLBBRUX3SJAKGQE536X7XA@googlegroups.com>)
	id 1VUMhb-0002YG-2J
	for gcvm-msysgit@m.gmane.org; Thu, 10 Oct 2013 22:19:19 +0200
Received: by mail-lb0-f192.google.com with SMTP id z5sf293266lbh.29
        for <gcvm-msysgit@m.gmane.org>; Thu, 10 Oct 2013 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=76vDLpAZVbp13usba2767pyU+c+RhFPwjkLbOpvVZpA=;
        b=m+6XRdJaqhLbp5a9l3IrjnNO2U3fYiWVCYEKKThzynLGFrRdyLPUfoXtd5hyYJwRof
         HtHRAkPR6naYZlIwXRiplXJV3njryyltDSwHXM/G/yvidYuYIElKRsuPYV3HJPM2JAdv
         6hnYylL/4w2xQUGanuX2KzxcHS7yoeOSuT+/zfMm900BRgPJqprs0OMJiSgGN/JS2+9U
         y/x57bkRBEJMOc98YlcSO+d5RKdZL5+6IxMyugC3+K+uQdKgv+LO+EURLCIHFjljzJe8
         l/bmUAY6DvJ4gIcjTBUDbjI5oDvsrtwedKJqegJoDgCgI7xVoev6rTm1GToyaN0/AGiq
         DpHA==
X-Received: by 10.152.3.104 with SMTP id b8mr76211lab.35.1381436358718;
        Thu, 10 Oct 2013 13:19:18 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.45.42 with SMTP id j10ls222644lam.41.gmail; Thu, 10 Oct
 2013 13:19:18 -0700 (PDT)
X-Received: by 10.112.56.148 with SMTP id a20mr5274363lbq.8.1381436357968;
        Thu, 10 Oct 2013 13:19:17 -0700 (PDT)
Received: from mail-bk0-x22c.google.com (mail-bk0-x22c.google.com [2a00:1450:4008:c01::22c])
        by gmr-mx.google.com with ESMTPS id qy6si4064588bkb.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 13:19:17 -0700 (PDT)
Received-SPF: pass (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4008:c01::22c as permitted sender) client-ip=2a00:1450:4008:c01::22c;
Received: by mail-bk0-f44.google.com with SMTP id mz10so1211845bkb.31
        for <msysgit@googlegroups.com>; Thu, 10 Oct 2013 13:19:17 -0700 (PDT)
X-Received: by 10.204.55.137 with SMTP id u9mr3757289bkg.28.1381436357838;
        Thu, 10 Oct 2013 13:19:17 -0700 (PDT)
Received: from [192.168.188.20] (p5DDB14BE.dip0.t-ipconnect.de. [93.219.20.190])
        by mx.google.com with ESMTPSA id ny10sm28316122bkb.17.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 10 Oct 2013 13:19:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAHOQ7J_ZZ=7j-5ULd7Tdvbiqg4inhwi+fue_w6WAtNRkvZSwsg@mail.gmail.com>
X-Original-Sender: sschuberth@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of sschuberth@gmail.com designates 2a00:1450:4008:c01::22c
 as permitted sender) smtp.mail=sschuberth@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235879>

Please keep in mind to CC the msysgit mailing list for Windows-specific 
stuff. I'm also CC'ing Karsten who has worked on performance 
improvements for Git for Windows in the past.

Thanks for bringing this up!

-- 
Sebastian Schuberth


> Hi folks,
>
> I don't follow the mailing list carefully, so forgive me if this has
> been discussed before, but:
>
> I've noticed that when working with a very large repository using msys
> git, the initial checkout of a cloned repository is excruciatingly
> slow (80%+ of total clone time).  The root cause, I think, is that git
> does all the file access serially, and that's really slow on Windows.
>
> Has anyone considered threading file access to speed this up?  In
> particular, I've got my eye on this loop in unpack-trees.c:
>
> static struct checkout state;
> static int check_updates(struct unpack_trees_options *o)
> {
>          unsigned cnt = 0, total = 0;
>          struct progress *progress = NULL;
>          struct index_state *index = &o->result;
>          int i;
>          int errs = 0;
>
>          ...
>
>          for (i = 0; i < index->cache_nr; i++) {
>                  struct cache_entry *ce = index->cache[i];
>
>                  if (ce->ce_flags & CE_UPDATE) {
>                          display_progress(progress, ++cnt);
>                          ce->ce_flags &= ~CE_UPDATE;
>                          if (o->update && !o->dry_run) {
>                                  errs |= checkout_entry(ce, &state, NULL);
>                          }
>                  }
>          }
>          stop_progress(&progress);
>          if (o->update)
>                  git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
>          return errs != 0;
> }
>
>
> Any thoughts on adding threading around the call to checkout_entry?
>
>
> Thanks in advance,
>
> Stefan


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
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
