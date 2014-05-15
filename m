From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep -I: do not bother to read known-binary files
Date: Thu, 15 May 2014 19:42:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1405151940170.14982@s15462909.onlinehome-server.info>
References: <20140514154419.GA4517@camelia.ucw.cz> <20140514194128.GC2715@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Cc: Stepan Kasal <kasal@ucw.cz>, GIT Mailing-list <git@vger.kernel.org>, 
    msysGit <msysgit@googlegroups.com>
To: Jeff King <peff@peff.net>
X-From: msysgit+bncBCZPH74Q5YNRB27Y2ONQKGQEVEVRW5I@googlegroups.com Thu May 15 19:42:05 2014
Return-path: <msysgit+bncBCZPH74Q5YNRB27Y2ONQKGQEVEVRW5I@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-we0-f185.google.com ([74.125.82.185])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCZPH74Q5YNRB27Y2ONQKGQEVEVRW5I@googlegroups.com>)
	id 1WkzfP-0008FV-QX
	for gcvm-msysgit@m.gmane.org; Thu, 15 May 2014 19:42:03 +0200
Received: by mail-we0-f185.google.com with SMTP id w61sf136275wes.2
        for <gcvm-msysgit@m.gmane.org>; Thu, 15 May 2014 10:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=kAzxQQe0c3yc/AmxaaI29+DmPKEV4XlEQnOK/ZTxuzY=;
        b=k9lxha1FYGP5fmrr+o6CAOLzduRkJP/8C12sJmQAhIChanDERBuflGjyVn3CdllVn0
         FAjkVfTmr1nsMmHXJfjAWSt7vtlCtQRq7u93x4ejqsKngHBAOlJQRUgglaOKF7m8DiQz
         TRWziRvqZ90mw4dBAFEf8G3hPonxPLVrt47ozcO75p1ktuUKKt7HQfRZX0ZRHxpXXDJi
         n4/XsaHWzCuiNvdzWmdzrqaX5HC5gIaD5HWInj//7NjsuXwPsU/t04K3AcyP1PvO9tK2
         FFzot3lhLGmfQYsoDpx5QfC4RZyOlyDjZPM1UCVCSym+kOXYDl3vofycwbDn3QNIXlxb
         zsmg==
X-Received: by 10.152.205.43 with SMTP id ld11mr38169lac.8.1400175723510;
        Thu, 15 May 2014 10:42:03 -0700 (PDT)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.27.5 with SMTP id p5ls67228lag.54.gmail; Thu, 15 May 2014
 10:42:02 -0700 (PDT)
X-Received: by 10.152.43.101 with SMTP id v5mr8458lal.10.1400175722796;
        Thu, 15 May 2014 10:42:02 -0700 (PDT)
Received: from mout.gmx.net (mout.gmx.net. [212.227.15.19])
        by gmr-mx.google.com with ESMTPS id u49si1905278eeo.1.2014.05.15.10.42.02
        for <msysgit@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 May 2014 10:42:02 -0700 (PDT)
Received-SPF: pass (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as permitted sender) client-ip=212.227.15.19;
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0LdYSM-1XBlxj1uaI-00ikwQ;
 Thu, 15 May 2014 19:42:01 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20140514194128.GC2715@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:vrawI7dmb/VR+zvRPs91rXQOnXsxcJzyUDN64RIqQmO77Iz5lmT
 V0fHSYx66XxuJV9DmYgU7cRQlUMBTCwv/AaxBA36MWCYOt35fX9E0+GJGBmHHWeqnL6rBcD
 f2PLPoWSnYyU1+IJB1kWt+23pciPP5cPylOSNE3FZCU4FmNJdQCVCCpugRUJj6YGYHibIVE
 YUQXh81h08DbrVyGjGTgg==
X-Original-Sender: johannes.schindelin@gmx.de
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of Johannes.Schindelin@gmx.de designates 212.227.15.19 as
 permitted sender) smtp.mail=Johannes.Schindelin@gmx.de
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249168>

Hi Peff,

On Wed, 14 May 2014, Jeff King wrote:

> On Wed, May 14, 2014 at 05:44:19PM +0200, Stepan Kasal wrote:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Date: Mon, 8 Nov 2010 16:10:43 +0100
> > 
> > Incidentally, this makes grep -I respect the "binary" attribute (actually,
> > the "-text" attribute, but "binary" implies that).
> 
> Hrm. Is this patch still necessary? In the time since this patch was
> written, we did 0826579 (grep: load file data after checking
> binary-ness, 2012-02-02)

I have no time to test this but I trust that you made sure that it works
as advertised. In my case, there were about 500 gigabytes of image data
intermixed with code, and waiting for 'git grep' was not funny at all (and
I did not have time back then to go through a full code submission cycle
on the Git mailing list, either).

So I guess we can drop my patch.

Ciao,
Johannes

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
