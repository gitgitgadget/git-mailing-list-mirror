From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] compat/terminal: support echoing on windows
Date: Sun, 24 Jun 2012 17:38:24 +0200
Message-ID: <CABPQNSYLL_eHzo6LjNJWdO-WOfxbCUz2GPyg8p5Vvc0FmToPEg@mail.gmail.com>
References: <1340544903-37016-1-git-send-email-kusmabite@gmail.com> <alpine.DEB.1.00.1206240938050.16012@bonsai2>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: msysgit+bncCOPdven-DxCZ6Zz_BBoE0Xoi3A@googlegroups.com Sun Jun 24 17:39:07 2012
Return-path: <msysgit+bncCOPdven-DxCZ6Zz_BBoE0Xoi3A@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f186.google.com ([209.85.216.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCOPdven-DxCZ6Zz_BBoE0Xoi3A@googlegroups.com>)
	id 1Siou2-0002Tu-Bs
	for gcvm-msysgit@m.gmane.org; Sun, 24 Jun 2012 17:39:06 +0200
Received: by qcsc2 with SMTP id c2sf3615621qcs.3
        for <gcvm-msysgit@m.gmane.org>; Sun, 24 Jun 2012 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:reply-to:in-reply-to
         :references:from:date:message-id:subject:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LSbSdcCtCdlDj/qwQyAARj9T0ObyUk24lW9oub6gxY4=;
        b=D7ol8ynyQc47sXMkFS/HdYewMZODc2vi4bDCZE0OapNJVN5Ar6Jtq4zmueyXb4RuRk
         YkMEeCipcf9v0SnqNPQNlvcMx+Zj97BQhs6ABq4CDQdfPkSSnzle8DhiqgqmcjA2+qWv
         938ChjtM9SZo9Md0JNxK+SyusbS+nP9H38DGg=
Received: by 10.68.229.132 with SMTP id sq4mr1881500pbc.18.1340552345710;
        Sun, 24 Jun 2012 08:39:05 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.68.211.194 with SMTP id ne2ls11407827pbc.9.gmail; Sun, 24 Jun
 2012 08:39:04 -0700 (PDT)
Received: by 10.68.219.170 with SMTP id pp10mr10538423pbc.1.1340552344768;
        Sun, 24 Jun 2012 08:39:04 -0700 (PDT)
Received: by 10.68.219.170 with SMTP id pp10mr10538422pbc.1.1340552344758;
        Sun, 24 Jun 2012 08:39:04 -0700 (PDT)
Received: from mail-pb0-f45.google.com (mail-pb0-f45.google.com [209.85.160.45])
        by gmr-mx.google.com with ESMTPS id iq5si5429490pbc.1.2012.06.24.08.39.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jun 2012 08:39:04 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@gmail.com designates 209.85.160.45 as permitted sender) client-ip=209.85.160.45;
Received: by mail-pb0-f45.google.com with SMTP id ro12so6638645pbb.18
        for <msysgit@googlegroups.com>; Sun, 24 Jun 2012 08:39:04 -0700 (PDT)
Received: by 10.68.241.8 with SMTP id we8mr30409658pbc.130.1340552344451; Sun,
 24 Jun 2012 08:39:04 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Sun, 24 Jun 2012 08:38:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1206240938050.16012@bonsai2>
X-Original-Sender: kusmabite@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of kusmabite@gmail.com designates 209.85.160.45 as permitted sender)
 smtp.mail=kusmabite@gmail.com; dkim=pass header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post?hl=en>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200532>

On Sun, Jun 24, 2012 at 4:38 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 24 Jun 2012, Erik Faye-Lund wrote:
>
>> Without /dev/tty support, git_terminal_prompt simply ignores the
>> 'echo'-parameter. On Windows we can do better by clevering up our
>> getpass-implementation a bit so it can conditionally echo.
>>
>> While we're at it, plug a small memory-leak by returning a pointer
>> to a static strbuf instead of detaching it. This is the same thing
>> the /dev/tty-version of git_terminal_prompt does, and the callee
>> doesn't expect to have to free it's memory.
>
> Looks good, please apply!

Done.

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
