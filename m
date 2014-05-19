From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] send-pack.c: Allow to disable side-band-64k
Date: Mon, 19 May 2014 23:20:06 +0200
Message-ID: <CABPQNSbyOzxyv91t87tJidwhdY=LJ5HZu=+vyETAFMkOFV6_HQ@mail.gmail.com>
References: <1400526434-3132-1-git-send-email-thomas.braun@byte-physics.de>
 <20140519193340.GP12314@google.com> <537A7454.6030001@byte-physics.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, GIT Mailing-list <git@vger.kernel.org>, 
	msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@byte-physics.de>
X-From: msysgit+bncBDR53PPJ7YHRBLXL5GNQKGQEKCBT3PI@googlegroups.com Mon May 19 23:20:50 2014
Return-path: <msysgit+bncBDR53PPJ7YHRBLXL5GNQKGQEKCBT3PI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-pa0-f58.google.com ([209.85.220.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBDR53PPJ7YHRBLXL5GNQKGQEKCBT3PI@googlegroups.com>)
	id 1WmUzI-00048D-TO
	for gcvm-msysgit@m.gmane.org; Mon, 19 May 2014 23:20:49 +0200
Received: by mail-pa0-f58.google.com with SMTP id kq14sf1806962pab.23
        for <gcvm-msysgit@m.gmane.org>; Mon, 19 May 2014 14:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        bh=s9+tsKw+syPpJhb/Hi5cWAj3hRRlUlNWLPoLJ/Djw2g=;
        b=yYezVQMrWWxb+XcsI/fBE6fq6y1figZqFK5Y9RiHW6mAIU77j/MjGfNsc90N2W+N4Q
         /3x9qJ9uckOgO23T0gOVlIzQefITvim3noivTQOk4BHHYAQLQSWbUPE3gkhvC2ULgorA
         +yqYi85YQV4NLv9m32j6YC6EQlQzA8BG68fbN9h05HwVZUsCiu0ra9IgpZHRpZkDsQWb
         +OOydQNpIFjjzzgmXF5bQ0sBUiX7pxqC2cAaaW4K9U6AHli7qb/ujDIDC67mOYF371zR
         Enh9SvQm1vOd0al52Nn8IMP4FeoQZn+3mca33GmpFQOi6coETPkQKOXOUed1YuABDW94
         vsLg==
X-Received: by 10.182.1.202 with SMTP id 10mr38579obo.31.1400534447769;
        Mon, 19 May 2014 14:20:47 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.182.126.134 with SMTP id my6ls596779obb.38.gmail; Mon, 19 May
 2014 14:20:46 -0700 (PDT)
X-Received: by 10.183.11.102 with SMTP id eh6mr17858290obd.37.1400534446715;
        Mon, 19 May 2014 14:20:46 -0700 (PDT)
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com [2607:f8b0:4001:c05::22d])
        by gmr-mx.google.com with ESMTPS id gy6si760841igb.2.2014.05.19.14.20.46
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 19 May 2014 14:20:46 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22d as permitted sender) client-ip=2607:f8b0:4001:c05::22d;
Received: by mail-ig0-f173.google.com with SMTP id hn18so4045447igb.6
        for <msysgit@googlegroups.com>; Mon, 19 May 2014 14:20:46 -0700 (PDT)
X-Received: by 10.50.13.42 with SMTP id e10mr1361286igc.24.1400534446620; Mon,
 19 May 2014 14:20:46 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 19 May 2014 14:20:06 -0700 (PDT)
In-Reply-To: <537A7454.6030001@byte-physics.de>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of kusmabite@gmail.com designates 2607:f8b0:4001:c05::22d
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249623>

On Mon, May 19, 2014 at 11:15 PM, Thomas Braun
<thomas.braun@byte-physics.de> wrote:
> Am 19.05.2014 21:33, schrieb Jonathan Nieder:
>
>> Hi,
>>
>> Thomas Braun wrote:
>>
>>> pushing over the dump git protocol with a windows git client.
>>
>>
>> I've never heard of the dump git protocol.  Do you mean the git
>> protocol that's used with git:// URLs?
>
>
> You are right I mean the protocol involving git:// URLs. But unfortunately I
> got it wrong as according to [1] the git:// is one of the so-called smart
> protocols. That was also the source where I read that there are smart and
> dump protocols.
>
> [1]: http://git-scm.com/book/en/Git-Internals-Transfer-Protocols
>
>
>> [...]
>>>
>>> Alternative approaches considered but deemed too invasive:
>>> - Rewrite read/write wrappers in mingw.c in order to distinguish between
>>>    a file descriptor which has a socket behind and a file descriptor
>>>    which has a file behind.
>>
>>
>> I assume here "too invasive" means "too much engineering effort"?
>>
>> It sounds like a clean fix, not too invasive at all.  But I can
>> understand wanting a stopgap in the meantime.
>
>
> No actually I meant too invasive in the sense of "requiring large rewrites
> which only benefit git on windows and hurt all others".
>
> The two fixes I can think of either involve:
> - In a read *and* write wrapper the need to check if the fd is a socket, if
> yes use send/recv if no use read/write. According to Erik's comments this
> should be possible. But I would deem the expected performance penalty quite
> large as that will be done in every call.

You clearly haven't stepped through MSVCRT's read and write implementations :P

I wouldn't worry too much about this, at least not until the numbers are in.

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
