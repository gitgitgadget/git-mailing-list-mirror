From: Thomas Braun <thomas.braun@byte-physics.de>
Subject: Re: [PATCH/RFC] send-pack.c: Allow to disable side-band-64k
Date: Mon, 19 May 2014 23:15:00 +0200
Message-ID: <537A7454.6030001@byte-physics.de>
References: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de> <20140519193340.GP12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: git@vger.kernel.org, msysgit@googlegroups.com, kusmabite@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: msysgit+bncBD57FPGWUYHBBVXI5GNQKGQENNPEDFQ@googlegroups.com Mon May 19 23:15:04 2014
Return-path: <msysgit+bncBD57FPGWUYHBBVXI5GNQKGQENNPEDFQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wi0-f190.google.com ([209.85.212.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD57FPGWUYHBBVXI5GNQKGQENNPEDFQ@googlegroups.com>)
	id 1WmUtj-0002LH-4i
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 23:15:03 +0200
Received: by mail-wi0-f190.google.com with SMTP id q5sf397690wiv.27
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=oiqW7mMkEh/j95dnbjlhOxGLb+UpTO1lgARp2KYT1w4=;
        b=sbf3IG6rkkBeQ7pi+a0oxMCtWnkkDW36Bds3G9TPzbDMCNJfcM9W5ygTa44o00/1S/
         adGTvRqnAEWDd1YZrVRCKsYpyIcYEjdJTqB6d8caMAxVZqIToUZ2qpy6fyCPNNQXcVik
         oXaZD1QMFHfbDHUr00CAYEOxJJHaplGszBcA9OqSy5H2bn7ntG4+LjjZ3hl4WZEDiKO5
         6pff1Ai5twUI19kFg4KXBnCW8YycpGgQfdTw1hc/cAx+n9R86kg83JgZNpb6BNPzqBbz
         ElMtdweCbnI5sLNrtQ1rwqqqBb70/v1oQxww7ohNsUYwFGGiG1WcPf/nIKoAABB/6f7o
         z4vg==
X-Received: by 10.152.37.200 with SMTP id a8mr39577lak.19.1400534102892;
        Mon, 19 May 2014 14:15:02 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.170.133 with SMTP id am5ls1952lac.36.gmail; Mon, 19 May
 2014 14:15:01 -0700 (PDT)
X-Received: by 10.152.203.226 with SMTP id kt2mr3078283lac.2.1400534101816;
        Mon, 19 May 2014 14:15:01 -0700 (PDT)
Received: from wp380.webpack.hosteurope.de (wp380.webpack.hosteurope.de. [2a01:488:42::50ed:8595])
        by gmr-mx.google.com with ESMTPS id g42si891571eev.1.2014.05.19.14.15.01
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 19 May 2014 14:15:01 -0700 (PDT)
Received-SPF: none (google.com: thomas.braun@byte-physics.de does not designate permitted sender hosts) client-ip=2a01:488:42::50ed:8595;
Received: from p5ddc1dd3.dip0.t-ipconnect.de ([93.220.29.211] helo=[192.168.100.43]); authenticated
	by wp380.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	id 1WmUtg-0002tl-GV; Mon, 19 May 2014 23:15:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140519193340.GP12314@google.com>
X-bounce-key: webpack.hosteurope.de;thomas.braun@byte-physics.de;1400534101;0d198d0d;
X-Original-Sender: thomas.braun@byte-physics.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: thomas.braun@byte-physics.de does not designate permitted sender
 hosts) smtp.mail=thomas.braun@byte-physics.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249622>

Am 19.05.2014 21:33, schrieb Jonathan Nieder:
> Hi,
>
> Thomas Braun wrote:
>
>> pushing over the dump git protocol with a windows git client.
>
> I've never heard of the dump git protocol.  Do you mean the git
> protocol that's used with git:// URLs?

You are right I mean the protocol involving git:// URLs. But 
unfortunately I got it wrong as according to [1] the git:// is one of 
the so-called smart protocols. That was also the source where I read 
that there are smart and dump protocols.

[1]: http://git-scm.com/book/en/Git-Internals-Transfer-Protocols

> [...]
>> Alternative approaches considered but deemed too invasive:
>> - Rewrite read/write wrappers in mingw.c in order to distinguish between
>>    a file descriptor which has a socket behind and a file descriptor
>>    which has a file behind.
>
> I assume here "too invasive" means "too much engineering effort"?
>
> It sounds like a clean fix, not too invasive at all.  But I can
> understand wanting a stopgap in the meantime.

No actually I meant too invasive in the sense of "requiring large 
rewrites which only benefit git on windows and hurt all others".

The two fixes I can think of either involve:
- In a read *and* write wrapper the need to check if the fd is a socket, 
if yes use send/recv if no use read/write. According to Erik's comments 
this should be possible. But I would deem the expected performance 
penalty quite large as that will be done in every call.
- Rewriting read/write to accept windows handles instead of file 
descriptors. Only a theoretical option IMHO.

For me the goal is also to minimise the diff between git and msysgit/git.

>
>> - Turning the capability side-band-64k off completely. This would remove a useful
>>    feature for users of non-affected transport protocols.
>
> Would it make sense to turn off sideband unconditionally on Windows
> when using the relevant protocols?
>

Yes, if this would be also acceptable for git.git.

I can check at the call site of send_pack in transport.c what protocol 
is in use, and then pass a new parameter use_sideband to it.
Or maybe "adapt" server_capabilities in connect.c to not include 
side-band-64k if using git:// ?


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
