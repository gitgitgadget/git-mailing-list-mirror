From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC 5/5] mingw: get rid of getpass implementation
Date: Fri, 30 Nov 2012 19:06:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1211301906080.31987@s15462909.onlinehome-server.info>
References: <1352815447-8824-1-git-send-email-kusmabite@gmail.com> <1352815447-8824-6-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, peff@peff.net
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBCZPH74Q5YNRBIHL4OCQKGQEEZ6E3LI@googlegroups.com Fri Nov 30 19:06:37 2012
Return-path: <msysgit+bncBCZPH74Q5YNRBIHL4OCQKGQEEZ6E3LI@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f58.google.com ([209.85.161.58])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRBIHL4OCQKGQEEZ6E3LI@googlegroups.com>)
	id 1TeUyy-0002Kj-8O
	for gcvm-msysgit@m.gmane.org; Fri, 30 Nov 2012 19:06:36 +0100
Received: by mail-fa0-f58.google.com with SMTP id v9sf438276fav.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 30 Nov 2012 10:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=x-beenthere:received-spf:x-authenticated:x-provags-id:date:from
         :x-x-sender:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-y-gmx-trusted:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type;
        bh=LngofhUyvDJTsxFyUEAi6uI5nzlUuL31tJdEd2yI2nY=;
        b=urYCMMeDgf4ZyhfiOOhLkEwlwwBTBYOyFe9mtcSgsAdO1IikzGnYAjsMQpnZqKUbMQ
         TJEUW6kWzJibNW8ftolF2m5NEXKDn6U9ohQAL3D8dLvZQi9X/zcf8T5zTkfMFq7nYJAc
         D1XCl6eI26i2ycoOeuR4hPQgZ5bXzHc7npOPWTliVRDyrzHZc0Ib85Ka8KcbKZ5OgBIC
         7cqqIbtpViGnI5bBx5vB6y3SCFLPfyiHVSRjQtl/7Pc6sWD2zwdsvt5AatcW1c8kIwxt
         a06g6sDAhpQLLEjhF0 
Received: by 10.180.96.170 with SMTP id dt10mr501921wib.12.1354298784884;
        Fri, 30 Nov 2012 10:06:24 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.180.87.194 with SMTP id ba2ls3276428wib.6.canary; Fri, 30 Nov
 2012 10:06:24 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr2560764eep.3.1354298783996;
        Fri, 30 Nov 2012 10:06:23 -0800 (PST)
Received: by 10.14.216.197 with SMTP id g45mr2560763eep.3.1354298783985;
        Fri, 30 Nov 2012 10:06:23 -0800 (PST)
Received: from mailout-de.gmx.net (mailout-de.gmx.net. [213.165.64.23])
        by gmr-mx.google.com with SMTP id u8si1333179een.1.2012.11.30.10.06.23;
        Fri, 30 Nov 2012 10:06:23 -0800 (PST)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 213.165.64.23 as permitted sender) client-ip=213.165.64.23;
Received: (qmail invoked by alias); 30 Nov 2012 18:06:23 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp035) with SMTP; 30 Nov 2012 19:06:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/NYBAZSpXN/KTMckS0M/85hfGsekjNx8kwhPuTgY
	g24bS/n5Uc/f3p
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <1352815447-8824-6-git-send-email-kusmabite@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210934>

Hi kusma,

On Tue, 13 Nov 2012, Erik Faye-Lund wrote:

> There's no remaining call-sites, and as pointed out in the
> previous commit message, it's not quite ideal. So let's just
> lose it.

Awesome!
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
