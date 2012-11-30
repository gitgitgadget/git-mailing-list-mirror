From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 4/5] mingw: reuse tty-version of git_terminal_prompt
Date: Fri, 30 Nov 2012 19:05:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211301901120.31987@s15462909.onlinehome-server.info>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com> <1352815447-8824-5-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRB47K4OCQKGQEKJZYXNA@googlegroups.com Fri Nov 30 19:05:51 2012
Return-path: <msysgit+bncBCZPH74Q5YNRB47K4OCQKGQEKJZYXNA@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-wg0-f58.google.com ([74.125.82.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB47K4OCQKGQEKJZYXNA@googlegroups.com>)
	id 1TeUyF-0001P5-BZ
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 19:05:51 +0100
Received: by mail-wg0-f58.google.com with SMTP id dt12sf433544wgb.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 10:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=KE7uZfp/m7LOy4iUmMGZa5x7/ozfgkw5TGRhTZQd5EI=;
        b=nBe8407DZuQTJayIIQKkZKYapZrqzXD7JTTWgfY9a0Hmr3BsiGTNSFFgRn5Cu1cpSO
         XRk0Y9o5KqJxXO5yhMC+ZPpxIMl6lshUtJnWqQcYdX2X2RHXaQc3HlJdvU/1FPVW/W3D
         KWlBT0gxY5xDuYZuXrbY4vLA6Kpj3HwWXwgykjZ87XSFMX65skSaRFNrsWmOxwQ9zNIz
         ZLDL4c7swAn9obpjONAUILDAsGvh4yOXaYFmhM5yz014oDDZkJ/Rd0uYUi46wxF4cLbl
         sRl+1NpAXIUANiZ7ZS 
Received: by 10.180.81.231 with SMTP id d7mr4245065wiy.0.1354298739982;
        Fri, 30 Nov 2012 10:05:39 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.88.73 with SMTP id be9ls405834wib.21.gmail; Fri, 30 Nov
 2012 10:05:39 -0800 (PST)
Received: by 10.14.0.196 with SMTP id 44mr2546653eeb.6.1354298739233;
        Fri, 30 Nov 2012 10:05:39 -0800 (PST)
Received: by 10.14.0.196 with SMTP id 44mr2546646eeb.6.1354298739214;
        Fri, 30 Nov 2012 10:05:39 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.23])
        by gmr-mx.google.com with SMTP id z47si1333797eel.0.2012.11.30.10.05.39;
        Fri, 30 Nov 2012 10:05:39 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted sender) client-ip=213.165.64.23;
Received: (qmail invoked by alias); 30 Nov 2012 18:05:39 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp039) with SMTP; 30 Nov 2012 19:05:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xl7A3LiYx58+dg/ec/VqN1BtNT3EqpxFIgKQ8BP
	DBO4tf/1GTBFTr
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1352815447-8824-5-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted
 sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210933>

Hi kusma,

On Tue, 13 Nov 2012, Erik Faye-Lund wrote:

> The getpass-implementation we use on Windows isn't at all ideal;
> it works in raw-mode (as opposed to cooked mode), and as a result
> does not deal correcly with deletion, arrow-keys etc.
> 
> Instead, use cooked mode to read a line at the time, allowing the
> C run-time to process the input properly.

Awesome!

The patch itself has a couple Windows-specific things in compat/terminal.c
that I would have loved to see in compat/mingw.c instead, but it looks as
if we have no choice: restore_term() and disable_echo() need to be
substantially different enough from the implementation in compat/mingw.c.

(Read: I am fine with this patch.)

Ciao,
Dscho

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
