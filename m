From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Re: [PATCH/RFC] send-pack.c: Allow to disable side-band-64k
Date: Mon, 19 May 2014 22:00:57 +0200
Message-ID: <CABPQNSbYVZP4CcatWLuv5m-RFWWgOuKOJJcceBkcEzyJQQ+BqA@mail.gmail.com>
References: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de> <20140519193340.GP12314@google.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Braun <thomas.braun@byte-physics.de>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBDR53PPJ7YHRBIWG5GNQKGQEM2VO2LI@googlegroups.com Mon May 19 22:01:40 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBIWG5GNQKGQEM2VO2LI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-ob0-f191.google.com ([209.85.214.191])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBIWG5GNQKGQEM2VO2LI@googlegroups.com>)
	id 1WmTkh-0003la-R6
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 22:01:40 +0200
Received: by mail-ob0-f191.google.com with SMTP id wm4sf1804054obc.8
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=8UaQdpeFNaZLTyV2vBAaCIig+Wb8P6OV+C1Lg2RqSa8=;
        b=QjuSIaV1/6XzTifbR8zbmDD4liXPWGAHhiTb6j7CctEJHvQfbHMV3qKdldsJtLhdjp
         /n88HbmhGKkcBFjqYdj03ml+9lLiJHSIdL6Zx3r51gUzZvvGijlZ9lDYOjts2k9lzZzN
         y3zfnbAx2hbK9I03z7BOrQJJiuXZxuVy5F9BwyLmm63BwMfgN3Cj9Kfj3RXRltO/E09P
         OW7afGCOSqSygXx1jVmMhIAWFELOAfN2kuuuH3HiRl8VUigu7CAf7/hcBghmy1ZdNyTM
         wp8gr+9ih6a8u0yyPCHszU4souuCcAqZsUv4Ecy9ZYGwEMDCFGZifSS/i3VRYLMtCZi3
         nz6A==
X-Received: by 10.140.51.231 with SMTP id u94mr48506qga.34.1400529698982;
        Mon, 19 May 2014 13:01:38 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.100.179 with SMTP id s48ls1793856qge.17.gmail; Mon, 19 May
 2014 13:01:38 -0700 (PDT)
X-Received: by 10.236.206.15 with SMTP id k15mr14978891yho.44.1400529698111;
        Mon, 19 May 2014 13:01:38 -0700 (PDT)
Received: from mail-ig0-x22b.google.com (mail-ig0-x22b.google.com [2607:f8b0:4001:c05::22b])
        by gmr-mx.google.com with ESMTPS id 6si746046igs.1.2014.05.19.13.01.38
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 13:01:38 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22b as permitted sender) client-ip=2607:f8b0:4001:c05::22b;
Received: by mail-ig0-f171.google.com with SMTP id c1so3969789igq.4
        for <msysgit@googlegroups.com>; Mon, 19 May 2014 13:01:38 -0700 (PDT)
X-Received: by 10.42.204.197 with SMTP id fn5mr4549651icb.95.1400529697961;
 Mon, 19 May 2014 13:01:37 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 19 May 2014 13:00:57 -0700 (PDT)
In-Reply-To: <20140519193340.GP12314@google.com>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22b
 as permitted sender) smtp.mail=kusmabite@gmail.com;       dkim=pass
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249618>

On Mon, May 19, 2014 at 9:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Thomas Braun wrote:
>
>> pushing over the dump git protocol with a windows git client.
>
> I've never heard of the dump git protocol.  Do you mean the git
> protocol that's used with git:// URLs?
>
> [...]
>> Alternative approaches considered but deemed too invasive:
>> - Rewrite read/write wrappers in mingw.c in order to distinguish between
>>   a file descriptor which has a socket behind and a file descriptor
>>   which has a file behind.
>
> I assume here "too invasive" means "too much engineering effort"?
>
> It sounds like a clean fix, not too invasive at all.  But I can
> understand wanting a stopgap in the meantime.
>

Yeah, now that the problem seems to be understood, I don't think that
would be too bad. I recently killed off our previous write()-wrapper
in c9df6f4, but I see no reason why we can't add a new one.

Would we need to wrap both ends, shouldn't wrapping only reading be
good enough to prevent deadlocking?

compat/poll/poll.c already contains a function called IsSocketHandle
that is able to tell if a HANDLE points to a socket or not.

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
For more options, visit https://groups.google.com/d/optout.
